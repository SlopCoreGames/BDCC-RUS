extends ItemBase

func _init():
	id = "NurseClothes"

func getVisibleName():
	return "Форма медсестры"
	
func getDescription():
	return "Простая рубашка и шорты в цветах медблока"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		ItemTag.NurseUniform,
		ItemTag.Illegal,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your nurse shirt and pulls down the shorts"
	else:
		return "take off your nurse shirt and pull down the shorts"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your nurse shirt and the shorts"
	else:
		return "put on your nurse shirt and the shorts"

func generateItemState():
	itemState = ShirtAndShortsState.new()
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/NurseClothes/NurseClothes.tscn",
	}

