extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""
var item: ItemBase = null

func _init():
	sceneID = "CatchBodyFluidsScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(GM.pc.hasBlockedHands() || GM.pc.hasBoundArms()):
		setState("cantdoit")
		return
	
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	if(item == null):
		return
	
	if(GM.pc.getFluids().isEmpty()):
		setState("nofluidsonbody")
		return
	
	processTime(10*60)
	var amount = GM.pc.getFluids().transferTo(item, RNG.randf_range(0.1, 0.2))
	
	addMessage("Тебе удалось собрать "+str(Util.roundF(amount))+" ml")

func _run():
	if(state == ""):
		saynn("Вы тратите некоторое время, используя "+item.getVisibleName()+" чтобы собрать часть покрывающих вас похотливых выделений.")
		
		addButton("Продолжить", "Окей", "endthescene")

	if(state == "nofluidsonbody"):
		saynn("Вас не покрывают никакие выделения, которые можно было бы собрать")
		
		addButton("Продолжить", "aww", "endthescene")

	if(state == "cantdoit"):
		saynn("Какие-то оковы мешают вам это сделать")
		
		addButton("Продолжить", "aww", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
