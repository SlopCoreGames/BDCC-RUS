extends ItemBase

func _init():
	id = "AlexSpine"

func getVisibleName():
	return "Экзопозвоночник"
	
func getDescription():
	return "Протез позвоночника, подключающийся напрямую к вашей нервной системе"

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
		"spine": "res://Inventory/RiggedModels/AlexSpine/AlexSpine.tscn",
	}

func canDye():
	return true
