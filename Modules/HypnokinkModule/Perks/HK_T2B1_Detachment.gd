extends PerkBase

func _init():
	id = Perk.HypnosisDetachment
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Отстраненность"

func getVisibleDescription():
	return "Вы настолько преуспели в роли объекта гипноза, что научились частично отстраняться даже от физической боли."
	
func getMoreDescription():
	return  "Снижает штрафы от гипноза еще на 20%." + "\n\n" + \
			"While "+HypnokinkUtil.hypnosisIcon()+"В состоянии гипноза или "+HypnokinkUtil.tranceIcon()+"транса вы получаете +10% к сопротивлению боли."

func getSkillTier():
	return 1
	
func getCost():
	return 2
	
func getRequiredPerks():
	return [Perk.HypnosisMantraMinded]

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/stoic.png"
	
func getBuffs():
	if(HypnokinkUtil.isHypnotized(npc)):
		return [
			buff(Buff.ReceivedPhysicalDamageBuff, [-10]),
		]
	else:
		return []
		
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
