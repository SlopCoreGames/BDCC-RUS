extends PerkBase

func _init():
	id = Perk.MilkBiggerBreastsV2
	skillGroup = Skill.Milking

func getVisibleName():
	return "Мега-молоко"

func getVisibleDescription():
	return "Большая грудь — значит больше молока! А молока тебе много не бывает! Во время лактации размер твоей груди может увеличиться на один пункт."

func getRequiredPerks():
	return [Perk.MilkBiggerBreasts]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/biggerbreasts.png"

func getBuffs():
	return [
		buff(Buff.BreastsLactatingSizeLimitBuff, [1]),
	]
