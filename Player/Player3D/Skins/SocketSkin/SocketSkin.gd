extends SkinBase

func _init():
	id = "SocketSkin"

func getName():
	return "Гнездо"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/SocketSkin/SocketSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
