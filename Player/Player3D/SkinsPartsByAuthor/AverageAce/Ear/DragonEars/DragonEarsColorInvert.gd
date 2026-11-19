extends PartSkinBase

func _init():
	id = "dragonearscolorinvert"
	partID = "dragonears"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/DragonEars/DragonEars_ColorInverted.png"),
	}
