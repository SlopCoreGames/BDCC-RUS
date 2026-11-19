extends PerkBase

func _init():
	id = Perk.CombatBetterBlockV2
	skillGroup = Skill.Combat

func getVisibleName():
	return "Бронежилет"

func getVisibleDescription():
	return "Вы научились лучше блокировать удары руками. Теперь при блоке вы получаете дополнительные 20 единиц брони."

func getRequiredPerks():
	return [Perk.CombatBetterBlock]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/armor.png"

func getBuffs():
	return [
		buff(Buff.BlockArmorBuff, [20]),
	]
