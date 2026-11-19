extends "res://Inventory/Items/PenisPump.gd"

func _init():
	id = "PenisPumpAdvanced"

func getVisibleName():
	return "Насос для пениса Mk2"
	
func getDescription():
	return "Инструмент для быстрого извлечения семени. Если носить его постоянно, он будет автоматически доить тебя каждые 30 минут."

func getBuffs():
	return [
		buff(Buff.ChastityPenisBuff),
		buff(Buff.PenisCumGenerationAfterOrgasmBuff, [10]),
		buff(Buff.PenisCumProductionBuff, [50]),
		]

func getPrice():
	return 50

func canSell():
	return true

func getTags():
	if(GM.main != null && GM.main.SCI != null && GM.main.SCI.hasUpgrade("advPenisPump")):
		return [ItemTag.SoldByMedicalVendomat, ItemTag.PenisPump]
	return [ItemTag.PenisPump]

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(10000.0)
	#fluids.addFluid("Milk", 250.0)
	#var _ok = fluids.connect("contentsChanged", self, "updatePcIfNeeded")

func isAdvancedPenisPump():
	return true

func getNormalPenisPumpScene():
	return "res://Inventory/RiggedModels/PenisPump/PenisPumpAdv.tscn"

func getBigPenisPumpScene():
	return "res://Inventory/RiggedModels/PenisPump/BigPenisPumpAdv.tscn"

func getInventoryImage():
	return "res://Images/Items/breastpump/penisPumpAdv.png"
