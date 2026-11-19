extends PartSkinBase

func _init():
	id = "wolfearsindustrial"
	partID = "wolfears"

func getName():
	return "Индустриальный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Ear/WolfEar/wolfEars_Industrial.png"),
	}
