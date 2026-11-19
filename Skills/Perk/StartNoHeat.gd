extends PerkBase

func _init():
	id = Perk.StartNoHeat
	skillGroup = Skill.Start

func getVisibleName():
	return "Без течки"

func getVisibleDescription():
	return "У тебя не возникает периодического желания быть осемененной. Действует только при наличии матки."

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

