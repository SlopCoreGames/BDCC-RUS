extends SkinBase

func _init():
	id = "EmptySkin"

func getName():
	return "Пустой скин"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/EmptySkin/EmptySkin.png")
