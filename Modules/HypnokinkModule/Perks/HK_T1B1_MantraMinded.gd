extends PerkBase

func _init():
	id = Perk.HypnosisMantraMinded
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Мантра-разум"

func getVisibleDescription():
	return "Вы выучили набор коротких расслабляющих мантр."
	
func getMoreDescription():
	return "Снижает штрафы от гипноза на 10%.\n\nВы получаете способность восстанавливать определенное количество выносливости в зависимости от текущей степени гипноза.\nМожно использовать один раз за бой."

func getSkillTier():
	return 0
	
func getCost():
	return 1

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/peace.png"

func addsAttacks():
	return ["ReciteMantra"]
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
