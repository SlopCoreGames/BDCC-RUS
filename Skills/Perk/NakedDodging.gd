extends PerkBase

func _init():
	id = Perk.NakedDodging
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Обнажённая ловкость"

func getVisibleDescription():
	return "Чем меньше на тебе одежды, тем сложнее тебя схватить! Ты получаешь дополнительные 5% к шансу уклонения, когда на тебе ВООБЩЕ нет одежды."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/avoidance.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	if(npc.isFullyNaked()):
		return [
			buff(Buff.DodgeChanceBuff, [5.0])
		]
	return []
