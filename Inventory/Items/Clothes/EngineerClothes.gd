extends ItemBase

func _init():
	id = "EngineerClothes"

func getVisibleName():
	return "Инженерная униформа"
	
func getDescription():
	return "Простая рубашка и шорты оранжевого цвета"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		ItemTag.EngineerUniform,
		ItemTag.Illegal,
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
	itemState = SimpleRemoveState.new()
	itemState.revealAnim = "ClothingFullOpen"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/EngineerUniform/EngineerUniform.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved()):
		return null
	var removed = {
		BodypartSlot.Legs: true,
		BodypartSlot.Arms: true,
		BodypartSlot.Breasts: true,
		"panties": true,
		"bra": true,
		"top": true,
	}
	if(!itemState.areShortsPulledDown() && !itemState.isDamaged()):
		removed[BodypartSlot.Penis] = true
	
	return removed
