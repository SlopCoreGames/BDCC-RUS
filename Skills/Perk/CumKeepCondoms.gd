extends PerkBase

func _init():
	id = Perk.CumKeepCondoms
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Кондомная шлюшка"

func getVisibleDescription():
	return "Презервативы! Ты так обожаешь использованные, полные презервативы, что будешь изо всех сил стараться сохранить их после секса."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/usedcondom.png"

