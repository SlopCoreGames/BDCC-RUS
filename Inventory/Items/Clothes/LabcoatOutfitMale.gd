extends ItemBase

func _init():
	id = "LabcoatOutfitMale"

func getVisibleName():
	return "Лабораторный халат"
	
func getDescription():
	return "Лабораторный халат поверх официальной одежды."

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
		return "снимает лабораторный халат и униформу"
	else:
		return "снять лабораторный халат и униформу"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает лабораторный халат и униформу"
	else:
		return "надеть лабораторный халат и униформу"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.revealAnim = "ClothingFullOpen"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/OfficialClothes/OfficialClothesLabcoat.tscn",
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
