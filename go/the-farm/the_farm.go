package thefarm

import (
	"errors"
	"fmt"
)

var ErrInvalidNumCows error = errors.New("invalid number of cows")

type InvalidCowsError struct {
	numCows    int
	errMessage string
}

func (e *InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.numCows, e.errMessage)
}

func DivideFood(fc FodderCalculator, numCows int) (float64, error) {
	var totalFood, factor float64
	var err error

	if totalFood, err = fc.FodderAmount(numCows); err != nil {
		return 0, err
	}
	if factor, err = fc.FatteningFactor(); err != nil {
		return 0, err
	}

	return totalFood / float64(numCows) * factor, nil
}

func ValidateInputAndDivideFood(fc FodderCalculator, numCows int) (float64, error) {
	if numCows <= 0 {
		return 0, ErrInvalidNumCows
	}
	return DivideFood(fc, numCows)
}

func ValidateNumberOfCows(numCows int) error {
	switch {
	case numCows < 0:
		return &InvalidCowsError{
			numCows:    numCows,
			errMessage: "there are no negative cows",
		}
	case numCows == 0:
		return &InvalidCowsError{
			numCows:    numCows,
			errMessage: "no cows don't need food",
		}
	default:
		return nil
	}
}
