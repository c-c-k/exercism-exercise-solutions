package blackjack

const (
	valAce       = 11
	valTwo       = 2
	valThree     = 3
	valFour      = 4
	valFive      = 5
	valSix       = 6
	valSeven     = 7
	valEight     = 8
	valNine      = 9
	valTen       = 10
	valFigure    = 10
	valOther     = 0
	valBlackJack = 21
)

const (
	actionStand   = "S"
	actionHit     = "H"
	actionSplit   = "P"
	actionAutoWin = "W"
)

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) (value int) {
	switch card {
	case "ace":
		value = valAce
	case "two":
		value = valTwo
	case "three":
		value = valThree
	case "four":
		value = valFour
	case "five":
		value = valFive
	case "six":
		value = valSix
	case "seven":
		value = valSeven
	case "eight":
		value = valEight
	case "nine":
		value = valNine
	case "ten":
		value = valTen
	case "jack", "queen", "king":
		value = valFigure
	default:
		value = valOther
	}

	return
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) (action string) {
	val1, val2, valDealer := ParseCard(card1), ParseCard(card2), ParseCard(dealerCard)
	valHand := val1 + val2

	switch {
	case val1 == valAce && val2 == valAce:
		action = actionSplit
	case valHand == valBlackJack && valDealer < 10:
		action = actionAutoWin
	case valHand <= 11,
		valHand >= 12 && valHand <= 16 && valDealer >= 7:

		action = actionHit
	default:
		action = actionStand
	}

	return
}
