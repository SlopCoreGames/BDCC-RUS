extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""

func _init():
	sceneID = "TakeAnyItemOffScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	if(item == null):
		return
	
	if(item.isRestraint()):
		var restraintData = item.getRestraintData()
		if(restraintData != null && restraintData.hasSmartLock()):
			setState("smartlocked")
			return
	
	if(!GM.pc.hasBlockedHands()):
		if(GM.pc.hasBoundArms()):
			setState("awkwardtakeoff")
		
		item.resetLustState()
		GM.pc.getInventory().removeEquippedItem(item)
		GM.pc.getInventory().addItem(item)
		GM.pc.updateAppearance()
		GM.main.updateSubAnims()
	else:
		setState("blockedhands")

func _run():
	if(state == ""):
		if(uniqueItemID == null || uniqueItemID == ""):
			addButton("Продолжить", "Ой", "endthescene")
			return
		
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("Ошибка: предмет не найден")
		else:
			saynn("Вы "+item.getTakingOffStringLong(false))
		
		addButton("Продолжить", "Вы сняли предмет", "endthescene")

	if(state == "smartlocked"):
		saynn("Этот предмет заблокирован умным замком... так что снять его не получится.")
		
		addButton("Продолжить", "О-о-о...", "endthescene")

	if(state == "awkwardtakeoff"):
		if(uniqueItemID == null || uniqueItemID == ""):
			addButton("Продолжить", "Ой", "endthescene")
			return
		
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("Ошибка: предмет не найден")
		else:
			saynn("Это чертовски неудобно делать со связанными руками, но вам почти удалось. Вы "+item.getTakingOffStringLong(false))
		
		addButton("Продолжить", "Вы сняли предмет", "endthescene")

	if(state == "blockedhands"):
		saynn("Вы изо всех сил пытаетесь что-то снять, но скованные руки мешают вам это сделать")
		
		addButton("Продолжить", "О-о-о...", "endthescene")


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
