extends PartSkinBase

func _init():
	id = "jackicolorful"
	partID = "jackihair"

func getName():
	return "Разноцветные"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/JackiHair/JackiHairVaried.png"),
	}
