extends PartSkinBase

func _init():
	id = "scarredcanine"
	partID = "caninepenis"

func getName():
	return "Шрамированный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Penis/CaninePenis/CanineScarred.png"),
	}
