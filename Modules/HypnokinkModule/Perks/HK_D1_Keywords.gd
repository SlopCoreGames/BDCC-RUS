extends PerkBase

func _init():
	id = Perk.HypnosisKeywordsDrawback
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Фиксация на ключевых словах"

func getVisibleDescription():
	return "Вы замечаете, что ваши мысли задерживаются на определенных словах, когда они произносятся."
	
func getMoreDescription():
	return "Находясь в "+HypnokinkUtil.tranceIcon()+"трансе, услышав одно из ключевых слов, вы чувствуете, как гипноз слегка усиливается, а ваша [color="+DamageType.getColorString(DamageType.Lust)+"]похоть[/color] и возбуждение немного возрастают."

func getSkillTier():
	return 0

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
	return "res://Modules/HypnokinkModule/Icons/Perks/speech.png"

