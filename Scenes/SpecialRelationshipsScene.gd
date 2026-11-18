extends SceneBase

var selectedCharID:String = ""

func _init():
	sceneID = "SpecialRelationshipsScene"

func _run():
	if(state == ""):
		addButton("CLOSE", "Закрыть меню", "endthescene")
		playAnimation(StageScene.Solo, "stand")
		setCharactersEasyList([])
		aimCameraAndSetLocName(GM.pc.getLocation())
		
		for charID in GM.main.RS.special:
			var theSpecial:SpecialRelationshipBase = GM.main.RS.special[charID]
			var theChar:BaseCharacter = getCharacter(charID)
			if(!theChar || !theSpecial):
				continue
			var theColor:Color = theSpecial.getCategoryColor()
			var theCharTypeName:String = CharacterType.getName(theChar.getCharType())
			sayn(theChar.getName()+" - "+theCharTypeName+" - [color=#"+theColor.to_html(false)+"]"+theSpecial.getCategoryName()+"[/color]")
			
			addButton(theChar.getName(), "Посмотри на эти отношения", "lookAt", [charID])
	
	if(state == "relationshipInfo"):
		addButton("BACK", "Назад в предыдущее меню", "")
		if(!GM.main.RS.special.has(selectedCharID)):
			return
		var theSpecial:SpecialRelationshipBase = GM.main.RS.special[selectedCharID]
		var theChar:BaseCharacter = getCharacter(selectedCharID)
		if(!theChar || !theSpecial):
			return
		playAnimation(StageScene.Duo, "stand", {npc=selectedCharID})
		setCharactersEasyList([selectedCharID])
		sayn("Имя: "+theChar.getName()+" ("+CharacterType.getName(theChar.getCharType())+")")
		var theColor:Color = theSpecial.getCategoryColor()
		sayn("Отношения: [color=#"+theColor.to_html(false)+"]"+theSpecial.getCategoryName()+"[/color]")
		sayn("Местоположение: "+getLocName(selectedCharID))
		saynn(theSpecial.getBigDescription())
		var thePawn:CharacterPawn = GM.main.IS.getPawn(selectedCharID)
		if(thePawn):
			aimCameraAndSetLocName(thePawn.getLocation())
		
		var canMeet:bool = theSpecial.canMeetThroughRelationshipMenu()
		if(canMeet):
			if(thePawn):
				var thePCLoc:String = GM.pc.getLocation()
				var theLoc:String = thePawn.getLocation()
				if(!isOnSameFloor(thePCLoc, theLoc)):
					addDisabledButton("Встретиться", "Вам нужно быть на одном этаже!")
				elif(!thePawn.canBeInterrupted()):
					addDisabledButton("Встретиться", "Они чем-то заняты!")
				elif(!isLocSafe(theLoc)):
					addDisabledButton("Встретиться", "Их местоположение небезопасно!")
				elif(!isLocSafe(thePCLoc)):
					addDisabledButton("Встретиться", "Ваше текущее местоположение небезопасно! Сначала спаситесь от опасности!")
				else:
					addButton("Встретиться", "Иди к ним!", "doMeet")
			else:
				var theLoc:String = GM.pc.getLocation()
				if(!isFloorSafeToMeetAt(theLoc)):
					addDisabledButton("Встретиться", "Вы не можете встретиться с ними на этом этаже!")
				elif(!isLocSafe(theLoc)):
					addDisabledButton("Встретиться", "Твое нынешнее местоположение небезопасно!")
				else:
					addButton("Встретиться", "Иди к ним!", "doMeet")

func isLocSafe(_loc:String) -> bool:
	return GM.world.isLocSafe(_loc)

func isFloorSafeToMeetAt(_loc:String) -> bool:
	return GM.world.canMeetInLoc(_loc)

func isOnSameFloor(_loc1:String, _loc2:String) -> bool:
	var theRoom1:GameRoom = GM.world.getRoomByID(_loc1)
	var theRoom2:GameRoom = GM.world.getRoomByID(_loc2)
	if(!theRoom1 || !theRoom2):
		return false
	return theRoom1.getFloorID() == theRoom2.getFloorID()

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "lookAt"):
		selectedCharID = _args[0]
		setState("relationshipInfo")
		return
	if(_action == "doMeet"):
		if(GM.main.IS.hasPawn(selectedCharID)):
			var thePawn:CharacterPawn = GM.main.IS.spawnPawnIfNeeded(selectedCharID)
			GM.pc.setLocation(thePawn.getLocation())
			GM.main.IS.startInteraction("Talking", {starter="pc", reacter=selectedCharID})
		else:
			var thePawn:CharacterPawn = GM.main.IS.spawnPawnIfNeeded(selectedCharID)
			if(thePawn):
				thePawn.setLocation(GM.pc.getLocation())
				GM.main.IS.startInteraction("Talking", {starter="pc", reacter=selectedCharID})
		
		processTime(5*60)
		endScene()
		return
	
	setState(_action)

func getLocName(theCharID:String) -> String:
	if(GM.main.IS.hasPawn(theCharID)):
		var pawn:CharacterPawn = GM.main.IS.getPawn(theCharID)
		var room = GM.world.getRoomByID(pawn.getLocation())
		if(room == null):
			return "Error.."
		else:
			var floorID:String = room.getFloorID()
			return getFloorName(floorID)+" - "+room.getName()
	return "Resting (Can be met through the Encounters menu)"

static func getFloorName(floorID:String) -> String:
	#var room = GM.world.getRoomByID(loc)
	#var floorID:String = room.getFloorID()
	if(floorID == "Cellblock"):
		return "Cellblock"
	if(floorID == "MainHall"):
		return "Main prison floor"
	if(floorID == "Medical"):
		return "Medical wing"
	if(floorID == "MiningFloor"):
		return "Mining floor"
	
	return "Unknown floor"

func supportsShowingPawns() -> bool:
	return true

func saveData():
	var data = .saveData()
	
	data["selectedCharID"] = selectedCharID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	selectedCharID = SAVE.loadVar(data, "selectedCharID", "")
