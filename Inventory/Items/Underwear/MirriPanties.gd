extends "res://Inventory/Items/Underwear/PlainPanties.gd"

func _init():
	id = "MirriPanties"
	clothesColor = Color("#0E446E")

func getVisibleName():
	return "Трусики Мирри"
	
func getDescription():
	var text = "Простые трусики в полоску."

	return text

func getPrice():
	return 30

func getTags():
	return [
		]

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"panties": "res://Inventory/RiggedModels/Panties/PantiesStripped.tscn",
	}
