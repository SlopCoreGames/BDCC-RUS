extends PerkBase

func _init():
	id = Perk.HypnosisFamousDrawback
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Знаменитая внушаемость"

func getVisibleDescription():
	return "Слухи о твоих гипнотических опытах начинают распространяться."

func getMoreDescription():
	return 	"Теперь тебе могут встретиться заключенные, знающие о твоей уязвимости к внушению (шанс возрастает по мере того, как тебя всё чаще гипнотизируют)."+"\n\n"+\
			"Теперь каждый раз, когда вы находитесь под "+HypnokinkUtil.hypnosisIcon()+"гипнозом, действует эффект «Фиксация на ключевом слове»."

func getSkillTier():
	return 1

func getCost():
	return 0
	
func unlockable() -> bool:
	return false

func toggleable() -> bool:
	var ch = npc if npc != null else GM.pc
	return !(ch.getSkillsHolder().hasPerk(self.id))

func hiddenWhenLocked() -> bool:
	return true;
	
func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/obey.png"

