extends PerkBase

func _init():
	id = Perk.StartNoHybrids
	skillGroup = Skill.Start

func getVisibleName():
	return "Без гибридов"

func getVisibleDescription():
	return "Ты никогда не родишь гибрида. Другие женщины, оплодотворенные твоей спермой, тоже никогда не родят гибридов. Гибрид — это смесь двух разных видов."
	
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

