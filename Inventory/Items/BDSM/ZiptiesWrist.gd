extends "res://Inventory/Items/BDSM/InmateWristCuffs.gd"

func _init():
	id = "ZiptiesWrist"

func getVisibleName():
	return "Пластиковые стяжки (на запястья)"
	
func getA():
	return ""
	
func getDescription():
	return "Массивные металлические оковы. Можно запереть, чтобы сковать руки вместе"

func getTakeOffScene():
	return "CuffTuggingScene"

func generateRestraintData():
	restraintData = RestraintHandCuffs.new()
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
		"wrist.L": ["res://Inventory/UnriggedModels/ZipTies/ZipTiesModel.tscn"],
		"wrist.R": ["res://Inventory/UnriggedModels/ZipTies/ZipTiesModel.tscn"],
	}
	
func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return "Тебе силой надели на руки пластиковые стяжки"
	else:
		return "Тебе силой надели на {receiver.nameS} руки пластиковые стяжки"

func getInventoryImage():
	return "res://Images/Items/bdsm/ZipTies.png"
