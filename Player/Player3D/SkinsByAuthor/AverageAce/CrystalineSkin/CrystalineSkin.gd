extends SkinBase

func _init():
	id = "CrystalineSkin"

func getName():
	return "Кристаллическая"

func getPatternTexture():
	return load("res://Player/Player3D/SkinsByAuthor/AverageAce/CrystalineSkin/CrystalineSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
