extends PerkBase

func _init():
	id = Perk.BDSMBlindfold
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Истинное зрение"

func getVisibleDescription():
	return "Ты привык к повязке на глазах и научился меньше полагаться на зрение. Задействуя остальные чувства, ты теперь можешь ориентироваться практически в любом пространстве."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/warlock-eye.png"

