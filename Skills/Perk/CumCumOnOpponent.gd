extends PerkBase

func _init():
	id = Perk.CumCumOnOpponent
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Кульминация"

func getVisibleDescription():
	return "Вы обретаете способность мастурбировать и кончать прямо во время боя"

func getMoreDescription():
	return "Эта способность снимает 50 единиц похоти, но использовать её можно, только если ваша [color="+DamageType.getColorString(DamageType.Lust)+"]похоть[/color] превышает 90%. Враг покрывается вашей спермой/девичьим соком и будет получать на 10% больше [color="+DamageType.getColorString(DamageType.Lust)+"]урона похотью[/color] в течение нескольких ходов"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/splurt.png"
