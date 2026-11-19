extends PerkBase

func _init():
	id = Perk.FertilityPainTolerance
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Болевой порог"

func getVisibleDescription():
	return "Жизнь в тюрьме — штука тяжелая, особенно если ты постоянно беременна; все испытания, через которые тебе пришлось пройти, сделали тебя гораздо выносливее. \n" \
			+ "Resistance to physical damage +10% \n" \
			+ "Maximum stamina +30" #maybe add as percentage total, like +10% total stamina

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityPainTolerance.png"

func getBuffs():
	return [
		buff(Buff.ReceivedPhysicalDamageBuff, [-10]),
		buff(Buff.MaxStaminaBuff, [30.0]),
	]
