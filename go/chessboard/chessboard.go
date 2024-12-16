package chessboard

// Declare a type named File which stores if a square is occupied by a piece - this will be a slice of bools
type File []bool

// Declare a type named Chessboard which contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File

// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) (count int) {
	count = 0
	if fileSquares, ok := cb[file]; ok {
		for _, squreOccupied := range fileSquares {
			if squreOccupied {
				count++
			}
		}
	}

	return
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) (count int) {
	count = 0
	rank-- // change from 1-based index to 0-based index
	if rank >= 0 && rank < 8 {
		for _, fileSquares := range cb {
			if fileSquares[rank] {
				count++
			}
		}
	}

	return
}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) (count int) {
	count = 0
	for fileID := range cb {
		for range cb[fileID] {
			count++
		}
	}

	return
	// return len(cb) * len(cb["A"])
	// return 8 * 8
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) (count int) {
	count = 0
	for fileID := range cb {
		count += CountInFile(cb, fileID)
	}

	return
}
