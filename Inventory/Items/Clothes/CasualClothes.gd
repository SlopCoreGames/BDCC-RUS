extends ItemBase

func _init():
	id = "CasualClothes"
	clothesColor = Color("22253e")

func getVisibleName():
	return "Повседневная одежда"
	
func getDescription():
	return "Просто обычная рубашка и шорты"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает тюремную рубашку и стягивает шорты"
	else:
		return "снять тюремную рубашку и стянуть шорты"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает тюремную рубашку и шорты"
	else:
		return "надеть тюремную рубашку и шорты"

func generateItemState():
	itemState = ShirtAndShortsState.new()
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/CasualClothes/CasualClothes.tscn",
	}

func canDye():
	return true
