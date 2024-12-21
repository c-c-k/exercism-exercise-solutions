package meteorology

import "fmt"

type TemperatureUnit int

const (
	Celsius TemperatureUnit = iota
	Fahrenheit
)

func (tu TemperatureUnit) String() string {
	temperatureUnitSuffixes := map[TemperatureUnit]string{
		Celsius:    "°C",
		Fahrenheit: "°F",
	}
	return temperatureUnitSuffixes[tu]
}

type Temperature struct {
	degree int
	unit   TemperatureUnit
}

func (t Temperature) String() string {
	return fmt.Sprintf("%v %v", t.degree, t.unit)
}

type SpeedUnit int

const (
	KmPerHour SpeedUnit = iota
	MilesPerHour
)

func (su SpeedUnit) String() string {
	speedUnitSuffixes := map[SpeedUnit]string{
		KmPerHour:    "km/h",
		MilesPerHour: "mph",
	}
	return speedUnitSuffixes[su]
}

type Speed struct {
	magnitude int
	unit      SpeedUnit
}

func (s Speed) String() string {
	return fmt.Sprintf("%v %v", s.magnitude, s.unit)
}

type MeteorologyData struct {
	location      string
	temperature   Temperature
	windDirection string
	windSpeed     Speed
	humidity      int
}

func (md MeteorologyData) String() string {
	return fmt.Sprintf("%v: %v, Wind %v at %v, %v%% Humidity",
		md.location, md.temperature,
		md.windDirection, md.windSpeed,
		md.humidity)
}
