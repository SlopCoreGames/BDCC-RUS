extends SceneBase

func _init():
	sceneID = "PSTentaclesWalker"

func _run():
	var tentacles:PlayerSlaveryTentacles = GM.main.PS
	
	if(state == ""):
		saynn("Ты волен бродить по своей камере.")
		var roomID:String = GM.pc.location
		var _roomInfo = GM.world.getRoomByID(roomID)
		aimCameraAndSetLocName(roomID)
		
		if(tentacles.getMonsterLoc() == roomID && !tentacles.hasEvent()):
			var theAnimInfo:Array = tentacles.getTentaclesMeetAnim()
			if(theAnimInfo.size() >= 3):
				playAnimation(theAnimInfo[0], theAnimInfo[1], theAnimInfo[2])
		
		var theText:String = tentacles.getText(roomID)
		if(!theText.empty()):
			saynn(theText)

		if(GM.world.canGoID(roomID, GameWorld.Direction.NORTH)):
			addButtonAt(6, "Север", "Идти на север", "go", [GameWorld.Direction.NORTH, Direction.North])
		else:
			addDisabledButtonAt(6, "Север", "Нельзя пройти на север")
			
		if(GM.world.canGoID(roomID, GameWorld.Direction.WEST)):
			addButtonAt(10, "Запад", "Идти на запад", "go", [GameWorld.Direction.WEST, Direction.West])
		else:
			addDisabledButtonAt(10, "Запад", "Нельзя пройти на запад")
			
		if(GM.world.canGoID(roomID, GameWorld.Direction.SOUTH)):
			addButtonAt(11, "Юг", "Идти на юг", "go", [GameWorld.Direction.SOUTH, Direction.South])
		else:
			addDisabledButtonAt(11, "Юг", "Нельзя пройти на юг")
		
		if(GM.world.canGoID(roomID, GameWorld.Direction.EAST)):
			addButtonAt(12, "Восток", "Идти на восток",  "go", [GameWorld.Direction.EAST, Direction.East])
		else:
			addDisabledButtonAt(12, "Восток", "Нельзя пройти на восток")
		
		var theActions:Array = tentacles.getActions(roomID)
		for actionEntry in theActions:
			addButton(actionEntry[0], actionEntry[1], "doAction", actionEntry)
		

func _react(_action: String, _args):
	var tentacles:PlayerSlaveryTentacles = GM.main.PS
	
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "go"):
		playAnimation(StageScene.Solo, "walk")
		GM.pc.setLocation(GM.world.applyDirectionID(GM.pc.location, _args[0]))
		processTime((30 if !GM.pc.hasBoundLegs() else 60))
		aimCameraAndSetLocName(GM.pc.location)
		#GM.ES.triggerReact(Trigger.EnteringRoom, [GM.pc.location, _args[1]])
		
		tentacles.processTurn()
		
		var eventInfo:Array = tentacles.checkEvent(self, GM.pc.getLocation())
		if(!eventInfo.empty()):
			runScene(eventInfo[0], eventInfo[1] if eventInfo.size() > 1 else [])
			return
		elif(!GM.main.checkExtraScenes(true, true)):
			if(GM.main.showLog()):
				return
		
			tentacles.afterWalkCheck()
			
		return
	if(_action == "doAction"):
		tentacles.doAction(self, _args)
		return

	setState(_action)

func supportsShowingPawns() -> bool:
	return true

func getDebugActions():
	return GM.main.PS.getDebugActions()

func doDebugAction(id, args = {}):
	GM.main.PS.doDebugAction(id, args)
