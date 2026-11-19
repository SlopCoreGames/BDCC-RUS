extends ItemBase

func _init():
	id = "blindfold"

func getVisibleName():
	return "Повязка на глазах"
	
func getDescription():
	return "Простой лоскут ткани"

func getClothingSlot():
	return InventorySlot.Eyes

func getBuffs():
	return [
		buff(Buff.BlindfoldBuff),
		]

func getPrice():
	return 2

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBlindfold.new()
	restraintData.setLevel(RNG.randi_range(1, 2))
	
func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" насильно натянули тебе на глаза. Ты ослеп!"
	else:
		return getAStackNameCapitalize()+" насильно натянули на глаза {receiver.nameS}! {receiver.He} {receiver.is} слепой!"

func getUnriggedParts(_character):
	return {
		"blindfold": ["res://Inventory/UnriggedModels/Blindfold/BlindfoldModel.tscn"],
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/blindfold.png"
