extends PerkBase

func _init():
	id = Perk.SexLustPassionV3
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Похоть как зависимость"

func getVisibleDescription():
	return "Без секса жизнь не мила! Каждый раз, когда вы занимаетесь оральным, вагинальным или анальным сексом, вы восстанавливаете 50 [color="+DamageType.getColorString(DamageType.Stamina)+"]единиц выносливости[/color]!"

func getRequiredPerks():
	return [Perk.SexLustPassion, Perk.SexLustPassionV2]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/heartwings.png"

func getBuffs():
	return [
		buff(Buff.StaminaRecoverAfterSexBuff, [50]),
	]
