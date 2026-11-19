extends ItemBase
class_name HK_Glasses

func _init():
	id = "VionGlasses"

func getVisibleName():
	return "Очки"
	
func getDescription():
	return "Пара антикварных очков. Кому они вообще сейчас нужны?"

func getClothingSlot():
	return InventorySlot.Eyes
	
func getPossibleActions():
	return []
	
func getTakeOffScene():
	return "TakeAnyItemOffScene"

func getPrice():
	return 0

func canSell():
	return true

func getTags():
	return []

func isRestraint():
	return false

func getUnriggedParts(_character):
	return {
		"blindfold": ["res://Modules/HypnokinkModule/Items/Glasses/GlassesModel.tscn"]
		}
