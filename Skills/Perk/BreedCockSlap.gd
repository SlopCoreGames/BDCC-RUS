extends PerkBase

func _init():
	id = Perk.BreedCockSlap
	skillGroup = Skill.Breeder

func getVisibleName():
	return "Размер имеет значение"

func getVisibleDescription():
	return "Используй мощь своего члена, чтобы вбивать врагов в землю! Ты получаешь новую особую атаку «Шлепок членом», сила которой зависит от веса твоего достоинства (то есть от того, сколько в нем накопилось спермы)!"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/cockslap.png"

func getBuffs():
	return [
	]

func addsAttacks():
	return ["CockSlapPCAttack"]
