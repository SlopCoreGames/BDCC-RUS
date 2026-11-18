extends NpcOwnerEventBase

func _init():
	id = "ResistGeneric"

func onStart(_args:Array):
	setState("start")

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Вы сопротивляетесь действиям своего хозяина!")
	talkModularOwnerToPC("SoftSlaveryResist") #"Really, {npc.npcSlave}? Is that how you wanna do this?"
	saynn("Похоже, тебе придется сразиться с {npc.him}.")
	
	addButton("Драться", "Начать бой", "startFight", [getOwnerID()])

func start_fightResult(_didWin:bool):
	if(_didWin):
		setState("pcWon")
	else:
		setState("pcLost")

func pcWon():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), npcAction="kneel"})
	saynn("Вы победили в схватке! Влияние хозяина на вас уменьшилось.")
	addInfluenceResist()
	
	addContinue("endEvent")

func pcLost():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID()})
	
	saynn("Вы проиграли в схватке.")
	saynn("{npc.name} собирается наказать вас..")
	addContinue("startPunish")

func pcLost_do(_id:String, _args:Array):
	if(_id == "startPunish"):
		runEvent("punishment", "Punish")

func pcLost_eventResult(_event, _tag:String, _args:Array):
	endEvent()
