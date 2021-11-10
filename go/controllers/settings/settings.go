package settings

import (
	"context"

	"github.com/ground-x/blockchain-go-flutter-starter/go/models/settings"
	"github.com/ground-x/blockchain-go-flutter-starter/go/tlog"
)

type SaveSettingsRequest struct {
	ChainID    string `json:"chainId"`
	Address    string `json:"address"`
	PrivateKey string `json:"privateKey"`
	Endpoint   string `json:"endpoint"`
}

type SettingsResponse struct {
	settings.Settings
}

func SaveSettings(ctx context.Context, data SaveSettingsRequest) (*SettingsResponse, error) {
	tlog.Info(data)

	conf := &settings.Settings{
		ChainID: data.ChainID,
	}
	if err := conf.Load(); err != nil {
		return nil, err
	}

	conf.Address = data.Address
	conf.PrivateKey = data.PrivateKey

	if data.Endpoint == "" {
	}

	return &SettingsResponse{}, nil
}

func LoadSettings(ctx context.Context, data string) (*SettingsResponse, error) {
	return &SettingsResponse{}, nil
}
