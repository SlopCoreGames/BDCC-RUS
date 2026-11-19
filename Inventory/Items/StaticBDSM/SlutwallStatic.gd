extends ItemBase

func _init():
	id = "SlutwallStatic"

func getVisibleName():
	return "Стенка для шлюх"
	
func getDescription():
	return "Ты в ней застрял"

func getClothingSlot():
	return InventorySlot.Static1

func getBuffs():
	return [
		buff(Buff.RestrainedLegsBuff),
		#buff(Buff.RestEffectivenessBuff, [-60]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getTags():
	return [ItemTag.BDSMRestraint]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintStocks.new()
	restraintData.setLevel(5)
