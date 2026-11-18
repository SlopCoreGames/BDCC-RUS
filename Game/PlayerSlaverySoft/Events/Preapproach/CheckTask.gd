extends NpcOwnerEventBase

#var creditsAmount:int = 10

func _init():
	id = "CheckTask"
	reactsToTags = [E_APPROACH]
	
	eventWeight = 999999.9

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNpcOwner := getNpcOwner()
	if(!theNpcOwner.hasGivenPCTasks()):
		return false
	
	if(theNpcOwner.isEverythingCompleted()):
		setState("allcompleted")
	
	theNpcOwner.clearTasks()
	
	return true

func start():
	playStand()
	saynn("К тебе стремительно подходит {npc.name}, твой хозяин! И вид у него совсем не радостный.")
	talkModularOwnerToPC("SoftSlaveryCheckTaskFail")
	saynn("Похоже, тебя сейчас будут наказывать...")
	
	addButton("Окей", "Согласиться на наказание", "startPunish")
	addButton("Сопротивляться!", "Сопротивляться наказанию", "startResist")

func start_do(_id:String, _args:Array):
	if(_id == "startPunish"):
		runPunishment()
	if(_id == "startResist"):
		runResist()

func allcompleted():
	playStand()
	saynn("К тебе подходит {npc.name}, твой хозяин.")
	talkModularOwnerToPC("SoftSlaveryCheckTaskGood")
	saynn("{npc.He} {npc.verb('seem')} доволен.")
	addInfluenceObey()
	talkModularOwnerToPC("SoftSlaveryCheckTaskGood2")
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	#data["creditsAmount"] = creditsAmount
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	#creditsAmount = SAVE.loadVar(_data, "creditsAmount", 10)
