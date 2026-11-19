extends PerkBase

func _init():
	id = Perk.BreedCumVolume
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Бак с кончей"

func getVisibleDescription():
	return "После такого количества кончи ты чувствуешь, как яички наливаются тяжестью. Теперь они вмещают на 50% больше семени!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/cumtruck.png"

func getBuffs():
	return [
		buff(Buff.PenisBallsVolumeBuff, [50]),
	]
