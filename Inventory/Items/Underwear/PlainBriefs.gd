extends ItemBase

func _init():
	id = "plainBriefs"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Трусы"
	
func getDescription():
	var text = "Скучные, но вполне удобные трусы."

	return text

func getClothingSlot():
	return InventorySlot.UnderwearBottom

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "сползает с твоих трусиков"
	else:
		return "сползти с твоих трусиков"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает трусики"
	else:
		return "надеть трусики"

func getPrice():
	return 1

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = PantiesState.new()
	itemState.canShiftAside = false
	itemState.casualName = "briefs"
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"panties": "res://Inventory/RiggedModels/Briefs/Briefs.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/boxers.png"

func canDye():
	return true
