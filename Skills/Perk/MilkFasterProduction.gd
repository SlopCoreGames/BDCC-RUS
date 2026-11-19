extends PerkBase

func _init():
	id = Perk.MilkFasterProduction
	skillGroup = Skill.Milking

func getVisibleName():
	return "Любительница молока"

func getVisibleDescription():
	return "Тебя доят так часто, что твоя грудь начала вырабатывать молоко на 30% fасте"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/drop.png"

func getBuffs():
	return [
		buff(Buff.BreastsMilkProductionBuff, [30]),
	]
