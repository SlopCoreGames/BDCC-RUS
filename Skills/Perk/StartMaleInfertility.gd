extends PerkBase

func _init():
	id = Perk.StartMaleInfertility
	skillGroup = Skill.Start

func getVisibleName():
	return "Бесплодие (М)"

func getVisibleDescription():
	return "Твоя сперма не может никого зачать, что бы ты ни делал"
	
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

