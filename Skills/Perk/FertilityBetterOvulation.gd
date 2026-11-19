extends PerkBase

func _init():
	id = Perk.FertilityBetterOvulation
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Улучшенная овуляция"

func getVisibleDescription():
	return "Ваше тело адаптируется к производству большего количества потомства. Количество яйцеклеток, выбрасываемых во время каждой фазы овуляции, увеличилось."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityBetterOvulation.png"

func getBuffs():

	return [
		buff(Buff.OvulationEggsAmountBuff, [50]),
		buff(Buff.MinOvulationEggsAmountBuff, [3]),
	]
