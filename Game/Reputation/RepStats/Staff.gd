extends RepStatBase

func _init():
	id = RepStat.Staff

func getVisibleName():
	return "Репутация персонала"

func getMaxLevel() -> int:
	return 4

func getMinLevel() -> int:
	return -1

func getTextForLevel(_level:int, _rep):
	if(_level <= -1):
		return "Insignificant"
	if(_level == 0):
		return "Unknown"
	if(_level == 1):
		return "Troublemaker"
	if(_level == 2):
		return "Rebel"
	if(_level == 3):
		return "Respected"
	if(_level == 4):
		return "Угроза тюрьме"
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
			"С персоналом чуть проще заводить дружбу.",
		]
	return [
		"С персоналом проще заводить дружбу.",
	]
