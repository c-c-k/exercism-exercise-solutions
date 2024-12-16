// Package lasagna contains utilities to help preparing and cooking a lasagna.
package lasagna

// Hardcoded values used throughout the rest of the script.
//
// IMPORTANT when modifying the following values remember to adjust
// the documentation accordingly.
const (
	defaultMinutesPerLayer = 2
	gramsPerNoodleLayer    = 50
	litersPerSauceLayer    = 0.2
	baseRecipePortions     = 2
)

// PreparationTime estimates total lasanga preparation time based on
// the number of layers in it and the average preparation time in
// minutes per layer.
//
// If the minutesPerLayer parameter is passed a value of 0 or less
// then a hard-coded default of 2 minutes is used instead.
func PreparationTime(layers []string, minutesPerLayer int) int {
	if minutesPerLayer <= 0 {
		minutesPerLayer = defaultMinutesPerLayer
	}
	return len(layers) * minutesPerLayer
}

// Quantities determines the quantity of noodles (in grams) and
// sauce (in liters) needed by all layers of the lasanga.
//
// Each layer of noodles is hardcoded to require 50 grams of noodles.
// Each layer of sauce is hardcoded to require 0.2 liters of sauce.
func Quantities(layers []string) (noodles int, sauce float64) {
	noodles, sauce = 0, 0.0
	for _, layer := range layers {
		switch layer {
		case "noodles":
			noodles += gramsPerNoodleLayer
		case "sauce":
			sauce += litersPerSauceLayer
		}
	}

	return
}

// AddSecretIngredient copies the secret ingredient from
// friendsList to myList.

// The secret ingredient is expected to be the last ingredient in
// friendsList and it replaces the last ingredient in myList which is
// expected to be "?".
func AddSecretIngredient(friendsList []string, myList []string) {
	myList[len(myList)-1] = friendsList[len(friendsList)-1]
}

// ScaleRecipe scales the quantities of the ingredients needed to
// the required number of portions.
//
// The input quantities are expected to be for two portions.
// The quantities argument is not modified, a new slice is returned.
func ScaleRecipe(quantities []float64, portions int) []float64 {
	scaledQuantities := make([]float64, len(quantities))
	for i, quantity := range quantities {
		scaledQuantities[i] = quantity / baseRecipePortions * float64(portions)
	}

	return scaledQuantities
}
