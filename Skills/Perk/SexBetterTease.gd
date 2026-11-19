extends PerkBase

func _init():
	id = Perk.SexBetterTease
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Насмотренность на кинки"

func getVisibleDescription():
	return "При соблазнении вы быстрее узнаете о вкусах и предпочтениях противника"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/charm.png"

