extends ItemBase

var breakChance:float = 20.0
var lastUser:String = ""

func _init():
	id = "UsedCondom"

func getVisibleName():
	return "Использованный презерватив"
	
func getDescription():
	var theText = "Использованный презерватив. Если он наполнен, его можно выбросить."
	if(lastUser != ""):
		theText += "\nНаполнен: "+str(lastUser)
	return theText

func getClothingSlot():
	return InventorySlot.Penis

func generateItemState():
	itemState = ItemStateUnremovable.new()

func getBuffs():
	return [
		]

func getCondomBreakChance():
	if(!OPTIONS.isContentEnabled(ContentType.RiskyCondoms)):
		return 0.0
	
	return breakChance

func saveData():
	var data = .saveData()
	
	data["breakChance"] = breakChance
	data["lastUser"] = lastUser
	
	return data
	
func loadData(data):
	.loadData(data)
	
	breakChance = SAVE.loadVar(data, "breakChance", 20.0)
	lastUser = SAVE.loadVar(data, "lastUser", "")

func markLastUser(theName):
	lastUser = theName

func onSexEnd():
	destroyMe()

func updateDoll(doll: Doll3D):
	doll.setState("cock", "condom")

func generateFluids():
	fluids = Fluids.new()
	#fluids.addFluid("Cum", 1000.0)
	#fluids.addFluid("Milk", 1000.0)
	#fluids.addFluid("GirlCum", 1000.0)
	#fluids.addFluid("Piss", 1000.0)

func getTags():
	return [
		ItemTag.CanPeeInto,
		ItemTag.CanForceCumInto,
		]

func getPossibleActions():
	return [
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
		{
			"name": "Утилизировать",
			"scene": "DisposeOfAnItemScene",
			"description": "Выбросить этот презерватив",
		},
	]

func getAttacks():
	if(fluids.isEmpty()):
		return []
	return ["ThrowUsedCondomPCAttack"]

func getInventoryImage():
	return "res://Images/Items/toys/usedcondom.png"
