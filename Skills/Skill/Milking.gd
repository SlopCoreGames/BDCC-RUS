extends SkillBase

func _init():
	id = Skill.Milking

func getVisibleName():
	return "Дойка"

func getVisibleDescription():
	return "Shows how much you like being milked"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
