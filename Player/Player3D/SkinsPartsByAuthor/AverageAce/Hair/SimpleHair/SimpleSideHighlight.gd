extends PartSkinBase

func _init():
	id = "simplehairsidehighlight"
	partID = "simplehair"

func getName():
	return "Боковой блик"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/SimpleHair/hairsimple_SideHighlight.png"),
	}
