extends ItemBase

func _init():
	id = "policecuffs"

func getVisibleName():
	return "Полицейские наручники"
	
func getDescription():
	return "Довольно стандартные полицейские наручники, которые надеваются на запястья"

func getClothingSlot():
	return InventorySlot.Wrists

func getBuffs():
	return [
		buff(Buff.RestrainedArmsBuff),
		]

func getTakeOffScene():
	return "CuffTuggingScene"

func getPrice():
	return 4

func getSellPrice():
	return 1

func canSell():
	return true
	
func getTags():
	return [ItemTag.BDSMRestraint]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintHandCuffs.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" защелкнулись на твоих руках, сковав их вместе"
	else:
		return getAStackNameCapitalize()+" защелкнулись на руках {receiver.nameS}, сковав их вместе"

func getUnriggedParts(_character):
	return {
		"wrist.L": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
		"wrist.R": ["res://Inventory/UnriggedModels/Cuff/CuffModel.tscn"],
	}

func updateDoll(doll: Doll3D):
	doll.setArmsCuffed(true)

func getInventoryImage():
	return "res://Images/Items/bdsm/cuff.png"
