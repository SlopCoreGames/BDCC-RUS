extends NpcOwnerEventBase

func _init():
	id = "FuckInStocksExtra"
	reactsToTags = ["FuckInStocks"]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 0.2

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNearPawns := getFreePawnsNear(3)
	if(theNearPawns.empty()):
		return false
	var thePickedPawn:CharacterPawn = RNG.pick(theNearPawns)
	involveCharID(C_EXTRA1, thePickedPawn.charID)
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {pc=getRoleID(C_EXTRA1), npc=getRoleID(C_OWNER)})
	sayPretext()
	saynn("{npc1.name} подходит к тебе и твоему хозяину!")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckInStocksExtra")
	
	var ownerRejectChance:float = 50.0 + ownerPersonality(PersonalityStat.Mean)*50.0 + 100.0*getOwnerNOM(NOM.NoSharing) - 100.0*getOwnerNOM(NOM.Sharing)
	if(!smartChance(ownerRejectChance)):
		talkModularOwnerToPC("SoftSlaveryFuckInStocksExtraYes")
		saynn("Двойная порция проблем...")
		addContinue("setState", ["inStocks"])
	else:
		talkModularOwnerToPC("SoftSlaveryFuckInStocksExtraNo")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckInStocksExtraNo2")
		saynn("Оба не собираются отступать...")
		addContinue("doNpcFight")

func start_do(_id:String, _args:Array):
	if(_id == "doNpcFight"):
		runEvent("npcFight", "NpcFight", [getRoleID(C_EXTRA1), getOwnerID()])

func start_eventResult(_event, _tag:String, _args:Array):
	if(_event.didNpc1Win()):
		setState("extraWon")
	else:
		setSubResult(SUB_CONTINUE)
		setState("extraLost")

func inStocks():
	setLocation(LOC_STOCKS)
	playAnimation(StageScene.StocksSpitroast, "tease", {npc=getRoleID(C_OWNER), npc2=getRoleID(C_EXTRA1)})
	
	saynn("Ты послушно подставляешься под их руки, наклоняясь вперед и опуская голову в нижнюю часть колодок, прежде чем они защелкнут замок.")
	addInfluenceObey()
	saynn("Похоже, тебя сейчас будут поиметь оба...")
	addContinue("startSex", [[getRoleID(C_OWNER), getRoleID(C_EXTRA1)], "pc", SexType.StocksSex])
	
func inStocks_sexResult(_sexResult:SexEngineResult):
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID()})
	saynn("После секса твой хозяин освобождает тебя из колодок.")
	talkModularOwnerToPC("SoftSlaveryFuckInStocksExtraFree")
	addContinue("endEvent")


func extraLost():
	playAnimation(StageScene.Solo, "stand", {pc=getRoleID(C_OWNER)})
	saynn("Проиграв бой, {npc1.name} просто съебывает!")
	addInfluenceObey(0.2)
	saynn("Пора продолжить с того места, где вы остановились...")
	addButton("Подчиниться", "Подчиниться хозяину", "endEvent")

func extraWon():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getRoleID(C_EXTRA1)})
	saynn("{npc1.name} победил(а)! Похоже, тебя собираются оттрахать в одиночку прямо на глазах у твоего хозяина!")
	addInfluenceResist()
	addContinue("startSex", [getRoleID(C_EXTRA1), "pc", SexType.StocksSex])

func extraWon_sexResult(_sex:SexEngineResult):
	setState("afterSexExtra")

func afterSexExtra():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID()})
	saynn("После секса {npc1.name} уходит, позволяя твоему поверженному хозяину освободить тебя из колодок.")
	talkModularOwnerToPC("SoftSlaveryFuckInStocksExtraFreeLost")
	addContinue("endEvent")
