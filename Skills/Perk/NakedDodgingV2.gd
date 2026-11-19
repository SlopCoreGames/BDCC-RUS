extends PerkBase

func _init():
	id = Perk.NakedDodgingV2
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Голый ниндзя"

func getVisibleDescription():
	return "Ой, ты забыл одежду. Но это их проблемы! Вы получаете +5% к шансу уклонения, когда вы ПОЛНОСТЬЮ голышом."

func getRequiredPerks():
	return [Perk.NakedDodging]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/scrum.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	if(npc.isFullyNaked()):
		return [
			buff(Buff.DodgeChanceBuff, [5.0])
		]
	return []
