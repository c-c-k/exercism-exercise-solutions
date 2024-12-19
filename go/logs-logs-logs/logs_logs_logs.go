package logs

import (
	"strings"
	"unicode/utf8"
)

var runeApps = map[int32]string{
	'\u2757':     "recommendation", // '❗'
	'\U0001F50D': "search",         // '🔍'
	'\u2600':     "weather",        // '☀'l
}

// Application identifies the application emitting the given log.
func Application(log string) string {
	app := "default"
	for _, rune := range log {
		if runeApp, ok := runeApps[rune]; ok {
			app = runeApp
			break
		}
	}

	return app
}

// Replace replaces all occurrences of old with new, returning the modified log
// to the caller.
func Replace(log string, oldRune, newRune rune) string {
	return strings.ReplaceAll(log, string(oldRune), string(newRune))
	// runes := []rune(log)
	// for index, rune := range runes {
	// 	if rune == oldRune {
	// 		runes[index] = newRune
	// 	}
	// }
	//
	// return string(runes)
}

// WithinLimit determines whether or not the number of characters in log is
// within the limit.
func WithinLimit(log string, limit int) bool {
	return utf8.RuneCountInString(log) <= limit
}
