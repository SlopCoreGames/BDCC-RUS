extends NpcOwnerEventBase

var timesLeft:int = 4
var isFirst:bool = true

#possible unique interactions:
#vendomat - buy an energy drink
#shower - shower together?
#medical - shows you to eliza?
#stocks - teases about stocks?

func _init():
	id = "ParadedAround"
	reactsToTags = [E_APPROACH]
	eventWeight = 1.0
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.BDSM: 1.5, NOET.ShowingOff:2.0}

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Твой хозяин подходит к тебе, держа в руке поводок.")
	talkModularOwnerToPC("SoftSlaveryParadeAroundStart") #"I wanna parade you around the prison. And show off my {npc.npcSlave}."
	
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
		setState("paraded")
		timesLeft -= 1
		var theTarget := getParadeTarget()
		runParadeTo(theTarget)
		checkUniqueTarget(theTarget)
	if(_id == "resist"):
		runResist()

func paraded():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID()})
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
		addButton("Повиноваться", "Позволить им снова надеть на тебя поводок", "obey")
		addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	else:
		talkModularOwnerToPC("SoftSlaveryParadeAroundFree")
		addContinue("endEvent")
	addInfluenceObey(0.25)

func paraded_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("paraded")
		timesLeft -= 1
		var theTarget := getParadeTarget()
		runParadeTo(theTarget)
		checkUniqueTarget(theTarget)
	if(_id == "resist"):
		runResist()


#Unique stuff
func checkUniqueTarget(_target:String):
	if(RNG.chance(0)):
		return
	if(_target in ["main_shower1", "main_shower2"]):
		setState("pShower")
	if(_target in ["main_punishment_spot"]):
		setState("pStocksTease")
	if(_target in ["hall_canteen"]):
		setState("pCanteen")
	if(_target in ["main_hallroom1"]):
		setState("pVendomat")
	if(_target in ["med_lobbymain"]):
		if(GM.pc.getPainLevel() > 0.4):
			setState("pMedical")

func getDoState() -> String:
	if(state in ["pShower", "pStocksTease", "pCanteen", "pVendomat", "pMedical"]):
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

func saveData() -> Dictionary:
	var data := .saveData()
	data["timesLeft"] = timesLeft
	data["isFirst"] = isFirst
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	timesLeft = SAVE.loadVar(_data, "timesLeft", 3)
	isFirst = SAVE.loadVar(_data, "isFirst", true)
