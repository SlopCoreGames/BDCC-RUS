extends SkinBase

func _init():
	id = "HumanSkin"

func getName():
	return "Человеческая кожа"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/HumanSkin/HumanSkin.png")

func getFittingSkinTypes():
	return {
		SkinType.SkinHuman: 1.0,
	}
