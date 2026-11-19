extends ItemBase

func _init():
	id = "Leotard"

func getVisibleName():
	return "Леотард"
	
func getDescription():
	return "Облегающий костюм"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твое леотардо"
	else:
		return "снять леотардо"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает леотардо"
	else:
		return "надеть леотардо"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.casualName = "leotard"
	itemState.revealAnim = "ClothingFullOpenAlt"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/Leotard/Leotard.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved()):
		return null
	var removed = {
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

func canDye():
	return true
