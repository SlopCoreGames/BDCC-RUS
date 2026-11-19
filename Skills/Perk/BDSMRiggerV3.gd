extends PerkBase

func _init():
	id = Perk.BDSMRiggerV3
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Профессиональный риггер"

func getVisibleDescription():
	return "Ты настоящий профи в превращении людей в «канатных кроликов». Даже если они об этом не просили. Твои шансы насильно наложить на кого-то путы увеличиваются на 30%, а во время боев ты также восстанавливаешь дополнительные 30% o% ограничений."

func getRequiredPerks():
	return [Perk.BDSMRigger, Perk.BDSMRiggerV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/bdsmlogo.png"

func getBuffs():
	return [
		buff(Buff.RestraintRecoveryBuff, [30]),
		buff(Buff.RestraintForcingSuccessBuff, [30]),
	]
