extends PerkBase

func _init():
	id = Perk.NakedStunningLips
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Ошеломляющие губы"

func getVisibleDescription():
	return "Облизывание губ, когда похоть противника превышает 30%, может отвлечь его непристойными мыслями, оглушая его с усилением на 10% c! Шанс растет вместе с вашей сексуальностью"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/lips.png"

