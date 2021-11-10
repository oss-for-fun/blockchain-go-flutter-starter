package tlog

import "go.uber.org/zap"

var Info = zap.S().Info
var Infow = zap.S().Infow
var Infof = zap.S().Infof
var Debug = zap.S().Debug
var Debugf = zap.S().Debugf
var Debugw = zap.S().Debugw
var Panic = zap.S().Panic
var Panicf = zap.S().Panicf
var Panicw = zap.S().Panicw
var Error = zap.S().Error
var Errorf = zap.S().Errorf
var Errorw = zap.S().Errorw

func ReplaceLogger(logger *zap.Logger) {
	zap.ReplaceGlobals(logger)

	Info = zap.S().Info
	Infow = zap.S().Infow
	Infof = zap.S().Infof
	Debug = zap.S().Debug
	Debugf = zap.S().Debugf
	Debugw = zap.S().Debugw
	Panic = zap.S().Panic
	Panicf = zap.S().Panicf
	Panicw = zap.S().Panicw
	Error = zap.S().Error
	Errorf = zap.S().Errorf
	Errorw = zap.S().Errorw
}
