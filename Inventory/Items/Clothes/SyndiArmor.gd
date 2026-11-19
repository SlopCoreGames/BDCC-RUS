extends ItemBase

func _init():
	id = "SyndiArmor"

func getVisibleName():
	return "Броня Синдиката"
	
func getDescription():
	return "Высокозащитный герметичный скафандр, разработанный специально для оперативников Синдиката, работающих в условиях нулевой гравитации"

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
		"clothing": "res://Inventory/RiggedModels/SyndiArmor/SyndiArmor.tscn",
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
