extends ItemBase

func _init():
	id = "PuppyCorset"

func getVisibleName():
	return "Корсет"
	
func getDescription():
	return "Тесный блестящий корсет, который ничего не скрывает"

func getClothingSlot():
	return InventorySlot.Torso

func getBuffs():
	return [
		buff(Buff.PregnantBellySizeModifierBuff, [-50.0])
		]

func getTags():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твой корсет"
	else:
		return "снять корсет"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает твой корсет"
	else:
		return "надеть корсет"

func getRiggedParts(_character):
	if(itemState != null && itemState.isRemoved()):
		return null
	return {
		"corset": "res://Inventory/RiggedModels/PuppyCorset/PuppyCorset.tscn",
	}

#func coversBodyparts():
#	return {
#		BodypartSlot.Body: true,
#	}
