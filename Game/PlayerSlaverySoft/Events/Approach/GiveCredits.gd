extends NpcOwnerEventBase

var creditsAmount:int = 10

func _init():
	id = "GiveCredits"
	reactsToTags = [E_APPROACH]
	
	eventMinLevel = 0
	eventMaxLevel = 2
	eventWeight = 0.4
	eventTagWeightOverrides = {NOET.Mean: 0.6, NOET.Credits: 1.0}

func start():
	if(onlyOnce()):
		creditsAmount = RNG.randi_range(5, 10)
	
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Твой хозяин подходит к тебе, {npc.his} глаза светятся жаждой чего-то.")
	talkOwner(getModularDialogue(C_OWNER, C_PC, "SoftSlaveryGiveCreditsStart").replace("<CREDITS>", str(creditsAmount)+" credits"))
	
	if(GM.pc.getCredits() >= creditsAmount):
		addButton("Повиноваться", "Позволить им забрать твои кредиты", "obey")
	else:
		addDisabledButton("Повиноваться", "Тебе не хватает!")
	addButton("Сопротивляться", "Они не собираются забирать твои кредиты", "resist")
	addButton("Мне не хватает", "Сказать, что у тебя недостаточно кредитов", "setState", ["amShort"])

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		if(checkSubEvent("GiveCredits", "Ты уже почти позволил {npc.name} забрать твои кредиты...", [])):
			return
		GM.pc.addCredits(-creditsAmount)
		setState("obey")
	if(_id == "resist"):
		runResist()

func start_eventResult(_event, _id:String, _args:Array):
	GM.pc.addCredits(-creditsAmount)
	setState("obey")

func obey():
	saynn("Ты послушно позволяешь хозяину забрать твои кредиты.")
	talkModularOwnerToPC("SoftSlaveryGiveCreditsTake")
	addInfluenceObey()
	addContinue("endEvent")

func amShort():
	saynn("Ты говоришь хозяину, что у тебя не хватает кредитов.")
	talkModularOwnerToPC("SoftSlaveryGiveCreditsShort")
	saynn("Похоже, {npc.he} {npc.isAre} собирается тебя наказать.")
	
	addButton("Принять", "Принять наказание", "accept")
	addButton("Сопротивляться", "Сопротивляться наказанию", "resist")

func amShort_do(_id:String, _args:Array):
	if(_id == "accept"):
		runPunishment()
	if(_id == "resist"):
		runResist()

func amShort_eventResult(_event, _id:String, _args:Array):
	if(_id == "resist"):
		setState("obey")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["creditsAmount"] = creditsAmount
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	creditsAmount = SAVE.loadVar(_data, "creditsAmount", 10)
