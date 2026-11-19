extends PartSkinBase

func _init():
	id = "canineearfadedspots"
	partID = "canineears"

func getName():
	return "Выцветшие пятна"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar/Canine_FadedSpots.png"),
	}
