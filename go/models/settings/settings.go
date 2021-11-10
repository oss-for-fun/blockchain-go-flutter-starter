package settings

import (
	"github.com/ground-x/blockchain-go-flutter-starter/go/db"
	"github.com/ground-x/blockchain-go-flutter-starter/go/errors"
	"gorm.io/gorm"
)

type Settings struct {
	gorm.Model

	ChainID    string `json:"chainId"`
	Address    string `json:"address"`
	PrivateKey string `json:"privateKey"`
}

func (r *Settings) Load() error {
	d := db.GetDatabase()
	d.First(r, "chainid = ?", r.ChainID)

	if r.Address == "" {
		return errors.ErrEmptySettings
	}

	return nil
}

func (r *Settings) Save() {
	d := db.GetDatabase()
	res := &Settings{ChainID: r.ChainID}
	if err := res.Load(); err != nil {
		r.ID = res.ID
		d.Model(r).Updates(r)
	}
	d.Create(r)
}
