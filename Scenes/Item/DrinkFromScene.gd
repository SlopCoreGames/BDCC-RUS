extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""
var item: ItemBase = null
var savedEffects = ""

func _init():
	sceneID = "DrinkFromScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(GM.pc.isOralBlocked() || GM.pc.hasBoundArms()):
		setState("cantdrink")
		return
	
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	if(item == null):
		return
	
	var fluids:Fluids = item.getFluids()
	if(fluids == null || fluids.isEmpty()):
		setState("nothingtodrink")

	var extraMessages = []
	var fluidByAmount = fluids.getFluidAmountByType()
	for fluidID in fluidByAmount:
		var swallowData:Dictionary = GM.pc.doSwallow(fluidID, fluidByAmount[fluidID])
		if(swallowData.has("text") && swallowData["text"] != ""):
			extraMessages.append(swallowData["text"])
	
	fluids.transferTo(GM.pc.getBodypart(BodypartSlot.Head), 1.0)
	savedEffects = Util.join(extraMessages, " ")

func _run():
	if(state == ""):
		saynn("Вы проглатываете содержимое "+item.getVisibleName())
		
		saynn(savedEffects)
		
		addButton("Продолжить", "Окей", "endthescene")

	if(state == "nothingtodrink"):
		saynn("Пить было нечего")
		
		addButton("Продолжить", "aww", "endthescene")

	if(state == "cantdrink"):
		saynn("Какая-то сдержанность мешает вам это выпить")
		
		addButton("Продолжить", "aww", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	data["savedEffects"] = savedEffects
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
	savedEffects = SAVE.loadVar(data, "savedEffects", "")
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
