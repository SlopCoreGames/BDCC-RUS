extends PerkBase

func _init():
	id = Perk.CombatShove
	skillGroup = Skill.Combat

func getVisibleName():
	return "Толкание"

func getVisibleDescription():
	return "Вы получаете способность отталкивать противника плечом, что может привести к его падению."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/armor-downgrade.png"

func addsAttacks():
	return ["shoveattack"]
