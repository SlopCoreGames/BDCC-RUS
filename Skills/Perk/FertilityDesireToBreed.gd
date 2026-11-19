extends PerkBase

func _init():
	id = Perk.FertilityDesireToBreed
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Безрассудные желания"

func getVisibleDescription():
	return "Твоя похотливая жажда настолько сильна, что ты намеренно пытаешься саботировать использование презервативов, увеличивая шанс их разрыва во время интимной близости с тобой в 3 раза.\n"\
			+ "Каждый испорченный презерватив вызывает у тебя прилив адреналина, который убирает [color="+DamageType.getColorString(DamageType.Physical)+"]20 pain[/color]!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityDesireToBreed.png"

func getBuffs():
	return []
