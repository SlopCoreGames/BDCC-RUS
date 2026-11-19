extends PartSkinBase

func _init():
	id = "dragonearsedgehighlight"
	partID = "dragonears"

func getName():
	return "Подсветка края"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/DragonEars/DragonEars_EdgeHighlight.png"),
	}
