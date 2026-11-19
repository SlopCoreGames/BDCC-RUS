extends PerkBase

func _init():
	id = Perk.HypnosisAmateurHypnotist
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Гипнотизер-любитель"

func getVisibleDescription():
	return "Вы освоили основы гипнотического искусства."

func getMoreDescription():
	return """Вы можете гипнотизировать согласную или достаточно подавленную цель. Можно внушать постгипнотические установки и активировать их в следующих встречах, накладывая один из эффектов:
	
Удовольствие (повышает [color="""+DamageType.getColorString(DamageType.Lust)+"""]Похоть[/color])
Усталость (снижает [color="""+DamageType.getColorString(DamageType.Stamina)+"""]Выносливость[/color])
На колени (сбивает с ног)
Отключка (оглушение)"""

func getSkillTier():
	return 1
	
func getCost():
	return 2

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/watch.png"

#maybe this should be one randomized attack?
func addsAttacks():
	return [
		"HypnoTriggerPleasure",
		"HypnoTriggerTiredness",
		"HypnoTriggerKneel",
		"HypnoTriggerStun"
	]
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
