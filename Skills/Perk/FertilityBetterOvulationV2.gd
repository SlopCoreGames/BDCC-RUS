extends PerkBase

func _init():
	id = Perk.FertilityBetterOvulationV2
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Режим ускоренного размножения"

func getVisibleDescription():
	return "Ваши репродуктивные органы работают на пределе возможностей, чтобы вы могли зачать как можно больше детей. \n" \
			+ "Максимальное количество яйцеклеток, выбрасываемых за одну фазу овуляции, увеличивается еще больше, а фертильность повышается на 20%"
	
func getRequiredPerks():
	return [Perk.FertilityBetterOvulation]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityBetterOvulationV2.png"

func getBuffs():
	return [
		buff(Buff.OvulationEggsAmountBuff, [100]),
		buff(Buff.FertilityBuff, [20]),
	]
