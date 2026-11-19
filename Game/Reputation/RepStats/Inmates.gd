extends RepStatBase

func _init():
	id = RepStat.Inmates

func getVisibleName():
	return "Репутация заключенных"

func getMaxLevel() -> int:
	return 4

func getMinLevel() -> int:
	return -1

func getTextForLevel(_level:int, _rep):
	if(_level <= -1):
		return "Pushover"
	if(_level == 0):
		return "Unknown"
	if(_level == 1):
		return "Свежая кровь"
	if(_level == 2):
		return "Known"
	if(_level == 3):
		return "Respected"
	if(_level == 4):
		return "Veteran"
	return "ALPHA"

#func getSpecialRequirementToReachLevel(_level:int, _rep):
#	if(_level == 3):
#		return ["enslavesomeone", "Enslave anyone"]
#	if(_level == 5):
#		return ["makeobey", "Make any slave submit to you.. or break their mind"]
#
#	return null

func getEffectsInfoForLevel(_level:int, _rep) -> Array:
	if(_level <= 1):
		return []
	if(_level <= 2):
		return [
			"С заключенными становится чуть проще заводить дружеские отношения.",
		]
	return [
		"С заключенными становится проще заводить дружеские отношения.",
	]
