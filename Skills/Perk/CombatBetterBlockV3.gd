extends PerkBase

func _init():
	id = Perk.CombatBetterBlockV3
	skillGroup = Skill.Combat

func getVisibleName():
	return "Крепость"

func getVisibleDescription():
	return "Вы научились лучше блокировать удары руками. Теперь при блоке атаки вы получаете дополнительные [b]50[/b] брони"

func getRequiredPerks():
	return [Perk.CombatBetterBlock, Perk.CombatBetterBlockV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/armor-upgrade.png"

func getBuffs():
	return [
		buff(Buff.BlockArmorBuff, [50]),
	]
