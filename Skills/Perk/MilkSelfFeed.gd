extends PerkBase

func _init():
	id = Perk.MilkSelfFeed
	skillGroup = Skill.Milking

func getVisibleName():
	return "Молочный наркоман"

func getVisibleDescription():
	return "You gain the ability to self-feed yourself by squeezing milk into your mouth, relieving pain depending on the amount!"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/baby-bottle.png"
