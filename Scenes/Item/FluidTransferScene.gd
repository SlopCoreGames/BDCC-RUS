extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""
var interactionItemID = ""
var item: ItemBase

func _init():
	sceneID = "FluidTransferScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)

func _run():
	if(state == ""):
		saynn("Что вы хотите сделать с содержимым "+item.getVisibleName())
		
		if(item.getFluids() != null):
			var fluids = item.getFluids()
			if(fluids.isCapacityLimited()):
				sayn("Макс. объем: "+str(Util.roundF(fluids.getFluidAmount()))+"/"+str(Util.roundF(fluids.getCapacity(), 1))+" ml")
			if(!fluids.isEmpty()):
				saynn("Содержимое:\n"+Util.join(fluids.getContentsHumanReadableArray(),"\n"))
			else:
				saynn("Содержимое: пусто")
			
			sayn("Перелить в = перекачать жидкость из этого предмета в другой")
			saynn("Наполнить = перекачать жидкость из другого предмета в этот")
			
			if(fluids.isEmpty()):
				addDisabledButton("Перелить в", "Оно пустое")
			else:
				addButton("Перелить в", "Перелить жидкость в другой предмет", "transferFluids")
			addButton("Наполнить", "Использовать другой предмет, чтобы наполнить этот", "fillWithFluids")
			if(!fluids.isEmpty()):
				addButton("Опорожнить!", "Удалить все жидкости из этого предмета", "empty_warning")
			else:
				addDisabledButton("Опорожнить!", "Он и так пуст")
		
		addButton("Закрыть", "Хватит возиться", "endthescene")

	if(state == "empty_warning"):
		saynn("Ты уверен, что хочешь опустошить этот предмет?")
		
		saynn("Жидкость внутри будет потеряна навсегда.")
		
		addButton("Подтвердить", "Опорожнить", "do_empty")
		addButton("Отмена", "Вы передумали", "")

	if(state == "fillWithFluids"):
		saynn("Выберите предмет, которым хотите наполнить выбранный")

		addButton("Назад", "Назад на меню", "")
		
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			if(equippedItem == item):
				continue
			
			if(equippedItem.getFluids() != null):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "pickFillFrom", [equippedItem.getUniqueID()])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem == item):
				continue
			
			if(theitem.getFluids() != null):
				if(theitem.getFluids().isEmpty()):
					addDisabledButton(theitem.getStackName(), "(Этот предмет пуст)\n\n"+theitem.getVisisbleDescription())
				else:
					addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "pickFillFrom", [theitem.getUniqueID()])

	if(state in ["pickFillFrom", "enteramounttofill"]):
		saynn("Сколько хотите перелить?")
		
		sayn("Кому:")
		if(item.getFluids() != null):
			sayn(item.getStackName())
			var fluids = item.getFluids()
			if(fluids.isCapacityLimited()):
				sayn("Макс. объем: "+str(Util.roundF(fluids.getFluidAmount()))+"/"+str(Util.roundF(fluids.getCapacity(), 1))+" ml")
			if(!fluids.isEmpty()):
				saynn("Содержимое:\n"+Util.join(fluids.getContentsHumanReadableArray(),"\n"))
			else:
				saynn("Содержимое: пусто")
		
		sayn("Откуда:")
		var item2 = GM.pc.getInventory().getItemByUniqueID(interactionItemID)
		if(item2.getFluids() != null):
			sayn(item2.getStackName())
			var fluids = item2.getFluids()
			if(fluids.isCapacityLimited()):
				sayn("Макс. объем: "+str(Util.roundF(fluids.getFluidAmount()))+"/"+str(Util.roundF(fluids.getCapacity(), 1))+" ml")
			if(!fluids.isEmpty()):
				saynn("Содержимое:\n"+Util.join(fluids.getContentsHumanReadableArray(),"\n"))
			else:
				saynn("Содержимое: пусто")
		
		if(state == "enteramounttofill"):
			saynn("Введите количество мл для переноса")
			
			var textBox:LineEdit = addTextbox("transfer_ml")
			var _ok = textBox.connect("text_entered", self, "onFillMLEnterPressed")
			addButton("Подтвердить", "выбрать это количество", "confirmtextfill")
			
			addButton("Назад", "Назад на меню", "fillWithFluids")
		else:
			addButton("Назад", "Назад на меню", "fillWithFluids")
			var variants = [0.1, 0.25, 0.5, 0.75, 1.0]
			var fluids = item2.getFluids()
			var howMuch = fluids.getFluidAmount()
			for howMuchPercent in variants:
				var willTransfer = howMuch * howMuchPercent
				addButton(str(Util.roundF(willTransfer, 1))+" ml", "Перелить "+(str(howMuchPercent*100.0))+"%", "doFill", [willTransfer])
			addButton("Точное количество", "Введите количество мл, которое хотите перелить", "enteramounttofill")
					

	if(state == "transferFluids"):
		saynn("Куда хочешь перекачать жидкости?")
		
		addButton("Назад", "Назад на меню", "")
		
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			if(equippedItem == item):
				continue
			
			if(equippedItem.getFluids() != null):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "pickTransferTo", [equippedItem.getUniqueID()])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem == item):
				continue
			
			if(theitem.getFluids() != null):
				addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "pickTransferTo", [theitem.getUniqueID()])
		
	if(state in ["pickTransferTo", "enteramounttotransfer"]):
		saynn("Сколько хотите перелить?")
		
		sayn("Откуда:")
		if(item.getFluids() != null):
			sayn(item.getStackName())
			var fluids = item.getFluids()
			if(fluids.isCapacityLimited()):
				sayn("Макс. объем: "+str(Util.roundF(fluids.getFluidAmount()))+"/"+str(Util.roundF(fluids.getCapacity(), 1))+" ml")
			if(!fluids.isEmpty()):
				saynn("Содержимое:\n"+Util.join(fluids.getContentsHumanReadableArray(),"\n"))
			else:
				saynn("Содержимое: пусто")
		
		sayn("Кому:")
		var item2 = GM.pc.getInventory().getItemByUniqueID(interactionItemID)
		if(item2.getFluids() != null):
			sayn(item2.getStackName())
			var fluids = item2.getFluids()
			if(fluids.isCapacityLimited()):
				sayn("Макс. объем: "+str(Util.roundF(fluids.getFluidAmount()))+"/"+str(Util.roundF(fluids.getCapacity(), 1))+" ml")
			if(!fluids.isEmpty()):
				saynn("Содержимое:\n"+Util.join(fluids.getContentsHumanReadableArray(),"\n"))
			else:
				saynn("Содержимое: пусто")
		
		if(state == "enteramounttotransfer"):
			saynn("Введите количество мл для переноса")
			
			var textBox:LineEdit = addTextbox("transfer_ml")
			var _ok = textBox.connect("text_entered", self, "onTransferMLEnterPressed")
			addButton("Подтвердить", "выбрать это количество", "confirmtexttransfer")
			
			addButton("Назад", "Назад на меню", "transferFluids")
		else:
			addButton("Назад", "Назад на меню", "transferFluids")
			var variants = [0.1, 0.25, 0.5, 0.75, 1.0]
			var fluids = item.getFluids()
			var howMuch = fluids.getFluidAmount()
			for howMuchPercent in variants:
				var willTransfer = howMuch * howMuchPercent
				addButton(str(Util.roundF(willTransfer, 1))+" ml", "Перелить "+(str(howMuchPercent*100.0))+"%", "doTransfer", [willTransfer])
			addButton("Точное количество", "Введите количество мл, которое хотите перелить", "enteramounttotransfer")
			
func onTransferMLEnterPressed(_new_text:String):
	GM.main.pickOption("confirmtexttransfer", [])
		
func onFillMLEnterPressed(_new_text:String):
	GM.main.pickOption("confirmtextfill", [])
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "pickTransferTo"):
		interactionItemID = _args[0]
	
	if(_action == "pickFillFrom"):
		interactionItemID = _args[0]
	
	if(_action == "confirmtexttransfer"):
		_action = "doTransfer"
		_args = [float(getTextboxData("transfer_ml"))]
	
	if(_action == "doTransfer"):
		var fluids:Fluids = item.getFluids()
		var item2 = GM.pc.getInventory().getItemByUniqueID(interactionItemID)
		
		var howMuch = fluids.transferAmountTo(item2, _args[0])
		
		addMessage("Вы перекачали "+str(Util.roundF(howMuch))+" мл из "+item.getVisibleName()+" to "+item2.getVisibleName() )
		
		setState("")
		return
	
	if(_action == "confirmtextfill"):
		_action = "doFill"
		_args = [float(getTextboxData("transfer_ml"))]
	
	if(_action == "doFill"):
		var item2 = GM.pc.getInventory().getItemByUniqueID(interactionItemID)
		var fluids:Fluids = item2.getFluids()
		
		var howMuch = fluids.transferAmountTo(item, _args[0])
		
		addMessage("Вы перекачали "+str(Util.roundF(howMuch))+" мл из "+item2.getVisibleName()+" to "+item.getVisibleName() )
		
		setState("")
		return
	
	if(_action == "do_empty"):
		item.getFluids().clear()
		setState("")
		
		addMessage("Вы опустошили "+item.getVisibleName())
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	data["interactionItemID"] = interactionItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
	interactionItemID = SAVE.loadVar(data, "interactionItemID", "")
	item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
