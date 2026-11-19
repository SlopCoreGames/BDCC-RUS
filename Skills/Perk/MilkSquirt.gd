extends PerkBase

func _init():
	id = Perk.MilkSquirt
	skillGroup = Skill.Milking

func getVisibleName():
	return "Боевая корова"

func getVisibleDescription():
	return "Вы обретаете способность сжимать грудь, чтобы ослепить противника струями молока!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/goo-spurt.png"
