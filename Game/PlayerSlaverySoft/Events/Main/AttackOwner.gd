extends NpcOwnerEventBase

func _init():
	id = "AttackOwner"

func onStart(_args:Array):
	setSubResult(SUB_END)

func start():
	playStand()
	saynn("Вы решаете напасть на своего хозяина!")
	talkModularOwnerToPC("SoftSlaveryAttackReaction") #You're gonna regret it.
	
	addButton("Драться", "Начать бой", "startFight", [getOwnerID()])
	
func start_fightResult(_didWin:bool):
	if(_didWin):
		setState("pcWon")
	else:
		setState("pcLost")

func pcWon():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), npcAction="kneel"})
	saynn("Вы победили в схватке! Обессиленный хозяин стоит перед вами на {npc.his} коленях.")
	talkModularOwnerToPC("SoftSlaveryAttackLost") #"Ugh.. so? You're still my {npc.npcSlave}."
	addInfluenceResist()
	saynn("Влияние {npc.name} на вас уменьшилось!")
	
	addContinue("endEvent")

func pcLost():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID()})
	saynn("Вы проиграли бой против своего хозяина.")
	talkModularOwnerToPC("SoftSlaveryAttackWon") #"And now.. I'm gonna punish you."
	saynn("Теперь вам придётся вытерпеть всё то, что он задумал для вас.")
	addContinue("startPunish")

func pcLost_do(_id:String, _args:Array):
	if(_id == "startPunish"):
		runPunishment()
