extends PerkBase

func _init():
	id = Perk.BreedStudV2
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Конь-производитель"

func getVisibleDescription():
	return "Ну и жеребец! Яйца у тебя всегда такие тяжелые! После каждого оргазма они мгновенно наполняются еще на 20%."

func getRequiredPerks():
	return [Perk.BreedStud]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/horse-head.png"

func getBuffs():
	return [
		buff(Buff.PenisCumGenerationAfterOrgasmBuff, [20]),
	]
