extends PerkBase

func _init():
	id = Perk.SexBiter
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Извращенная шалава"

func getVisibleDescription():
	return "Ты знаешь, как использовать свой рот эффективнее: твои укусы вызывают больше кровотечения и наносят больше урона."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/fangs.png"

