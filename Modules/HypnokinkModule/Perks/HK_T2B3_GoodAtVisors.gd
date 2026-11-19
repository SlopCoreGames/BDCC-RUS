extends PerkBase

func _init():
	id = Perk.HypnosisGoodAtVisors
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Мудрость визора"

func getVisibleDescription():
	return "Вы досконально изучили все ощущения от ношения гипнотического визора."
	
func getMoreDescription():
	return 	"Теперь вы можете попытаться снять гипнотический визор даже в "+HypnokinkUtil.tranceIcon()+"трансе."+"\n\n"+\
			"Принудительное надевание гипнотического визора заставляет уровень гипноза противника мгновенно подняться до 30%, если он был ниже этого значения."

func getSkillTier():
	return 1
	
func getCost():
	return 2

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/visor2.png"
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
