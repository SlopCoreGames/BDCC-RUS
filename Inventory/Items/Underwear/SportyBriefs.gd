extends ItemBase

func _init():
	id = "sportyBriefs"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Спортивные трусы"
	
func getDescription():
	var text = "Хлопковые спортивные трусы, идеально подходят для занятий физкультурой."

	return text

func getClothingSlot():
	return InventorySlot.UnderwearBottom

func getBuffs():
	return [
		buff(Buff.PhysicalArmorBuff, [5]),
		buff(Buff.StatBuff, [Stat.Agility, 3]),
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "сползает с твоих трусиков"
	else:
		return "сползти с твоих трусиков"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает трусики"
	else:
		return "надеть трусики"

func getPrice():
	return 5

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func generateItemState():
	itemState = PantiesState.new()
	itemState.canShiftAside = false
	itemState.casualName = "briefs"
	itemState.canActuallyBeDamaged = true

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"panties": "res://Inventory/RiggedModels/Briefs/Briefs.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/boxers.png"

func canDye():
	return true
