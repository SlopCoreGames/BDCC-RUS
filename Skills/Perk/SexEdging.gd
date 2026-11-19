extends PerkBase

func _init():
	id = Perk.SexEdging
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Эджинг"

func getVisibleDescription():
	return "Вы обожаете балансировать на грани. Вы наносите на 50% больше [color="+DamageType.getColorString(DamageType.Lust)+"]возбуждения[/color], когда ваш уровень желания превышает 90%"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/leak.png"

func getBuffs():
	if(npc.getLustLevel() >= 0.9):
		return [
			buff(Buff.LustDamageBuff, [50])
		]

	return []
