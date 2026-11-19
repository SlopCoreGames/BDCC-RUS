extends PerkBase

func _init():
	id = Perk.FertilitySubmissiveAndBreedable
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Покорная и плодовитая"

func getVisibleDescription():
	return "Ты — знаменитая игрушка для размножения. Домы будут трахать тебя дольше обычного и никогда не будут кончать в себя во время вагинального или анального секса."

func getRequiredPerks():
	return [Perk.FertilityDesireToBreed]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilitySubmissiveAndBreedable.png"

