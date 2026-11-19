extends "res://Inventory/Items/Underwear/Strapon.gd"

func _init():
	id = "StraponCanine"

func getVisibleName():
	return "Страпон (собачий)"
	
func getDescription():
	var text = "Страпон с узлом"

	return text

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"strapon": "res://Inventory/RiggedModels/Strapons/CaninecockStrapon.tscn",
	}

func getCasualName():
	return "собачий страпон"

func getLewdStraponName() -> String:
	return RNG.pick(["узловатый страпон", "собачий страпон", "резиновый собачий член"])

func getPrice():
	return 20

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(750.0)

func getInventoryImage():
	return "res://Images/Items/strapons/canine.png"

func getStraponTraits() -> Dictionary:
	return {
		PartTrait.PenisKnot: true,
	}
