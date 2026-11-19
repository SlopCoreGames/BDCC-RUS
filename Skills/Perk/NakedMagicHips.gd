extends PerkBase

func _init():
	id = Perk.NakedMagicHips
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Магические бёдра"

func getVisibleDescription():
	return "Покачивание бедрами перед противником может заставить его ослабить волю перед вашим телом с усилением на 20% c! Шанс растет вместе с показателем витальности"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/hips.png"

