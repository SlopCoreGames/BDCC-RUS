extends PerkBase

func _init():
	id = Perk.CombatDrunkenMaster
	skillGroup = Skill.Combat

func getVisibleName():
	return "Пьяный мастер"

func getVisibleDescription():
	return "Пьяный человек становится менее предсказуемым. Если уровень опьянения превышает 50%, вы получаете 10% бонуса к уклонению."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/booze.png"

func getBuffs():
	if(npc.has_method("getIntoxicationLevel") && npc.getIntoxicationLevel() >= 0.5):
		return [
			buff(Buff.DodgeChanceBuff, [10]),
		]
	return []
