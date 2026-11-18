extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0
var instantSurrender:bool = false

func _init():
	id = "JealousOwner"
	reactsToTags = ["fuck"]
	eventWeight = 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var allFrens:Array= _event.getFreeOwnerIDsNearby(true, _context)
	if(allFrens.empty()):
		if(RNG.chance(_event.getNearbyCheckAllChance())):
			allFrens = _event.getFreeOwnerIDs(true, _context)
			if(allFrens.empty()):
				return false
		else:
			return false
	
	var randomFrenID:String = RNG.pick(allFrens)
	involveCharID(C_EXTRA1, randomFrenID)
	if(smartChance(-20.0 + ownerPersonality(PersonalityStat.Coward)*80.0)):
		instantSurrender = true
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {pc=getRoleID(C_EXTRA1), npc=getOwnerID()})
	sayPretext()
	saynn("К вам приближается кто-то.. кто-то, кого вы знаете.. и кто знает вас.")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckJealousStart")
	talkModular(C_OWNER, C_EXTRA1, "SoftSlaveryFuckJealousFight")
	
	saynn("Похоже, твои двое хозяев вот-вот вцепятся друг другу в глотки...")
	
	if(instantSurrender):
		addContinue("setState", ["ownerLost"])
	else:
		addContinue("fight")

func start_do(_id:String, _args:Array):
	if(_id == "fight"):
		runNpcFight(getOwnerID(), getRoleID(C_EXTRA1))

func start_eventResult(_event, _tag:String, _args:Array):
	if(_event.didWin()):
		setSubResult(SUB_CONTINUE)
		setState("ownerWon")
	else:
		setState("ownerLost")

func ownerWon():
	playAnimation(StageScene.SexStart, "start", {npc=getRoleID(C_EXTRA1), pc=getOwnerID()})
	
	saynn("Твой хозяин победил... твоего второго хозяина!")
	talkModularOwnerToPC("SoftSlaveryFuckJealousOwnerWon")
	addInfluenceObey(0.2)
	saynn("Твой второй хозяин кряхтит.")
	talk(C_EXTRA1, "Whatever.")
	
	var haveSexChance:float = 50.0 + ownerPersonality(PersonalityStat.Mean)*50.0
	haveSexChance -= getOwnerNOM(NOM.Asexual)*200.0
	if(smartChance(haveSexChance)):
		saynn("Когда побежденный хозяин пытается уйти, {npc.name} хватает и удерживает {npc1.him} на месте!")
		talkModularOwnerToPC("SoftSlaveryFuckJealousOwnerWonFuck")
		addInfluenceObey()
		addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [getOwnerID(), ["pc", getRoleID(C_EXTRA1)], SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])
	else:
		saynn("Когда побежденный хозяин уходит, {npc.name} заставляет {npc.his} снова обратить внимание на тебя...")
		addButton("Подчиниться", "Смотри, что будет дальше...", "endEvent")

func ownerWon_sexResult(_sexResult:SexEngineResult):
	setSubResult(SUB_END)
	setState("afterSex")

func ownerLost():
	if(!instantSurrender):
		playAnimation(StageScene.SexStart, "start", {pc=getRoleID(C_EXTRA1), npc=getOwnerID()})
		saynn("Твой хозяин проиграл... твоему другому хозяину!")
	else:
		playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_EXTRA1), pc=getOwnerID()})
		saynn("Впрочем, драки не случилось!")

	saynn("{npc1.name} начинает приближаться к {npc.name}...")
	talkModularOwnerToPC("SoftSlaveryFuckJealousOwnerLostOffer")
	saynn("Твой второй хозяин на секунду замирает.")
	talkModularOwnerToPC("SoftSlaveryFuckJealousOwnerLostOffer2")
	saynn("Твой второй хозяин что-то напевает, вожделенно разглядывая тебя.")
	if(smartChance(50.0 - personality(C_EXTRA1, PersonalityStat.Mean)*50.0)):
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckJealousOwnerLostOfferAgree")
		saynn("Они оба хватают тебя...")
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckJealousOwnerLostOfferAgree2")
		addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [[getOwnerID(), getRoleID(C_EXTRA1)], "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])
	else:
		talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckJealousOwnerLostOfferNope")
		addInfluenceResist()
		saynn("{npc1.He} {npc1.verb('grab')} вас обоих...")
		addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [getRoleID(C_EXTRA1), ["pc", getOwnerID()], SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])

func ownerLost_sexResult(_sexResult:SexEngineResult):
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Секс окончен!")
	saynn("Твой другой хозяин наконец-то оставляет тебя в покое.")
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["sexSatisfaction"] = sexSatisfaction
	data["instantSurrender"] = instantSurrender
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
	instantSurrender = SAVE.loadVar(_data, "instantSurrender", false)
