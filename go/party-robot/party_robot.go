package partyrobot

import "fmt"

const (
	msgWelcome       = "Welcome to my party, %s!"
	msgHappyBirthday = "Happy birthday %s! You are now %d years old!"
	msgAssignTable   = "%s\n" +
		"You have been assigned to table %03d. " +
		"Your table is %s, exactly %.1f meters from here.\n" +
		"You will be sitting next to %s."
)

// Welcome greets a person by name.
func Welcome(name string) string {
	return fmt.Sprintf(msgWelcome, name)
}

// HappyBirthday wishes happy birthday to the birthday person and exclaims their age.
func HappyBirthday(name string, age int) string {
	return fmt.Sprintf(msgHappyBirthday, name, age)
}

// AssignTable assigns a table to each guest.
func AssignTable(name string, table int, neighbor, direction string, distance float64) string {
	return fmt.Sprintf(msgAssignTable,
		Welcome(name),
		table, direction, distance,
		neighbor)
}
