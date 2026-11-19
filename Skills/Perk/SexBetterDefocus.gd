extends PerkBase

func _init():
	id = Perk.SexBetterDefocus
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Медитация"

func getVisibleDescription():
	return "Благодаря колоссальному опыту вы научились лучше дистанцироваться от атак [color="+DamageType.getColorString(DamageType.Lust)+"]похоти[/color] противников; теперь эффект дефокусировки сокращает получаемую похоть вдвое"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/distraction.png"

func getBuffs():
	return [
		buff(Buff.DefocusArmorBuff, [30]),
	]
