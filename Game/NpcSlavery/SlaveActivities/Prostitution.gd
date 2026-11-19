extends SlaveActivityBase

var workHoursLeft:int = 12
var workHoursRemember:int = 12
var earnedCreds:int = 0
var slutSkill:int = 0

func _init():
	id = "Prostitution"
	
func getVisibleName():
	return "Проституция"

func onStart(_args = []):
	slutSkill = getSlave().getSlaveSkill(SlaveType.Slut)
	
	workHoursLeft = RNG.randi_range(3,4)
	if(slutSkill >= 8):
		workHoursLeft += RNG.randi_range(2,4)
	if(slutSkill >= 11):
		workHoursLeft += RNG.randi_range(3,5)
	if(slutSkill >= 13):
		workHoursLeft += RNG.randi_range(3,6)
	if(slutSkill >= 15):
		workHoursLeft += RNG.randi_range(4,6)
	workHoursRemember = workHoursLeft
	
	var pawn = GM.main.IS.spawnPawnIfNeeded(getCharID())
	pawn.setLocation(GM.pc.getCellLocation())
	
func pawnShouldReturnHome() -> bool:
	#if(workHoursLeft <= 0):
	#	return true
	return false
	
func onNewDay():
	pass

func preventsStatsDecay():
	return false

func preventsNormalInteractions():
	return true

func getActivityText():
	return "{npc.name} сейчас где-то там, вовсю шлюшит с {npc.himself}.\n\n{npc.He} найдет тебя, когда {npc.he} закончит работу.\n\nТы можешь отменить это, но тогда не получишь кредиты, которые заработала твоя шлюшка."

func onPawnDeleted(_pawn):
	stopActivity()
	if(getChar() != null):
		GM.main.addMessage("Твоя рабыня "+getChar().getName()+" больше не занимается проституцией...")

func onInteractionChanged(_newInteraction):
	if(_newInteraction != null && _newInteraction.id == "Unconscious" && _newInteraction.getCharIDByRole("main") == getCharID()):
		stopActivity()
		GM.main.addMessage("Твоя рабыня "+getChar().getName()+" получила по морде и отключилась, теперь больше не занимается проституцией...")

func hoursPassed(_howMuch):
	if(!pawnExist()):
		stopActivity()
		return
	if(workHoursLeft <= 0):
		return
	for _i in range(_howMuch):
		if(workHoursLeft > 0):
			workHoursLeft -= 1

func onInteractionEvent(_eventID:String, _args:Dictionary):
	if(_eventID == "slutPaid"):
		var howMuch:int = _args["credits"] if _args.has("credits") else 1
		earnedCreds += howMuch
		getSlave().addExperience(2)
	if(_eventID == "slutReturnedCredits"):
		var howMuch:int = _args["credits"] if _args.has("credits") else 1
		earnedCreds -= howMuch
		#getSlave().addExperience(2)

func canReceiveCredits():
	return workHoursLeft <= 0

func shouldWork() -> bool:
	return workHoursLeft > 0

func getEarnedCredits():
	return earnedCreds

func getInteractActions():
	return [
		{
			name = "Отмена",
			desc = "Найди свою шлюху и прикажи ей перестать трахаться за копейки.",
			sceneID = "SlaveryCancelActivity",
			args = ["Ты находишь {npc.name} в тюрьме и велишь {npc.him} прекратить работу. Поскольку ты прервал(а) работу {npc.his}, ты не получишь никаких кредитов."],
			buttonChecks = [],
		}
	]

func getCustomInteractAnimInfo():
	return [StageScene.Solo, "stand", {pc="pc"}]

func saveData():
	var data = .saveData()
	
	data["workHoursLeft"] = workHoursLeft
	data["earnedCreds"] = earnedCreds
	data["slutSkill"] = slutSkill
	data["workHoursRemember"] = workHoursRemember
	
	return data

func loadData(_data):
	.loadData(_data)
	
	workHoursLeft = SAVE.loadVar(_data, "workHoursLeft", 12)
	earnedCreds = SAVE.loadVar(_data, "earnedCreds", 0)
	slutSkill = SAVE.loadVar(_data, "slutSkill", 0)
	workHoursRemember = SAVE.loadVar(_data, "workHoursRemember", 0)
