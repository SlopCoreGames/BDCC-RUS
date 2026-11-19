extends NpcOwnerEventBase

func _init():
	id = "Punish1Credits"
	reactsToTags = [E_PUNISH_WEAK]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "hurt", {npc=getOwnerID(), npcAction="shove"})
	sayPretext()
	if(isOwnerStaff()):
		saynn("{npc.name} толкает тебя, а затем прижимает к твоему ошейнику какое-то устройство!")
	else:
		saynn("{npc.name} толкает тебя, а затем прижимает к твоему ошейнику какой-то взломанный чип!")
	talkModularOwnerToPC("SoftSlaveryPunishCredits")
	saynn("Твой ошейник издает писк: часть твоих кредитов принудительно списывается с заключенческого счета...")
	talkModularOwnerToPC("SoftSlaveryPunishCredits2")
	
	if(onlyOnce()):
		var credAmount:int = RNG.randi_range(5, 10)
		GM.pc.addCredits(-credAmount)
		GM.main.addMessage("Ты проиграл "+str(credAmount)+" кредитами!")
	
	addContinue("endEvent")
	
