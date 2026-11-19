extends PerkBase

func _init():
	id = Perk.SexLustPassion
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Интерес к похоти"

func getVisibleDescription():
	return "Секс вас не утомляет. Напротив, каждый раз, когда вы занимаетесь оральным, вагинальным или анальным сексом, вы восстанавливаете 10 [color="+DamageType.getColorString(DamageType.Stamina)+"]единиц выносливости[/color]!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/hearts.png"

func getBuffs():
	return [
		buff(Buff.StaminaRecoverAfterSexBuff, [10]),
	]
