extends PartSkinBase

func _init():
	id = "lynxears2colorinverted"
	partID = "lynxears2"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/LynxEar2/earsLynx2_ColorInvert.png"),
	}
