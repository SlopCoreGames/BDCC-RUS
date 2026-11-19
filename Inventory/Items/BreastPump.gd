extends ItemBase

func _init():
	id = "BreastPump"

func getVisibleName():
	return "Сцеживающий молоконик"
	
func getDescription():
	return "Инструмент для извлечения молока из лактирующих грудей. Это базовая версия, у которой есть свои недостатки.\nЕсли использовать его во время секса, он высасывает "+str(getMilkSpeedPerMinuteMin())+"-"+str(getMilkSpeedPerMinuteMax())+" мл молока в минуту."

func getClothingSlot():
	return InventorySlot.UnderwearTop

func generateItemState():
	itemState = ItemStateUnremovable.new()

func getBuffs():
	return [
		]

func getPrice():
	return 10

func canSell():
	return true

func getMilkSpeedPerMinuteMin():
	return 30.0

func getMilkSpeedPerMinuteMax():
	return 100.0

func getTags():
	return [ItemTag.SoldByMedicalVendomat, ItemTag.BreastPump, ItemTag.BreastPumpUsableByNPC]

func getUnriggedParts(_character):
	var howFilled = fluids.getFluidAmount()/fluids.getCapacity()
	
	if(howFilled <= 0.0):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpEmpty.tscn"],
		}
	elif(howFilled < 0.3):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpLittle.tscn"],
		}
	elif(howFilled < 0.75):
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpHalf.tscn"],
		}
	else:
		return {
			"breastpump": ["res://Inventory/UnriggedModels/BreastPump/BreastPumpFull.tscn"],
		}

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(2000.0)
	#fluids.addFluid("Milk", 250.0)
	var _ok = fluids.connect("contentsChanged", self, "updatePcIfNeeded")

func updatePcIfNeeded(_oldFluidAmount, _newFluidAmount):
	if(!isWornByWearer()):
		return
	
	updateWearerAppearance()

func getPossibleActions():
	return [
		{
			"name": "Собственное молоко",
			"scene": "BreastPumpsMilkingScene",
			"description": "Включить молокоотсосы",
		},
		{
			"name": "Перекачать жидкость",
			"scene": "FluidTransferScene",
			"description": "Перелить жидкость из одного контейнера в другой",
		},
		{
			"name": "Выпить из",
			"scene": "DrinkFromScene",
			"description": "Проглотить содержимое этого предмета",
		},
	]

func getInventoryImage():
	var howFilled = fluids.getFluidAmount()/fluids.getCapacity()
	
	if(howFilled <= 0.0):
		return "res://Images/Items/breastpump/pumpEmpty.png"
	elif(howFilled < 0.3):
		return "res://Images/Items/breastpump/pumpLittle.png"
	elif(howFilled < 0.75):
		return "res://Images/Items/breastpump/pumpHalf.png"
	else:
		return "res://Images/Items/breastpump/pumpFull.png"

func alwaysRecoveredAfterSex():
	return true
