extends PerkBase

func _init():
	id = Perk.BDSMRiggerV2
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Жаждущая Риггерша"

func getVisibleDescription():
	return "Вы стали опытнее в связывании людей. Шанс принудительно надеть на кого-то средство фиксации увеличивается на 10%, а также вы восстанавливаете 20% of фиксаторов, когда враг вырывается из них."

func getRequiredPerks():
	return [Perk.BDSMRigger]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/cage.png"

func getBuffs():
	return [
		buff(Buff.RestraintRecoveryBuff, [20]),
		buff(Buff.RestraintForcingSuccessBuff, [10]),
	]
