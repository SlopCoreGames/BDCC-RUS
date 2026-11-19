extends PerkBase

func _init():
	id = Perk.BDSMGagTalk
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Речь при кляпе"

func getVisibleDescription():
	return "Ты привык говорить сквозь кляп, и теперь люди понимают тебя лучше — да и ты сам тоже. Правда, слюни всё так же текут ручьём."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/gag.png"

