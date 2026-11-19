extends SmartLockBase

var keyAmount:int = 3

func _init():
	id = SmartLock.TightLock

func getName():
	return "Тугой замок"

func getUnlockDescription():
	var restData:RestraintData = getRestraintData()
	if(restData == null):
		return "ОШИБКА, ЧТО-ТО ПОШЛО НЕ ТАК"
	var requiredItemID:String = restData.getTightLockRequiredItemID()
	var reqItem:ItemBase = GlobalRegistry.getItemRef(requiredItemID)
	if(reqItem == null):
		return "ОШИБКА, ЧТО-ТО ПОШЛО НЕ ТАК"
	
	return "Не получается вырваться, нужен специальный предмет, чтобы открыть! Либо у него есть "+str(keyAmount)+" замочных скважин, и для открытия потребуется соответствующее количество ключей от фиксаторов.\nНеобходимый предмет для открытия: "+reqItem.getVisibleName()

func getKeysAmountToUnlock() -> int:
	return keyAmount

func onLocked(_contex):
	keyAmount = RNG.randi_range(2, 5)
	if(OPTIONS.isHardStruggleEnabled()): #Evil
		keyAmount = RNG.randi_range(2, 8)

func saveData():
	return {
		keyAmount = keyAmount,
	}

func loadData(_data):
	keyAmount = SAVE.loadVar(_data, "keyAmount", 2)
