extends NpcOwnerEventBase

func _init():
	id = "ParadeGuard"
	reactsToTags = [E_PARADE_TO]
	eventWeight = 0.1

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	if(_args.empty()):
		return false
	var thePawns:Array = _args[0]
	for thePawn in thePawns:
		if(thePawn.isGuard()):
			involveCharID(C_EXTRA1, thePawn.getCharID())
			return true
	return false
	
func start():
	playAnimation(StageScene.Duo, "stand", {pc=getOwnerID(), npc=getRoleID(C_EXTRA1)})
	sayPretext()
	saynn("Охранник останавливает тебя и твоего хозяина.")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryParadeGuard")
	
	if(getRolePawn(C_OWNER).isStaff() && RNG.chance(50)):
		setSubResult(SUB_CONTINUE)
		talkModularOwnerToPC("SoftSlaveryParadeGuardPunish")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryParadeGuardPunish2")
		addContinue("endEvent")
		return
	
	talkModularOwnerToPC("SoftSlaveryParadeGuardProblem")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryParadeGuardProblem2")
	saynn("Похоже, они сейчас вцепятся друг другу в глотки...")
	
	addContinue("fight")

func start_do(_id:String, _args:Array):
	if(_id == "fight"):
		runNpcFight(getRoleID(C_OWNER), getRoleID(C_EXTRA1))

func start_eventResult(_event, _tag:String, _args:Array):
	if(_event.didWin()):
		setSubResult(SUB_CONTINUE)
		setState("ownerWon")
	else:
		setState("ownerLost")

func ownerWon():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	
	saynn("Ваш хозяин снова пристегивает поводок к вашему ошейнику.")
	talkModularOwnerToPC("SoftSlaveryParadeGuardWon")
	addInfluenceObey(0.2)
	addContinue("endEvent")

func ownerLost():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_EXTRA1)})
	
	saynn("Охранник освобождает тебя.")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryParadeGuardLost")
	addInfluenceResist(0.4)
	addContinue("endEvent")
