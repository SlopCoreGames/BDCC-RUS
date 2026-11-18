extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "FuckInStocks"
	reactsToTags = [E_APPROACH]
	eventWeight = 0.6
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.OwnerSex: 1.5, NOET.BDSM: 2.0, NOET.ShowingOff:1.0}

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Твой хозяин подходит к тебе, сжимая поводок в {npc.his} руке!")
	talkModularOwnerToPC("SoftSlaveryStocksStart")
	
	addButton("Повиноваться", "Позволить им это", "obey")
	addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	if(canSetLimits()):
		addButton("Да, но..", "Повиноваться, но установить границы того, что хозяин может с вами делать во время секса", "yesbut")
	else:
		addDisabledButton("Да, но..", "Ваши отношения еще недостаточно развиты, чтобы вы могли устанавливать границы")

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		runParadeTo(LOC_STOCKS)
	if(_id == "resist"):
		runResist()
	if(_id == "yesbut"):
		runEvent("yesbut", "SetOwnerLimits")

func start_eventResult(_event, _id:String, _args:Array):
	if(_id == "yesbut"):
		runParadeTo(LOC_STOCKS)
	if(_id == "paradeTo"):
		setState("inStocks")
		checkSubEvent("FuckInStocks", "You were about to be locked into stocks by {npc.name}..", [])
	
func inStocks():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getRoleID(C_OWNER)})
	
	saynn("Вы полностью повинуетесь и позволяете {npc.name} запереть вас в колодки!")
	talkModularOwnerToPC("SoftSlaveryStocksLocked")
	addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [getRoleID(C_OWNER), "pc", SexType.StocksSex, {SexMod.DisableDynamicJoiners:true}])
	
func inStocks_sexResult(_sexResult:SexEngineResult):
	sexSatisfaction = _sexResult.getAverageDomSatisfaction()
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("После секса хозяин проявляет милосердие и отпирает тебя!")
	
	if(sexSatisfaction < 0.5):
		talkModularOwnerToPC("SoftSlaveryFuckResultBad") #"That was awful. Are you trying to make me mad, {npc.npcSlave}? Whatever, I will be back soon."
	elif(sexSatisfaction < 0.8):
		talkModularOwnerToPC("SoftSlaveryFuckResultOkay") #"That was okay. Can't you moan a little louder, {npc.npcSlave}? I will be back when I'm horny again."
	else:
		talkModularOwnerToPC("SoftSlaveryFuckResultGood") #"Not bad for a {npc.npcSlave}. I will be back when I'm horny again."
	if(sexSatisfaction > 0.4):
		addInfluenceObey(sexSatisfaction)
	else:
		addInfluenceResist(1.0-sexSatisfaction)
	
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	data["sexSatisfaction"] = sexSatisfaction
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
