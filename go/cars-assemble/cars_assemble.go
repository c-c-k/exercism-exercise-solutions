// Package cars implements utilities to analyze the production in a car factory.
package cars

const (
	singleCarCost = 10000
	batchCost     = 95000
	batchSize     = 10
)

// CalculateWorkingCarsPerHour calculates how many working cars are
// produced by the assembly line every hour.
func CalculateWorkingCarsPerHour(productionRate int, successRate float64) float64 {
	return float64(productionRate) * successRate / 100.0
}

// CalculateWorkingCarsPerMinute calculates how many working cars are
// produced by the assembly line every minute.
func CalculateWorkingCarsPerMinute(productionRate int, successRate float64) int {
	return int(CalculateWorkingCarsPerHour(productionRate, successRate) / 60)
}

// CalculateCost works out the cost of producing the given number of cars.
func CalculateCost(carsCount int) uint {
	var (
		carBatches = carsCount / batchSize
		singleCars = carsCount % batchSize
	)

	return uint(carBatches*batchCost + singleCars*singleCarCost)
}
