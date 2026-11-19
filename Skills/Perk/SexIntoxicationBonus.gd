extends PerkBase

func _init():
	id = Perk.SexIntoxicationBonus
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Нимфоманка"

func getVisibleDescription():
	return "Секс в состоянии опьянения — это то, что ты обожаешь. Желательно — одновременно. Теперь негативные эффекты от алкоголя бьют по тебе слабее."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/boba.png"

