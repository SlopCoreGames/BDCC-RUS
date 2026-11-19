extends BodypartEars

func _init():
	visibleName = "драконьи уши"
	id = "dragonears"

func getCompatibleSpecies():
	return [Species.Dragon]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Ears/DragonEars/DragonEars.tscn"
