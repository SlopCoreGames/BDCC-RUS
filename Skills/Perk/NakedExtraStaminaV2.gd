extends PerkBase

func _init():
	id = Perk.NakedExtraStaminaV2
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Первобытная мощь"

func getVisibleDescription():
	return "Когда одежда не мешает, можно гораздо больше: вы получаете [b]100[/b] дополнительной выносливости, если вы ПОЛНОСТЬЮ голышом"

func getRequiredPerks():
	return [Perk.NakedExtraStamina]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/speedometer.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	if(npc.isFullyNaked()):
		return [
			buff(Buff.MaxStaminaBuff, [100.0])
		]
	return []
