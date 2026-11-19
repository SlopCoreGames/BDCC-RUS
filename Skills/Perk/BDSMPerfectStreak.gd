extends PerkBase

func _init():
	id = Perk.BDSMPerfectStreak
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Идеальная серия"

func getVisibleDescription():
	return "Пора сказать «КРАСНЫЙ» своим путам! Ты можешь продолжать мини-игру с вырыванием, пока идеально попадаешь в красную зону. Каждое идеальное попадание повышает эффективность твоих попыток вырваться на 25%."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/breaking-chain.png"

