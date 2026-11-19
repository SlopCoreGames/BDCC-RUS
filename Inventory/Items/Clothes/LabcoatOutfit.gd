extends ItemBase

func _init():
	id = "LabcoatOutfit"

func getVisibleName():
	return "Лабораторный халат"
	
func getDescription():
	return "Халат, топ и юбка. Старайся не слишком активно двигаться в этом наряде..."

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		#ItemTag.NurseUniform,
		#ItemTag.Illegal,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your labcoat and skirt"
	else:
		return "take off your labcoat and skirt"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your labcoat and skirt"
	else:
		return "put on your labcoat and skirt"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.revealAnim = "ClothingFullOpen"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/LabcoatOutfit/LabcoatOutfit.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved()):
		return null
	var removed = {
		#BodypartSlot.Body: true,
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
