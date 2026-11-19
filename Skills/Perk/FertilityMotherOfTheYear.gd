extends PerkBase

func _init():
	id = Perk.FertilityMotherOfTheYear
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Мать года"

func getVisibleDescription():
	return "Корпорация заметила твои старания и хочет вознаградить тебя!\n" \
			+ "You receive a 'Maternal Glow' status effect for 2 days after giving birth.\n" \
			+ "AlphaCorp will transfer credits to you for each birth (up to 20 per birth)."
	
func getRequiredPerks():
	return [Perk.FertilitySubmissiveAndBreedable]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityMotherOfTheYear.png"

