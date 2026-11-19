extends PerkBase

func _init():
	id = Perk.CumBreathV1
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Экспериментатор с жидкостями"

func getVisibleDescription():
	return "Зачем ограничиваться только поеданием спермы, ведь можно попробовать и другие вкусы. Разные жидкости в твоем животе будут давать тебе разные (или даже более мощные) баффы."

func getRequiredPerks():
	return [Perk.CumBreath]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/funnel.png"

