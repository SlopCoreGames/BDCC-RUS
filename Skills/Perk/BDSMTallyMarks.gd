extends PerkBase

func _init():
	id = Perk.BDSMTallyMarks
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Арифметика шлюх"

func getVisibleDescription():
	return "Тебе нравится, когда другие оставляют на твоем теле зарубки после того, как используют тебя. Каждая зарубка дает +1% [color="+DamageType.getColorString(DamageType.Lust)+"]урона похоти[/color]!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/tallymarks.png"

