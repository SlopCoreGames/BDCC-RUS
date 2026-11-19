extends PartSkinBase

func _init():
	id = "canineearindustrial"
	partID = "canineears"

func getName():
	return "Индустриальный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar/Canine_Industrial.png"),
	}
