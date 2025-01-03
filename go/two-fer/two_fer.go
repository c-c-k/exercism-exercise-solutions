// Package twofer implements utilities to produce "two-fer" style expressions.
package twofer

import "fmt"

// ShareWith returns a string of the format:
// "One for <name>, one for me.".
// If a name is not provided it defaults to "you".
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
