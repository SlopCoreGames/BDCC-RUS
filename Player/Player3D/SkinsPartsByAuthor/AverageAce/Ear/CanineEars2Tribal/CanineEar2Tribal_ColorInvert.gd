extends PartSkinBase

func _init():
	id = "canineear2tribalcolorinvert"
	partID = "canineears2tribal"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEars2Tribal/CanineEars2Tribal_ColorInvert.png"),
	}
