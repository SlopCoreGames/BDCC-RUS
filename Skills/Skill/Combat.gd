extends SkillBase

func _init():
	id = Skill.Combat

func getVisibleName():
	return "Бой"

func getVisibleDescription():
	return "Показывает, насколько хорошо вы владеете навыками рукопашного боя"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
