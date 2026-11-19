extends ItemBase

func _init():
	id = "GasMask"

func getVisibleName():
	return "Противогаз"
	
func getDescription():
	return "Маска, способная фильтровать воздух"

func getClothingSlot():
	return InventorySlot.Eyes

func getBuffs():
	return [
		]

func getTags():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает противогаз"
	else:
		return "снять противогаз"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает противогаз"
	else:
		return "надеть противогаз"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"gasmask": "res://Inventory/RiggedModels/GasMask/GasMask.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/equipment/gas-mask.png"
