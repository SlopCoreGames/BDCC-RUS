extends PartSkinBase

func _init():
	id = "canineearpierced"
	partID = "canineears"

func getName():
	return "Проколотые"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/CanineEar/Canine_Pierced.png"),
	}
