extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "StealingFromGreenhouseScene"

func _run():
	if(state == ""):
		saynn("Вы подходите к теплицам; каждая из них похожа на огромный длинный шатёр, внутри которого горит множество искусственных ламп. Вам нужно пробираться осторожно, потому что в любой момент рабочие или охрана могут вас заметить.")
		
		saynn("Похоже, на станции выращивают самые разные фрукты и овощи, но вы также замечаете грибы и различные виды инопланетных растений и трав, большинство из которых вам совершенно незнакомы.")

		saynn("Вы решаете, что пробираться внутрь одной из теплиц слишком опасно, но замечаете несколько деревянных ящиков, оставленных прямо на виду. Вы предполагаете, что вскрыть один из них будет несложно, но в процессе вас могут поймать.")
		
		saynn("Что будете делать?")

		addButton("Стибрить яблоко", "Попробовать вскрыть ящик с яблоками", "apple")
		addButton("Ничего не красть", "Слишком опасно", "endthescene")

			
	if(state == "apple"):
		saynn("Вам удается поддеть один из ящиков и стащить несколько яблок. Пора делать ноги.")
		
		addButton("Продолжить", "Попытаться сбежать незамеченным", "caughtcheck")

	if(state == "canTryAgain"):
		saynn("Похоже, вам это удалось. Но вы думаете, что можно попробовать стащить еще немного.")
		
		addButton("Украсть ещё больше", "Попытаться сбежать незамеченным", "caughtcheck2")
		addButton("Ничего не красть", "Слишком опасно", "endthescene")
		GM.ES.triggerRun(Trigger.CaughtStealingInGreenhouse)

func _react(_action: String, _args):
	if(_action == "apple"):
		GM.main.setModuleFlag("CellblockModule", "Cellblock_GreenhouseLooted", true)
		
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
		if(RNG.chance(50)):
			GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
			addMessage("Вы украли 2 яблока")
		else:
			addMessage("Вы украли яблоко")
	
	if(_action == "caughtcheck"):		
		processTime(10 * 5)
		
		if(RNG.chance(50)):
			if(GM.ES.triggerReact(Trigger.CaughtStealingInGreenhouse)):
				endScene()
				return
		
		setState("canTryAgain")
		return
		
	if(_action == "caughtcheck2"):
		processTime(10 * 5)
		
		if(RNG.chance(75)):
			if(GM.ES.triggerReact(Trigger.CaughtStealingInGreenhouse)):
				endScene()
				return
		endScene()
		
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
		addMessage("Вы украли ещё 2 яблока")
		
		addMessage("Похоже, вам удалось уйти незамеченным")
		return


	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
