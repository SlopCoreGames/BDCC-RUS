extends PerkBase

func _init():
	id = Perk.MilkBiggerBreastsV3
	skillGroup = Skill.Milking

func getVisibleName():
	return "Гига-молоко"

func getVisibleDescription():
	return "Доить — это так приятно! Твои вымени должны производить еще больше молока! Молоко, молоко, молоко! Твоя грудь может увеличиться на [b]ДВА[/b] дополнительных размера во время лактации"

func getRequiredPerks():
	return [Perk.MilkBiggerBreasts, Perk.MilkBiggerBreastsV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/verybigbreast.png"

func getBuffs():
	return [
		buff(Buff.BreastsLactatingSizeLimitBuff, [2]),
	]
