extends "res://Inventory/Items/Condom.gd"


func _init():
	id = "QualityCondom"

func getVisibleName():
	return "Дорогой презерватив"
	
func getDescription():
	return "Три по цене двух! Похоже, они сделаны из премиального материала, который усиливает ощущения, обеспечивая при этом почти 100% защиту от разрывов"

func getPrice():
	return 2

func canSell():
	return true

func canCombine():
	return true

func getBuyAmount():
	return 3

func getTags():
	return [
		ItemTag.Condom,
		ItemTag.SoldByMedicalVendomat,
	]

func getCondomBreakChance():
	if(!OPTIONS.isContentEnabled(ContentType.RiskyCondoms)):
		return 0.0
	
	return 1.0

func getItemCategory():
	return ItemCategory.Medical

func getInventoryImage():
	return "res://Images/Items/medical/goodcondom.png"
