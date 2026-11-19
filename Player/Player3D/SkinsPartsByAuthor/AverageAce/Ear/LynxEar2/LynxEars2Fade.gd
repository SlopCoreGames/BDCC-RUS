extends PartSkinBase

func _init():
	id = "lynxears2fade"
	partID = "lynxears2"

func getName():
	return "Затухание"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/LynxEar2/earsLynx2_Fade.png"),
	}
