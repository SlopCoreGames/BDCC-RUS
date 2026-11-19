extends NpcOwnerEventBase

var targetLoc:String = ""

func _init():
	id = "ParadeTo"
	reactsToTags = []

func onStart(_args:Array):
	setState("start")
	#setSubResult(SUB_CONTINUE)
	
	targetLoc = _args[0]
	if(!canGetTo(targetLoc)):
		setLocation(targetLoc)
		setSubResult(SUB_CONTINUE)
		endEvent()

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	saynn("{npc.name} защелкивает поводок на твоем ошейнике!")
	
	addButtonAt(6, "Идти", "Посмотрим, куда тебя приведёт хозяин...", "walk")
	addDisabledButtonAt(10, "На поводке", "Ты на поводке")
	addDisabledButtonAt(11, "На поводке", "Ты на поводке")
	addDisabledButtonAt(12, "На поводке", "Ты на поводке")

func doWalk() -> bool:
	if(goTowards(targetLoc)):
		setSubResult(SUB_CONTINUE)
		endEvent()
		return true
	return false

func start_do(_id:String, _args:Array):
	if(_id == "walk"):
		setState("walking")
		
		doWalk()

func walking():
	playAnimation(StageScene.Duo, "walk", {npc=getOwnerID(), npcAction="walk", flipNPC=true, bodyState={leashedBy=getOwnerID()}})
	
	saynn("Твой хозяин ведет тебя на парад.")
	
	var _roomInfo = GM.world.getRoomByID(getLocation())
	if(_roomInfo):
		if(GM.pc.isBlindfolded() && !GM.pc.canHandleBlindness()):
			saynn(_roomInfo.getBlindDescription())
		else:
			saynn(_roomInfo.getDescription())
	
	addButtonAt(6, "Идти", "Посмотрим, куда тебя приведёт хозяин...", "walk")
	addDisabledButtonAt(10, "На поводке", "Ты на поводке")
	addDisabledButtonAt(11, "На поводке", "Ты на поводке")
	addDisabledButtonAt(12, "На поводке", "Ты на поводке")
	
func walking_do(_id:String, _args:Array):
	if(_id == "walk"):
		doWalk()
		
		if(checkProtect("Тебя тащили на поводке...")):
			return
		
		checkSubEvent(E_PARADE_TO, "Твой хозяин выставлял тебя напоказ...", [getFreePawnsNear(2)])

func isPlayerOnALeash() -> bool:
	return true

func getNearbyCheckDist() -> float:
	return 2.0

func getNearbyCheckAllChance() -> float:
	return 3.0

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	data["targetLoc"] = targetLoc
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	targetLoc = SAVE.loadVar(_data, "targetLoc", "")
