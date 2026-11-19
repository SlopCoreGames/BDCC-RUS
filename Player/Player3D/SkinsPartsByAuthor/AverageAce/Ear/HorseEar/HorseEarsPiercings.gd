extends PartSkinBase

func _init():
	id = "horseearspierceings"
	partID = "horseears"

func getName():
	return "Пирсинг"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/HorseEar/horseEars_Piercings.png"),
	}
