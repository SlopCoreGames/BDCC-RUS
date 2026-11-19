extends PartSkinBase

func _init():
	id = "canineearscarred"
	partID = "canineears"

func getName():
	return "Шрамированный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar/Canine_Scarred.png"),
	}
