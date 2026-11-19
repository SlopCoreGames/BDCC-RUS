extends PerkBase

func _init():
	id = Perk.BDSMCollector
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Коллекционер снаряжения"

func getVisibleDescription():
	return "Вы научились выбираться из пут, не повреждая их, и теперь можете припрятать их для использования в будущем."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/locked-heart.png"

