extends PartSkinBase

func _init():
	id = "ponytailtwosided"
	partID = "ponytailhair"

func getName():
	return "двусторонний"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/Ponytail1/ponytail1_Dual.png"),
	}
