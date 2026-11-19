extends BodypartArms

func _init():
	visibleName = "антропоморфные руки"
	id = "anthroarms"

func getCompatibleSpecies():
	return [Species.Any]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Arms/HumanArms/HumanArms.tscn"
