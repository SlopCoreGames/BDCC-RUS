extends BodypartHair

func _init():
	visibleName = "конский хвост 3"
	id = "ponytailhair3"

	maleWeight = 0.1
	femaleWeight = 1.0

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Hair/PonytailHair3/PonytailHair3.tscn"

func getTraits():
	return {
		PartTrait.HairPonytail: true,
	}
