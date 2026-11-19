extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "Fuck"
	reactsToTags = [E_APPROACH]
	eventWeight = 1.0
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.OwnerSex: 3.0}

func start():
	playAnimation(StageScene.Grope, "tease", {npc=getOwnerID()})
	saynn("Ваш хозяин {npc.name} приближается к вам!")
	talkModularOwnerToPC("SoftSlaveryFuckStart")
	saynn("Похоже, {npc.he} {npc.verb('want')} вами!")
	
	addButton("Повиноваться", "Позволить им это", "obey")
	addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	if(canSetLimits()):
		addButton("Да, но..", "Повиноваться, но установить границы того, что хозяин может с вами делать во время секса", "yesbut")
	else:
		addDisabledButton("Да, но..", "Ваши отношения еще недостаточно развиты, чтобы вы могли устанавливать границы")

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("obey")
		checkSubEvent("fuck", "Тебя как раз собирались оттрахать {npc.name}..", [])
	if(_id == "resist"):
		runResist()
	if(_id == "yesbut"):
		runEvent("yesbut", "SetOwnerLimits")
		setState("obey")
	
func obey():
	playAnimation(StageScene.Duo, "kneel", {npc=getRoleID(C_OWNER)})
	
	saynn("Вы подчиняетесь своему хозяину!")
	addInfluenceObey(RNG.randf_range(0.05, 0.1))
	addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [getRoleID(C_OWNER), "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])
	
func obey_sexResult(_sexResult:SexEngineResult):
	sexSatisfaction = _sexResult.getAverageDomSatisfaction()
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Секс окончен!")
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
