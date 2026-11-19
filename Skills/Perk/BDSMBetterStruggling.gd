extends PerkBase

func _init():
	id = Perk.BDSMBetterStruggling
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Дева Успеха"

func getVisibleDescription():
	return "Вы научились максимально эффективно сбрасывать с себя путы: если пройти мини-игру на сопротивление идеально, эффективность ваших попычек удвоится."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/andromeda-chain.png"

