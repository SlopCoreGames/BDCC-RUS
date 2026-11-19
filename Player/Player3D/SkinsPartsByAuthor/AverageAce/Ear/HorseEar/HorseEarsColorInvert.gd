extends PartSkinBase

func _init():
	id = "horseearscolorinvert"
	partID = "horseears"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/HorseEar/horseEars_ColorInvert.png"),
	}
