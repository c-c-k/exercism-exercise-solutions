// Package raindrops implements a utility to convert a number into its corresponding raindrop sounds.
package raindrops

import (
	"strconv"
)

var divisorSoundList = []struct {
	divisor int
	sound   string
}{
	{3, "Pling"}, {5, "Plang"}, {7, "Plong"},
}

// Convert returns a string representing a raindrops sound
// corresponding to a number.
//
// If the number is divisable by 3, 5 or 7,
// a "Pling", "Plang" or "Plong" sound is inserted accordingly.
// If the string **is not** divisible by 3, 5, or 7,
// the number is returned as a string.
func Convert(number int) string {
	var sound string
	for _, divisorSound := range divisorSoundList {
		if number%divisorSound.divisor == 0 {
			sound += divisorSound.sound
		}
	}

	if sound == "" {
		return strconv.Itoa(number)
	}
	return sound
}
