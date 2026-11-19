extends ItemBase

func _init():
	id = "SocketVisor"

func getVisibleName():
	return "Визор разъема"
	
func getDescription():
	return "Крутой маленький VR-визор"

func getClothingSlot():
	return InventorySlot.Eyes

func getBuffs():
	return [
		]

func getPrice():
	return 0

func canSell():
	return true

func getTags():
	return []

func getUnriggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"blindfold": ["res://Inventory/RiggedModels/SocketArmor/VisorModel.tscn"],
	}

#func getInventoryImage():
#	return "res://Images/Items/bdsm/blindfold.png"
