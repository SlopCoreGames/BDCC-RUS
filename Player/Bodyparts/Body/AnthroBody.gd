extends BodypartBody

func _init():
	visibleName = "антропоморфное тело"
	id = "anthrobody"

func getCompatibleSpecies():
	return [Species.Any]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Body/HumanBody/HumanBody.tscn"

func getVulgarName() -> String:
	return "обычное тело"

func getAVulgarName() -> String:
	return "обычное тело"
