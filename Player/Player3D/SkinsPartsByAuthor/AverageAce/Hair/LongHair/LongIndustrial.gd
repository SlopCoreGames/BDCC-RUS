extends PartSkinBase

func _init():
	id = "longhairindustrial"
	partID = "longhair"

func getName():
	return "Индустриальный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/LongHair/hairlong_Industrial.png"),
	}
