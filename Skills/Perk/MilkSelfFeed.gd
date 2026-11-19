extends PerkBase

func _init():
	id = Perk.MilkSelfFeed
	skillGroup = Skill.Milking

func getVisibleName():
	return "Молочный наркоман"

func getVisibleDescription():
	return "Вы обретаете способность кормить себя самостоятельно, выдавливая молоко прямо в рот, что облегчает боль в зависимости от количества съеденного!"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/baby-bottle.png"
