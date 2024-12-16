package birdwatcher

// birdCount returns the total bird count between the given two days.
func birdCount(birdsPerDay []int, firstDay int, lastDay int) int {
	sum := 0
	if lastDay > len(birdsPerDay) {
		lastDay = len(birdsPerDay)
	}
	for day := firstDay; day < lastDay; day++ {
		sum += birdsPerDay[day]
	}
	return sum
}

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	return birdCount(birdsPerDay, 0, len(birdsPerDay))
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	return birdCount(birdsPerDay, 7*(week-1), 7*week)
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	firstDay, lastDay := 0, len(birdsPerDay)
	for i := firstDay; i < lastDay; i += 2 {
		birdsPerDay[i] += 1
	}
	return birdsPerDay
}
