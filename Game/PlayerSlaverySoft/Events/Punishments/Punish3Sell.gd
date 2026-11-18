extends NpcOwnerEventBase

func _init():
	id = "Punish3Sell"
	reactsToTags = [E_PUNISH_GET_RID_OF]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	sayPretext()
	saynn("Твой хозяин бросает на тебя очень злобный взгляд!")
	talkModularOwnerToPC("SoftSlaveryPunishSell")
	saynn("Похоже, ты вот-вот обретешь свободу?")
	
	addContinue("setState", ["flashed"])

func flashed():
	playAnimation(StageScene.Sleeping, "sleep")
	saynn("Внезапно ты видишь яркую вспышку! Настолько яркую, что кажется, будто она прошивает тебя насквозь!")
	saynn("Мучительная головная боль заставляет голову идти кругом... а затем ты валишься с ног.")
	saynn("Приземление было не самым мягким. Ты чувствуешь, как сознание ускользает...")
	talkModularOwnerToPC("SoftSlaveryPunishSell2")
	
	addContinue("getSold")

func flashed_do(_id:String, _args:Array):
	var npcOwner := getNpcOwner()
	if(npcOwner):
		npcOwner.endSlavery()
	endEvent()
	stopRunner()
	GM.main.runScene(GlobalRegistry.getModule("PlayerSlaveryModule").getSlaveryStartScene())
