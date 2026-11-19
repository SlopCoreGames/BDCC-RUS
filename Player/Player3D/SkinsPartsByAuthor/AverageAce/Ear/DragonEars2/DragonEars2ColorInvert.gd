extends PartSkinBase

func _init():
	id = "dragonears2colorinvert"
	partID = "dragonears2"

func getName():
	return "Инверсия цвета"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/DragonEars2/DragonEars2_ColorInvert.png"),
	}
