extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "Punish1RoughSex"
	reactsToTags = [E_PUNISH_WEAK]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	return true
	
func start():
	playAnimation(StageScene.SexLowDoggy, "tease", {pc=getOwnerID()})
	sayPretext()
	saynn("{npc.name} хватает тебя и вжимает в пол!")
	talkModularOwnerToPC("SoftSlaveryPunishRoughSex")
	
	var theChar = GlobalRegistry.getCharacter(getOwnerID())
	if(theChar):
		theChar.addEffect("SexAngry", [100])
	addContinue("startSex", [getOwnerID(), "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true,SexMod.DomNoPullingOut:true}])

func start_sexResult(_sex:SexEngineResult):
	sexSatisfaction = _sex.getAverageDomSatisfaction()
	if(_sex.didSubsWin()):
		setState("pcWon")
	else:
		setState("afterSex")

func afterSex():
	playAnimation(StageScene.SexStart, "start", {pc=getOwnerID()})
	saynn("Грубый секс окончен!")
	talkModularOwnerToPC("SoftSlaveryPunishRoughSexEnded")
	saynn("Похоже, наказание подошло к концу...")
	addContinue("endEvent")

func pcWon():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), npcAction="defeat"})
	saynn("Тебе удалось дать отпор своему хозяину!")
	addInfluenceResist()
	talkModularOwnerToPC("SoftSlaveryPunishRoughSexPCWon") #Ugh.. I'm not done with you
	saynn("Похоже, наказание подошло к концу...")
	addContinue("endEvent")
