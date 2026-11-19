extends PerkBase

func _init():
	id = Perk.NakedNoShame
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Голая и гордая"

func getVisibleDescription():
	return "Вы больше не чувствуете стыда, когда на вас нет одежды; вам комфортно ходить голышом."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/nudity.png"

