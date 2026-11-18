extends NpcOwnerEventBase

func _init():
	id = "Punish2Slutwall"
	reactsToTags = [E_PUNISH_STRONG]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	if(!canGetToSlutwall()):
		return false
	if(!getOwner().isInmate()):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "hurt", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	sayPretext()
	saynn("{npc.name} толкает тебя, а затем пристегивает поводок к твоему ошейнику!")
	talkModularOwnerToPC("SoftSlaveryPunishSlutwall")
	saynn("Твой хозяин явно не в духе...")
	
	addContinue("setState", ["inStocks"])
	
func inStocks():
	setLocation(LOC_SLUTWALL)
	playAnimation(StageScene.SlutwallSex, "tease", {npc=getRoleID(C_OWNER)})
	
	saynn("Тебя приводят на подземную арену и заталкивают в стену для шлюх!")
	talkModularOwnerToPC("SoftSlaveryPunishSlutwallLock")
	addContinue("startStocks")

func inStocks_do(_id:String, _args:Array):
	endEvent()
	stopRunner()
	
	GM.main.IS.startInteraction("InSlutwall", {inmate="pc"})
