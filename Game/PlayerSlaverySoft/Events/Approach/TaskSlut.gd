extends NpcOwnerEventBase

#var creditsAmount:int = 10

func _init():
	id = "TaskSlut"
	reactsToTags = [E_APPROACH]
	
	eventWeight = 0.4
	eventTagWeightOverrides = {NOET.Tasks: 1.0}

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNpcOwner := getNpcOwner()
	if(theNpcOwner.hasGivenPCAnyTasks()):
		return false
	genTasks()
	return true

func genTasks():
	var theNpcOwner := getNpcOwner()
	if(RNG.chance(50)):
		theNpcOwner.generateTasks(2, 1.5, 3.0) # 2 hard tasks
	else:
		theNpcOwner.generateTasks(RNG.randi_range(3, 5), 1.0, 1.5) # 3-5 simple tasks
	GM.main.addMessage("Tasks menu updated.")

func start():
	playStand()
	saynn("{npc.name} подходит к тебе.")
	talkModularOwnerToPC("SoftSlaveryTaskSlutGive")
	saynn("{npc.He} {npc.verb('start')} список дел, которые {npc.he} {npc.verb('want')} заставляет тебя выполнять.")
	sayTaskInfo()
	sayOwnerRandomTaskLine()
	saynn("Твой хозяин/хозяйка одаривает тебя улыбкой...")
	talkModularOwnerToPC("SoftSlaveryTaskCheck")
	saynn("Похоже, на выполнение этих заданий у тебя всего пара дней...")
	addButton("Окей", "Согласиться на задания", "endEvent")
	addButton("Что-то другое?", "Попросить хозяина дать тебе другие задания", "askDifferent")

func start_do(_id:String, _args:Array):
	if(_id == "askDifferent"):
		genTasks()
		setState("askedDifferent")

func askedDifferent():
	saynn("Ты спрашиваешь хозяина/хозяйку, может ли он/она давать тебе другие задания.")
	sayTaskInfo()
	sayOwnerRandomTaskLine()
	addButton("Окей", "Согласиться на задания", "endEvent")
	addButton("Что-то другое?", "Попросить хозяина дать тебе другие задания", "askDifferent")

func askedDifferent_do(_id:String, _args:Array):
	if(_id == "askDifferent"):
		genTasks()
		setState("askedDifferent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	#data["creditsAmount"] = creditsAmount
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	#creditsAmount = SAVE.loadVar(_data, "creditsAmount", 10)
