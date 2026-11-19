extends PerkBase

func _init():
	id = Perk.NakedExtraStamina
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Быстрые перекаты"

func getVisibleDescription():
	return "Вся эта одежда тебя только тормозит; если ты СОВСЕМ голышом, получаешь дополнительные 50 единиц выносливости."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/running.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	if(npc.isFullyNaked()):
		return [
			buff(Buff.MaxStaminaBuff, [50.0])
		]
	return []
