extends PerkBase

func _init():
	id = Perk.BDSMRigger
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Риггер"

func getVisibleDescription():
	return "У вас приличный опыт в БДСМ, и теперь вам хочется приобщить к этому остальных. Вы получаете способность накладывать БДСМ-ограничения на противников во время боя! Оковы спадают, если враг вырывается из них."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/bdsm.png"
