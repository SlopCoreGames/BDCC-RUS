extends PerkBase

func _init():
	id = Perk.NakedDodgingV3
	skillGroup = Skill.Exhibitionism

func getVisibleName():
	return "Обнаженное веселье"

func getVisibleDescription():
	return "Давай раздеваться! Вы получаете [b]10%[/b] дополнительного шанса уклонения, когда вы ПОЛНОСТЬЮ голы"

func getRequiredPerks():
	return [Perk.NakedDodging, Perk.NakedDodgingV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/acrobatic.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	if(npc.isFullyNaked()):
		return [
			buff(Buff.DodgeChanceBuff, [10.0])
		]
	return []
