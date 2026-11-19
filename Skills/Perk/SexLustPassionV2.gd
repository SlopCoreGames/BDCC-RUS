extends PerkBase

func _init():
	id = Perk.SexLustPassionV2
	skillGroup = Skill.SexSlave

func getVisibleName():
	return "Страсть к похоти"

func getVisibleDescription():
	return "Ты обожаешь секс! Каждый раз, когда ты занимаешься оральным, вагинальным или анальным сексом, ты восстанавливаешь 20 [color="+DamageType.getColorString(DamageType.Stamina)+"]единиц выносливости[/color]!"

func getRequiredPerks():
	return [Perk.SexLustPassion]

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/cherish.png"

func getBuffs():
	return [
		buff(Buff.StaminaRecoverAfterSexBuff, [20]),
	]
