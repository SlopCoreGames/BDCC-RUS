extends PerkBase

func _init():
	id = Perk.FertilityMotherOfTheYear
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Мать года"

func getVisibleDescription():
	return "Корпорация заметила твои старания и хочет вознаградить тебя!\n" \
			+ "После родов вы получаете статус «Материнское сияние» на 2 дня.\n" \
			+ "AlphaCorp будет перечислять вам кредиты за каждую рожденную особь (максимум до 20 за раз)."
	
func getRequiredPerks():
	return [Perk.FertilitySubmissiveAndBreedable]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityMotherOfTheYear.png"

