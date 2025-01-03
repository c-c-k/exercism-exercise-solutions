// Package collatzconjecture implements utilities pertaining to the [Collatz Conjecture].
//
// [Collatz Conjecture]: https://en.wikipedia.org/wiki/Collatz_conjecture
package collatzconjecture

import "errors"

// CollatzConjecture returns the number of steps required to reach 1 given a number n.
// An error is returned if n is not a positive integer.
func CollatzConjecture(n int) (int, error) {
	if n <= 0 {
		return 0, errors.New("only positive numbers are allowed")
	}

	steps := 0
	for ; n != 1; steps++ {
		if n%2 == 0 {
			n /= 2
		} else {
			n = 3*n + 1
		}
	}

	return steps, nil
}
