// Package hamming implements a routine to calculate the [Hamming Distance] between two strings.
//
// [Hamming Distance]: https://en.wikipedia.org/wiki/Hamming_distance
package hamming

import "errors"

// Distance returns the Hamming Distance between two strings.
//
// An error is returned in case the strings are not of equal length
// since the Hamming Distance is only defined for strings of equal length.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("input strings must be of equal length")
	}

	distance := 0
	bRunes := []rune(b)
	for i, rune := range a {
		if rune != bRunes[i] {
			distance++
		}
	}

	return distance, nil
}
