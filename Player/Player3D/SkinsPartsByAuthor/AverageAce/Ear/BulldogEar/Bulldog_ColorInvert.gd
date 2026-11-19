extends PartSkinBase

func _init():
	id = "bulldogcolorinvert"
	partID = "bulldogears"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/BulldogEar/Bulldog_ColorInvert.png"),
	}
