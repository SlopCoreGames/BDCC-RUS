extends "res://Inventory/Items/BDSM/InmateAnkleCuffs.gd"

func _init():
	id = "ZiptiesAnkle"

func getVisibleName():
	return "Пластиковые стяжки (на лодыжки)"
	
func getA():
	return ""
	
func getDescription():
	return "Массивные металлические оковы. Можно запереть, чтобы сковать ноги вместе"

func getTakeOffScene():
	return "CuffTuggingScene"

func generateRestraintData():
	restraintData = RestraintLegCuffs.new()
	restraintData.setLevel(calculateBestRestraintLevel())
	restraintData.tightlockShiv = true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]

func getPrice():
	return 4

func getSellPrice():
	return 1

func getUnriggedParts(_character):
	return {
		"ankle.L": ["res://Inventory/UnriggedModels/ZipTies/AnkleZipTiesModel.tscn"],
		"ankle.R": ["res://Inventory/UnriggedModels/ZipTies/AnkleZipTiesModel.tscn"],
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return "Тебе на ноги натянули пластиковые стяжки, из-за чего теперь приходится передвигаться только вразвалочку или прыжками!"
	else:
		return "На ноги {receiver.nameS} натянули пластиковые стяжки, из-за чего {receiver.him} теперь приходится передвигаться только вразвалочку или прыжками!"

func getChains():
	return [["cableshort", "ankle.L", "ankle.R"]]

func getInventoryImage():
	return "res://Images/Items/bdsm/ZipTies.png"
