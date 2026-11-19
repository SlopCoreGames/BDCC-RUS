extends PartSkinBase

func _init():
	id = "canineear3colorinvert"
	partID = "canineears3"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar3/CanineEars3_ColorInvert.png"),
	}
