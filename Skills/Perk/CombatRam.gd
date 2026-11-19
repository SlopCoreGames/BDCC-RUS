extends PerkBase

func _init():
	id = Perk.CombatRam
	skillGroup = Skill.Combat

func getVisibleName():
	return "Таранный удар"

func getVisibleDescription():
	return "Внутри тебя заперт разъяренный бык. Ты обретаешь особую способность таранить врагов и оглушать их ценой в 50 единиц выносливости."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/whip.png"

func addsAttacks():
	return ["RamPCAttack"]
