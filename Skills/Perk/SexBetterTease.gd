extends PerkBase

func _init():
	id = Perk.SexBetterTease
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Насмотренность на кинки"

func getVisibleDescription():
	return "You learn opponent's likes/dislikes faster when teasing"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/charm.png"

