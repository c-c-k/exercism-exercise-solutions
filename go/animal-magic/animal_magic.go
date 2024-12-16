package chance

import "math/rand"

var animals = []string{
	"ant",
	"beaver",
	"cat",
	"dog",
	"elephant",
	"fox",
	"giraffe",
	"hedgehog",
}

// RollADie returns a random int d with 1 <= d <= 20.
func RollADie() int {
	return 1 + rand.Intn(20)
}

// GenerateWandEnergy returns a random float64 f with 0.0 <= f < 12.0.
func GenerateWandEnergy() float64 {
	return 12 * rand.Float64()
}

// ShuffleAnimals returns a slice with all eight animal strings in random order.
func ShuffleAnimals() []string {
	shuffled := make([]string, len(animals))
	copy(shuffled, animals)
	rand.Shuffle(len(shuffled), func(i int, j int) {
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	})

	return shuffled
}
