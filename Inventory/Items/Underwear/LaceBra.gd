extends ItemBase

func _init():
	id = "LaceBra"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Кружевной бюстгальтер"
	
func getDescription():
	var text = "Сексуальный лифчик, который подчеркнет твою грудь именно так, как надо"

	return text

func getClothingSlot():
	return InventorySlot.UnderwearTop

func getBuffs():
	return [
		buff(Buff.LustArmorBuff, [10]),
		buff(Buff.StatBuff, [Stat.Sexiness, 5]),
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твой кружевной лифчик"
	else:
		return "снять кружевной лифчик"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает кружевной лифчик"
	else:
		return "надеть кружевной лифчик"

func getPrice():
	return 8

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = BraState.new()
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"bra": "res://Inventory/RiggedModels/Bra/Bra.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/lacebra.png"

func canDye():
	return true
