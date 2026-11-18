extends NpcOwnerEventBase

func _init():
	id = "TestEvent"

func onStart(_args:Array):
	setState("start")

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	saynn("Тест!")
	talk(C_OWNER, "Meow meow.")
	#if(onlyOnce()):
	#	sayAppend("[color=red]OW[/color]")
	#	GM.pc.addPain(10)
	addInfluence(0.01)
	
	addButton("Питомец", "Погладить кошку", "pet")
	addButton("Погладить 2", "Погладить кошку, но получше", "setState", ["petted"])
	addButton("Прекрати!", "Перестать гладить", "end")
	addButton("В бой!", "Вааах!", "startFight", ["risha"])

func start_do(_id:String, _args:Array):
	if(_id == "end"):
		endEvent()
	if(_id == "pet"):
		setState("petted")
		#runEvent(id, args)

#func start_eventResult(_id:String, _args:Array)

func start_fightResult(_didWin:bool):
	if(_didWin):
		setState("weWon")

func weWon():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER), npcAction="kneel"})
	saynn("УРА! ТЫ ПОБЕДИЛА!")
	addButton("Назад", "Назад", "setState", ["start"])

func petted():
	saynn("Вы гладите кошку.")
	saynn("Кошка мурлычет.")
	
	addButton("Назад", "Назад", "setState", ["start"])
