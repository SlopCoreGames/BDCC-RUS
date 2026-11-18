extends "res://Scenes/SceneBase.gd"

var inventoryScreenScene = preload("res://UI/Inventory/InventoryScreen.tscn")

var savedItemUniqueID = ""
var fightMode = false

func _init():
	sceneID = "InventoryScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		fightMode = _args[0]
		
		if(fightMode && false):
			setState("interactmenu")

func _run():
	if(state == ""):
		if(true):
			var inventory = inventoryScreenScene.instance()
			GM.ui.addFullScreenCustomControl("inventory", inventory)
			inventory.setItems(GM.pc.getInventory().getItemsAndEquippedItemsTogetherGrouped(), ("fight" if fightMode else ""))
			var _ok = inventory.connect("onItemSelected", self, "onInventoryItemSelected")
			var _ok2 = inventory.connect("onInteractWith", self, "onInventoryItemInteracted")
			
		else:
			saynn("Что хочешь сделать?")
			
			say("Твоё снаряжение:\n")
			for slot in InventorySlot.getAll():
				if(!GM.pc.getInventory().hasSlotEquipped(slot) && GM.pc.invCanEquipSlot(slot)):
					say(InventorySlot.getVisibleName(slot)+": "+"Ничего"+"\n")
					continue
				if(!GM.pc.invCanEquipSlot(slot)):
					continue
				
				var item = GM.pc.getInventory().getEquippedItem(slot)
				
				say(InventorySlot.getVisibleName(slot)+": "+item.getVisibleName()+"\n")
			
			say("\n")
			var items = GM.pc.getInventory().getAllItems()
			var itemNames = []
			for item in items:
				itemNames.append(item.getStackName())
			say("Твои вещи:\n")
			say(Util.join(itemNames, ", "))
		
			addButton("Снять", "Снять предмет", "takeoffmenu")
			addButton("Надеть", "Надеть предмет", "putonmenu")
			addButton("Использовать", "Выбери предмет, чтобы использовать", "interactmenu")
		addButton("Закрыть", "Закрыть инвентарь", "endthescene")
		
	if(state == "takeoffmenu"):
		saynn("Выберите предмет, который хотите снять")
		
		addButton("Назад", "Назад", "")
		
		say("Твоё снаряжение:\n")
		for slot in InventorySlot.getAll():
			if(!GM.pc.getInventory().hasSlotEquipped(slot) && GM.pc.invCanEquipSlot(slot)):
				say(InventorySlot.getVisibleName(slot)+": "+"Ничего"+"\n")
				continue
			if(!GM.pc.invCanEquipSlot(slot)):
				continue
			
			var item = GM.pc.getInventory().getEquippedItem(slot)
			
			say(InventorySlot.getVisibleName(slot)+": "+item.getVisibleName()+"\n")
			addButton(item.getVisibleName(), item.getVisisbleDescription(), "takeoff", [item.getUniqueID()])
		
	if(state == "putonmenu"):
		saynn("Выберите предмет, который хотите надеть")
		
		addButton("Назад", "Назад", "")
		
		say("Твоё снаряжение:\n")
		for slot in InventorySlot.getAll():
			if(!GM.pc.getInventory().hasSlotEquipped(slot) && GM.pc.invCanEquipSlot(slot)):
				say(InventorySlot.getVisibleName(slot)+": "+"Ничего"+"\n")
				continue
			if(!GM.pc.invCanEquipSlot(slot)):
				continue
			
			var item = GM.pc.getInventory().getEquippedItem(slot)
			
			say(InventorySlot.getVisibleName(slot)+": "+item.getVisibleName()+"\n")
		
		for item in GM.pc.getInventory().getAllItems():
			var slot:String = item.getClothingSlotSafe()
			if(slot.empty()):
				continue
				
			if(GM.pc.getInventory().hasSlotEquipped(slot)):
				addDisabledButton(item.getVisibleName(), "Этот слот уже занят")
				continue
			if(!GM.pc.invCanEquipSlot(slot)):
				addDisabledButton(item.getVisibleName(), "Этот предмет нельзя экипировать")
				continue
			
			addButton(item.getVisibleName(), item.getVisisbleDescription(), "puton", [item.getUniqueID()])
		
		
	if(state == "interactmenu"):
		saynn("Выберите предмет для взаимодействия")
		#if(fightMode):
		#	saynn("Нажмите «назад», чтобы иметь возможность надевать и снимать предметы во время боя.")
		
		if(fightMode):
			addButton("Назад", "Вы не хотите ничего использовать", "endthescene")
		else:
			addButton("Назад", "Назад", "")
		
		var savedDisabled = []
		var equippeditems = GM.pc.getInventory().getAllEquippedItems()
		for invSlot in equippeditems:
			var item = equippeditems[invSlot]
			var actions = item.getPossibleActions()
			if(actions.size() > 0):
				addButton("(надето)"+item.getStackName(), item.getVisisbleDescription(), "lookat", [item.getUniqueID()])
		
		var items = GM.pc.getInventory().getAllItems()
		for item in items:
			var actions = item.getPossibleActions()
			if(actions.size() > 0):
				addButton(item.getStackName(), item.getVisisbleDescription(), "lookat", [item.getUniqueID()])
			else:
				savedDisabled.append([item.getStackName(), item.getVisisbleDescription()])
		
		for disabledRecord in savedDisabled:
			addDisabledButton(disabledRecord[0], disabledRecord[1])
			

		
	if(state == "lookat"):
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(savedItemUniqueID)
		assert(item != null)
		
		saynn("Что вы хотите сделать с "+item.getStackName())
		
		for action in item.getPossibleActions():
			if(!canDoAction(action)):
				addDisabledButton(action["name"], "(Сейчас нельзя)\n\n"+action["description"])
			else:
				addButton(action["name"], action["description"], "doitemaction", [action["scene"]])
		
		addButton("Назад", "Ничего не делать", "interactmenu")

func canDoAction(action):
	if(fightMode && action.has("onlyWhenCalm") && action["onlyWhenCalm"]):
		return false
		
	return true

func _react(_action: String, _args):
	if(_action == "takeoff"):
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(_args[0])
		runScene(item.getTakeOffScene(), [_args[0]])
		if(fightMode):
			endScene()
		return
	if(_action == "puton"):
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(_args[0])
		runScene(item.getPutOnScene(), [_args[0]])
		if(fightMode):
			endScene()
		return
	if(_action == "doitemaction"):
		var sceneToRun = _args[0]
		runScene(sceneToRun, [savedItemUniqueID])
		if(fightMode):
			endScene()
		return
	if(_action == "endthescene"):
		endScene([false])
		return
	if(_action == "lookat"):
		savedItemUniqueID = _args[0]
	
		if(fightMode):
			var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(savedItemUniqueID)
			
			var possibleActions = item.getPossibleActions()
			if(possibleActions.size() == 1):
				if(canDoAction(possibleActions[0])):
					runScene(possibleActions[0]["scene"], [savedItemUniqueID])
					endScene()
	
	if(_action == "dofightaction"):
		savedItemUniqueID = _args[0]
	
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(savedItemUniqueID)
			
		var possibleActions = item.getPossibleActions()
		if(possibleActions.size() == 1):
			if(canDoAction(possibleActions[0])):
				runScene(possibleActions[0]["scene"], [savedItemUniqueID])
				endScene()
		return
	
	setState(_action)

func _react_scene_end(_tag, _result):
	setState("")

func onInventoryItemInteracted(item: ItemBase):
	GM.main.pickOption("dofightaction", [item.getUniqueID()])

func onInventoryItemSelected(item: ItemBase):
	GM.ui.clearButtons()
	addButton("Закрыть", "Закрыть инвентарь", "endthescene")
	
	if(item == null):
		return
	savedItemUniqueID = item.getUniqueID()
	
	var slot = item.getClothingSlotSafe()
	if(!slot.empty() && !fightMode):
		if(GM.pc.getInventory().hasSlotEquipped(slot)):
			if(GM.pc.getInventory().getEquippedItem(slot) == item):
				addButton("Снять", item.getVisisbleDescription(), "takeoff", [item.getUniqueID()])
			else:
				addDisabledButton("Надеть", "Этот слот уже занят")
		elif(!GM.pc.invCanEquipSlot(slot)):
			addDisabledButton("Надеть", "Этот предмет нельзя экипировать")
		else:
			addButton("Надеть", item.getVisisbleDescription(), "puton", [item.getUniqueID()])
	
	if(fightMode && !item.canUseInCombat()):
		addDisabledButton("Нельзя использовать!","Этот предмет нельзя использовать в бою")
		return
	
	for action in item.getPossibleActions():
		if(!canDoAction(action)):
			addDisabledButton(action["name"], "(Сейчас нельзя)\n\n"+action["description"])
		else:
			addButton(action["name"], action["description"], "doitemaction", [action["scene"]])

func saveData():
	var data = .saveData()
	
	data["savedItemUniqueID"] = savedItemUniqueID
	data["fightMode"] = fightMode
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedItemUniqueID = SAVE.loadVar(data, "savedItemUniqueID", "")
	fightMode = SAVE.loadVar(data, "fightMode", false)

func supportsShowingPawns() -> bool:
	return true
