extends NpcOwnerEventBase

var curTarget:String = ""
var triedCharIDs:Dictionary = {}
var giveupTimer:int = 0
var gaveupSearching:bool = false
var sexSatisfaction:float = 1.0
var earnedCredits:int = 0

func _init():
	id = "Gangbang"
	reactsToTags = [E_APPROACH]
	eventWeight = 0.3
	eventTagWeightOverrides = {NOET.OwnerSex: 0.6, NOET.Sharing: 1.5}

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	if(GM.main.isVeryLate()):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER), bodyState={leashedBy=getOwnerID()}})
	sayPretext()
	saynn("{npc.name} щелкает поводком у твоего ошейника.")
	talkModularOwnerToPC("SoftSlaveryGB")
	saynn("Похоже, твой хозяин хочет найти кого-нибудь, чтобы устроить тебе групповой секс...")
	addButton("Повиноваться", "Пусть всё идет своим чередом", "go")
	addButton("Сопротивляться", "Ты не собираешься этого допускать!", "resist")
	if(canSetLimits()):
		addButton("Да, но..", "Повиноваться, но установить границы того, что хозяин может с вами делать во время секса", "yesbut")
	else:
		addDisabledButton("Да, но..", "Ваши отношения еще недостаточно развиты, чтобы вы могли устанавливать границы")

func getParadeTarget() -> String:
	var theResult:String= RNG.pick(LOCS_PARADE)
	while(theResult == getLocation()):
		theResult = RNG.pick(LOCS_PARADE)
	return theResult

func start_do(_id:String, _args:Array):
	if(_id == "go"):
		doGo()
	if(_id == "resist"):
		runResist()
	if(_id == "yesbut"):
		runEvent("yesbut", "SetOwnerLimits")
		#setState("obey")

func start_eventResult(_event, _id:String, _args:Array):
	if(_id == "yesbut"):
		doGo()

func searching():
	playAnimation(StageScene.Duo, "walk", {npc=getOwnerID(), npcAction="walk", flipNPC=true, bodyState={leashedBy=getOwnerID()}})
	
	saynn("Тебя ведут на поводке, пока {npc.name} ищет кандидатов для группового секса с тобой!")
	
	addButtonAt(6, "Walk", "See where your owner will bring you..", "go")
	addDisabledButtonAt(10, "Leashed", "You are leashed")
	addDisabledButtonAt(11, "Leashed", "You are leashed")
	addDisabledButtonAt(12, "Leashed", "You are leashed")

func searching_do(_id:String, _args:Array):
	if(_id == "go"):
		doGo()

func doGo():
	giveupTimer += 1
	if(curTarget == ""):
		curTarget = getParadeTarget()
	if(goTowards(curTarget)):
		curTarget = getParadeTarget()
	
	var nearbyPeeps := getFreePawnsNear(1)
	for thePawn in nearbyPeeps:
		if(triedCharIDs.has(thePawn.getCharID())):
			continue
		involveCharID(C_EXTRA4, thePawn.getCharID())
		setState("invite")
		return
	
	if(GM.main.isVeryLate() || giveupTimer > 30):
		if(canStartSexAtAll()):
			gaveupSearching = true
			setState("about_to_sex")
		else:
			setState("cancel_sex")
	
	setState("searching")

func cancel_sex():
	playStand(true)
	
	saynn("В конце концов, {npc.name} решает сдаться.")
	talkModularOwnerToPC("SoftSlaveryGBGiveup")
	addInfluenceResist(0.5)
	saynn("Похоже, групповушка отменяется...")
	addContinue("endEvent")

func invite():
	playAnimation(StageScene.Duo, "stand", {pc=getOwnerID(), npc=getRoleID(C_EXTRA4)})
	
	saynn("Твой хозяин подходит к кому-то!")
	talkModularOwnerToPC("SoftSlaveryGBOffer")
	
	var agreeChance:float = 50.0 - personality(C_EXTRA4, PersonalityStat.Subby)*20.0 + personality(C_EXTRA4, PersonalityStat.Mean)*30.0
	var subInsteadChance:float = 10.0 + personality(C_EXTRA4, PersonalityStat.Subby)*200.0
	
	if(smartChance(agreeChance)):
		saynn("Новичок вовсю разглядывает тебя.")
		talkModular(C_EXTRA4, C_OWNER, "SoftSlaveryGBSure")
		talkModularOwnerToPC("SoftSlaveryGBFollow")
		addContinue("add")
	elif(smartChance(subInsteadChance)):
		talkModular(C_EXTRA4, C_OWNER, "SoftSlaveryGBSubOffer")
		if(roles.has(C_EXTRA3)):
			talkModularOwnerToPC("SoftSlaveryGBSubOfferNo")
			talkModular(C_EXTRA4, C_OWNER, "SoftSlaveryGBSubOfferNoAw")
			addContinue("notadd")
		else:
			saynn("{npc.name} наклоняет {npc.his} голову.")
			talkModularOwnerToPC("SoftSlaveryGBSubOfferYes")
			addContinue("addsub")
	else:
		talkModular(C_EXTRA4, C_OWNER, "SoftSlaveryGBNo")
		talkModularOwnerToPC("SoftSlaveryGBNoReact")
		addContinue("notadd")
	

func invite_do(_id:String, _args:Array):
	if(_id == "add"):
		var theCharID:String = getRoleID(C_EXTRA4)
		removeRole(C_EXTRA4)
		involveCharID(getFreeSlot(), theCharID)
		if(canStartSexCheckFull()):
			setState("about_to_sex")
		else:
			setState("searching")
	if(_id == "addsub"):
		var theCharID:String = getRoleID(C_EXTRA4)
		removeRole(C_EXTRA4)
		involveCharID(C_EXTRA3, theCharID)
		if(canStartSexCheckFull()):
			setState("about_to_sex")
		else:
			setState("searching")
	if(_id == "notadd"):
		removeRole(C_EXTRA4)
		setState("searching")

func canStartSexCheckFull() -> bool:
	if(roles.has(C_EXTRA1) && roles.has(C_EXTRA2)):
		return true
	return false

func canStartSexAtAll() -> bool:
	if(roles.has(C_EXTRA1) || roles.has(C_EXTRA2)):
		setState("about_to_sex")
		return true
	setState("searching")
	return false

func getFreeSlot() -> int:
	if(!roles.has(C_EXTRA1)):
		return C_EXTRA1
	if(!roles.has(C_EXTRA2)):
		return C_EXTRA2
	#if(!roles.has(C_EXTRA3)):
	#	return C_EXTRA3
	return -999

func about_to_sex():
	playAnimation(StageScene.GivingBirth, "idle")
	
	saynn("{npc.name} замирает. Похоже, банда в сборе...")
	talkModularOwnerToPC("SoftSlaveryGBStart")
	
	var theDoms:Array = [getOwnerID()]
	if(hasRole(C_EXTRA1)):
		theDoms.append(getRoleID(C_EXTRA1))
	if(hasRole(C_EXTRA2)):
		theDoms.append(getRoleID(C_EXTRA2))
	var theSubs:Array = ["pc"]
	if(hasRole(C_EXTRA3)):
		theSubs.append(getRoleID(C_EXTRA3))
	
	addContinue("startSex", [ theDoms, theSubs ])

func about_to_sex_sexResult(_sex:SexEngineResult):
	sexSatisfaction = _sex.getAverageDomSatisfaction()
	earnedCredits = 0
	if(_sex.didSubsWin()):
		earnedCredits = RNG.randi_range(5, 10)
	elif(sexSatisfaction < 0.4):
		earnedCredits = RNG.randi_range(5, 10)
	else:
		var minExtra:float = pow(sexSatisfaction, 0.3)*10.0
		var maxExtra:float = pow(sexSatisfaction, 0.5)*20.0
		earnedCredits = RNG.randi_range(5, 10) + int(RNG.randf_range(minExtra, maxExtra))
	if(earnedCredits > 0):
		GM.pc.addCredits(earnedCredits)
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.GivingBirth, "idle")
	saynn("Гангбанг окончен!")
	talkModularOwnerToPC("SoftSlaveryGBEnd")
	addInfluenceObey()
	saynn("Твой хозяин протягивает тебе чип с "+str(earnedCredits)+" кредитами!")
	
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["curTarget"] = curTarget
	data["triedCharIDs"] = triedCharIDs
	data["giveupTimer"] = giveupTimer
	data["gaveupSearching"] = gaveupSearching
	data["sexSatisfaction"] = sexSatisfaction
	data["earnedCredits"] = earnedCredits
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	curTarget = SAVE.loadVar(_data, "curTarget", "")
	triedCharIDs = SAVE.loadVar(_data, "triedCharIDs", {})
	giveupTimer = SAVE.loadVar(_data, "giveupTimer", 0)
	gaveupSearching = SAVE.loadVar(_data, "gaveupSearching", false)
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
	earnedCredits = SAVE.loadVar(_data, "earnedCredits", 0)
