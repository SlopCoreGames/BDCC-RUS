extends ItemBase

func _init():
	id = "inmatewristcuffs"

func getVisibleName():
	return "Железные наручники"
	
func getDescription():
	return "Массивные металлические оковы. Можно запереть, чтобы сковать руки вместе"

func getClothingSlot():
	return InventorySlot.Wrists

func getBuffs():
	return [
		buff(Buff.RestrainedArmsBuff),
		]

func getTakeOffScene():
	return "CuffTuggingScene"

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func getPrice():
	return 6

func getSellPrice():
	return 1

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintHandCuffs.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" были застегнуты на твоих руках, чуть ниже локтей, соединенные цепью"
	else:
		return getAStackNameCapitalize()+" были застегнуты на руках {receiver.nameS}, чуть ниже {receiver.his} локтей, соединенные цепью"

func getUnriggedParts(_character):
	return {
		"wrist.L": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
		"wrist.R": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
	}

func updateDoll(doll: Doll3D):
	doll.setArmsCuffed(true)

func getInventoryImage():
	return "res://Images/Items/bdsm/cuff.png"
