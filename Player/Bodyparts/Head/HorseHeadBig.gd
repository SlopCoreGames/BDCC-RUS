extends BodypartHead

func _init():
	visibleName = "большая лошадиная голова"
	id = "horseheadbig"

func getCompatibleSpecies():
	return [Species.Equine]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Head/HorseHead/HorseHead.tscn"

func npcGenerationWeight(_dynamicCharacter):
	if(_dynamicCharacter.getFemininity() < 40):
		return 0.4
	return 0.0

func getHeadLength():
	return 1.0
