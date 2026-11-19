extends PartSkinBase

func _init():
	id = "fennecearstipfade"
	partID = "fennecears"

func getName():
	return "Затухание кончиков"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/FennecEar/fennecEars_TipFade.png"),
	}
