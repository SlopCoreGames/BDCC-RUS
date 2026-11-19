extends BodypartEars

func _init():
	visibleName = "уши бульдога"
	id = "bulldogears"

func getCompatibleSpecies():
	return [Species.Canine]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Ears/BulldogEars/BulldogEars.tscn"
