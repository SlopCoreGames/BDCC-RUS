extends PerkBase

func _init():
	id = Perk.BreedCumProductionV3
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Сила природы"

func getVisibleDescription():
	return "Прими свою роль совершенного заводчика. Теперь твои яйца производят на 50% f быстрее плюс дополнительные 10% f за каждую единицу Силы! Твоя выработка спермы теперь не знает границ!"

func getRequiredPerks():
	return [Perk.BreedCumProductionV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/sperm5.png"

func getBuffs():
	return [
		buff(Buff.PenisCumProductionBuff, [50 + npc.getStat(Stat.Strength) * 10]),
	]
