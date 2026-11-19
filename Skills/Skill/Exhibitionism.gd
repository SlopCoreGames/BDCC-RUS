extends SkillBase

func _init():
	id = Skill.Exhibitionism

func getVisibleName():
	return "Эксгибиционизм"

func getShortName():
	return "Выставить напоказ."
	
func getVisibleDescription():
	return "Показывает, насколько вы привыкли к полному отсутствию одежды на публике"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
