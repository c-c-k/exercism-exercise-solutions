package scrabble

import (
	"bufio"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var (
	letterValues   map[byte]int8
	reLetterValues = regexp.MustCompile(`\b(?:[[:upper:]]|\d+)\b`)
)

func processLetterValuesLine(line []byte) error {
	matches := reLetterValues.FindAll(line, -1)
	if len(matches) == 0 {
		return nil
	}

	int64Value, err := strconv.Atoi(string(matches[len(matches)-1]))
	if err != nil {
		return err
	}
	value := int8(int64Value)

	for _, letter := range matches[:len(matches)-1] {
		letterValues[letter[0]] = value
	}

	return nil
}

func processLetterValuesFile() error {
	file, err := os.Open("./letter_values_map.txt")
	if err != nil {
		return err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		if err := scanner.Err(); err != nil {
			return err
		}

		processLetterValuesLine(scanner.Bytes())
	}

	return nil
}

func initLetterValues() error {
	if letterValues != nil {
		return nil
	}
	letterValues = make(map[byte]int8, 26)
	return processLetterValuesFile()
}

func Score(word string) int {
	if err := initLetterValues(); err != nil {
		log.Fatalf("Failed to initialize letter values map: %v", err)
	}

	score := 0
	word = strings.ToUpper(word)
	for _, letter := range []byte(word) {
		score += int(letterValues[letter])
	}

	return score
}
