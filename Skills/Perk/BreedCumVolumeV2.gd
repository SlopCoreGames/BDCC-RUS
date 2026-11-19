extends PerkBase

func _init():
	id = Perk.BreedCumVolumeV2
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Божественная выносливость"

func getVisibleDescription():
	return "Ты не зря старался. И теперь это начинает приносить плоды. Теперь твои яйца вмещают на 10% больше семени за каждый пункт Ловкости."

func getRequiredPerks():
	return [Perk.BreedCumVolume]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/cumstorage.png"

func getBuffs():
	return [
		buff(Buff.PenisBallsVolumeBuff, [10 * npc.getStat(Stat.Agility)]),
	]
