extends PerkBase

func _init():
	id = Perk.FertilityBetterOvulationV3
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Аномальная беременность"

func getVisibleDescription():
	return "Текущая беременность не мешает овуляции или наступлению течки. Получайте больше шансов заполнить свое чрево потомством до самого предела."

func getRequiredPerks():
	return [Perk.FertilityBetterOvulationV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityBetterOvulationV3.png"

