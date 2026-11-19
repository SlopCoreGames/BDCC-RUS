extends PartSkinBase

func _init():
	id = "canineearcolorinvert"
	partID = "canineears"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar/Canine_ColorInverted.png"),
	}
