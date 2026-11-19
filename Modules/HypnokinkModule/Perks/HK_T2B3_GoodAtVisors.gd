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
			"When forcing an opponent to wear a hypnotic visor, their hypnosis level will immediately rise to 30% if it is lower."

func getSkillTier():
	return 1
	
func getCost():
	return 2

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/visor2.png"
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
