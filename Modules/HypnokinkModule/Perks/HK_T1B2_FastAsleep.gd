extends PerkBase

func _init():
	id = Perk.HypnosisFastAsleep
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Крепкий сон"

func getVisibleDescription():
	return "Вы можете мгновенно проваливаться в глубокий сон."
	
func getMoreDescription():
	return 	"Отдых в камере теперь в два раза эффективнее."+"\n\n"+\
			"Баффы, полученные во время сеансов гипноза, становятся сильнее и длятся дольше."

func getSkillTier():
	return 0
	
func getCost():
	return 1

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/zzz.png"

func getBuffs():
	return [
		buff(Buff.RestEffectivenessBuff, [0.5]),
	]
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
