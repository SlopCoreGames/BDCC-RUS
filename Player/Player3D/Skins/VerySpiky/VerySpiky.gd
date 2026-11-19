extends SkinBase

func _init():
	id = "VerySpiky"

func getName():
	return "Очень колючий"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/VerySpiky/veryspiky.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
