package db

import (
	"os"
	"path/filepath"
	"sync"

	"github.com/ground-x/blockchain-go-flutter-starter/go/common"
	"github.com/mitchellh/go-homedir"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var _db *gorm.DB
var once = sync.Once{}

const dbFile = "blockchain-starter.db"

func InitDatabase() (*gorm.DB, error) {
	var err error
	once.Do(func() {
		_db, err = initDatabase()
	})

	return _db, err
}

func GetDatabase() *gorm.DB {
	once.Do(func() {
		_db, _ = initDatabase()
	})

	return _db
}

func initDatabase() (*gorm.DB, error) {
	home, err := homedir.Dir()
	if err != nil {
		return nil, err
	}
	workspace := filepath.Join(home, common.AppName)
	if err := os.MkdirAll(workspace, os.ModePerm); err != nil {
		return nil, err
	}
	return gorm.Open(sqlite.Open(filepath.Join(workspace, dbFile)))
}
