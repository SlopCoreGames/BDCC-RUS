extends SkillBase

func _init():
	id = Skill.BDSM

func getVisibleName():
	return "BDSM"

func getVisibleDescription():
	return "Показывает, насколько вы привыкли к ограничению подвижности"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
