extends PartSkinBase

func _init():
	id = "simplehairdipped"
	partID = "simplehair"

func getName():
	return "Окрашенные кончики"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/SimpleHair/hairsimple_Dipped.png"),
	}
