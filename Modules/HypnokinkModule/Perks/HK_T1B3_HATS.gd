extends PerkBase

func _init():
	id = Perk.HypnosisHATS
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "H.A.T.S."

func getVisibleDescription():
	return "Вы привыкли к подсознательным сообщениям гипнотических визоров."

func getMoreDescription():
	return "Находясь в "+HypnokinkUtil.tranceIcon()+"Транс: дебафф точности от гипнотических визоров превращается в бафф эквивалентного значения."

func getSkillTier():
	return 0
	
func getCost():
	return 1

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/visor1.png"
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
