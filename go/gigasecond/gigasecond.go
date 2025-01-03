// Package gigasecond implements utilities to measure time in gigaseconds.
package gigasecond

import (
	"time"
)

const gigasecond = time.Duration(1e9) * time.Second

// AddGigasecond determines the date and time one gigasecond after a certain date.
func AddGigasecond(t time.Time) time.Time {
	return t.Add(gigasecond)
}
