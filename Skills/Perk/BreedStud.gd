extends PerkBase

func _init():
	id = Perk.BreedStud
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Жеребец"

func getVisibleDescription():
	return "Ты настоящий жеребец: после оргазма твои яйца стремительно наполняются на 10%, чтобы ты никогда не оставался пустым."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/horse.png"

func getBuffs():
	return [
		buff(Buff.PenisCumGenerationAfterOrgasmBuff, [10]),
	]
