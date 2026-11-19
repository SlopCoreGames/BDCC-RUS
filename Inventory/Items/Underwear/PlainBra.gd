extends ItemBase

func _init():
	id = "plainBra"
	clothesColor = Color(1.0, 0.53, 0.73)

func getVisibleName():
	return "Бюстгальтер"
	
func getDescription():
	var text = "Обычный бюстгальтер из дешевого, но эластичного материала."

	return text

func getClothingSlot():
	return InventorySlot.UnderwearTop

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "расстегивает твой бюстгальтер и снимает его"
	else:
		return "расстегнуть твой бюстгальтер и снять его"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает бюстгальтер"
	else:
		return "надеть бюстгальтер"

func getPrice():
	return 1

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = BraState.new()
	itemState.canActuallyBeDamaged = true

func getInventoryImage():
	return "res://Images/Items/underwear/pinkbra.png"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"bra": "res://Inventory/RiggedModels/Bra/Bra.tscn",
	}

func canDye():
	return true
