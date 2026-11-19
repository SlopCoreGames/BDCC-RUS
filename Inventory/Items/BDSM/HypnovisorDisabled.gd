extends ItemBase

func _init():
	id = "HypnovisorDisabled"

func getVisibleName():
	return "Стильный визор"
	
func getDescription():
	return "Просто модные очки"

func getClothingSlot():
	return InventorySlot.Eyes

func getBuffs():
	return [
		]

func getPrice():
	return 10

func canSell():
	return true

func getTags():
	return []

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" насильно надели тебе на глаза."
	else:
		return getAStackNameCapitalize()+" насильно надели на глаза {receiver.nameS}!"

func getUnriggedParts(_character):
	return {
		"blindfold": ["res://Inventory/UnriggedModels/HypnoVisor/HypnoVisorDisabled.tscn"],
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/hypnovisor.png"
