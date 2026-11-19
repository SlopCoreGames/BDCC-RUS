extends PerkBase

func _init():
	id = Perk.FertilityBroodmother
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Матка-настоятельница"

func getVisibleDescription():
	return "Твоя утроба созрела для размножения, готовая выносить потомство любого, кто окажется достаточно доминантным, чтобы заявить на тебя права. \n"  \
			+ "Дебаффы беременности уменьшены на 50%. \n" \
			+ "Дебаффы фертильности уменьшены на 70%.\n" \
			+ "Шанс оплодотворения другим видом теперь такой же высокий, как и от своего собственного вида!" 
	
func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityBroodmother.png"

func getBuffs():
	return [
	]
