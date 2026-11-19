extends PerkBase

func _init():
	id = Perk.HypnosisVisorMastery
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "ВЗЛОМ РАЗУМА"

func getVisibleDescription():
	return "Вы обнаружили, где спрятана кнопка меню конфигурации на гипнотических визорах."

func getMoreDescription():
	return 	"Теперь вы можете программировать гипнотические визоры так, чтобы они подавляли ваши недостатки гипноза."+"\n\n"+\
			"When forcing an opponent to wear a hypnotic visor, their hypnosis level will immediately rise to 50% if it is lower."

func getSkillTier():
	return 2
	
func getCost():
	return 3
	
func getRequiredPerks():
	return [Perk.HypnosisGoodAtVisors]

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/visor3.png"
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
