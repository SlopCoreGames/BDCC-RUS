extends "res://Inventory/Items/Underwear/Strapon.gd"

func _init():
	id = "StraponDragon"

func getVisibleName():
	return "Страпон (дракон)"
	
func getDescription():
	var text = "Огромный, мать его, страпон"

	return text

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"strapon": "res://Inventory/RiggedModels/Strapons/DragoncockStrapon.tscn",
	}

func getCasualName():
	return "рельефный страпон"

func getLewdStraponName() -> String:
	return RNG.pick(["узловатый страпон-дракон", "рельефный страпон", "узловатый страпон", "резиновый член-дракон"])

func getPrice():
	return 20

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(750.0)

func getInventoryImage():
	return "res://Images/Items/strapons/dragon.png"

func getStraponTraits() -> Dictionary:
	return {
		PartTrait.PenisKnot: true,
		PartTrait.PenisRidges: true,
	}
