extends PerkBase

func _init():
	id = Perk.SexDefocusNeverLose
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Зависание в пространстве"

func getVisibleDescription():
	return "Вы научились контролировать свои похотливые мысли: при дефокусировке вы НИКОГДА не потеряете [color="+DamageType.getColorString(DamageType.Lust)+"]урон похоти[/color], если только вы еще не достигли пика"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/loveflame.png"

