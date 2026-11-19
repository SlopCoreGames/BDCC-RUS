extends PerkBase

func _init():
	id = Perk.CombatScratching
	skillGroup = Skill.Combat

func getVisibleName():
	return "Чесать-чесать!"

func getVisibleDescription():
	return "Вы научились использовать когти в бою, поэтому иногда ваши удары кулаками будут вызывать кровотечение."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/grasping-claws.png"
