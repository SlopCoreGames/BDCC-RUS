extends NpcOwnerEventBase

#var creditsAmount:int = 10

func _init():
	id = "TaskProstitution"
	reactsToTags = [E_APPROACH]
	
	eventWeight = 0.1
	eventTagWeightOverrides = {NOET.Tasks: 0.5, NOET.Prostitution: 1.0}

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNpcOwner := getNpcOwner()
	if(theNpcOwner.hasGivenPCAnyTasks()):
		return false
	theNpcOwner.generateTasks(1, 1.0, 2.0, NpcTaskPool.Prostitution)
	GM.main.addMessage("Меню задач обновлено.")
	return true

func start():
	playStand()
	saynn("{npc.name} подходит к тебе.")
	talkModularOwnerToPC("SoftSlaveryTaskProstitutionGive")
	saynn("Твой хозяин дает тебе задание.")
	sayTaskInfo()
	sayOwnerRandomTaskLine()
	saynn("{npc.He} {npc.verb('nod')}.")
	talkModularOwnerToPC("SoftSlaveryTaskCheck")
	saynn("Похоже, на выполнение у тебя всего пара дней...")
	addButton("Окей", "Согласиться на задания", "endEvent")

func start_do(_id:String, _args:Array):
	if(_id == "resist"):
		runResist()

func saveData() -> Dictionary:
	var data := .saveData()
	
	#data["creditsAmount"] = creditsAmount
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	#creditsAmount = SAVE.loadVar(_data, "creditsAmount", 10)
