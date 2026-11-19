extends SkinBase

func _init():
	id = "SoftSpikySkin"

func getName():
	return "Мягкий и колючий"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/SoftSpikySkin/RahiSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.Fur: 1.0,
		SkinType.Scales: 1.0,
	}
