extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0
var resultText:String = ""

func _init():
	id = "TaskFuckOwner"
	reactsToTags = [E_APPROACH]
	eventWeight = 0.0
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.Tasks: 0.0, NOET.SubbyOwner: 2.0}

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	if(_event.ownerPersonality(PersonalityStat.Subby) < 0.0):
		return 0.0
	return .getSubEventScore(_event, _tag, _args)

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNpcOwner := getNpcOwner()

	if(theNpcOwner.hasGivenPCAnyTasks()):
		return false
	genTasks()
	if(!theNpcOwner.hasGivenPCOwnerTasks()):
		theNpcOwner.clearOwnerTasks()
		return false
	return true

func genTasks():
	var theNpcOwner := getNpcOwner()
	if(RNG.chance(50)):
		theNpcOwner.generateOwnerTasks(2, 1.5, 3.0) # 2 hard task
	else:
		theNpcOwner.generateOwnerTasks(3, 1.0, 1.5) # 3 simple tasks

func start():
	playAnimation(StageScene.Grope, "tease", {npc=getOwnerID()})
	saynn("Твой хозяин {npc.name} подходит к тебе, выглядя немного... застенчиво.")
	talkModularOwnerToPC("SoftSlaveryTaskFuckOwner")
	saynn("Похоже, {npc.he} {npc.verb('want')} тебе.. на какое-то время. Твой хозяин перечисляет, что {npc.he} {npc.verb('want')} тебе делать с {npc.him} во время секса.")
	
	sayOwnerTaskInfo("{npc.name} хочет, чтобы ты сделал это с {npc.him}:")
	
	saynn("{npc.He} наверняка разозлится, если ты не сделаешь всё до конца..")
	
	addButton("Принять", "Попробовать сделать всё", "obey")
	addButton("Сопротивляться!", "Ты не собираешься этого делать", "resist")
	addButton("Что-то другое?", "Попросить хозяина дать тебе другие задания", "askDifferent")
	
	
func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("obey")
		#checkSubEvent("fuck", "You were about to start fucking {npc.name}..", [])
	if(_id == "resist"):
		getNpcOwner().clearOwnerTasks()
		runResist()
	if(_id == "askDifferent"):
		genTasks()
	
func obey():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER), npcAction="kneel"})
	
	saynn("Ты соглашаешься.. и вот.. Твой хозяин подчиняется тебе!")
	saynn("Пора повеселиться.")
	#addInfluenceObey(RNG.randf_range(0.05, 0.1))
	addButton("Продолжить", "Смотреть, что будет дальше", "startSex", ["pc", getRoleID(C_OWNER), SexType.DefaultSex, {}])
	
func obey_sexResult(_sexResult:SexEngineResult):
	if(_sexResult.isSubUnconscious(getOwnerID())):
		getNpcOwner().clearOwnerTasks()
		setState("madeDomUncon")
		return
	
	getNpcOwner().checkIfOwnerTasksGotCompleted()
	resultText = getOwnerTaskInfo()
	sexSatisfaction = _sexResult.getAverageDomSatisfaction()
	if(getNpcOwner().isEveryOwnerTaskCompleted()):
		setState("afterSex")
	else:
		setState("failedSex")
	getNpcOwner().clearOwnerTasks()

func afterSex():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Секс окончен!")
	saynn(resultText)
	talkModularOwnerToPC("SoftSlaveryTaskFuckOwnerGood")
	saynn("Похоже, твой хозяин удовлетворен!")
	addInfluenceObey()
	addContinue("endEvent")

func failedSex():
	playStand()
	saynn("Секс окончен!")
	saynn(resultText)
	talkModularOwnerToPC("SoftSlaveryTaskFuckOwnerBad")
	saynn("Похоже, твой хозяин не в восторге от твоих действий..")
	addButton("Повиноваться", "Принять наказание", "punish")
	addButton("Сопротивляться!", "Ты не собираешься просто так принять наказание?", "resist")

func madeDomUncon():
	playAnimation(StageScene.SexStart, "defeated", {npc=getOwnerID()})
	saynn("Ой, похоже, твой хозяин слабее, чем ты думала. А может, ты сделала это специально...")
	saynn("Так или иначе, {npc.he} не сможет наказать тебя, даже если {npc.he} очень захочет!")
	addInfluenceResist()
	addContinue("endEventOwnerUncon")

func madeDomUncon_do(_id:String, _args:Array):
	if(_id == "endEventOwnerUncon"):
		var theOwnerID:String = getOwnerID()
		endEvent()
		stopRunner()
		GM.main.IS.startInteraction("Unconscious", {main=theOwnerID})

func failedSex_do(_id:String, _args:Array):
	if(_id == "punish"):
		runPunishment()
	if(_id == "resist"):
		runResist()

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["sexSatisfaction"] = sexSatisfaction
	data["resultText"] = resultText
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
	resultText = SAVE.loadVar(_data, "resultText", "")
