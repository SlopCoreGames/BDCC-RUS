extends SkillBase

func _init():
	id = Skill.SexSlave

func getVisibleName():
	return "Секс-рабыня"

func getVisibleDescription():
	return "Показывает, насколько хорошо вы умеете трахаться с другими"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
