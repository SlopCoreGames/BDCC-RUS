extends SkillBase

func _init():
	id = Skill.Fertility

func getVisibleName():
	return "Плодовитость"

func getVisibleDescription():
	return "Показывает, насколько вы привыкли к тому, что вас оплодотворяют местные обитатели"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
