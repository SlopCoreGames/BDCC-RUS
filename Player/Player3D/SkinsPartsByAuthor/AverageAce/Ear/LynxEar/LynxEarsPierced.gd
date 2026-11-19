extends PartSkinBase

func _init():
	id = "lynxearspierced"
	partID = "lynxears"

func getName():
	return "Проколотые"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/LynxEar/earsLynxPierced.png"),
	}
