extends NpcOwnerEventBase

func _init():
	id = "Punish"

func onStart(_args:Array):
	setState("start")
	
	if(checkProtect("Твой хозяин уже собирался тебя наказать...")):
		return
	
	var theNpcOwner := getNpcOwner()
	if(theNpcOwner.checkSkipPunishment()):
		theNpcOwner.onSkipPunish()
		setState("punishSkip")
		return
	
	if(!checkRunPunish()):
		endEvent()

func start_eventResult(_event, _tag:String, _args:Array):
	if(_tag == "protect"):
		if(!checkRunPunish()):
			endEvent()
		return
	endEvent()

func checkRunPunish() -> bool:
	var theOwner := getNpcOwner()
	if(!theOwner):
		return false
	
	var thePunishAmount:int = theOwner.getPunishAmount()
	var theTag := E_PUNISH_WEAK
	if(thePunishAmount <= 1):
		theTag = E_PUNISH_WEAK
	elif(thePunishAmount == 2):
		theTag = E_PUNISH_STRONG
	else:
		theTag = E_PUNISH_GET_RID_OF
	
	if(checkSubEvent(theTag, "", [])):
		theOwner.onPunish()
		return true
	return false


func punishSkip():
	playStand()
	
	saynn("{npc.name} собиралась тебя наказать... но в последний момент передумала.")
	talkModularOwnerToPC("SoftSlaveryPunishSkip")
	saynn("Похоже, пока что ты свободен!")
	addContinue("endEvent")
