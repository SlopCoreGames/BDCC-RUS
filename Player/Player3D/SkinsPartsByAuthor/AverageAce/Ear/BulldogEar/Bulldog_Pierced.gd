extends PartSkinBase

func _init():
	id = "bulldogpierced"
	partID = "bulldogears"

func getName():
	return "Проколотые"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/BulldogEar/Bulldog_Pierced.png"),
	}
