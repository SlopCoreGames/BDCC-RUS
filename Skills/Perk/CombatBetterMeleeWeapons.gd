extends PerkBase

func _init():
	id = Perk.CombatBetterMeleeWeapons
	skillGroup = Skill.Combat

func getVisibleName():
	return "Тупая сила"

func getVisibleDescription():
	return "Вам нравится использовать холодное оружие, чтобы получить преимущество в бою. Вы наносите на 15% больше урона в ближнем бою."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/telescopic-baton.png"

func getBuffs():
	return [
		buff(Buff.MeleeDamageBuff, [15]),
	]
