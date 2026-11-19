extends PartSkinBase

func _init():
	id = "shorthairspread"
	partID = "shorthair"

func getName():
	return "Верхний мелированный слой"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/ShortHair/hairshort_TwoToneHighlights.png"),
	}
