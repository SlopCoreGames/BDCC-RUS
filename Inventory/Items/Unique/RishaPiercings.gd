extends ItemBase

func _init():
	id = "RishaPiercings"

func getVisibleName():
	return "Кошачьи пирсинги"
	
func getDescription():
	return "Пирсинг для твоей кошечки!"

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
		"headpiercings": "res://Inventory/RiggedModels/RishaPiercings/RishaPiercings.tscn",
	}

func canDye():
	return true
