package main

import (
	"context"
	"encoding/json"
	"log"
	"reflect"
	"runtime"
	"strings"
	"time"

	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/ground-x/blockchain-go-flutter-starter/go/controllers/settings"
	"github.com/ground-x/blockchain-go-flutter-starter/go/errors"
	"github.com/ground-x/blockchain-go-flutter-starter/go/tlog"
)

type BlockchainStarterPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &BlockchainStarterPlugin{}

const (
	pluginName = "blockchain.starter/utils"
)

func (r *BlockchainStarterPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	tlog.Info("Initializing Blockchain Starter plugin...")
	r.channel = plugin.NewMethodChannel(messenger, pluginName, plugin.StandardMethodCodec{})
	r.HandleFunc(PrintTextInConsole)
	r.HandleFunc(settings.SaveSettings)
	r.HandleFunc(settings.LoadSettings)

	return nil
}

func PrintTextInConsole(ctx context.Context, arg string) (string, error) {
	tlog.Infof("%v", arg)

	return "done", nil
}

func (r *BlockchainStarterPlugin) HandleFunc(handle interface{}) error {
	h := reflect.ValueOf(handle)
	n := runtime.FuncForPC(h.Pointer()).Name()
	nl := strings.Split(n, ".")
	fn := strings.Split(nl[len(nl)-1], "-")[0]
	tlog.Infof("Registering %s handler...", fn)

	r.channel.HandleFunc(fn, func(args interface{}) (resp interface{}, err error) {
		recoverFunc := func() {
			if e := recover(); e != nil {
				log.Printf("[ERROR] %v\n", e)
				err = errors.ErrUnknown
				resp = nil
			}
		}

		defer recoverFunc()

		ctx, cancel := context.WithCancel(context.TODO())

		respCh := make(chan interface{}, 1)
		errCh := make(chan error, 1)

		go func(ctx context.Context, rc chan<- interface{}, ec chan<- error) {
			defer recoverFunc()
			fv := reflect.TypeOf(handle)
			rargs := []reflect.Value{reflect.ValueOf(ctx)}
			argType := fv.In(1)
			if argType.Kind() != reflect.String {
				arg := reflect.New(argType)
				json.Unmarshal([]byte(args.(string)), arg.Interface())
				rargs = append(rargs, reflect.Indirect(arg))
			} else {
				rargs = append(rargs, reflect.ValueOf(args))
			}

			f := reflect.ValueOf(handle)
			rresp := f.Call(rargs)
			err := rresp[1].Interface()
			if err != nil {
				ec <- err.(error)
				return
			}
			val := reflect.Indirect(rresp[0])
			if val.Kind() != reflect.String {
				data, _ := json.Marshal(rresp[0].Interface())
				val = reflect.ValueOf(string(data))
			}
			rc <- val.Interface()
		}(ctx, respCh, errCh)

		select {
		case resp = <-respCh:
		case err = <-errCh:
			log.Println("[ERROR] " + err.Error())
		case <-ctx.Done():
			log.Printf("[ERROR] %s handler was incorrectly exited without results\n", fn)
			err = errors.ErrIncorrectDone
		case <-time.After(30 * time.Second):
			log.Printf("[ERROR] 30s timeout; %s\n", fn)
			err = errors.ErrTimeout
		}

		cancel()

		return resp, err
	})

	return nil
}
