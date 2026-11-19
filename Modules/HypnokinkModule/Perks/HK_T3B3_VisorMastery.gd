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
			"Принудительное надевание гипнотического визора мгновенно повышает уровень гипноза противника до 50%, если текущее значение ниже этого порога."

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
