extends PerkBase

func _init():
	id = Perk.StartInfertile
	skillGroup = Skill.Start

func getVisibleName():
	return "Бесплодие"

func getVisibleDescription():
	return "Что бы ты ни делала, забеременеть тебе всё равно не удастся"

func hiddenWhenLocked() -> bool:
	return true

func toggleable() -> bool:
	return false
	
func unlockable() -> bool:
	return false

func getCost():
	return 0
	
func getSkillTier():
	return 0

func getPicture():
	return "res://UI/StatusEffectsPanel/images/cuffshands.png"

