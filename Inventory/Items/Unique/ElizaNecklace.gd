extends ItemBase

func _init():
	id = "ElizaNecklace"

func getVisibleName():
	return "Ожерелье"
	
func getDescription():
	return "Изысканное ожерелье"

func getClothingSlot():
	return InventorySlot.Unique

func getBuffs():
	return [
		]

#func generateItemState():
#	itemState = ShirtAndShortsState.new()

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"necklace": "res://Inventory/RiggedModels/ElizaNecklace/ElizaNecklace.tscn",
	}
