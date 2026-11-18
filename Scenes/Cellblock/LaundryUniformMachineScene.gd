extends "res://Scenes/SceneBase.gd"

var dyingItemUniqueID = ""
var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")
var savedDyedColor = ""

func _init():
	sceneID = "LaundryUniformMachineScene"

func _run():
	if(state == ""):
		saynn("Вы подходите к терминалу автомата — у него черно-зеленый экран и несколько кнопок. Вы нажимаете на одну из них, и машина издает писк.")
		
		saynn("На экране отображается:\n\nОбнаружен номер заключенного {pc.inmateNumber}.\nКатегория заключенного: {pc.inmateType}\nСтоимость новой формы: 10 кредитов.\nСтоимость ремонта формы: 5 кредитов.\nСтоимость окрашивания вещи: 5 кредитов.")

		saynn("Что будете делать?")

		addButton("Напечатать форму", "Вы хотите получить свежую тюремную робу", "printUniform")
		if(GM.pc.canRepairClothes()):
			addButton("Починить одежду", "Починить всё, что на вас надето.", "repairUniform")
		else:
			addDisabledButton("Починить одежду", "На вас нет ничего, что требовало бы ремонта")
		addButton("Покрасить одежду", "Выберите вещь, которую хотите покрасить", "dye_clothes_menu")
		
		addButton("Уйти", "Не хочешь тратить свои кровно заработанные кредиты?", "endthescene")
	
	if(state == "dye_clothes_menu"):
		playAnimation(StageScene.Solo, "stand")
		saynn("Машина ждет одежду для окрашивания. На экране красуется напоминание: покраска тюремной робы запрещена законом и может привести к существенному увеличению срока заключения.")
		
		saynn("Стоимость: 5 кредитов")
		
		for item in GM.pc.getInventory().getAllItemsCanDye():
			addButtonWithChecks(item.getVisibleName(), item.getVisibleDescription(), "start_dye", [item], [[ButtonChecks.HasCredits, 5]])
		
		addButton("Назад", "Вы передумали", "")
	
	if(state == "coloring_item"):
		var theItem:ItemBase = GM.pc.getInventory().getItemByUniqueID(dyingItemUniqueID)
		
		if(theItem.hasTag(ItemTag.Strapon)):
			playAnimation(StageScene.Solo, "stand", {bodyState={exposedCrotch=true}})
		elif(!theItem.getClothingSlotSafe().empty() && (theItem.getClothingSlotSafe() in [InventorySlot.UnderwearBottom, InventorySlot.UnderwearTop])):
			playAnimation(StageScene.Solo, "stand", {bodyState={underwear=true}})
		else:
			playAnimation(StageScene.Solo, "stand")
		
		var colorPicker = colorPickerScene.instance()
		GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
		colorPicker.setCurrentColor(theItem.clothesColor)
		colorPicker.connect("color_changed", self, "changebasecolormenu_colorchanged")
		
		addButtonWithChecks("Подтвердить", "Заплатить 5 кредитов и закрепить цвет", "do_pay_coloritem", [theItem], [[ButtonChecks.HasCredits, 5]])
		addButton("Отмена", "Вы передумали", "cancel_dying")
	
	if(state == "notEnough"):
		if(GM.pc.isBlindfolded()):
			saynn("Машина сердито пищит, на экране что-то мелькает. Разглядеть сложно, но, скорее всего, там написано, что у вас не хватает кредитов.")
		else:
			saynn("Машина сердито пищит, на экране надпись: [b]Не хватает кредитов! Иди паши в шахтах, ленивая зэчка[/b]")
		
		addButton("Уйти", "Какая грубость", "endthescene")
	
	if(state == "repairUniform"):
		saynn("Вы нажимаете на кнопку, и машина списывает с вас немного кредитов. Затем вы снимаете свою потрёпанную одежду и кладете её в специальный отсек. Машина заглатывает всё содержимое и начинает работать, издавая кучу шума, пока пытается заштопать все дыры.")
		
		saynn("Машина издает звуковой сигнал и выдает вам вашу одежду — полностью чистую и отремонтированную!")
		
		addButton("Уйти", "Круто", "endthescene")
	
	if(state == "afterPrinting"):
		if(GM.pc.isBlindfolded()):
			saynn("Несмотря на повязку на глазах, вам каким-то образом удается нащупать нужную кнопку, перебирая все подряд. Машина списывает кредиты и распечатывает вам свежую униформу. Непонятно, та ли это, но деваться некуда — вы хватаете её и уходите.")
		elif(GM.pc.hasBoundArms()):
			saynn("Взаимодействовать с машиной, когда руки заняты, чертовски сложно, но вам это удается: вы просто тыкаете в кнопки носом. Машина сверяется с базой отпечатков носа и выдает вам униформу точно вашего размера с вашим номером заключенного. Вы подхватываете её подбородком и уходите.")
		else:
			saynn("Вы нажимаете на кнопку, и машина списывает с вас немного кредитов. После этого она начинает гудеть и выдает вам новенькую тюремную робу точно вашего размера с вашим номером заключенного. Вы хватаете её и уходите.")
			
		addButton("Уйти", "Хорошо", "endthescene")
		
		
func _react(_action: String, _args):
	if(_action == "repairUniform"):
		processTime(30)
		
		if(GM.pc.getCredits() < 5):
			setState("notEnough")
			return
		else:
			GM.pc.addCredits(-5)
			
			GM.pc.repairAllClothes()
			#var item:ItemBase = GM.pc.getInventory().getEquippedItem(InventorySlot.Body)
			#if(item!=null && item.id in ["inmateuniform", "inmateuniformHighsec", "inmateuniformSexDeviant"]):
			#	item.repairDamage()
	
	if(_action == "do_pay_coloritem"):
		var theItem:ItemBase = GM.pc.getInventory().getItemByUniqueID(dyingItemUniqueID)
		var theColor = GM.ui.getUIdata("colorpicker")
		theItem.onDyed(theColor)
		GM.pc.addCredits(-5)
		setState("dye_clothes_menu")
		GM.pc.unequipStrapon()
		return
	
	if(_action == "start_dye"):
		var theItem = _args[0]
		dyingItemUniqueID = _args[0].uniqueID
		savedDyedColor = theItem.clothesColor.to_html()
		if(!GM.pc.getInventory().hasEquippedItemWithUniqueID(dyingItemUniqueID)):
			var theSlot:String = theItem.getClothingSlotSafe()
			if(!theSlot.empty()):
				if(GM.pc.getInventory().canEquipSlot(theSlot)):
					if(GM.pc.getInventory().hasSlotEquipped(theSlot)):
						if(!GM.pc.getInventory().getEquippedItem(theSlot).isRestraint()):
							# We have something equipped but it's not a restraint, can replace
							GM.pc.getInventory().forceEquipStoreOther(theItem)
					else:
						# Nothing equipped there, can put on
						GM.pc.getInventory().forceEquipStoreOther(theItem)
		setState("coloring_item")
		return
	
	if(_action == "cancel_dying"):
		var theItem:ItemBase = GM.pc.getInventory().getItemByUniqueID(dyingItemUniqueID)
		theItem.onDyed(Color(savedDyedColor))
		setState("dye_clothes_menu")
		GM.pc.unequipStrapon()
		return
	
	if(_action == "printUniform"):
		processTime(30)
		
		if(GM.pc.getCredits() < 10):
			setState("notEnough")
			return
		else:
			GM.pc.addCredits(-10)
			
			var uniform = GlobalRegistry.createItem("inmateuniform")
			uniform.setPrisonerNumber(GM.pc.getFullInmateNumber())
			uniform.setInmateType(GM.pc.getInmateType())
			GM.pc.getInventory().addItem(uniform)
			
			addMessage("A fresh uniform was added to your inventory")
			
			setState("afterPrinting")
		return

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

var isChanging = false
func changebasecolormenu_colorchanged(_theColor):
	if(isChanging):
		return
	isChanging = true
	yield(get_tree().create_timer(0.3), "timeout")
	if(GM.ui.getCustomControl("colorpicker") == null):
		isChanging = false
		return
	var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
	
	var theItem:ItemBase = GM.pc.getInventory().getItemByUniqueID(dyingItemUniqueID)
	theItem.onDyed(theColor)

	#thePC.updateAppearance()
	isChanging = false

func saveData():
	var data = .saveData()
	
	data["dyingItemUniqueID"] = dyingItemUniqueID
	data["savedDyedColor"] = savedDyedColor
	
	return data
	
func loadData(data):
	.loadData(data)
	
	dyingItemUniqueID = SAVE.loadVar(data, "dyingItemUniqueID", "")
	savedDyedColor = SAVE.loadVar(data, "savedDyedColor", "")
