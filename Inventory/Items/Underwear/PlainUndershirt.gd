extends ItemBase

func _init():
	id = "plainUndershirt"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Майка"
	
func getDescription():
	var text = "Безрукавка, прикрывающая грудь."

	return text

func getClothingSlot():
	return InventorySlot.UnderwearTop

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает майку"
	else:
		return "снять майку"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает майку"
	else:
		return "надеть майку"

func getPrice():
	return 1

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = BraState.new()
	itemState.casualName = "undershirt"
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"top": "res://Inventory/RiggedModels/Undershirt/Undershirt.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved() || itemState.isBraPulledUp() || itemState.isDamaged()):
		return null
	return {
		BodypartSlot.Breasts: true,
	}

func getInventoryImage():
	return "res://Images/Items/underwear/tanktop.png"

func canDye():
	return true
