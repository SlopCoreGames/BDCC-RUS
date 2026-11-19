extends PartSkinBase

func _init():
	id = "humanscarred"
	partID = "humanpenis"

func getName():
	return "Шрамированный"

func getPatternTexture():
	return {
		"": preload("res://Player/Player3D/SkinsPartsByAuthor/AverageAce/Penis/HumanPenis/HumanScarred.png"),
	}
	
