extends PartSkinBase

func _init():
	id = "canineear2innergradient"
	partID = "canineears2"

func getName():
	return "Внутренний градиент"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEars2/CanineEars2_InnerGradient.png"),
	}
