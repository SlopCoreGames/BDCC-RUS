extends PerkBase

func _init():
	id = Perk.FertilityBellySize
	skillGroup = Skill.Fertility
	dungeonWeight = 0.0

func getVisibleName():
	return "Материнская интуиция"

func getVisibleDescription():
	return "Ты настолько набила руку на беременности, что теперь можешь примерно определить количество детенышей в животе, просто оценив его размер и частоту толчков. (Стакается с перком «Проницательность» [Insight of You])"
	
func getRequiredPerks():
	return []

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/pregnantmother.png"

func getBuffs():
	return [
	]
