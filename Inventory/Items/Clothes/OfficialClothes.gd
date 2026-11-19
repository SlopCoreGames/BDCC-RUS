extends ItemBase

func _init():
	id = "OfficialClothes"

func getVisibleName():
	return "Официальная одежда"
	
func getDescription():
	return "Очень шикарная одежда для очень шикарных людей"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твою куртку и стягивает штаны"
	else:
		return "снять куртку и стянуть штаны"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает твою куртку и штаны"
	else:
		return "надеть куртку и штаны"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.revealAnim = "ClothingFullOpen"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/OfficialClothes/OfficialClothes.tscn",
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

#func updateDoll(doll: Doll3D):
#	doll.setState("armalpha", "hidearms")
