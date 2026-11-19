extends ItemBase

func _init():
	id = "LacePanties"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Кружевные трусики"
	
func getDescription():
	var text = "Сексуальные кружевные трусики с изысканным узором. От них точно у любого встанет"

	return text

func getClothingSlot():
	return InventorySlot.UnderwearBottom

func getBuffs():
	return [
		buff(Buff.LustArmorBuff, [10]),
		buff(Buff.StatBuff, [Stat.Sexiness, 5]),
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "сползает с твоих кружевных трусиков"
	else:
		return "сползти с твоих кружевных трусиков"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает кружевные трусики"
	else:
		return "надеть кружевные трусики"

func getPrice():
	return 8

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = PantiesState.new()
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"panties": "res://Inventory/RiggedModels/Panties/Panties.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/lacepanties.png"

func canDye():
	return true
