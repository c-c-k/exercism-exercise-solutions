package purchase

// NeedsLicense determines whether a license is needed to drive a type of vehicle. Only "car" and "truck" require a license.
func NeedsLicense(kind string) bool {
	return kind == "car" || kind == "truck"
}

// ChooseVehicle recommends a vehicle for selection. It always recommends the vehicle that comes first in lexicographical order.
func ChooseVehicle(option1, option2 string) string {
	choice := option1
	if option1 >= option2 {
		choice = option2
	}
	return choice + " is clearly the better choice."
}

// CalculateResellPrice calculates how much a vehicle can resell for at a certain age.
func CalculateResellPrice(originalPrice, age float64) (price float64) {
	var percent float64
	if age < 3 {
		percent = 0.8
	} else if age < 10 {
		percent = 0.7
	} else {
		percent = 0.5
	}
	return percent * originalPrice
}
