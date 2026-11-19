extends PerkBase

func _init():
	id = Perk.BreedCumVolumeV3
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Чемпион размножения"

func getVisibleDescription():
	return "В твоих яйцах столько качественного семени, что становится даже жутковато. Емкость яиц и твоя вирильность увеличиваются на 25% и 10% соответственно за каждую единицу показателя Витальности."

func getRequiredPerks():
	return [Perk.BreedCumVolumeV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/cumtanker.png"

func getBuffs():
	return [
		buff(Buff.PenisBallsVolumeBuff, [25 * npc.getStat(Stat.Vitality)]),
		buff(Buff.VirilityBuff, [10 * npc.getStat(Stat.Vitality)]),
	]
