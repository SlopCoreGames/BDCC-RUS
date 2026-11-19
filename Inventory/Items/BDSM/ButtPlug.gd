extends ItemBase

func _init():
	id = "buttplug"

func getVisibleName():
	return "Анальная пробка"
	
func getDescription():
	return "Классическая пробка из черного силикона, стандартного размера"

func getClothingSlot():
	return InventorySlot.Anal

func getRequiredBodypart():
	return BodypartSlot.Anus

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.MinLoosenessAnusBuff, [2.0]),
		buff(Buff.SensitivityGainBuff, [25.0]),
		buff(Buff.BlocksAnusLeakingBuff),
		]

func getPrice():
	return 6

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks]#[ItemTag.BDSMRestraint]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintButtplug.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "вытаскивает пробку из твоей задницы"
	else:
		return "вытащить пробку из твоей задницы"

func getPuttingOnStringLong(withS):
	if(withS):
		return "вставляет пробку в твою задницу"
	else:
		return "вставить пробку в твою задницу"

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" была затолкана в твою "+RNG.pick(["anus", "заднюю дырочку", "rear", "butt", "tailhole"])+". Она шевелится, когда ты двигаешься!"
	else:
		return getAStackNameCapitalize()+" была затолкана в {receiver.nameS} "+RNG.pick(["anus", "заднюю дырочку", "rear", "butt", "tailhole"])+". Она шевелится, когда {receiver.he} {receiver.verbS('move')}!"

func getInventoryImage():
	return "res://Images/Items/bdsm/anal-plug.png"
