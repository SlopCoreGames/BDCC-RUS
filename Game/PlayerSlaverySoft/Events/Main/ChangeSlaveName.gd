extends NpcOwnerEventBase

func _init():
	id = "ChangeSlaveName"

func onStart(_args:Array):
	setSubResult(SUB_CONTINUE)

func start():
	playStand()
	saynn("Вы спрашиваете своего хозяина, может ли {npc.he} теперь называться как-то иначе.")
	talkModularOwnerToPC("SoftSlaveryChangeName") #"How should I call my {npc.npcSlave} then?"
	saynn("Выберите себе новое прозвище.")
	
	addButton("CANCEL", "Вы передумали", "endEvent")
	var theNpcOwner := getNpcOwner()
	if(!theNpcOwner):
		return
	for nickname in theNpcOwner.getPossiblePCNames():
		addButton(nickname, "Выбрать это прозвище", "setNickname", [nickname])

func start_do(_id:String, _args:Array):
	var theNpcOwner := getNpcOwner()
	if(theNpcOwner):
		theNpcOwner.setPCName(_args[0])
	setState("afterNamed")
	
func afterNamed():
	saynn("Вы говорите хозяину, каким именем вы бы хотели, чтобы {npc.him} вас называл(а).")
	talkModularOwnerToPC("SoftSlaveryChangeNameEND") #Alright. You will now be my {npc.npcSlave}.
	addContinue("endEvent")
