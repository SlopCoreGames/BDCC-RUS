extends ItemBase

func _init():
	id = "ropeharness"
	clothesColor = Color.red

func getVisibleName():
	return "Веревочная портупея"
	
func getA():
	return "a"
	
func getDescription():
	return "Набор веревок, которые стягивают ваше тело"

func getClothingSlot():
	return InventorySlot.Torso

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.StatBuff, [Stat.Sexiness, 2]),
		]

func getPrice():
	return 8

func getSellPrice():
	return 2

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, ItemTag.RopeHarness]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintRopeHarness.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "развязывает все узлы и снимает твою верёвочную портупею"
	else:
		return "развязать все узлы и снять твою верёвочную портупею"

func getPuttingOnStringLong(withS):
	if(withS):
		return "связывает твоё тело верёвками"
	else:
		return "связать твоё тело верёвками"

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" была навязана тебе силой. Верёвки продолжают тереться о твои чувствительные места"
	else:
		return getAStackNameCapitalize()+" была навязана на {receiver.name} силой. Верёвки продолжают тереться о чувствительные места {receiver.his}"

func getRiggedParts(_character):
	return {
		"harness": "res://Inventory/RiggedModels/RopeHarness/RopeHarness.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/rope.png"

func canDye():
	return true
