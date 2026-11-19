extends SkinBase

func _init():
	id = "NovaSkin"

func getName():
	return "Мягкий"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/NovaSkin/novaSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
