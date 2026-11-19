extends PerkBase

func _init():
	id = Perk.MilkBiggerBreasts
	skillGroup = Skill.Milking

func getVisibleName():
	return "Много молока"

func getVisibleDescription():
	return "Ты обожаешь, когда тебя доят! Во время лактации твоя грудь может увеличиваться еще на один размер, позволяя удерживать больше молока."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/augmentation.png"

func getBuffs():
	return [
		buff(Buff.BreastsLactatingSizeLimitBuff, [1]),
	]
