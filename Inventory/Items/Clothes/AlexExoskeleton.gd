extends ItemBase

func _init():
	id = "AlexExoskeleton"

func getVisibleName():
	return "Экзоскелет"
	
func getDescription():
	return "Помогает двигаться и сражаться"

func getClothingSlot():
	return InventorySlot.Torso

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твой экзоскелет"
	else:
		return "снять экзоскелет"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает твой экзоскелет"
	else:
		return "надеть экзоскелет"

#func generateItemState():
#	itemState = ShirtAndShortsState.new()

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"suit": "res://Inventory/RiggedModels/Exoskeleton/ExoSkeleton.tscn",
	}
