extends PerkBase

func _init():
	id = Perk.CombatBetterMeleeWeaponsV2
	skillGroup = Skill.Combat

func getVisibleName():
	return "Множитель силы"

func getVisibleDescription():
	return "Зачем махать кулаками, когда тюрьма буквально усыпана контрабандным оружием? Вы наносите на 35% больше урона в ближнем бою."

func getRequiredPerks():
	return [Perk.CombatBetterMeleeWeapons]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/stiletto.png"

func getBuffs():
	return [
		buff(Buff.MeleeDamageBuff, [35]),
	]
