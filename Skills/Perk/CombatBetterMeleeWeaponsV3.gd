extends PerkBase

func _init():
	id = Perk.CombatBetterMeleeWeaponsV3
	skillGroup = Skill.Combat

func getVisibleName():
	return "Сила Разрушения"

func getVisibleDescription():
	return "Вы обожаете смотреть, как враги падают к вашим ногам. А умение мастерски владеть оружием определенно помогает в этом деле. Вы наносите на [b]50%[/b] больше урона в ближнем бою."

func getRequiredPerks():
	return [Perk.CombatBetterMeleeWeapons, Perk.CombatBetterMeleeWeaponsV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/spiked-bat.png"

func getBuffs():
	return [
		buff(Buff.MeleeDamageBuff, [50]),
	]
