extends PerkBase

func _init():
	id = Perk.StartMaleChastity
	skillGroup = Skill.Start

func getVisibleName():
	return "Пояс верности"

func getVisibleDescription():
	return "Во время процесса приема на тебя наденут [b]постоянную[/b] клетку целомудрия. Применяется только если у тебя есть пенис."

func hiddenWhenLocked() -> bool:
	return true

func hiddenWhenUnlocked() -> bool:
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

