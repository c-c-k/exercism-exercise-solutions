package elon

import (
	"fmt"
)

// Drive() drives car increasing it's distance by it's speed and
// decreasing it's battery by it's batteryDrain.
func (c *Car) Drive() {
	if c.battery >= c.batteryDrain {
		c.distance += c.speed
		c.battery -= c.batteryDrain
	}
}

// DisplayDistance() returns a string with the distance in meters
// the car has traveled.
//
// Example: "Driven 0 meters"
func (c Car) DisplayDistance() string {
	return fmt.Sprintf("Driven %d meters", c.distance)
}

// DisplayBattery() returns a string with the car's remaining battery.
//
// Example: "Battery at 100%"
func (c Car) DisplayBattery() string {
	return fmt.Sprintf("Battery at %d%%", c.battery)
}

// CanFinish reports whether the car can drive trackDistance
// without it's battery running out.
func (c Car) CanFinish(trackDistance int) bool {
	return c.speed*(c.battery/c.batteryDrain) >= trackDistance
}
