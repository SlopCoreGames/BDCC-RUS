extends ItemBase

func _init():
	id = "LatexSuit"

func getVisibleName():
	return "Латексный костюм"
	
func getDescription():
	return "Очень блестящий комбинезон"

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
		return "снимает твой латексный костюм"
	else:
		return "снять латексный костюм"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает латексный костюм"
	else:
		return "надеть латексный костюм"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.casualName = "suit"
	itemState.revealAnim = "ClothingFullOpenAlt"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/LatexSuit/LatexSuit.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved()):
		return null
	var removed = {
		BodypartSlot.Legs: true,
		BodypartSlot.Arms: true,
		BodypartSlot.Body: true,
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
