extends RepStatBase

func _init():
	id = RepStat.Alpha

func getVisibleName():
	return "Репутация Альфы"

func getMaxLevel() -> int:
	return 6

func getMinLevel() -> int:
	return -1

# Opposite of Alpha is Doormat
func getTextForLevel(_level:int, _rep):
	if(_level <= -1):
		return "Doormat"
	if(_level == 0):
		return "Unknown"
	if(_level == 1):
		return "Someone"
	if(_level == 2):
		return "Слабый доминант"
	if(_level == 3):
		return "Slaver"
	if(_level == 4):
		return "Вожак стаи"
	if(_level == 5):
		return "Ломатель разума"
	if(_level == 6):
		return "Альфа тюрьмы"
	return "ALPHA"

func getSpecialRequirementToReachLevel(_level:int, _rep):
	if(_level == 3):
		return ["enslavesomeone", "Порабощение любого"]
	if(_level == 5):
		return ["makeobey", "Любой раб подчинится вам... или вы сломаете ему разум"]
	
	return null

func getEffectsInfoForLevel(_level:int, _rep) -> Array:
	if(_level <= 1):
		return []
	if(_level <= 3):
		return [
			"Сабмиссивные люди чуть охотнее соглашаются, чтобы их трахнули.",
		]
	if(_level <= 5):
		return [
			"Сабмиссивные люди гораздо охотнее соглашаются, чтобы их трахнули.",
			"Вы зарабатываете больше кредитов как сервисный доминант.",
		]
	return [
		"Люди жаждут, чтобы вы их трахнули.",
		"Вы зарабатываете больше кредитов как сервисный доминант.",
		"Ты можешь порабощать сабби-людей, даже не ломая их волю.",
	]
