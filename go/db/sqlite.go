package db

import (
	"sync"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var _db *gorm.DB
var once = sync.Once{}

const dbFile = "blockchain-starter.db"

func InitDatabase() (*gorm.DB, error) {
	var err error
	once.Do(func() {
		_db, err = gorm.Open(sqlite.Open(dbFile))
	})

	return _db, err
}

func GetDatabase() *gorm.DB {
	once.Do(func() {
		_db, _ = gorm.Open(sqlite.Open(dbFile))
	})

	return _db
}
