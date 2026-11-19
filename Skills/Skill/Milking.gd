extends SkillBase

func _init():
	id = Skill.Milking

func getVisibleName():
	return "Дойка"

func getVisibleDescription():
	return "Показывает, насколько вам нравится, когда вас доят"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
