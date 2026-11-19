extends PerkBase

func _init():
	id = Perk.MilkNoSoreNipples
	skillGroup = Skill.Milking

func getVisibleName():
	return "Мууу"

func getVisibleDescription():
	return "Твоя грудь так привыкла к дойке, что после неё больше не болит. Доись сколько влезет!"

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/milk-carton.png"

func getBuffs():
	return [
	]
