extends "res://Inventory/Items/Underwear/Strapon.gd"

func _init():
	id = "StraponFeeldoe"
	clothesColor = Color(0.69, 0.08, 0.08)

func getVisibleName():
	return "Страпон (филдо)"
	
func getDescription():
	var text = "Двусторонний страпон с узлом. Также приносит удовольствие самой носительнице во время секса"

	return text

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"strapon": "res://Inventory/RiggedModels/Strapons/FeeldoeStrapon.tscn",
	}

func getStraponPleasureForDom():
	return 0.5

func getCasualName():
	return "страпон Feeldoe"

func getLewdStraponName() -> String:
	return RNG.pick(["страпон Feeldoe", "двусторонний страпон", "узловатый страпон", "резиновый собачий член"])

func getPrice():
	return 30

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(850.0)

func getInventoryImage():
	return "res://Images/Items/strapons/feeldoe.png"

func getInventoryImageColor():
	return clothesColor

func getStraponTraits() -> Dictionary:
	return {
		PartTrait.PenisKnot: true,
	}
