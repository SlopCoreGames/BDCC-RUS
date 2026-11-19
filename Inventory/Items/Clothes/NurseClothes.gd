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
		return "снимает твою медицинскую рубашку и стягивает шорты"
	else:
		return "снять медицинскую рубашку и стянуть шорты"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает медицинскую рубашку и шорты"
	else:
		return "надеть медицинскую рубашку и шорты"

func generateItemState():
	itemState = ShirtAndShortsState.new()
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/NurseClothes/NurseClothes.tscn",
	}

