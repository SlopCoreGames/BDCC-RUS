extends PerkBase

func _init():
	id = Perk.CombatBetterBlock
	skillGroup = Skill.Combat

func getVisibleName():
	return "Стена"

func getVisibleDescription():
	return "Вы научились лучше блокировать удары руками. Теперь при блоке вы получаете дополнительные 10 единиц брони. Каждые 50 единиц брони уменьшают входящий урон вдвое."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/mansory.png"

func getBuffs():
	return [
		buff(Buff.BlockArmorBuff, [10]),
	]
