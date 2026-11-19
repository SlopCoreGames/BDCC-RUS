extends ItemBase

func _init():
	id = "sportyTop"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Спортивный топ"
	
func getDescription():
	var text = "Хлопковый топ, разработанный для поддержки груди во время физических упражнений."

	return text

func getClothingSlot():
	return InventorySlot.UnderwearTop

func getBuffs():
	return [
		buff(Buff.PhysicalArmorBuff, [5]),
		buff(Buff.StatBuff, [Stat.Agility, 2]),
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает спортивный топ"
	else:
		return "снять спортивный топ"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает спортивный топ"
	else:
		return "надеть спортивный топ"

func getPrice():
	return 5

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = BraState.new()
	itemState.casualName = "top"
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"bra": "res://Inventory/RiggedModels/Bra/Bra.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/sport-bra.png"

func canDye():
	return true
