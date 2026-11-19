extends Object
class_name RecruitDifficulty

const VeryEasy := 0
const Easy := 1
const Medium := 2
const Hard := 3

static func getName(_diff:int) -> String:
	if(_diff == VeryEasy):
		return "Очень легко"
	if(_diff == Easy):
		return "Easy"
	if(_diff == Medium):
		return "Medium"
	if(_diff == Hard):
		return "Hard"
	return "Unknown"

static func getDifficultyText(_diff:int) -> String:
	if(_diff == VeryEasy):
		return "Допускается 3 желтых"
	if(_diff == Easy):
		return "Допускается 2 желтых"
	if(_diff == Medium):
		return "Допускается 2 желтых"
	if(_diff == Hard):
		return "Допускается 1 желтый"
	return "Unknown"

static func getDifficultyYellowAmount(_diff:int) -> int:
	if(_diff == VeryEasy):
		return 3
	if(_diff == Easy):
		return 2
	if(_diff == Medium):
		return 2
	if(_diff == Hard):
		return 1
	return 0
