extends PerkBase

func _init():
	id = Perk.CombatDoubleDown
	skillGroup = Skill.Combat

func getVisibleName():
	return "Двойная ставка"

func getVisibleDescription():
	return "Твои рефлексы просто запредельные: теперь ты можешь реагировать на атаку противника, нанося повторный базовый физический удар ценой 10 единиц выносливости."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/revolt.png"

