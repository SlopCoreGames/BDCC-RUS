extends PerkBase

func _init():
	id = Perk.HypnosisLucidTrance
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Осознанный транс"

func getVisibleDescription():
	return "Вы настолько привыкли к гипнозу, что случайный наблюдатель может этого даже не заметить."

func getMoreDescription():
	return "Снижает штрафы от гипноза еще на 30%.\n\nНаходясь в "+HypnokinkUtil.tranceIcon()+"трансе, вы получаете % c% к шансу уклонения от атак."
	

func getSkillTier():
	return 2
	
func getCost():
	return 3
	
func getRequiredPerks():
	return [Perk.HypnosisDetachment]

func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/mask.png"
	
func getBuffs():
	if(HypnokinkUtil.isInTrance(npc)):
		return [
			buff(Buff.DodgeChanceBuff, [10]),
		]
	else:
		return []
	
func runOnceWhenLearned():
	GM.main.setFlag("HypnokinkModule.SoftOptIn", true)
	GM.pc.getSkillsHolder().getSkill(Skill.Hypnosis).checkDrawbacks()
