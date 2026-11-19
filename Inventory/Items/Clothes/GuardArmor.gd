extends ItemBase

func _init():
	id = "GuardArmor"

func getVisibleName():
	return "Стражарская броня"
	
func getDescription():
	return "Стандартная броня для охранников"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		ItemTag.GuardUniform,
		ItemTag.Illegal,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твою броню"
	else:
		return "снять броню"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает твою броню"
	else:
		return "надеть броню"

func generateItemState():
	itemState = SimpleRemoveState.new()
	itemState.casualName = "armor"
	itemState.revealAnim = "ClothingFullOpenAlt"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/GuardClothes/GuardClothes.tscn",
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

func getInventoryImage():
	return "res://Images/Items/equipment/guardarmor.png"
