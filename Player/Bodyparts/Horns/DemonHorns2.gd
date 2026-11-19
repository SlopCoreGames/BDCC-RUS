extends BodypartHorns

func _init():
	visibleName = "демонические рога 2"
	id = "demonhorns2"

func getCompatibleSpecies():
	return [Species.Dragon, Species.Demon]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Horns/DemonHorns2/DemonHorns2.tscn"
