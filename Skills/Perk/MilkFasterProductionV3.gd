extends PerkBase

func _init():
	id = Perk.MilkFasterProductionV3
	skillGroup = Skill.Milking

func getVisibleName():
	return "Молочная фабрика"

func getVisibleDescription():
	return "Твоя грудь становится такой тяжелой и приятной, что ты не можешь думать ни о чем другом. Твои вымена начинают вырабатывать молоко [b]120%[/b] быстрее"

func getRequiredPerks():
	return [Perk.MilkFasterProduction, Perk.MilkFasterProductionV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/udder.png"

func getBuffs():
	return [
		buff(Buff.BreastsMilkProductionBuff, [120]),
	]
