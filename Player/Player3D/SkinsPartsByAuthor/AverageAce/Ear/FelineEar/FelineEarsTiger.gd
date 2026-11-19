extends PartSkinBase

func _init():
	id = "felineeartiger"
	partID = "felineears"

func getName():
	return "Тигриные уши"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/FelineEar/CatEars_Tiger.png"),
	}
