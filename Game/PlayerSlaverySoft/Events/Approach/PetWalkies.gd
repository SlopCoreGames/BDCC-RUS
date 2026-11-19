extends NpcOwnerEventBase

var timesLeft:int = 3
var isFirst:bool = true

var wantsTrick:String = "" #bark down sit paw roll
var pcPickedTrick:String = ""

var trickQueue:Array = []

var didComplicatedEvent:bool = false

var stickLoc:String = ""
var ownerLoc:String = ""
var foundStick:bool = false
var isStickFake:bool = false # Very cruel
var moveAmount:int = 0

#possible unique interactions:
# simons says but with puppy tricks (sit, lay down, give paw, etc)
# Eliza checking the puppy
# Find-bring ball?
# Just belly rubs?
# Do X (but you are presented with all of the options)

func _init():
	id = "PetWalkies"
	reactsToTags = [E_APPROACH]
	eventWeight = 0.2
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.Petplay: 2.0}

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Твой хозяин подходит к тебе, держа в руках собачий инвентарь и поводок.")
	talkModularOwnerToPC("SoftSlaveryPetWalkies") # It's walkies time. Let's get you prepared, {npc.npcSlave}.
	saynn("Похоже, он хочет раздеть тебя и нацепить на тебя всё это снаряжение...")
	
	addButton("Повиноваться", "Позволить им это", "obey")
	addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")

#func shouldEndAfterSubEvent(_args:Array) -> bool:
#	return true

func getParadeTarget() -> String:
	var theResult:String= RNG.pick(LOCS_PARADE)
	while(theResult == getLocation()):
		theResult = RNG.pick(LOCS_PARADE)
	return theResult

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("preparedPuppy")
		#setState("paraded")
		#timesLeft -= 1
		#var theTarget := getParadeTarget()
		#runParadeTo(theTarget)
		#checkUniqueTarget(theTarget)
	if(_id == "resist"):
		runResist()

func preparedPuppy():
	playAnimation(StageScene.PuppySexOral, "tease", {pc=getOwnerID(), npcBodyState={naked=true, leashedBy=getOwnerID()}})
	saynn("Твой хозяин готовит тебя к прогулке: сначала он надевает на тебя собачьи фиксаторы, а затем пристегивает поводок к твоему ошейнику.")
	talkModularOwnerToPC("SoftSlaveryPetWalkiesReady") # Ready? Try to keep up, puppy.
	addContinue("start")

func preparedPuppy_do(_id:String, _args:Array):
	if(_id == "start"):
		setState("paraded")
		var theTarget := getParadeTarget()
		runWalkiesTo(theTarget)
		checkUniqueTarget(theTarget)

func paraded():
	#playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcBodyState={naked=true, leashedBy=getOwnerID()}})
	playAnimation(StageScene.PuppySexOral, "tease", {pc=getOwnerID(), npcBodyState={naked=true, leashedBy=getOwnerID()}})
	saynn("Дойдя до места назначения, {npc.name} останавливается и поворачивается к тебе.")
	paradedOutcome()

func paradedOutcome():
	if(timesLeft > 0):
		if(timesLeft == 1):
			talkModularOwnerToPC("SoftSlaveryParadeAroundLast") #"One more time. I want everyone to see you."
		else:
			if(isFirst):
				isFirst = false
				talkModularOwnerToPC("SoftSlaveryParadeAroundFirst") #"Like it so far? We're just getting started."
			else:
				talkModularOwnerToPC("SoftSlaveryParadeAroundMore") #"Good. Let's walk more."
		addContinue("obey")
		#addButton("Повиноваться", "Позволить им снова надеть на тебя поводок", "obey")
		#addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	else:
		talkModularOwnerToPC("SoftSlaveryParadeAroundFree")
		saynn("{npc.name} начинает снимать с тебя собачьи фиксаторы.")
		addContinue("endEvent")
	addInfluenceObey(0.25)

func paraded_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("paraded")
		timesLeft -= 1
		var theTarget := getParadeTarget()
		runWalkiesTo(theTarget)
		checkUniqueTarget(theTarget)
	if(_id == "resist"):
		runResist()


#Unique stuff
func checkUniqueTarget(_target:String):
	if(RNG.chance(0)):
		setState("paraded")
		return
	#if(true):
	#	setState("findStick")
	#	return
#	if(_target in ["main_shower1", "main_shower2"]):
#		setState("pShower")
#	if(_target in ["main_punishment_spot"]):
#		setState("pStocksTease")
#	if(_target in ["hall_canteen"]):
#		setState("pCanteen")
#	if(_target in ["main_hallroom1"]):
#		setState("pVendomat")
#	if(_target in ["med_lobbymain"]):
#		if(GM.pc.getPainLevel() > 0.4):
#			setState("pMedical")
	if(!didComplicatedEvent):
		if(timesLeft != 2 && (RNG.chance(30.0) || timesLeft==0 )):
			didComplicatedEvent = true
			setState(RNG.pick([
				"simonsSaysTricks",
				"findStick",
			]))
			return
		
	
	setState("simpleTrick")
	
func getDoState() -> String:
	if(state in ["pShower", "pStocksTease", "pCanteen", "pVendomat", "pMedical",
		"simpleTrickCorrect", "simpleTrickWrong", "gaveStick", "simonsSaysTricksDoFailed", "simonsSaysTricksDoGood", "stickTooFar", "fakeStickFound"]):
		return "paraded"
	return .getDoState()

func pMedical():
	playAnimation(StageScene.Duo, "stand", {npc="eliza"})
	saynn("{npc.name} ведет тебя в медицинское крыло.")
	talkOwner("Мой {npc.npcSlave} не в лучшей форме.")
	talkCharID("eliza", "О, у меня есть кое-что, что может помочь.")
	saynn("Кошка-врач подходит к тебе и дает тебе маленькую таблетку!")
	talkCharID("eliza", "Это должно помочь~.")
	saynn("Твой хозяин кивает и уводит тебя от прилавка.")
	
	if(onlyOnce()):
		GM.pc.addPain(-100)
		GM.pc.addStamina(150)
		GM.main.addMessage("Тебе стало лучше!")
	
	paradedOutcome()
	

func pVendomat():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("{npc.name} решает остановиться возле вендомата.")
	
	if(onlyOnce()):
		var theItemToGive:String = RNG.pick(["EnergyDrink"])
		if(theItemToGive):
			talkOwner("Хочешь пить?")
			saynn("{npc.He} {npc.verb('buy')} энергетический напиток и протягивает его тебе.")
			talkOwner("Наслаждайся.")
			GM.pc.getInventory().addItem(GlobalRegistry.createItem(theItemToGive))
			GM.main.addMessage("Ты получил(а) энергетический напиток!")
	saynn("После этого тебя уводят от вендомата.")
	paradedOutcome()

func pCanteen():
	playAnimation(StageScene.PawJobUnderTable, "start", {pc="pc", npc=getOwnerID()})
	saynn("{npc.name} заводит тебя в столовую.")
	if(GM.pc.isOralBlocked()):
		talkModularOwnerToPC("SoftSlaveryParadeAroundEatGagged") #"Too bad you can't eat, {npc.npcSlave}. I will though."
		if(!GM.pc.isBlindfolded()):
			saynn("Всё, что тебе остаётся — это смотреть, как ест твой хозяин...")
		else:
			saynn("Всё, что тебе остаётся — это... воображать... как ест твой хозяин...")
	else:
		talkModularOwnerToPC("SoftSlaveryParadeAroundEat") #"Lets take a break. Enjoy your meal, {npc.npcSlave}."
		if(onlyOnce()):
			GM.pc.afterEatingAtCanteen()
		saynn("Вы с хозяином проводите время за едой за одним из столов в столовой.")
	paradedOutcome()
	
func pStocksTease():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID()})
	saynn("Вы останавливаетесь возле помоста для наказаний, где стоит ряд колодок.")
	talkModularOwnerToPC("SoftSlaveryParadeAroundPlatform")
	paradedOutcome()

func pShower():
	playAnimation(StageScene.ShoweringDuo, "shower", {npc=getOwnerID(), bodyState={naked=true}, npcBodyState={naked=true}})
	saynn("Вас приводят в душевую, где {npc.name} помогает вам отмыться!")
	talkModularOwnerToPC("SoftSlaveryParadeAroundShower")
	if(onlyOnce()):
		getOwner().afterTakingAShower()
		GM.pc.afterTakingAShower()
	saynn("Когда всё закончено, хозяин выводит вас наружу.")
	
	paradedOutcome()

func simpleTrick():
	playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcBodyState={naked=true}})
	if(onlyOnce()):
		wantsTrick = RNG.pick([
			"bark", "down", "sit", "paw", "roll",
		])
	saynn("Твой хозяин замирает и поворачивается к тебе.")
	
	if(wantsTrick == "bark"):
		talkOwner("Гавкни для меня.")
	elif(wantsTrick == "down"):
		talkOwner("Лежать.")
	elif(wantsTrick == "sit"):
		talkOwner("Сидеть.")
	elif(wantsTrick == "paw"):
		talkOwner("Дай лапу.")
	elif(wantsTrick == "roll"):
		talkOwner("Перевернись.")
	saynn("Похоже, {npc.name} хочет, чтобы ты что-то сделал(а)...")
	
	var possible:Array = [
		["Bark", "bark"], ["Лежать", "down"], ["Sit", "sit"], ["Поднять лапу", "paw"], ["Roll", "roll"],
	]
	possible.shuffle()
	for buttonEntry in possible:
		addButton(buttonEntry[0], "Сделай это!", "doTrick", [buttonEntry[1]])

func simpleTrick_do(_id:String, _args:Array):
	if(_id == "doTrick"):
		pcPickedTrick = _args[0]
		if(pcPickedTrick == wantsTrick):
			setState("simpleTrickCorrect")
		else:
			setState("simpleTrickWrong")

func playTrickAnim(theTrick:String):
	if(theTrick == "bark"):
		playAnimation(StageScene.PuppySexStart, "start", {pc=getOwnerID(), npcBodyState={naked=true}})
	elif(theTrick == "down"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcAction="sad", npcBodyState={naked=true}})
	elif(theTrick == "sit"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcAction="sit", npcBodyState={naked=true}})
	elif(theTrick == "paw"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcAction="paw", npcBodyState={naked=true}})
	elif(theTrick == "roll"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcAction="sad", npcBodyState={naked=true}})

func generateTrickQueue(_size:int) -> Array:
	var result:Array = []
	var possible:Array = ["bark", "down", "sit", "paw", "roll"]
	var lastTrick:String = ""
	
	while(_size > 0):
		var nextTrick:String = RNG.pick(possible)
		if(nextTrick == lastTrick):
			nextTrick = RNG.pick(possible)
		result.append(nextTrick)
		lastTrick = nextTrick
		_size -= 1
	
	return result

func trickToTrickName(_trick:String) -> String:
	if(_trick == "bark"):
		return "bark"
	if(_trick == "down"):
		return "лечь"
	if(_trick == "sit"):
		return "sit"
	if(_trick == "paw"):
		return "дать лапу"
	if(_trick == "roll"):
		return "перевернуться"
	return "ОШИБКА?"

func trickToText(theTrick:String) -> String:
	if(theTrick == "bark"):
		return "Ты громко гавкаешь несколько раз!"
	elif(theTrick == "down"):
		return "Ты ложишься на холодную землю и ждешь внимания."
	elif(theTrick == "sit"):
		return "Ты отталкиваешься передними лапами от земли и садишься на зад."
	elif(theTrick == "paw"):
		return "Ты поднимаешь лапу и ждешь, когда хозяин ее пожмет."
	elif(theTrick == "roll"):
		return "Ты плюхаешься на бок, а затем изо всех сил стараешься перевернуться на другой бок."
	return "ОШИБКА?"
	
func trickResultToText(theTrick:String, _isCorrect:bool) -> String:
	if(theTrick == "bark"):
		if(_isCorrect):
			return "Твой хозяин улыбается и гладит тебя."
		else:
			return "Твой хозяин скрещивает {npc.his} руки на груди и хмурит {npc.his} брови."
	elif(theTrick == "down"):
		if(_isCorrect):
			return "Твой хозяин кивает и жестом велит тебе подняться."
		else:
			return "Твой хозяин качает {npc.his} головой."
	elif(theTrick == "sit"):
		if(_isCorrect):
			return "Твой хозяин восхищается твоей ловкостью."
		else:
			return "Твой хозяин качает {npc.his} головой."
	elif(theTrick == "paw"):
		if(_isCorrect):
			return "Твой хозяин улыбается и жмет тебе лапу!"
		else:
			return "Твой хозяин отказывается жать тебе лапу."
	elif(theTrick == "roll"):
		if(_isCorrect):
			return "Твой хозяин кивает и гладит тебя по спине."
		else:
			return "Твой хозяин вздыхает и щелкает тебя по носу."
	if(_isCorrect):
		return "Твой хозяин кивает."
	else:
		return "Твой хозяин качает {npc.his} головой."
	
func simpleTrickCorrect():
	playTrickAnim(pcPickedTrick)
	saynn(trickToText(pcPickedTrick))
	saynn(trickResultToText(pcPickedTrick, true))
	talkModularOwnerToPC("SoftSlaveryWalkiesCorrect") # Correct. Good puppy.
	addInfluenceObey(0.2)
	saynn("Ты замер(ла) в ожидании того, что будет дальше.")
	paradedOutcome()

func simpleTrickWrong():
	playTrickAnim(pcPickedTrick)
	saynn(trickToText(pcPickedTrick))
	saynn(trickResultToText(pcPickedTrick, false))
	talkModularOwnerToPC("SoftSlaveryWalkiesWrong") # Nope. Wrong.
	saynn("Ну что ж. Ты ждешь, что будет дальше.")
	#addInfluenceObey(0.2)
	paradedOutcome()

func simonsSaysTricks():
	playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcBodyState={naked=true}})
	if(onlyOnce()):
		trickQueue = generateTrickQueue(RNG.randi_range(3, 5))
		pcPickedTrick = ""
	
	saynn("Твой хозяин поворачивается к тебе.")
	talkOwner("Давай что-нибудь посложнее, хочу проверить своего щеночка.")
	saynn("Ты наклоняешь голову набок.")
	talkOwner("Я назову список команд, а ты будешь выполнять их строго по порядку.")
	saynn("Твои ушки на макушке, ты внимательно прислушиваешься...")
	
	var theTricks:Array = []
	for theTrick in trickQueue:
		theTricks.append(trickToTrickName(theTrick))
	talkOwner("Я хочу, чтобы ты сделал вот это: "+Util.humanReadableList(theTricks, "а затем")+".")
	addContinue("setState", ["simonsSaysTricksDo"])
	
func simonsSaysTricksDo():
	if(pcPickedTrick == ""):
		saynn("Твой хозяин закончил перечислять трюки, которые {npc.he} {npc.verb('want')} заставляет тебя выполнять, и теперь просто наблюдает.")
	else:
		playTrickAnim(pcPickedTrick)
		saynn(trickToText(pcPickedTrick))
		saynn(trickResultToText(pcPickedTrick, true))
	
	var possible:Array = [
		["Bark", "bark"], ["Лежать", "down"], ["Sit", "sit"], ["Поднять лапу", "paw"], ["Roll", "roll"],
	]
	for buttonEntry in possible:
		addButton(buttonEntry[0], "Сделай это!", "doTrick", [buttonEntry[1]])

func simonsSaysTricksDo_do(_id:String, _args:Array):
	var theTrick:String = _args[0]
	pcPickedTrick = theTrick
	
	if(pcPickedTrick == trickQueue.front()):
		trickQueue.pop_front()
		if(trickQueue.empty()):
			setState("simonsSaysTricksDoGood")
		else:
			setState("simonsSaysTricksDo")
	else:
		setState("simonsSaysTricksDoFailed")

func simonsSaysTricksDoFailed():
	playTrickAnim(pcPickedTrick)
	saynn(trickToText(pcPickedTrick))
	saynn(trickResultToText(pcPickedTrick, false))
	talkModularOwnerToPC("SoftSlaveryWalkiesWrong") # Nope. Wrong.
	saynn("Ну что ж. Ты ждешь, что будет дальше.")
	#addInfluenceObey(0.2)
	paradedOutcome()

func simonsSaysTricksDoGood():
	playTrickAnim(pcPickedTrick)
	saynn(trickToText(pcPickedTrick))
	saynn(trickResultToText(pcPickedTrick, true))
	talkModularOwnerToPC("SoftSlaveryWalkiesCorrect") # Correct. Good puppy.
	addInfluenceObey(0.4)
	saynn("За то, что всё сделала правильно, тебя щедро гладят по голове!")
	paradedOutcome()

func applyRandomDir(_loc:String, _amount:int) -> String:
	var _lastDir:int = -1
	while(_amount > 0):
		var canGoDirs:Array = []
		for theDir in GameWorld.getAllDirections():
			if(GM.world.canGoID(_loc, theDir)):
				canGoDirs.append(theDir)

		if(canGoDirs.size() <= 0):
			return _loc
		if(_lastDir >= 0):
			canGoDirs.erase(GameWorld.getOppositeDir(_lastDir))
		if(canGoDirs.size() <= 0):
			return _loc
		var randomDir = RNG.pick(canGoDirs)
		_lastDir = randomDir
		_loc = GM.world.applyDirectionID(_loc, randomDir)
		_amount -= 1
	
	return _loc

func findStick():
	if(onlyOnce()):
		stickLoc = applyRandomDir(GM.pc.getLocation(), 2)
		ownerLoc = GM.pc.getLocation()
		foundStick = false
		moveAmount = 0
		isStickFake = RNG.chance(20.0 + ownerPersonality(PersonalityStat.Mean)*10.0)
	playAnimation(StageScene.PuppyDuo, "throw", {pc=getOwnerID(), npcBodyState={naked=true}})
	saynn("{npc.name} останавливается и поворачивается к тебе, {npc.his} рука достает мячик!")
	talkModularOwnerToPC("SoftSlaveryWalkiesBall") # I wanna play fetch with you, {npc.npcSlave}.
	saynn("{npc.He} {npc.verb('pull')} {npc.his} заносит руку далеко назад... а затем швыряет мяч куда-то за спину!")
	talkModularOwnerToPC("SoftSlaveryWalkiesBall2") # Go get the ball!
	
	addContinue("setState", ["findStickFinding"])

func findStickFinding():
	if(!foundStick):
		saynn("Найди мяч! Найди мяч! Найди мяч!")
	else:
		saynn("Принеси мяч! Принеси мяч! Принеси мяч!")
	var roomID:String = GM.pc.location
	aimCamera(roomID)
	
	if(!isStickFake):
		if(roomID == stickLoc && !foundStick):
			addButton("МЯЧ!", "Хватай мяч!", "grabStick")
		
		if(foundStick && roomID == ownerLoc):
			addButton("Дай мяч!", "Подать мячик хозяину", "setState", ["gaveStick"])
	else:
		if(moveAmount >= 3 && roomID == ownerLoc):
			addButton("Мячика нет...", "Тебе не удалось найти мячик хозяина...", "setState", ["fakeStickFound"])
	
	if(GM.world.canGoID(roomID, GameWorld.Direction.NORTH)):
		addButtonAt(6, "Север", "Идти на север", "go", [GameWorld.Direction.NORTH, Direction.North])
	else:
		addDisabledButtonAt(6, "Север", "Нельзя пройти на север")
	if(GM.world.canGoID(roomID, GameWorld.Direction.WEST)):
		addButtonAt(10, "Запад", "Идти на запад", "go", [GameWorld.Direction.WEST, Direction.West])
	else:
		addDisabledButtonAt(10, "Запад", "Нельзя пройти на запад")
	if(GM.world.canGoID(roomID, GameWorld.Direction.SOUTH)):
		addButtonAt(11, "Юг", "Идти на юг", "go", [GameWorld.Direction.SOUTH, Direction.South])
	else:
		addDisabledButtonAt(11, "Юг", "Нельзя пройти на юг")
	if(GM.world.canGoID(roomID, GameWorld.Direction.EAST)):
		addButtonAt(12, "Восток", "Идти на восток",  "go", [GameWorld.Direction.EAST, Direction.East])
	else:
		addDisabledButtonAt(12, "Восток", "Нельзя пройти на восток")

func findStickFinding_do(_id:String, _args:Array):
	if(_id == "go"):
		playAnimation(StageScene.PuppySolo, "walk", {bodyState={naked=true}})
		moveAmount += 1
		var theGoDir:int = _args[0]
		var newPCLoc:String = GM.world.applyDirectionID(GM.pc.getLocation(), theGoDir)
		GM.pc.setLocation(newPCLoc)
		#play walk anim
		
		if(GM.world.simpleDistance(newPCLoc, ownerLoc) >= 2.8):
			setLocation(newPCLoc)
			setState("stickTooFar")
		
	if(_id == "grabStick"):
		foundStick = true
		GM.main.addMessage("Найди мячик и схвати его зубами!")
		playAnimation(StageScene.PuppySolo, "sad", {bodyState={naked=true}})

func gaveStick():
	playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcAction="back", npcBodyState={naked=true}})
	saynn("Ты садишься и роняешь мячик прямо в руку хозяину!")
	saynn("В награду {npc.name} валит тебя на спину и начинает вовсю чесать тебе пузико!")
	talkModularOwnerToPC("SoftSlaveryWalkiesPraise") # Good puppy. What a good puppy.
	addInfluenceObey(0.4)
	saynn("Ты не можешь удержаться и начинаешь вилять всем телом от этих ласк.")
	saynn("Когда всё заканчивается, хозяин помогает тебе подняться.")
	paradedOutcome()

func stickTooFar():
	playAnimation(StageScene.PuppySexStart, "start", {pc=getOwnerID(), npcBodyState={naked=true}})
	if(isStickFake):
		saynn("Ты уходишь довольно далеко от хозяина... пытаясь найти мячик... но тщетно... куда же он делся?")
		saynn("В конце концов, хозяин тебя догоняет.")
		talkModularOwnerToPC("SoftSlaveryWalkiesBallTooFarFake") #Couldn't find the ball? It's because it's in my hand, you silly pup.
		saynn("Похоже, тебя разыграли... никакого мячика и не было.")
		addInfluenceObey(0.2)
	else:
		saynn("Ты уходишь довольно далеко от своего хозяина... но {npc.he} легко {npc.verb('catch', 'catches')} за тобой.")
		talkModularOwnerToPC("SoftSlaveryWalkiesBallTooFar") #Where do you think you're going? What a silly pup, did you get lost trying to find the ball?
		addInfluenceObey(0.2)
		saynn("Ты издаешь тихий скулящий звук.")
	paradedOutcome()

func fakeStickFound():
	playAnimation(StageScene.PuppySexStart, "pat", {pc=getOwnerID(), npcBodyState={naked=true}})
	saynn("Ты возвращаешься к хозяину и опускаешь голову, издавая печальный, тихий скулёж.")
	saynn("{npc.name} улыбается и начинает гладить тебя по голове!")
	talkModularOwnerToPC("SoftSlaveryWalkiesNoBallFound") # You're sad because you couldn't find my ball? That's because I did a fake throw. Such a silly puppy.
	addInfluenceObey(0.4)
	saynn("Тебя обхитрили! Но за это тебя щедро погладили.")
	paradedOutcome()

func saveData() -> Dictionary:
	var data := .saveData()
	data["timesLeft"] = timesLeft
	data["isFirst"] = isFirst
	data["wantsTrick"] = wantsTrick
	data["pcPickedTrick"] = pcPickedTrick
	data["trickQueue"] = trickQueue
	data["didComplicatedEvent"] = didComplicatedEvent
	data["stickLoc"] = stickLoc
	data["ownerLoc"] = ownerLoc
	data["foundStick"] = foundStick
	data["isStickFake"] = isStickFake
	data["moveAmount"] = moveAmount
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	timesLeft = SAVE.loadVar(_data, "timesLeft", 3)
	isFirst = SAVE.loadVar(_data, "isFirst", true)
	wantsTrick = SAVE.loadVar(_data, "wantsTrick", "")
	pcPickedTrick = SAVE.loadVar(_data, "pcPickedTrick", "")
	trickQueue = SAVE.loadVar(_data, "trickQueue", [])
	didComplicatedEvent = SAVE.loadVar(_data, "didComplicatedEvent", false)
	stickLoc = SAVE.loadVar(_data, "stickLoc", "")
	ownerLoc = SAVE.loadVar(_data, "ownerLoc", "")
	foundStick = SAVE.loadVar(_data, "foundStick", false)
	isStickFake = SAVE.loadVar(_data, "isStickFake", false)
	moveAmount = SAVE.loadVar(_data, "moveAmount", 0)
