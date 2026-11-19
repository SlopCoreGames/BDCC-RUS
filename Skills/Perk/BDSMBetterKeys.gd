extends PerkBase

func _init():
	id = Perk.BDSMBetterKeys
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Осторожнее, малявка"

func getVisibleDescription():
	return "Вы научились лучше балансировать ключ для фиксации, когда ваши руки связаны. Теперь при попытке что-то отпереть у вас есть 2 дополнительные попытки, прежде чем ключ выпадет из рук."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/lock-picking.png"

