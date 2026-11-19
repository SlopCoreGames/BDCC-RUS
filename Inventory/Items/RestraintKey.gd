extends ItemBase


func _init():
	id = "restraintkey"

func getVisibleName():
	return "Ключ от пут"
	
func getDescription():
	return "Универсальный одноразовый ключ, способный открыть любой элемент БДСМ-снаряжения. Кажется, стоит приберечь парочку на всякий случай."

func getPrice():
	return 15

func getSellPrice():
	return 2

func canSell():
	return true

func canCombine():
	return true

func getTags():
	return [
		ItemTag.SoldByTheAnnouncer,
		ItemTag.Illegal,
		ItemTag.KeptAfterDrugDenRun,
		]

func getInventoryImage():
	return "res://Images/Items/bdsm/key.png"
