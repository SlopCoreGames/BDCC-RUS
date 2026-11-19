extends "res://Inventory/Items/Underwear/Strapon.gd"

func _init():
	id = "StraponFeline"

func getVisibleName():
	return "Страпон (фелиний)"
	
func getDescription():
	var text = "Страпон с шипами"

	return text

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"strapon": "res://Inventory/RiggedModels/Strapons/FelinecockStrapon.tscn",
	}

func getCasualName():
	return "колючий страпон"

func getLewdStraponName() -> String:
	return RNG.pick(["колючий страпон", "фелинийский страпон", "резиновый кошачий член"])

func getPrice():
	return 15

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(500.0)

func getInventoryImage():
	return "res://Images/Items/strapons/feline.png"

func getStraponTraits() -> Dictionary:
	return {
		PartTrait.PenisBarbs: true,
	}
