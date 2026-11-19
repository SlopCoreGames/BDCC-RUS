extends PerkBase

func _init():
	id = Perk.BreedCumProduction
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Плодовитый сеятель"

func getVisibleDescription():
	return "Твои яйца начинают адаптироваться к образу жизни заводчика и теперь наполняются на 25% f быстрее"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/sperm1.png"

func getBuffs():
	return [
		buff(Buff.PenisCumProductionBuff, [25]),
	]
