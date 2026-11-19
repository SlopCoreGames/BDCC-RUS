extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "Threesome"
	reactsToTags = [E_APPROACH]
	eventMinLevel = 2
	eventWeight = 0.6
	eventTagWeightOverrides = {NOET.OwnerSex: 0.9, NOET.Sharing: 2.0}

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theFriend := findOwnerFriend()
	if(theFriend.empty()):
		return false
	involveCharID(C_EXTRA1, theFriend)
	return true

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER), pc=getRoleID(C_EXTRA1), flipNPC=true})
	saynn("{npc.name} подходит к тебе... но на этот раз {npc.he} {npc.isAre} не в одиночку.")
	talkModularOwnerToPC("SoftSlaveryThreesomeStart")
	
	addButton("Повиноваться", "Позволить им это", "obey")
	addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	if(canSetLimits()):
		addButton("Да, но..", "Повиноваться, но установить границы того, что хозяин может с вами делать во время секса", "yesbut")
	else:
		addDisabledButton("Да, но..", "Ваши отношения еще недостаточно развиты, чтобы вы могли устанавливать границы")

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		if(checkSubEvent("fuck", "Тебя уже почти трахали {npc.name} и подруга {npc.his}..", [])):
			return
		setState("obey")
	if(_id == "resist"):
		runResist()
	if(_id == "yesbut"):
		runEvent("yesbut", "SetOwnerLimits")
		setState("obey")

func obey():
	playAnimation(StageScene.Duo, "kneel", {npc=getRoleID(C_OWNER)})
	
	saynn("Ты послушно подчиняешься {npc.name} и {npc.his} другу!")
	addInfluenceObey(RNG.randf_range(0.05, 0.1))
	addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [[getRoleID(C_OWNER), getRoleID(C_EXTRA1)], "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])
	
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
