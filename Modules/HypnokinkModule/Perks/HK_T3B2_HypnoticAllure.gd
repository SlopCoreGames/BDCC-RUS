extends PerkBase

func _init():
	id = Perk.HypnosisHypnoticAllure
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Гипнотическое очарование"

func getVisibleDescription():
	return "Вы способны стать настолько притягательной, что будете буквально завороживать умы."
	
func getMoreDescription():
	return "Теперь покачивание бедрами будет оказывать настоящий гипнотический эффект, повышая уровень гипноза противника с вероятностью, равной вашему собственному уровню гипноза."

func getSkillTier():
	return 2
	
func getCost():
	return 3

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/hips.png"
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
