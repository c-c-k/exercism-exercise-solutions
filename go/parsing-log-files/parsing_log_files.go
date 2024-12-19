package parsinglogfiles

import (
	"regexp"
)

var (
	reIsValidLine           = regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	reSplitLogLine          = regexp.MustCompile(`<[-~*=]*>`)
	reCountQuotedPasswords  = regexp.MustCompile(`(?i)".*password.*"`)
	reRemoveEndOfLineText   = regexp.MustCompile(`end-of-line\d+`)
	reTagWithUserName       = regexp.MustCompile(`.*User\ +(?P<USER>\w+).*`)
	templateTagWithUserName = "[USR] $USER $0"
)

func IsValidLine(text string) bool {
	return reIsValidLine.MatchString(text)
}

func SplitLogLine(text string) []string {
	return reSplitLogLine.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	count := 0
	for _, line := range lines {
		if reCountQuotedPasswords.MatchString(line) {
			count++
		}
	}

	return count
}

func RemoveEndOfLineText(text string) string {
	return reRemoveEndOfLineText.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	for index, line := range lines {
		lines[index] = reTagWithUserName.ReplaceAllString(line, templateTagWithUserName)
		// if match := reTagWithUserName.FindStringSubmatch(line); len(match)>0 {
		// 	lines[index]= fmt.Sprintf("[USR] %v %v", )
		// }
	}

	return lines
}
