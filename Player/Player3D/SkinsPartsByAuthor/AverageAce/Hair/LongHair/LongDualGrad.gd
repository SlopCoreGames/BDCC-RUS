extends PartSkinBase

func _init():
	id = "longhairdualgrad"
	partID = "longhair"

func getName():
	return "Двусторонний"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/LongHair/hairlong_DualGradient.png"),
	}
