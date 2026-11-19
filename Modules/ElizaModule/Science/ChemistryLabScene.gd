extends SceneBase

var genericInventoryScreenScene = preload("res://UI/Inventory/GenericInventoryScreen.tscn")
var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")


var pickedUpgrade:String = ""
var pickedTF:String = ""
var pickedTFOption:String = ""
var pickedArgs:Dictionary = {}
var uniqueItemID:String = ""

func _init():
	sceneID = "ChemistryLabScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Вы стоите внутри лаборатории.")
		
		sayn("Очки науки: " + str(GM.main.SCI.getSciencePoints()))
		sayn("Разблокированные таблетки трансформации: "+str(GM.main.SCI.getUnlockedStrangePillsCount())+"/"+str(GM.main.SCI.getTotalStrangePillCount()))
		sayn("Протестированные таблетки трансформации: "+str(GM.main.SCI.getTestedStrangePillsCount())+"/"+str(GM.main.SCI.getTotalStrangePillCount()))
		saynn("Улучшения: "+str(GM.main.SCI.getUpgradeCount())+"/"+str(GM.main.SCI.getTotalUpgradeCount()))
		
		sayTanksVolume()
		
		# DEBUG INFO
		if(false):
			sayn("МАКС. НАУКИ ДЛЯ РАЗБЛОКИРОВКИ ТФ: "+str(GM.main.SCI.getMaxScienceFromUnlockingTFs()))
			sayn("МАКС. НАУКИ ДЛЯ РАЗБЛОКИРОВКИ+ТЕСТА ТФ: "+str(GM.main.SCI.getMaxScienceFromUnlockingAndTestingTFs()))
			saynn("СТОИМОСТЬ ВСЕХ УЛУЧШЕНИЙ: "+str(GM.main.SCI.getAllUpgradesScienceCost()))
		
		addButton("Создать", "Посмотреть, что можно создать в этой лаборатории", "create_menu")
		addButton("Жидкости", "Посмотреть, что можно сделать с резервуарами", "fluid_tanks")
		addButton("Улучшения", "Просмотреть список доступных улучшений", "upgrades")
		addButton("База данных", "Просмотреть базу данных всего, что вы разблокировали или изучили", "database")
		if(GM.main.SCI.hasUpgrade("bluespaceStash")):
			addButton("Заначка", "Посмотреть свой личный запас предметов", "look_stash")
		if(GM.main.SCI.doesPCHaveUnknownStrangePills()):
			addButton("Странная таблетка!", "Заставить Элизу просканировать странную таблетку, которая у тебя есть", "scan_strange_pill")
		addButton("Уйти", "Пора идти", "endthescene")
	
	if(state == "fluid_tanks"):
		playAnimation(StageScene.Solo, "stand")
		sayTanksVolume()
		
		saynn("Что ты хочешь сделать?")
		
		addButton("Наполнить", "Наполнить резервуары одним из ваших предметов", "tank_fill_select")
		addButton("Очистить", "Выбрать один из резервуаров и полностью его опустошить", "tank_clear_select")
		
		if(GM.main.SCI.hasUpgrade("shower1")):
			addButton("Душ", "Принять особый душ, который соберет все жидкости", "tank_shower")
		if(GM.main.SCI.hasUpgrade("fluidInspector")):
			addButton("Осмотреть контейнер", "Использовать лабораторное оборудование, чтобы изучить один из ваших контейнеров с жидкостью и получить полную информацию о её составе", "inspect_select")
		if(GM.main.SCI.hasUpgrade("fluidFilter")):
			addButton("Фильтровать контейнер", "Использовать лабораторное оборудование, чтобы отфильтровать жидкости из одного из ваших контейнеров", "filter_select")
		
		
		addButton("Назад", "Назад в предыдущее меню", "")
	
	if(state == "filter_select"):
		addButton("Назад", "Назад в предыдущее меню", "fluid_tanks")
		
		saynn("Выберите контейнер, который хотите отфильтровать. Вы сможете удалить выбранные жидкости из этого контейнера.")
		
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			
			if(equippedItem.getFluids() != null && !equippedItem.getFluids().isEmpty()):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "tank_pickFilter", [equippedItem])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem.getFluids() != null):
				if(theitem.getFluids().isEmpty()):
					#addDisabledButton(theitem.getStackName(), "(Этот предмет пуст)\n\n"+theitem.getVisisbleDescription())
					pass
				else:
					addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "tank_pickFilter", [theitem])
	
	if(state == "tank_pickFilter"):
		var item:ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("ОШИБКА: ПРЕДМЕТ НЕ НАЙДЕН.")
			addButton("Продолжить", "Смотреть, что будет дальше", "filter_select")
			return
		var fluids:Fluids = item.getFluids()
		if(fluids == null):
			saynn("ОШИБКА: У ПРЕДМЕТА ОТСУТСТВУЕТ ОБЪЕКТ ЖИДКОСТЕЙ.")
			addButton("Продолжить", "Смотреть, что будет дальше", "filter_select")
			return
		addButton("Назад", "Назад в предыдущее меню", "filter_select")
		
		sayn("Название контейнера: "+item.getVisibleName())
		saynn("Емкость: "+str(Util.roundF(fluids.getFluidAmount(), 1))+(("/"+str(Util.roundF(fluids.getCapacity(), 1))) if fluids.isCapacityLimited() else "")+" ml")
		
		if(fluids.isEmpty()):
			saynn("Контейнер пуст!")
		else:
			var fluidByType:Dictionary = fluids.getFluidAmountByType()
			sayn("Обнаруженные жидкости:")
			
			for fluidID in fluidByType:
				var fluidAmount:float = fluidByType[fluidID]
				var fluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidID)
				var fluidName:String = fluidOBJ.getVisibleName() if fluidOBJ != null else fluidID
				
				sayn(" - "+fluidName+": "+str(Util.roundF(fluidAmount, 1))+" ml")
				
				addButton(fluidName, "Удалить "+str(Util.roundF(fluidAmount, 1))+" мл "+fluidName, "do_filter_out", [fluids, fluidID])
				
			sayn("")
			saynn("Выберите жидкость, которую хотите отфильтровать. Выбранная жидкость будет удалена из контейнера и безопасно утилизирована.")
		
	
	if(state == "inspect_select"):
		addButton("Назад", "Назад в предыдущее меню", "fluid_tanks")
		
		saynn("Выберите контейнер с жидкостью для осмотра. Лаборатория покажет вам подробную информацию о содержимом этого предмета.")
		
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			
			if(equippedItem.getFluids() != null && !equippedItem.getFluids().isEmpty()):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "tank_pickInspect", [equippedItem])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem.getFluids() != null):
				if(theitem.getFluids().isEmpty()):
					#addDisabledButton(theitem.getStackName(), "(Этот предмет пуст)\n\n"+theitem.getVisisbleDescription())
					pass
				else:
					addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "tank_pickInspect", [theitem])
		
	if(state == "tank_pickInspect"):
		var item:ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("ОШИБКА: ПРЕДМЕТ НЕ НАЙДЕН.")
			addButton("Продолжить", "Смотреть, что будет дальше", "inspect_select")
			return
		var fluids:Fluids = item.getFluids()
		if(fluids == null):
			saynn("ОШИБКА: У ПРЕДМЕТА ОТСУТСТВУЕТ ОБЪЕКТ ЖИДКОСТЕЙ.")
			addButton("Продолжить", "Смотреть, что будет дальше", "inspect_select")
			return
		
		saynn("Вы помещаете контейнер в сканер и нажимаете кнопку. Экран компьютера загорается, отображая различные данные.")
		
		sayn("Название контейнера: "+item.getVisibleName())
		saynn("Емкость: "+str(Util.roundF(fluids.getFluidAmount(), 1))+(("/"+str(Util.roundF(fluids.getCapacity(), 1))) if fluids.isCapacityLimited() else "")+" ml")
		
		saynn("Найдено уникальных записей: "+str(fluids.contents.size()))
		
		var _i:int = 1
		for recordInfo in fluids.contents:
			var fluidType:String = recordInfo["fluidType"] if recordInfo.has("fluidType") else "ERROR"
			var fluidAmount:float = recordInfo["amount"] if recordInfo.has("amount") else 0.0
			var fluidDNA:FluidDNA = recordInfo["fluidDNA"] if recordInfo.has("fluidDNA") else null
			var fluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidType)
			var fluidName:String = fluidOBJ.getVisibleName() if fluidOBJ != null else fluidType
			
			sayn("Запись №"+str(_i))
			sayn("Тип жидкости: "+fluidName)
			sayn("Кол-во: "+str(Util.roundF(fluidAmount, 1))+" ml")
			if(fluidDNA == null):
				saynn("ДНК не обнаружена")
			else:
				var theChar:BaseCharacter = fluidDNA.getCharacter()
				var charName:String = theChar.getName() if theChar != null else "Unknown"
				var theSpeciesRaw:Array = fluidDNA.getSpecies()
				var theSpeciesStr:String = ""
				for species in theSpeciesRaw:
					var theSpeciesObj:Species = GlobalRegistry.getSpecies(species)
					if(theSpeciesObj == null):
						continue
					if(theSpeciesStr != ""):
						theSpeciesStr += ", "
					theSpeciesStr += theSpeciesObj.getVisibleName()
				sayn("Обнаруженная ДНК: "+charName)
				sayn("Вид: "+theSpeciesStr)
				sayn("Вирильность: "+str(Util.roundF(fluidDNA.getVirility()*100.0, 1))+"%")
				sayn("")
			
			_i += 1
		
		addButton("Продолжить", "Смотреть, что будет дальше", "inspect_select")
	
	if(state == "tank_fill_select"):
		addButton("Назад", "Назад в предыдущее меню", "fluid_tanks")
		saynn("Какой предмет вы хотите использовать, чтобы заполнить резервуары с жидкостью? Выбранный предмет будет [b]опустошен полностью[/b]!")
		
		sayTanksVolume()
		
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			
			if(equippedItem.getFluids() != null && !equippedItem.getFluids().isEmpty()):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "tank_pickFillFrom", [equippedItem])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem.getFluids() != null):
				if(theitem.getFluids().isEmpty()):
					#addDisabledButton(theitem.getStackName(), "(Этот предмет пуст)\n\n"+theitem.getVisisbleDescription())
					pass
				else:
					addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "tank_pickFillFrom", [theitem])

	
	if(state == "tank_clear_select"):
		addButton("Назад", "Назад в предыдущее меню", "fluid_tanks")
		
		saynn("Какой резервуар вы хотите опустошить? [b]Это полностью очистит его, удалив все жидкости данного типа из вашей лаборатории[/b].")
		
		sayTanksVolume()
		
		var storedFluids:Dictionary = GM.main.SCI.getStoredFluids()
		for fluidID in storedFluids:
			var fluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidID)
			var fluidName:String = fluidOBJ.getVisibleName() if fluidOBJ != null else fluidID
			
			addButton(fluidName, "Опустошить "+str(round(storedFluids[fluidID]))+" мл "+fluidName, "do_empty_tank", [fluidID])
	
	if(state == "create_menu"):
		addButton("Назад", "Назад в предыдущее меню", "")
		
		#var canConfigure:bool = GM.main.SCI.canConfigureDrugs()
		
		var entries:Dictionary = {}
		
		for tfID in GlobalRegistry.getTransformationRefs():
			if(!GM.main.SCI.isTransformationUnlocked(tfID)):
				continue
			var canMakeResult:Array = GM.main.SCI.canMakePillResult(tfID)
			var canMake:bool = canMakeResult[0]
			var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
			
			var desc:String = GM.main.SCI.getMakePillDescription(tfID)
			
			var theActions:Array = []
			if(canMake):
				theActions = [["make", "Make"]]
				if(tf.getPillCanConfigure() && GM.main.SCI.canConfigureDrugs()):
					theActions = [["custom", "Custom"], ["make", "Make"]]
			
			entries[tfID] = {
				name = tf.getPillName()+" pill",
				desc = desc+("\n\n[color=red]"+canMakeResult[1]+"[/color]" if !canMake else ""),
				actions = theActions,
			}
		
		var crafts:Dictionary = GM.main.SCI.getCraftableItems()
		for itemID in crafts:
			var craftInfo:Dictionary = crafts[itemID]
			var itemRef:ItemBase = GlobalRegistry.getItemRef(itemID)
			if(itemRef == null):
				continue
			
			var itemName:String = itemRef.getVisibleName()
			var itemDesc:String = itemRef.getVisisbleDescription()
			
			if(itemID == "TFPill"):
				itemName = "Strange Pill"
				itemDesc = "Use advanced algorithms to brute-force random molecular structures until we find one that has transformative properties.\n\nThis pill is guaranteed to be one that hasn't been unlocked yet (Unless you have unlocked all of them already). The cost of this pill will raise each time you make it."
			
			var itemFluidsReq:String = GM.main.SCI.canMakeGetFluidsDescription(craftInfo["fluids"])
			var canMakeResult:Array = GM.main.SCI.canMakeHasFluids(craftInfo["fluids"])
			var canMake:bool = canMakeResult[0]
			
			if(craftInfo.has("science")):
				itemFluidsReq = "Science points: "+str(craftInfo["science"])+"  (You have "+str(GM.main.SCI.getSciencePoints())+")\n"+itemFluidsReq
				if(GM.main.SCI.getPoints() < craftInfo["science"]):
					canMake = false
					if(canMakeResult[1] != ""):
						canMakeResult[1] += "\n"
					canMakeResult[1] += "Not enough Science Points"
				
			var theActions:Array = []
			if(canMake):
				theActions = [["makeCraft", "Make"]]
			
			entries[itemID] = {
				name = itemName,
				desc = itemDesc+"\n\nRequired:\n"+itemFluidsReq+("\n\n[color=red]"+canMakeResult[1]+"[/color]" if !canMake else ""),
				actions = theActions,
			}
			
		var inventory = genericInventoryScreenScene.instance()
		GM.ui.addFullScreenCustomControl("inventory", inventory)
		inventory.setRightPanelStretchRation(0.75)
		inventory.setEntries(entries)
		var _ok = inventory.connect("onInteractWith", self, "onMakeInteract")
	
	if(state == "database"):
		addButton("Назад", "Назад в предыдущее меню", "")
		addButton("Переиграть сцену", "Переиграть одну из старых сцен с наркотиками", "replay_menu")
		
		var entries:Dictionary = {}
		entries["1"] = {
			name = "= УЛУЧШЕНИЯ =",
			desc = "В этом списке показаны разблокированные улучшения",
		}
		
		var upgradesInfo:Dictionary = GM.main.SCI.getUpgrades()
		var hasAnyUnlocked:bool = false
		#sayn("Доступные улучшения:")
		for upgradeID in upgradesInfo:
			if(!GM.main.SCI.hasUpgrade(upgradeID)):
				continue
			entries["up_"+upgradeID] = {
				name = upgradesInfo[upgradeID]["name"],
				desc = upgradesInfo[upgradeID]["desc"],
			}
			#sayn(" - "+upgradesInfo[upgradeID]["name"])
			hasAnyUnlocked = true
		if(!hasAnyUnlocked):
			#sayn(" - Улучшений не найдено")
			entries["noup_"] = {
				name = "Улучшений не найдено",
				desc = "Сначала получи несколько улучшений!",
			}
		#sayn("")
		
		entries["2"] = {
			name = "= ПРЕПАРАТЫ =",
			desc = "В этом списке показаны найденные тобой особые препараты",
		}
		#sayn("Трансформирующие препараты:")
		var _i:int = 1
		for tfID in GlobalRegistry.getTransformationRefs():
			var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
			if(!tf.canUnlockAsPill()):
				continue
			var isUnlocked:bool = GM.main.SCI.isTransformationUnlocked(tfID)
			var isTested:bool = isUnlocked && GM.main.SCI.isTransformationTested(tfID)
			
			if(!isUnlocked):
				#sayn(" - "+str(_i)+": Неизвестно")
				entries["drug_"+tfID] = {
					name = str(_i)+": Неизвестно",
					desc = "Ты еще не нашел этот препарат",
				}
			else:
				#sayn(" - "+str(_i)+": "+(tf.getPillName() if isUnlocked else "Unknown")+". "+(tf.getName()+". Untested" if !isTested else tf.getName()+". Tested"))
				
				var drugDesc:String = ""
				drugDesc += "Pill name: "+tf.getPillName()
				drugDesc += "\nPossible effect: "+tf.getName()
				drugDesc += "\nStatus: "+("[color=red]UNTESTED[/color]" if !isTested else "[color=green]TESTED[/color]")
				drugDesc += "\n\nFull description:"
				if(isTested):
					drugDesc += "\n"+tf.getPillDatabaseDesc()
				else:
					drugDesc += "\nNot available, testing is required"
				
				entries["drug_"+tfID] = {
					name = str(_i)+": "+tf.getPillName(),
					desc = drugDesc,
				}
			
			#if(isTested):
			#	addButton(tf.getPillName(), "Посмотреть подробную информацию об этой таблетке", "detailedViewTF", [tfID])
			
			_i += 1
			
			

			
		var inventory = genericInventoryScreenScene.instance()
		GM.ui.addFullScreenCustomControl("inventory", inventory)
		inventory.setRightPanelStretchRation(0.75)
		inventory.setEntries(entries)
		#var _ok = inventory.connect("onItemSelected", self, "onInventoryItemSelected")
		#var _ok2 = inventory.connect("onInteractWith", self, "onInventoryItemInteracted")
		
	
	if(state == "upgrades"):
		var upgradesInfo:Dictionary = GM.main.SCI.getUpgrades()
		var currentDrugAmount:int = GM.main.SCI.getUnlockedStrangePillsCount()
		
		#saynn("Список доступных улучшений. Выберите любое, чтобы узнать подробности.")
		
		var hasAnyUpgrades:bool = false
		
		var entries:Dictionary = {}
		
		addButton("Назад", "Назад в предыдущее меню", "")
		for upgradeID in upgradesInfo:
			if(GM.main.SCI.hasUpgrade(upgradeID)):
				continue
			if(!GM.main.SCI.isUpgradeVisible(upgradeID)):
				continue
			hasAnyUpgrades = true
			var upgradeInfo:Dictionary = upgradesInfo[upgradeID]
			#sayn("- "+upgradeInfo["name"]+": "+str(upgradeInfo["cost"])+" очков науки")
			#addButton(upgradeInfo["name"], "Инфо об этом улучшении", "lookAtUpgrade", [upgradeID])
			
			
			var canBuy:bool = upgradeInfo["cost"] <= GM.main.SCI.getPoints()
			var upgradeDesc:String = ""
			upgradeDesc += upgradeInfo["desc"]
			upgradeDesc += "\n\nYou have "+str(GM.main.SCI.getPoints())+" science points"
			upgradeDesc += "\nCost: [color="+("red" if !canBuy else "green")+"]"+str(upgradeInfo["cost"])+" science points[/color]"
			if(upgradeInfo.has("drugAmount")):
				var needDrugAmount:int = upgradeInfo["drugAmount"]
				if(currentDrugAmount < needDrugAmount):
					canBuy = false
				upgradeDesc += "\nAmount of drugs unlocked: [color="+("red" if currentDrugAmount < needDrugAmount else "green")+"]"+str(needDrugAmount)+" drug"+("s" if needDrugAmount != 1 else "")+"[/color]"
			
			entries[upgradeID] = {
				name = upgradeInfo["name"],
				desc = upgradeDesc,
				actions = [
					["buy", "Unlock"]
				] if canBuy else [],
			}
		if(!hasAnyUpgrades):
			#sayn("- Больше улучшений нет! AlphaCorp вами гордится!")
			entries["1"] = {
				name = "= Улучшений больше нет =",
				desc = "Улучшений больше нет! АльфаКорп гордится тобой!",
			}
	
		var inventory = genericInventoryScreenScene.instance()
		GM.ui.addFullScreenCustomControl("inventory", inventory)
		inventory.setRightPanelStretchRation(0.75)
		inventory.setEntries(entries)
		var _ok = inventory.connect("onInteractWith", self, "onUpgradesInteract")
	
	if(state == "lookAtUpgrade"):
		var upgradeInfo:Dictionary = GM.main.SCI.getUpgrades()[pickedUpgrade]
		
		saynn("Название улучшения: "+upgradeInfo["name"])
		sayn("Описание:")
		saynn(upgradeInfo["desc"])
		sayn("Цена: "+str(upgradeInfo["cost"])+" очков науки")
		sayn("У вас есть "+str(GM.main.SCI.getPoints())+" очков науки")
		
		addButton("Назад", "Назад в предыдущее меню", "upgrades")
		if(GM.main.SCI.getPoints() >= upgradeInfo["cost"]):
			addButton("Купить", "Потратить "+str(upgradeInfo["cost"])+" очков науки, чтобы получить это улучшение", "doBuyUpgrade", [pickedUpgrade])
		else:
			addDisabledButton("Купить", "Недостаточно очков науки")
	
	if(state == "detailedViewTF"):
		var tf:TFBase = GlobalRegistry.getTransformationRef(pickedTF)
		if(tf == null):
			addButton("Назад", "Назад в предыдущее меню", "database")
			return
		
		sayn("Название таблетки: "+tf.getPillName())
		saynn("Краткое описание: "+tf.getName())
		sayn("Полное описание:")
		saynn(tf.getPillDatabaseDesc())
		
		addButton("Назад", "Назад в предыдущее меню", "database")
	
	if(state == "after_buy"):
		var upgradeInfo:Dictionary = GM.main.SCI.getUpgrades()[pickedUpgrade]
		saynn("Вы разблокировали '"+upgradeInfo["name"]+" улучшение!")
		addButton("Продолжить", "Смотреть, что будет дальше", "upgrades")
		
	if(state == "configuring_drug"):
		var tf:TFBase = GlobalRegistry.getTransformationRef(pickedTF)
		
		saynn("Здесь вы можете настроить таблетку перед её созданием.")
		
		sayn("Название таблетки: "+tf.getPillName())
		saynn("Описание: "+tf.getName())
		
		addButton("Создать", "Создать таблетку с этими параметрами", "do_create_configured_pill")
		
		sayn("Настройки:")
		var _i:int = 1
		var options:Dictionary = tf.getPillOptions()
		for optionID in options:
			var option:Dictionary = options[optionID]
			
			if(option.has("color") && option["color"]):
				sayn(str(_i)+". "+option["name"]+" = [color="+pickedArgs[optionID]+"]"+pickedArgs[optionID]+"[/color]")
			else:
				var currentOptionName:String = "???"
				for valueEntry in option["values"]:
					if(valueEntry[0] == pickedArgs[optionID]):
						currentOptionName = valueEntry[1]
				
				sayn(str(_i)+". "+option["name"]+" = "+currentOptionName)
			saynn(option["desc"])
			addButton(option["name"], option["desc"], "configure_value_menu", [optionID])
			
		
		addButton("CANCEL", "Ты передумал!", "")
	
	if(state == "configure_value_menu"):
		var tf:TFBase = GlobalRegistry.getTransformationRef(pickedTF)
		var options:Dictionary = tf.getPillOptions()
		var option:Dictionary = options[pickedTFOption]
		
		if(option.has("color") && option["color"]):
			var colorPicker = colorPickerScene.instance()
			GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
			colorPicker.setCurrentColor(Color(pickedArgs[pickedTFOption]))
			
			addButton("Применить", "Выбрать этот цвет", "set_value_configure_color")
		else:
			var currentOptionName:String = "???"
			for valueEntry in option["values"]:
				if(valueEntry[0] == pickedArgs[pickedTFOption]):
					currentOptionName = valueEntry[1]
			
			sayn("Название параметра: "+option["name"])
			sayn("Описание: "+option["desc"])
			saynn("Текущее значение: "+currentOptionName)
			
			saynn("Выберите новое значение для этого параметра!")
			
			for valueEntry in option["values"]:
				addButton(valueEntry[1], valueEntry[2] if valueEntry.size() > 2 else "Установить значение настройки", "set_value_configure", [valueEntry[0]])
			
		addButton("BACK", "Ты передумал!", "configuring_drug")
		
	if(state == "replay_menu"):
		addButton("Назад", "Назад в предыдущее меню", "database")
		saynn("Некоторые трансформирующие препараты имеют уникальные секс-сцены с Элизой. Здесь можно посмотреть и переиграть их все.")
		
		for tfID in GlobalRegistry.getTransformationRefs():
			if(!GM.main.SCI.isTransformationUnlocked(tfID)):
				continue
			var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
			
			var unlockData:Dictionary = tf.getUnlockData()
			
			if(unlockData.has("tryOptions")):
				var tryOptions:Array = unlockData["tryOptions"]
				if(tryOptions.size() > 0):
					addButton(tf.getPillName(), "Смотреть сцены, связанные с этим препаратом", "replay_menu_drug", [tfID])
		
	if(state == "replay_menu_drug"):
		addButton("Назад", "Назад в предыдущее меню", "replay_menu")
		var tf:TFBase = GlobalRegistry.getTransformationRef(pickedTF)
		
		saynn("Выбранный препарат: "+tf.getPillName())
		saynn("Хочешь переиграть сцену?")
		
		var unlockData:Dictionary = tf.getUnlockData()
		if(!unlockData.has("tryOptions")):
			return
		var tryOptions:Array = unlockData["tryOptions"]
		
		for optionEntry in tryOptions:
			if(optionEntry.has("disabled") && optionEntry["disabled"]):
				addDisabledButton(optionEntry["name"], "(Невозможно для вашего текущего тела)"+optionEntry["desc"])
			else:
				addButton(optionEntry["name"], optionEntry["desc"], "play_replay_scene", [optionEntry["sceneID"]])

func onUpgradesInteract(_upgradeID:String, _id, _args):
	pickedUpgrade = _upgradeID
	GM.main.pickOption("doBuyUpgrade", [_upgradeID])
		
func onMakeInteract(_upgradeID:String, _id, _args):
	GM.main.pickOption("doMakeTFPill", [_upgradeID, _id])
	
func sayTanksVolume():
	var storedFluids:Dictionary = GM.main.SCI.getStoredFluidsWithDefauls()
	
	sayn("Содержимое резервуаров с жидкостью:")
	for fluidID in storedFluids:
		var fluidAmount:float = storedFluids[fluidID]
		var fluidLimit:float = GM.main.SCI.getStoredFluidLimit(fluidID)
		var fluidName:String = "Unknown fluid"
		
		var fluid:FluidBase = GlobalRegistry.getFluid(fluidID)
		if(fluid != null):
			fluidName = fluid.getVisibleName()
		
		sayn("- "+fluidName+": "+str(Util.roundF(fluidAmount, 1))+"/"+str(Util.roundF(fluidLimit, 1))+"ml")
	sayn("")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "lookAtUpgrade"):
		pickedUpgrade = _args[0]
	if(_action == "detailedViewTF"):
		pickedTF = _args[0]
	if(_action == "replay_menu_drug"):
		pickedTF = _args[0]
	if(_action == "configure_value_menu"):
		pickedTFOption = _args[0]
	if(_action == "set_value_configure"):
		pickedArgs[pickedTFOption] = _args[0]
		setState("configuring_drug")
		return
	if(_action == "set_value_configure_color"):
		var colorPicker = GM.ui.getCustomControl("colorpicker")
		pickedArgs[pickedTFOption] = "#"+colorPicker.getCurrentColor().to_html(false)
		setState("configuring_drug")
		return
	if(_action == "doBuyUpgrade"):
		var upgradeInfo:Dictionary = GM.main.SCI.getUpgrades()[pickedUpgrade]
		GM.main.SCI.addPoints(-upgradeInfo["cost"])
		GM.main.SCI.unlockUpgrade(pickedUpgrade)
		#addMessage("You unlocked the '"+upgradeInfo["name"]+"' upgrade!")
		#setState("upgrades")
		setState("after_buy")
		return
	if(_action == "doMakeTFPill"):
		var tfID:String = _args[0]
		
		if(_args[1] == "makeCraft"):
			var theCrafts:Dictionary = GM.main.SCI.getCraftableItems()
			var craftInfo:Dictionary = theCrafts[tfID]
			var itemRef:ItemBase = GlobalRegistry.getItemRef(tfID)
			
			if(craftInfo.has("science")):
				GM.main.SCI.addPoints(-craftInfo["science"])
			GM.main.SCI.useFluidsToMakeSomething(craftInfo["fluids"])
			
			addMessage("Ты создал «"+itemRef.getVisibleName()+"'!")
			
			if(tfID == "TFPill"):
				GM.main.SCI.madeStrangePills += 1
				var newPill:ItemBase = GlobalRegistry.createItem(tfID)
				newPill.makePillStrangeIfCan()
				GM.pc.getInventory().addItem(newPill)
			else:
				GM.pc.getInventory().addItem(GlobalRegistry.createItem(tfID))
			setState("")
			return
		
		var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
		if(_args[1] == "custom" && GM.main.SCI.canConfigureDrugs() && tf.getPillCanConfigure()):
			pickedTF = tfID
			pickedArgs = {}
			var theOptions:Dictionary = tf.getPillOptions()
			for optionID in theOptions:
				pickedArgs[optionID] = theOptions[optionID]["value"]
			setState("configuring_drug")
			return
		
		var newPill:ItemBase = GM.main.SCI.useFluidsToMakePill(tfID)
		if(newPill != null):
			addMessage("Ты создал "+tf.getPillName()+" таблетку!")
			GM.pc.getInventory().addItem(newPill)
		
		setState("")
		return
	if(_action == "do_create_configured_pill"):
		var tfID:String = pickedTF
		
		var newPill:ItemBase = GM.main.SCI.useFluidsToMakePill(tfID, pickedArgs)
		if(newPill != null):
			var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
			var configDescAr:Array = []
			var options:Dictionary = tf.getPillOptions()
			for optionID in options:
				var option:Dictionary = options[optionID]
				
				if(option.has("color") && option["color"]):
					configDescAr.append(option["name"]+": [color="+pickedArgs[optionID]+"]"+pickedArgs[optionID]+"[/color]")
				else:
					var currentOptionName:String = "???"
					for valueEntry in option["values"]:
						if(valueEntry[0] == pickedArgs[optionID]):
							currentOptionName = valueEntry[1]
					configDescAr.append(option["name"]+": "+currentOptionName)
			newPill.setConfigDesc(Util.join(configDescAr, "\n"))
			
			addMessage("Ты создал "+tf.getPillName()+" таблетку!")
			GM.pc.getInventory().addItem(newPill)
		
		setState("")
		return
		
	if(_action == "do_empty_tank"):
		var fluidID:String = _args[0]
		var fluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidID)
		var fluidName:String = fluidOBJ.getVisibleName() if fluidOBJ != null else fluidID
		
		GM.main.SCI.clearFluid(fluidID)
		addMessage("'"+fluidName+"Резервуар с жидкостью очищен!")
		return
		
	if(_action == "tank_pickFillFrom"):
		var theItem:ItemBase = _args[0]
		if(theItem == null):
			return
		var fluids:Fluids = theItem.getFluids()
		if(fluids == null):
			return
		
		var fluidsByType:Dictionary = fluids.getFluidAmountByType()
		for fluidID in fluidsByType:
			var theFluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidID)
			if(theFluidOBJ == null):
				continue
			
			var howMuchAdded:float = GM.main.SCI.addFluid(fluidID, fluidsByType[fluidID])
			if(howMuchAdded > 0.0):
				addMessage(str(Util.roundF(howMuchAdded, 1))+" мл "+theFluidOBJ.getVisibleName()+" было слито в резервуары с жидкостью.")
		fluids.clear()
		
		return
		
	if(_action == "tank_shower"):
		runScene("ChemistryLabShowerScene")
		return
	
	if(_action == "look_stash"):
		runScene("PlayerStashScene")
		return
	
	if(_action in ["tank_pickInspect", "tank_pickFilter"]):
		if(_args.size() > 0):
			uniqueItemID = _args[0].uniqueID
	
	if(_action == "do_filter_out"):
		var fluids:Fluids = _args[0]
		var fluidID:String = _args[1]
		
		fluids.removeFluidType(fluidID)
		
		return
	
	if(_action == "scan_strange_pill"):
		runScene("ElizaGenericUnlockDrugScene")
		return
	
	if(_action == "play_replay_scene"):
		endScene()
		runScene(_args[0])
		return
	
	setState(_action)


func getDebugActions():
	var fluidValues:Array = []
	for fluidID in GlobalRegistry.getFluids():
		fluidValues.append([fluidID, fluidID])
	var tfValues:Array = []
	for tfID in GlobalRegistry.getTransformationRefs():
		var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
		tfValues.append([tfID, tf.getPillName()+" ("+tf.getName()+")"])
	
	return [
	{
		"id": "addPoints",
		"name": "Добавить науку",
		"args": [
			{
				"id": "points",
				"name": "Очки",
				"type": "number",
				"value": 100,
			},
		],
	},
	{
		"id": "addFluid",
		"name": "Добавить жидкость",
		"args": [
			{
				"id": "fluidID",
				"name": "Жидкость",
				"type": "list",
				"value": "Milk",
				"values": fluidValues,
			},
			{
				"id": "ml",
				"name": "Сколько мл?",
				"type": "number",
				"value": 100,
			},
		],
	},
	{
		"id": "unlockTF",
		"name": "Разблокировать ТФ",
		"args": [
			{
				"id": "tf",
				"name": "ID ТФ",
				"type": "list",
				"value": "Demonification",
				"values": tfValues,
			},
		],
	},
	{
		"id": "testTF",
		"name": "Тест ТФ",
		"args": [
			{
				"id": "tf",
				"name": "ID ТФ",
				"type": "list",
				"value": "Demonification",
				"values": tfValues,
			},
		],
	},
	{
		"id": "unlockAll",
		"name": "Разблокировать ВСЕ ТФ",
		"args": [
		],
	},
	{
		"id": "testAll",
		"name": "Тест ВСЕХ ТФ",
		"args": [
		],
	},
	{
		"id": "lockAll",
		"name": "Заблокировать ВСЕ ТФ",
		"args": [
		],
	},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "addPoints"):
		GM.main.SCI.addPoints(_args["points"])
	if(_id == "addFluid"):
		GM.main.SCI.addFluid(_args["fluidID"], _args["ml"])
	if(_id == "unlockTF"):
		GM.main.SCI.doUnlockTF(_args["tf"])
	if(_id == "testTF"):
		GM.main.SCI.doUnlockTF(_args["tf"])
		GM.main.SCI.doTestTF(_args["tf"])
	if(_id == "unlockAll"):
		for tfID in GlobalRegistry.getTransformationRefs():
			GM.main.SCI.doUnlockTF(tfID)
	if(_id == "testAll"):
		for tfID in GlobalRegistry.getTransformationRefs():
			GM.main.SCI.doTestTF(tfID)
	if(_id == "lockAll"):
		GM.main.SCI.unlockedTFs.clear()
		GM.main.SCI.testedTFs.clear()

func saveData():
	var data = .saveData()
	
	data["pickedUpgrade"] = pickedUpgrade
	data["pickedTF"] = pickedTF
	data["pickedTFOption"] = pickedTFOption
	data["pickedArgs"] = pickedArgs
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	pickedUpgrade = SAVE.loadVar(data, "pickedUpgrade", "")
	pickedTF = SAVE.loadVar(data, "pickedTF", "")
	pickedTFOption = SAVE.loadVar(data, "pickedTFOption", "")
	pickedArgs = SAVE.loadVar(data, "pickedArgs", {})
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
