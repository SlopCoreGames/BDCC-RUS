extends ItemBase

func _init():
	id = "inmateanklecuffs"

func getVisibleName():
	return "Железные кандалы на лодыжки"
	
func getDescription():
	return "Массивные металлические оковы. Можно запереть, чтобы сковать ноги вместе"

func getClothingSlot():
	return InventorySlot.Ankles

func getBuffs():
	return [
		buff(Buff.RestrainedLegsBuff),
		]

func getTakeOffScene():
	return "CuffTuggingScene"

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks]

func getPrice():
	return 6

func getSellPrice():
	return 1

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintLegCuffs.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" их намертво затянули на твоих ногах; соединенные цепью, они заставляют тебя переваливаться с ноги на ногу или прыгать на одной ножке!"
	else:
		return getAStackNameCapitalize()+" их надели на ноги {receiver.nameS}, соединив цепью, из-за чего {receiver.him} приходится переваливаться с ноги на ногу или прыгать!"

func getUnriggedParts(_character):
	return {
		"ankle.L": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
		"ankle.R": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
	}

func updateDoll(doll: Doll3D):
	doll.setLegsCuffed(true)

func getChains():
	# Extra chains if we're wearing matching wrist cuffs
	if(isWornByWearer()):
		if(getWearer().getInventory().hasItemIDEquipped("inmatewristcuffs")):
			return [["short", "ankle.L", "ankle.R"], ["short", "wrist.R", "ankle.R"], ["short", "wrist.L", "ankle.L"]]
	
	return [["short", "ankle.L", "ankle.R"]]

func getInventoryImage():
	return "res://Images/Items/bdsm/cuff.png"
