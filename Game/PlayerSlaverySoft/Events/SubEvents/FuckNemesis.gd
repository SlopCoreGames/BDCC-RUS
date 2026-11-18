extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "FuckInStocksExtra"
	reactsToTags = ["fuck"]
	eventWeight = 0.1

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var allNemesis:Array= _event.getFreeNemesisIDs(true, _context)
	if(allNemesis.empty()):
		return false
	involveCharID(C_EXTRA1, RNG.pick(allNemesis))
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {pc=getRoleID(C_EXTRA1), npc=getOwnerID()})
	sayPretext()
	saynn("К вам приближается кто-то.. кто-то, кого вы знаете.. и кто знает вас.")
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckNemesisApproach")
	talkModular(C_OWNER, C_EXTRA1, "SoftSlaveryFuckNemesisAsk") #What's your problem?
	talkModular(C_EXTRA1, C_OWNER, "SoftSlaveryFuckNemesisAnswer") #Your slave crossed me. Wanna punish him together?
	
	saynn("Ваш хозяин немного задумывается..")
	
	if(smartChance(50.0+ownerPersonality(PersonalityStat.Subby)*70.0 - 200.0*getOwnerNOM(NOM.NoSharing) + 30.0*getOwnerNOM(NOM.Sharing))):
		setSubResult(SUB_END)
		talkModular(C_OWNER, C_EXTRA1, "SoftSlaveryFuckNemesisYes") #Sure
		saynn("Ваш заклятый враг улыбается, когда {npc1.he} {npc1.verb('approach', 'approaches')} вас..")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [[getOwnerID(), getRoleID(C_EXTRA1)], "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}])
	else:
		setSubResult(SUB_CONTINUE)
		talkModular(C_OWNER, C_EXTRA1, "SoftSlaveryFuckNemesisNo") #"No. {pc.He} {pc.isAre} mine."
		saynn("Ваш заклятый враг бросает на вас злобный взгляд.. но уходит.")
		addInfluenceObey(0.2)
		addContinue("endEvent")

func start_sexResult(_sexResult:SexEngineResult):
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
	saynn("Ваш заклятый враг, наконец, оставляет вас в покое.")
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["sexSatisfaction"] = sexSatisfaction
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
