extends PartSkinBase

func _init():
	id = "combedangled"
	partID = "combedbackhair"

func getName():
	return "Угловатый"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Hair/CombedBack/CombedBackAngular.png"),
	}
