extends PerkBase

func _init():
	id = Perk.CombatFullStaminaBonus
	skillGroup = Skill.Combat

func getVisibleName():
	return "Жажда власти"

func getVisibleDescription():
	return "К черту усталость. Если запас выносливости составляет 100 или более, вы наносите на 20% больше [color="+DamageType.getColorString(DamageType.Physical)+"]физического урона[/color]."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/biceps.png"

func getBuffs():
	if(npc.getStamina() >= 100):
		return [
			buff(Buff.PhysicalDamageBuff, [20]),
		]
	return []
