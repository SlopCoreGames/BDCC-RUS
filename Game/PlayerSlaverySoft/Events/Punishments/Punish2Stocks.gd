extends NpcOwnerEventBase

var shouldTakeCredits:bool = false

func _init():
	id = "Punish2Stocks"
	reactsToTags = [E_PUNISH_STRONG]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	sayPretext()
	saynn("{npc.name} толкает тебя, а затем пристегивает поводок к твоему ошейнику!")
	talkModularOwnerToPC("SoftSlaveryPunishStocks")
	saynn("Твой хозяин явно не в духе...")
	
	addContinue("setState", ["inStocks"])
	
func inStocks():
	setLocation(LOC_STOCKS)
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getOwnerID()})
	
	saynn("Тебя притаскивают к плахе для наказаний и зажимают ноги в колодки!")
	talkModularOwnerToPC("SoftSlaveryPunishStocksLock")
	addContinue("findSomeone")

func inStocks_do(_id:String, _args:Array):
	if(_id == "findSomeone"):
		var theFriendID := findOwnerFriend(false)
		if(theFriendID.empty()):
			startTheStocks()
			return
		involveCharID(C_EXTRA1, theFriendID)
		setState("foundSomeone")

func foundSomeone():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getRoleID(C_EXTRA1)})
	saynn("Твой хозяин предлагает окружающим тебя наказать.")
	saynn("И вскоре... к тебе кто-то подходит.")
	
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksAsk")
	var credAm:int = RNG.randi_range(1,4)*5
	talkOwner(getModularDialogue(C_OWNER, C_EXTRA1, "SoftSlaveryPunishStocksAskNope").replace("<CREDITS>", str(credAm)))
	
	var attackInsteadChance:float = 30.0 + personality(C_EXTRA1, PersonalityStat.Mean)*30.0 + personality(C_EXTRA1, PersonalityStat.Impatient)*10.0 - personality(C_EXTRA1, PersonalityStat.Coward)*10.0
	if(RNG.chance(attackInsteadChance)):
		saynn("{npc1.name} обдумывает {npc1.his} варианты.")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksAskNoBuy")
		saynn("Твой хозяин хмурит {npc.his} брови.")
		talkModularOwnerToPC("SoftSlaveryPunishStocksAskNoBuy2")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksAskNoBuy3")
		saynn("О-о, похоже, сейчас что-то будет!")
		addContinue("doNpcFight")
	else:
		saynn("{npc1.name} обдумывает {npc1.his} варианты.")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksAskSure")
		saynn("{npc1.He} протягивает {npc1.verb('hand')} твоему хозяину кредитный чип... и кладет {npc1.his} на тебя...")
		addContinue("startSex", [getRoleID(C_EXTRA1), "pc", SexType.StocksSex, {SexMod.DisableDynamicJoiners:true}])

func foundSomeone_do(_id:String, _args:Array):
	if(_id == "doNpcFight"):
		runNpcFight(getOwnerID(), getRoleID(C_EXTRA1))

func foundSomeone_eventResult(_event, _tag:String, _args:Array):
	if(_event.didWin()):
		setSubResult(SUB_CONTINUE)
		setState("ownerWon")
	else:
		shouldTakeCredits = false
		setState("ownerLost")

func foundSomeone_sexResult(_sex:SexEngineResult):
	if(_sex.didSubsWin() || _sex.getAverageDomSatisfaction() < 0.6):
		setState("thatSucked")
	else:
		setState("afterSex")

func startTheStocks():
	endEvent()
	stopRunner()
	
	GM.main.IS.startInteraction("InStocks", {inmate="pc"})

func afterSex():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getOwnerID()})
	saynn("Секс окончен! {npc1.name} уходит, довольный/ая.")
	saynn("Твой хозяин опирается на колодки.")
	talkModularOwnerToPC("SoftSlaveryPunishStocksAfterSex")
	saynn("{npc.He} {npc.verb('step')} от колодок... но тебя не освобождает.")
	saynn("Похоже, тебе придется выбираться самостоятельно...")
	addContinue("startTheStocks")

func afterSex_do(_id:String, _args:Array):
	if(_id == "startTheStocks"):
		startTheStocks()

func thatSucked():
	playAnimation(StageScene.Duo, "shove", {npc=getOwnerID(), npcAction="hurt", pc=getRoleID(C_EXTRA1)})
	saynn("Секс окончен! Но {npc1.name}, кажется, совсем не удовлетворена.")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksAfterBadSex")
	talkModularOwnerToPC("SoftSlaveryPunishStocksAfterBadSex2")
	saynn("Твоего хозяина толкает разъяренный человек!")
	saynn("Похоже, сейчас что-то будет!")
	addContinue("doNpcFight")
	
func thatSucked_do(_id:String, _args:Array):
	if(_id == "doNpcFight"):
		runNpcFight(getOwnerID(), getRoleID(C_EXTRA1))

func thatSucked_eventResult(_event, _tag:String, _args:Array):
	if(_event.didWin()):
		setSubResult(SUB_CONTINUE)
		setState("ownerWon")
	else:
		shouldTakeCredits = true
		setState("ownerLost")

func ownerLost():
	playAnimation(StageScene.StocksSexOral, "tease", {pc=getOwnerID(), npc=getRoleID(C_EXTRA1)})
	saynn("Твой хозяин проиграл бой против {npc1.name}!")
	if(shouldTakeCredits):
		saynn("{npc1.name} тянется, чтобы забрать {npc1.his} кредитов обратно у {npc.name}.")
	talkOwner(RNG.pick(["Грх..", "Блядь..", "Ух..", "Mghh-.."]))
	addInfluenceResist()
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksOwnerLost")
	saynn("Человек еще не закончил... {npc1.he} {npc1.verb('grab')} {npc.name} и {npc1.verb('lock')} {npc.him} в колодки вместе с тобой!")
	
	var willAlsoFuckChance:float = 50.0 + personality(C_EXTRA1, PersonalityStat.Mean)*20.0 - personality(C_EXTRA1, PersonalityStat.Subby)*20.0
	if(!smartChance(willAlsoFuckChance)):
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksOwnerLost2")
		saynn("И вот так просто, {npc1.he} {npc1.verb('leave')} вас двоих запертыми в колодках...")
		addContinue("endMakeOwnerStocked")
	else:
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryPunishStocksOwnerLost3")
		saynn("Какой ироничный поворот событий. И у тебя есть место в первом ряду.")
		addContinue("startSex", [getRoleID(C_EXTRA1), getOwnerID(), SexType.StocksSex, {}])

func ownerLost_do(_id:String, _args:Array):
	if(_id == "endMakeOwnerStocked"):
		var theOwnerID:String = getOwnerID()
		startTheStocks()
		GM.main.IS.startInteraction("InStocks", {inmate=theOwnerID})

func ownerLost_sexResult(_sex:SexEngineResult):
	setState("afterSexDomLost")

func ownerWon():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getOwnerID(), pc=getRoleID(C_EXTRA1)})
	saynn("Твой хозяин победил в схватке против {npc1.name}! И теперь {npc.he} {npc.verb('locks')} проигравшего в колодки, прямо к тебе!")
	var willAlsoFuckChance:float = 50.0 + personality(C_OWNER, PersonalityStat.Mean)*20.0 - personality(C_OWNER, PersonalityStat.Subby)*20.0
	if(!smartChance(willAlsoFuckChance)):
		talkModularOwnerToPC("SoftSlaveryPunishStocksOwnerWon")
		saynn("{npc.He} {npc.verb('point')} на тебя.")
		talkModularOwnerToPC("SoftSlaveryPunishStocksOwnerWon2")
		saynn("{npc.He} {npc.verb('step')} от колодок... но тебя не освобождает.")
		saynn("Похоже, тебе придется выбираться самостоятельно...")
		addContinue("startTheStocks")
	else:
		talkModularOwnerToPC("SoftSlaveryPunishStocksOwnerWon3")
		saynn("{npc.He} тоже {npc.verb('point')} на тебя.")
		talkModularOwnerToPC("SoftSlaveryPunishStocksOwnerWon4")
		saynn("Бесплатное шоу специально для тебя.")
		addContinue("startSex", [getOwnerID(), getRoleID(C_EXTRA1), SexType.StocksSex, {}])
	

func ownerWon_do(_id:String, _args:Array):
	if(_id == "startTheStocks"):
		var theCharID:String = getRoleID(C_EXTRA1)
		startTheStocks()
		GM.main.IS.startInteraction("InStocks", {inmate=theCharID})

func ownerWon_sexResult(_sex:SexEngineResult):
	setState("afterSexDomWon")

func afterSexDomLost():
	playAnimation(StageScene.StocksSexOral, "tease", {pc=getOwnerID(), npc=getRoleID(C_EXTRA1)})
	saynn("Секс закончился... и, похоже, {npc1.name} не собирается освобождать ни вас, ни его.")
	saynn("Ну, что ж.")
	addContinue("endMakeOwnerStocked")

func afterSexDomLost_do(_id:String, _args:Array):
	if(_id == "endMakeOwnerStocked"):
		var theOwnerID:String = getOwnerID()
		startTheStocks()
		GM.main.IS.startInteraction("InStocks", {inmate=theOwnerID})

func afterSexDomWon():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getOwnerID(), pc=getRoleID(C_EXTRA1)})
	saynn("Секс закончился... и, похоже, {npc.name} не собирается освобождать ни вас, ни его.")
	saynn("Ну, что ж.")
	addContinue("endMakeOwnerStocked")

func afterSexDomWon_do(_id:String, _args:Array):
	if(_id == "endMakeOwnerStocked"):
		var theCharID:String = getRoleID(C_EXTRA1)
		startTheStocks()
		GM.main.IS.startInteraction("InStocks", {inmate=theCharID})
