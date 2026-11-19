extends PartSkinBase

func _init():
	id = "humanearsoildcolors"
	partID = "humanears"

func getName():
	return "Сплошные цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/HumanEar/HumanEar_SolidColors.png"),
	}
