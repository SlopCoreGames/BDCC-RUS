extends PartSkinBase

func _init():
	id = "ponytail3TwoSided"
	partID = "ponytailhair3"

func getName():
	return "Двусторонний"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/Ponytail3/ponytail3_TwoTOne.png"),
	}
