extends "res://Inventory/Items/BreastPump.gd"

func _init():
	id = "BreastPumpAdvanced"

func getVisibleName():
	return "Сцеживающий насос Mk2"
	
func getDescription():
	return "Инструмент для извлечения молока из лактирующих грудей. Это продвинутая версия, которая будет автоматически собирать молоко при длительном ношении.\nЕсли надеть во время секса, она извлекает"+str(getMilkSpeedPerMinuteMin())+"-"+str(getMilkSpeedPerMinuteMax())+" мл молока в минуту."

func getBuffs():
	return [
		buff(Buff.BreastsMilkProductionBuff, [50.0]),
		]

func getPrice():
	return 50

func canSell():
	return true

func getMilkSpeedPerMinuteMin():
	return 100.0

func getMilkSpeedPerMinuteMax():
	return 300.0

func getTags():
	if(GM.main != null && GM.main.SCI != null && GM.main.SCI.hasUpgrade("advBreastPump")):
		return [ItemTag.SoldByMedicalVendomat, ItemTag.BreastPump]
	return [ItemTag.BreastPump]

func getUnriggedParts(_character):
	var howFilled = fluids.getFluidAmount()/fluids.getCapacity()
	
	if(howFilled <= 0.0):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpAdvEmpty.tscn"],
		}
	elif(howFilled < 0.3):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpAdvLittle.tscn"],
		}
	elif(howFilled < 0.75):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpAdvHalf.tscn"],
		}
	else:
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpAdvFull.tscn"],
		}

func generateFluids():
	.generateFluids()
	fluids.setCapacity(20000.0)

func getInventoryImage():
	var howFilled = fluids.getFluidAmount()/fluids.getCapacity()
	
	if(howFilled <= 0.0):
		return "res://Images/Items/breastpump/pumpAdvEmpty.png"
	elif(howFilled < 0.3):
		return "res://Images/Items/breastpump/pumpAdvLittle.png"
	elif(howFilled < 0.75):
		return "res://Images/Items/breastpump/pumpAdvHalf.png"
	else:
		return "res://Images/Items/breastpump/pumpAdvFull.png"
