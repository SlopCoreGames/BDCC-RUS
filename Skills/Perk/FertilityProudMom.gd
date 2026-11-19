extends PerkBase

func _init():
	id = Perk.FertilityProudMom
	skillGroup = Skill.Fertility

func getVisibleName():
	return "Гордая мамочка"

func getVisibleDescription():
	return "AlphaCorp заметила твои старания и хочет помочь тебе стать лучшей матерью, на которую ты только способна.\n" \
			+ "Теперь вы можете заходить в детскую, чтобы раз в день получить бесплатное яблоко.\n" \
			+ "Пока вы беременны, шанс попасть в случайную встречу с персоналом снижен на 70%." #base chance is 30% + exposure, this sets it to 10% + exposure 

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/Skill_Icon_FertilityProudMom.png"
	
func getBuffs():
	if(npc.getMenstrualCycle().isVisiblyPregnant()):
		return [
			buff(Buff.EncounterChanceModifierStaffBuff, [-70])
		]
	return []
