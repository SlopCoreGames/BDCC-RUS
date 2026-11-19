extends PerkBase

func _init():
	id = Perk.CombatBetterGetUp
	skillGroup = Skill.Combat

func getVisibleName():
	return "Вскочить"

func getVisibleDescription():
	return "Благодаря всей вашей боевой практике вы научились правильно падать. Теперь вы будете подниматься с бонусом % c100%, и даже сможете сделать это в тот же ход, когда вас сбили с ног."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/upgrade.png"
