extends PerkBase

func _init():
	id = Perk.SexBiter
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Извращенная шалава"

func getVisibleDescription():
	return "You know how to use your mouth more effectively, your bites cause more bleeding and do more damage"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/fangs.png"

