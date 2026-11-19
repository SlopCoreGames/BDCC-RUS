extends PerkBase

func _init():
	id = Perk.MilkFasterProductionV2
	skillGroup = Skill.Milking

func getVisibleName():
	return "Любитель молочка"

func getVisibleDescription():
	return "Ты — настоящая молочная корова. Твои гордые девчонки начали давать молоко на 50% f быстрее"

func getRequiredPerks():
	return [Perk.MilkFasterProduction]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/breast-pump.png"

func getBuffs():
	return [
		buff(Buff.BreastsMilkProductionBuff, [50]),
	]
