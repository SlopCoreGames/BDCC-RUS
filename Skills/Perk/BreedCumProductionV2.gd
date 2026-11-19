extends PerkBase

func _init():
	id = Perk.BreedCumProductionV2
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Фабрика семян"

func getVisibleDescription():
	return "Тебе всё мало их разводить. Теперь твои яйца производят сперму на 75% f быстрее."

func getRequiredPerks():
	return [Perk.BreedCumProduction]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/sperm3.png"

func getBuffs():
	return [
		buff(Buff.PenisCumProductionBuff, [75]),
	]
