extends ItemBase

func _init():
	id = "sportyTankTop"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Спортивная майка"
	
func getDescription():
	var text = "Хлопковая майка, идеально подходит для занятий спортом."

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
		return "снимает твою спортивную майку"
	else:
		return "снять спортивную майку"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает спортивную майку"
	else:
		return "надеть спортивную майку"

func getPrice():
	return 5

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = BraState.new()
	itemState.casualName = "tanktop"
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"top": "res://Inventory/RiggedModels/Undershirt/Undershirt.tscn",
	}

func getHidesParts(_character):
	if(itemState.isRemoved() || itemState.isBraPulledUp() || itemState.isDamaged()):
		return null
	return {
		BodypartSlot.Breasts: true,
	}

func getInventoryImage():
	return "res://Images/Items/underwear/tanktop.png"

func canDye():
	return true
