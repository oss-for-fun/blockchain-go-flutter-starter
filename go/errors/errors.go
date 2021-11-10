package errors

import "errors"

var (
	ErrIncorrectHandler = errors.New("incorrect handler")
	ErrIncorrectDone    = errors.New("incorrectly exited without results")
	ErrTimeout          = errors.New("30s timeout")
	ErrUnknown          = errors.New("unknown error")

	ErrEmptySettings     = errors.New("you must configured your networks before using it")
	ErrNotTriedToRequest = errors.New("it's dummy error for backoff retries")
)
