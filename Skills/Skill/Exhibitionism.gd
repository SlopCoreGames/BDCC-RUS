extends SkillBase

func _init():
	id = Skill.Exhibitionism

func getVisibleName():
	return "Эксгибиционизм"

func getShortName():
	return "Выставить напоказ."
	
func getVisibleDescription():
	return "Shows how used you are to being completely naked in public"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
