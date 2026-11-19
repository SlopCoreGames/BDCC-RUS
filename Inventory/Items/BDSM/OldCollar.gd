extends ItemBase

func _init():
	id = "oldcollar"

func getVisibleName():
	return "Рабский ошейник"
	
func getDescription():
	return "Очень громоздкий и крайне неудобный ошейник из литого железа. На нем постоянно мигает красный огонек. Похоже, это старая и довольно простая модель."

func getClothingSlot():
	return InventorySlot.Neck

func getBuffs():
	return [
		]

func getTakeOffScene():
	return "CollarTuggingScene"

func getTags():
	if(GM.main != null && GM.main.getFlag("FightClubModule.CanBuySlaveCollars", false)):
		return [ItemTag.AllowsEnslaving, ItemTag.ReturnsToPCIfSlaveReleased, ItemTag.SoldByTheAnnouncer]
	return [ItemTag.AllowsEnslaving, ItemTag.ReturnsToPCIfSlaveReleased]

func getPrice():
	return 10

func canSell():
	return true

func isImportant():
	return true

func isRestraint():
	return true

func canForceOntoNpc():
	return true

func canForceOntoStaticNpc():
	return false

func generateRestraintData():
	restraintData = RestraintSlaveCollar.new()

func getUnriggedParts(_character):
	return {
		"neck": ["res://Inventory/UnriggedModels/Collar/CollarOldModel.tscn"],
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/collar_old.png"
