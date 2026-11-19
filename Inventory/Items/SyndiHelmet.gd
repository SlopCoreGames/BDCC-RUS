extends ItemBase

func _init():
	id = "SyndiHelmet"

func getVisibleName():
	return "Шлем Синдиката"
	
func getDescription():
	return "Бронированный шлем"

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
		return "снимает ваш шлем"
	else:
		return "снять шлем"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает ваш шлем"
	else:
		return "надеть шлем"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"helmet": "res://Inventory/RiggedModels/SyndiHelmet/SyndiHelmet.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved()):
		return null
	var removed = {
		BodypartSlot.Hair: true,
		BodypartSlot.Head: true,
		BodypartSlot.Ears: true,
		BodypartSlot.Horns: true,
	}
	
	return removed

func getInventoryImage():
	return "res://Images/Items/equipment/syndihelmet.png"
