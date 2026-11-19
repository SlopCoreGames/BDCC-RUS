extends PartSkinBase

func _init():
	id = "horseearsfade"
	partID = "horseears"

func getName():
	return "Затухание"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/HorseEar/horseEars_Fade.png"),
	}
