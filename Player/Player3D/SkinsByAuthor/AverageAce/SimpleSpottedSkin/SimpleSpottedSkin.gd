extends SkinBase

func _init():
	id = "SimpleSpottedSkin"

func getName():
	return "Простая пятнистая"

func getPatternTexture():
	return load("res://Player/Player3D/SkinsByAuthor/AverageAce/SimpleSpottedSkin/SimpleSpottedSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
