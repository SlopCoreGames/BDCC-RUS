extends SceneBase

var npc1ID:String = ""
var npc2ID:String = ""

#var meow = 1
var genericInventoryScreenScene = preload("res://UI/Inventory/GenericInventoryScreen.tscn")
var nuggetButtons:Array = []

func _init():
	sceneID = "PSShaftMinerGameplayScene"

func _reactInit():
	GM.pc.setLocation("psmine_sleep")
	setState("roam")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc1"):
		return npc1ID
	if(_charID == "npc2"):
		return npc2ID

func _run():
	var roomID:String = GM.pc.getLocation()
	
	if(state == ""):
		saynn("Если вы видите это, значит, что-то пошло не так.")
	
	
	if(state == "roam"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		var _roomInfo = GM.world.getRoomByID(roomID)

		if(GM.pc.isBlindfolded() && !GM.pc.canHandleBlindness()):
			saynn(_roomInfo.getBlindDescription())
		else:
			saynn(_roomInfo.getDescription())
		
		var canMineInfo:Array = GM.main.PS.canMineSmart(roomID)
		var canMine:bool = canMineInfo[0]
		
		if(GM.world.canGoID(roomID, GameWorld.Direction.NORTH)):
			addButtonAt(6, "North", "Go north", "go", [GameWorld.Direction.NORTH, Direction.North])
		else:
			addDisabledButtonAt(6, "North", "Can't go north")
		if(GM.world.canGoID(roomID, GameWorld.Direction.WEST)):
			addButtonAt(10, "West", "Go west", "go", [GameWorld.Direction.WEST, Direction.West])
		else:
			addDisabledButtonAt(10, "West", "Can't go west")
		if(GM.world.canGoID(roomID, GameWorld.Direction.SOUTH)):
			addButtonAt(11, "South", "Go south", "go", [GameWorld.Direction.SOUTH, Direction.South])
		else:
			addDisabledButtonAt(11, "South", "Can't go south")
		if(GM.world.canGoID(roomID, GameWorld.Direction.EAST)):
			addButtonAt(12, "East", "Go east",  "go", [GameWorld.Direction.EAST, Direction.East])
		else:
			addDisabledButtonAt(12, "East", "Can't go east")
		if(GM.main.PS.dudes.size() > 0):
			addButtonAt(7, "Idle", "Just idle around, letting other slaves work", "justIdle")
		
		if(GM.main.PS.canRefresh()):
			addButtonAt(13, "Refreshments", "Use the minecart's refreshments", "useRefresh")
		
		if(GM.main.PS.nuggetsCarrying > 0):
			if(GM.pc.getLocation() != GM.main.PS.LOC_ENTRANCE):
				addButtonAt(14, "Drop nuggets", "Drop all the nuggets that you are holding", "dropNuggets")
			else:
				addButton("Сбросить самородки", "Сбросить все самородки, которые вы держите", "dropNuggets")
		
		
		if(GM.main.PS.pushingMinecart):
			if(GM.pc.getLocation() == GM.main.PS.LOC_ENTRANCE && GM.main.PS.nuggetsMinecart > 0):
				addButton("Разгрузить вагонетку", "Разгрузить вагонетку и получить кредиты за все самородки руды.", "doUnloadMinecart")
			addButton("Перестать толкать", "Перестать толкать вагонетку", "stoppush")
		
		if(canMine):
			if(GM.pc.getStamina() > 0):
				addButton("Копай!", "Начать добычу", "domine")
			else:
				addDisabledButton("Копай!", "У тебя не хватает выносливости для этого")
		else:
			if(canMineInfo[1] != ""):
				addDisabledButton("Копай!", canMineInfo[1])
			
		if(!GM.main.PS.pushingMinecart && GM.pc.getLocation() == GM.main.PS.minecartLoc):
			if(GM.main.PS.nuggetsCarrying > 0):
				if(GM.main.PS.canLoadMinecart()):
					addButton("Загрузить вагонетку", "Сложить все самородки в вагонетку", "doLoadMinecart")
				else:
					addDisabledButton("Загрузить вагонетку", "Вагонетка полна!")
			addButton("Толкать вагонетку", "Начать толкать вагонетку", "startpush")
		
		if(!GM.main.PS.pushingMinecart && GM.main.PS.hasNuggetsIn(GM.pc.getLocation())):
			addButton("Подбирать самородки", "Начать собирать самородки руды", "start_nuggets_picking")
		
		if(roomID == "psmine_entrance"):
			saynn("Разблокированные улучшения: "+GM.main.PS.getUpgradesCompletionStr()+"")
			
			addButton("Улучшения", "Посмотри, как можно улучшить свои инструменты", "upgrades_menu")
		

		if(!GM.main.PS.pushingMinecart):
			if(GM.pc.getLocation() == GM.main.PS.LOC_CAGE):
				addButton("Закончить день", "Поспать в клетке", "doSleep")
				if(GM.main.PS.hasUpgrade("rest")):
					addButton("Отдохнуть", "Отдохнуть в клетке 2 часа и восстановить немного выносливости", "doRest")
				#else:
				#	addDisabledButton("Отдохнуть", "Для отдыха уже слишком поздно")
				
				if(GM.main.PS.canHireDudes(1)):
					addButton("Нанять помощника", "Нанять одного из других рабов, чтобы работать вместе с тобой", "hire1_pickslave")
				if(GM.main.PS.canHireDudes(2)):
					addButton("Нанять 2 помощников", "Нанять двух рабов, чтобы работать вместе с тобой", "hire2_pickslave")
		
		if(!GM.main.PS.pushingMinecart):
			if(GM.pc.getLocation() == GM.main.PS.LOC_BOSS):
				if(GM.main.PS.didReachTarget()):
					addButton("Свобода!", "Ты добыл достаточно руды, чтобы уйти!", "do_win")
				else:
					addDisabledButton("Свобода!", "Ты добыл недостаточно руды, чтобы заслужить свободу...")
				
				addButtonAt(14, "Mine", "Do some mining here", "do_mine_boss")
		
		var theTexts:Array = GM.main.PS.getTextsForLocFinal(roomID)
		if(!theTexts.empty()):
			say(Util.join(theTexts, ""))
		
	if(state == "hire1_menu"):
		playAnimation(StageScene.Duo, "stand", {npc=npc1ID})
		
		saynn("Ты подходишь к одному из рабов и предлагаешь ему поработать на тебя.")
		
		saynn("Они соглашаются поработать на тебя день... но только если ты позволишь им трахнуть тебя!")
		
		sayn("Предложение:")
		sayn("Они получают: Твое тело.")
		saynn("Ты получаешь: Их помощь.")
		
		addButton("Согласиться", "Позволить им трахнуть тебя!", "hire1_sex")
		addButton("Отмена", "Вы передумали", "hire_cancel")
	
	if(state == "hire1_after_sex"):
		playAnimation(StageScene.Duo, "stand", {npc=npc1ID})
		
		saynn("Что ты хочешь, чтобы они сделали?")
		
		if(GM.main.PS.canHireDude(true)):
			addButton("Шахтер", "Они будут заниматься добычей", "hire1_pick_miner")
		else:
			addDisabledButton("Шахтер", "У вас уже слишком много таких")
		if(GM.main.PS.canHireDude(false)):
			addButton("Перевозчик руды", "Они будут перевозить руду", "hire1_pick_carrier")
		else:
			addDisabledButton("Перевозчик руды", "У вас уже слишком много таких")
	
	if(state == "hire2_menu"):
		playAnimation(StageScene.Duo, "stand", {pc=npc1ID, npc=npc2ID})
		
		saynn("Вы подходите к двум рабыням и предлагаете им поработать на вас.")
		
		saynn("Они согласились поработать на вас один день... но только если вы позволите им трахать вас... одновременно!")
		
		sayn("Предложение:")
		sayn("Они получают: Твое тело.")
		saynn("Ты получаешь: Их помощь.")
		
		addButton("Согласиться", "Позволить им трахнуть тебя!", "hire2_sex")
		addButton("Отмена", "Вы передумали", "hire_cancel")
	
	if(state == "hire2_after_sex"):
		playAnimation(StageScene.Duo, "stand", {pc=npc1ID, npc=npc2ID})
		
		saynn("Теперь эти две рабыни будут работать на вас!")
		
		addButton("Продолжить", "Отличные новости", "hire2_do")
		
#		if(GM.main.PS.canHireDude(true)):
#			addButton("Шахтер", "Они будут заниматься добычей", "hire2_pick_miner")
#		else:
#			addDisabledButton("Шахтер", "У вас уже слишком много таких")
#		if(GM.main.PS.canHireDude(false)):
#			addButton("Перевозчик руды", "Они будут перевозить руду", "hire2_pick_carrier")
#		else:
#			addDisabledButton("Перевозчик руды", "У вас уже слишком много таких")
	
	if(state == "hire2_2_after_sex"):
		playAnimation(StageScene.Duo, "stand", {npc=npc2ID})
		
		saynn("Что ты хочешь, чтобы они сделали?")
		
		if(GM.main.PS.canHireDude(true)):
			addButton("Шахтер", "Они будут заниматься добычей", "hire2_2_pick_miner")
		else:
			addDisabledButton("Шахтер", "У вас уже слишком много таких")
		if(GM.main.PS.canHireDude(false)):
			addButton("Перевозчик руды", "Они будут перевозить руду", "hire2_2_pick_carrier")
		else:
			addDisabledButton("Перевозчик руды", "У вас уже слишком много таких")
	
	if(state == "do_win"):
		saynn("ТЫ ПОБЕДИЛ!")
		
		addButton("Уйти", "Пора идти", "stopMinigame")
		
	if(state == "pickup_screen"):
		var amountOfNuggets:int = GM.main.PS.getNuggetsAmmountIn(GM.pc.getLocation())
		saynn("Здесь "+("is" if amountOfNuggets == 1 else "are")+" "+str(amountOfNuggets)+" "+("nugget" if amountOfNuggets == 1 else "nuggets")+" валяется на земле!")
		
		for btnxIndx in nuggetButtons:
			addButtonAt(btnxIndx, "Nugget", "Pick up the nugget!", "doPickUpNugget", [btnxIndx])
		
		addButtonAt(14, "Enough picking up", "Stop picking up the nuggets", "roam")
		
	if(state == "doSleep"):
		saynn("Измотанный, ты забираешься в клетку и среди всей толпы рабов ищешь свободное место, чтобы забиться в угол.")
		
		saynn("По сути, тебе приходится спать прямо на земле. По сравнению с этим даже тюремные койки кажутся мягкими и уютными.")
		
		saynn("В конце концов, тебе удается провалиться в царство снов...")
		
		saynn("С наступлением утра громилы будят всех.")
		
		saynn("Добро пожаловать в новый день. Ты всё еще раб, и это не сон.")
		
		if(GM.main.PS.didReachTarget()):
			saynn("[b]Ты достиг цели, которую поставил Рикки! Иди к нему![/b]")
		
		addButton("Продолжить", "Пора за работу!", "roam")
	
	if(state == "timeToSleep"):
		saynn("Для работы уже слишком поздно.")
		
		saynn("Один из вооруженных головорезов находит тебя и тащит обратно в клетку.")
		
		addButton("Закончить день", "Поспать в клетке", "doSleep")
	
	if(state == "first_offer_slave"):
		playAnimation(StageScene.Duo, "stand", {npc=npc1ID})
		
		saynn("Один из рабов окликает тебя.")
		
		saynn("Говорят, что они готовы помочь с добычей руды.")
		
		saynn("..но только если ты позволишь им трахнуть тебя. Прямо здесь и прямо сейчас.")
		
		addButton("Согласиться", "Позволить им трахнуть тебя!", "first_offer_sex")
		addButton("Неа", "Просто продолжай. Ты со всем справишься сам.", "first_offer_deny")
	
	if(state == "first_offer_aftersex"):
		playAnimation(StageScene.Duo, "stand", {npc=npc1ID})
		
		saynn("Раб будет помогать тебе добывать руду в течение одного дня!")
		
		addButton("Продолжить", "Пора идти", "first_offer_spawn")
	
	if(state == "upgrades_menu"):
		#saynn("Улучшения ("+GM.main.PS.getUpgradesCompletionStr()+"):")
		
		#var upgradesCanSee:Array = GM.main.PS.getUpgradesCanSee()
		
		#for upgradeID in upgradesCanSee:
			
		
		var entries:Dictionary = {}
		
		for upgradeID in GM.main.PS.getUpgradesCanSee():
			var canUnlock:bool = GM.main.PS.canUnlockUpgrade(upgradeID)
			var upgradeInfo:Dictionary = GM.main.PS.UpgradesDB[upgradeID]
			
			entries[upgradeID] = {
				name = upgradeInfo["name"]+" ("+str(upgradeInfo["cost"])+" credits)",
				desc = upgradeInfo["desc"]+"\n\nCost: "+str(upgradeInfo["cost"])+" credits",
				actions = [["unlock", "Buy"]] if canUnlock else [],
			}
		
		if(!GM.main.PS.upgrades.empty()):
			entries["=placeholderbuy="] = {
				name = " === Открытые улучшения ===",
				desc = "A list of what you have upgraded.",
			}
			for upgradeID in GM.main.PS.upgrades:
				var upgradeInfo:Dictionary = GM.main.PS.UpgradesDB[upgradeID]
				entries[upgradeID] = {
					name = upgradeInfo["name"],
					desc = upgradeInfo["desc"]+"\n\nCost: "+str(upgradeInfo["cost"])+" credits",
				}
		
		var inventory = genericInventoryScreenScene.instance()
		GM.ui.addFullScreenCustomControl("inventory", inventory)
		inventory.setRightPanelStretchRation(1.25)
		inventory.setEntries(entries)
		var _ok = inventory.connect("onInteractWith", self, "onMakeInteract")
		
		addButton("Назад", "Хватит глазеть", "roam")
	
	
func onMakeInteract(_upgradeID:String, _id, _args):
	GM.main.pickOption("doBuyUpgrade", [_upgradeID])

func calcNuggetButtons():
	nuggetButtons = []
	
	var amountOfNuggets:int = GM.main.PS.getNuggetsAmmountIn(GM.pc.getLocation())
	
	var maxNuggets:int = Util.mini(10, amountOfNuggets)
	var theButtonIDs:Array = range(14)
	theButtonIDs.shuffle()
	
	while(maxNuggets > 0):
		nuggetButtons.append(theButtonIDs.back())
		theButtonIDs.pop_back()
		
		maxNuggets -= 1

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "doLoadMinecart"):
		GM.main.PS.loadMinecartFromPC()
		doTurn()
		return

	if(_action == "doUnloadMinecart"):
		GM.main.PS.unloadMinecart()
		doTurn()
		return

	if(_action == "dropNuggets"):
		GM.main.PS.dropAllNuggets()
		doTurn()
		return

	if(_action == "doPickUpNugget"):
		var theIndx:int = _args[0]
		nuggetButtons.erase(theIndx)
		GM.main.PS.pickupNugget()
		
		var extraPickUp:int = GM.main.PS.getExtraPickupAmount()
		for _i in range(extraPickUp):
			if(!nuggetButtons.empty()):
				nuggetButtons.erase(RNG.pick(nuggetButtons))
			GM.main.PS.pickupNugget()
		
		var amountOfNuggets:int = GM.main.PS.getNuggetsAmmountIn(GM.pc.getLocation())
		if(amountOfNuggets <= 0):
			setState("roam")
			return
		
		if(nuggetButtons.empty()):
			calcNuggetButtons()
		return

	if(_action == "start_nuggets_picking"):
		calcNuggetButtons()
		
		setState("pickup_screen")
		return

	if(_action == "doBuyUpgrade"):
		GM.main.PS.payUnlockUpgrade(_args[0])
		return

	if(_action == "domine"):
		GM.main.PS.doMine()
		doTurn()
		return
	if(_action == "startpush"):
		GM.main.PS.pushingMinecart = true
		addMessage("You have started pushing the minecart!")
		return
	if(_action == "stoppush"):
		GM.main.PS.pushingMinecart = false
		addMessage("You have stopped pushing the minecart!")
		return

	if(_action == "justIdle"):
		doTurn()
		return

	if(_action == "go"):
		GM.main.PS.prevPCLoc = GM.pc.getLocation()
		playAnimation(StageScene.Solo, "walk")
		GM.pc.setLocation(GM.world.applyDirectionID(GM.pc.location, _args[0]))
		#processTime(600)
		aimCameraAndSetLocName(GM.pc.location)
		#GM.ES.triggerReact(Trigger.EnteringRoom, [GM.pc.location, _args[1]])
		
		doTurn(true)
		GM.main.PS.prevPCLoc = GM.pc.getLocation()
		
		if(!GM.main.checkExtraScenes()):
			GM.main.showLog()
		
		if(GM.main.PS.shouldDoFirstSlaveOfferEvent()):
			npc1ID = genSlaveID()
			addCharacter(npc1ID)
			setState("first_offer_slave")
		
		return
	
	if(_action == "doSleep"):
		GM.main.startNewDay()
		GM.pc.afterSleepingInBed()
		GM.main.PS.sleep()
	
	if(_action == "do_win"):
		endScene()
		runScene("PSShaftMinerEnding1")
		return
	
	if(_action == "do_mine_boss"):
		if(!GM.main.PS.hasUpgrade("pick5")):
			addMessage("You try to hit the reinforced door but your current tool bounces right off.")
		else:
			endScene()
			runScene("PSShaftMinerEnding2")
		return
	
	if(_action == "hire1_pickslave"):
		npc1ID = genSlaveID()
		addCharacter(npc1ID)
		setState("hire1_menu")
		return
	if(_action == "hire2_pickslave"):
		npc1ID = genSlaveID()
		npc2ID = genSlaveID()
		addCharacter(npc1ID)
		addCharacter(npc2ID)
		setState("hire2_menu")
		return
	if(_action == "hire_cancel"):
		if(npc1ID != ""):
			npc1ID = ""
		if(npc2ID != ""):
			npc2ID = ""
		clearCharacter()
		setState("roam")
		return
	if(_action == "first_offer_deny"):
		npc1ID = ""
		npc2ID = ""
		clearCharacter()
		setState("roam")
		return
	if(_action == "first_offer_spawn"):
		npc1ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired a shaft miner slave for one day!")
		GM.main.PS.spawnDude(true)
		return
	if(_action == "first_offer_sex"):
		runScene("GenericSexScene", [npc1ID, "pc", SexType.DefaultSex, {SexMod.BondageDisabled: true}])
		setState("first_offer_aftersex")
		return
	if(_action == "hire1_sex"):
		runScene("GenericSexScene", [npc1ID, "pc", SexType.DefaultSex, {SexMod.BondageDisabled: true}])
		setState("hire1_after_sex")
		return
	if(_action == "hire2_sex"):
		runScene("GenericSexScene", [[npc1ID, npc2ID], "pc", SexType.DefaultSex, {SexMod.BondageDisabled: true}])
		setState("hire2_after_sex")
		return
	if(_action == "hire1_pick_miner"):
		npc1ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired a shaft miner slave for one day!")
		GM.main.PS.spawnDude(true)
		return
	if(_action == "hire1_pick_carrier"):
		npc1ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired an ore carrier slave for one day!")
		GM.main.PS.spawnDude(false)
		return
	if(_action == "hire2_pick_miner"):
		npc1ID = ""
		clearCharacter()
		setState("hire2_2_after_sex")
		addMessage("You have hired a shaft miner slave for one day!")
		GM.main.PS.spawnDude(true)
		return
	if(_action == "hire2_pick_carrier"):
		npc1ID = ""
		clearCharacter()
		setState("hire2_2_after_sex")
		addMessage("You have hired an ore carrier slave for one day!")
		GM.main.PS.spawnDude(false)
		return
	if(_action == "hire2_2_pick_miner"):
		npc2ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired a shaft miner slave for one day!")
		GM.main.PS.spawnDude(true)
		return
	if(_action == "hire2_2_pick_carrier"):
		npc2ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired an ore carrier slave for one day!")
		GM.main.PS.spawnDude(false)
		return
	if(_action == "hire2_do"):
		npc1ID = ""
		npc2ID = ""
		clearCharacter()
		setState("roam")
		addMessage("You have hired a shaft miner and an ore carrier slaves for one day!")
		GM.main.PS.spawnDude(true)
		GM.main.PS.spawnDude(false)
		return
	
	if(_action == "useRefresh"):
		GM.main.PS.doRefresh()
		return
	
	if(_action == "doRest"):
		processTime(60*60*2)
		GM.main.PS.useStamina(-50)
		for _i in range(12):
			doTurn()
		return
	
	setState(_action)

func doTurn(isMove:bool=false):
	processTime(600)
	if(isMove):
		GM.main.PS.afterMove()
	GM.main.PS.processTurn()
	GM.main.PS.updateLoc()
	
	sleepCheck()

func sleepCheck():
	if(GM.main.isVeryLate()):
		GM.pc.setLocation(GM.main.PS.LOC_CAGE)
		aimCameraAndSetLocName(GM.pc.getLocation())
		setState("timeToSleep")

func supportsShowingPawns() -> bool:
	return true

func genSlaveID() -> String:
	var theID:String = NakedSlaveGenerator.new().generate({NpcGen.Temporary: true}).getID()
	return theID

func saveData():
	var data = .saveData()

	data["nuggetButtons"] = nuggetButtons
	data["npc1ID"] = npc1ID

	return data

func loadData(data):
	.loadData(data)

	nuggetButtons = SAVE.loadVar(data, "nuggetButtons", [])
	npc1ID = SAVE.loadVar(data, "npc1ID", "")
