extends SkinBase

func _init():
	id = "FurGirl"

func getName():
	return "Меховая Девушка"

func getPatternTexture():
	return load("res://Player/Player3D/Skins/FurGirl/FurGirl.png")

func getFittingSkinTypes():
	return {
		SkinType.SkinAndFur: 1.0,
		#SkinType.Fur: 1.0,
	}
