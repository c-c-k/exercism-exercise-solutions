// Package weather implements utility functions to forecast
// the current weather condition of various cities in Goblinocus.
package weather

var (
	// CurrentCondition represents the current weather condition in [CurrentLocation], it is set via [Forecast].
	CurrentCondition string
	// CurrentLocation represents the current location to which [CurrentCondition] applies, it is set via [Forecast].
	CurrentLocation string
)

// Forecast sets [CurrentLocation] to city, [CurrentCondition] to condition and returns a string with the format:
//
//	"<city> - current weather condition: <condition>".
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
