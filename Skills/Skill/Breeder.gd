extends SkillBase

func _init():
	id = Skill.Breeder

func getVisibleName():
	return "Осеменитель"

func getVisibleDescription():
	return "Показывает, насколько сильно вам нравится кончать в других и оплодотворять их"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
