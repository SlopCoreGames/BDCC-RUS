extends "res://Scenes/SceneBase.gd"

var npcID = ""

func _init():
	sceneID = "EnslaveDynamicNpcScene"

func _initScene(_args = []):
	npcID = _args[0]
	#var npc = GlobalRegistry.getCharacter(npcID)
	
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

	if(state == ""):
		#var npc = GlobalRegistry.getCharacter(npcID)
		saynn("Хочешь попробовать поработить {npc.name}?")
		
		saynn("Сначала тебе придется сломить дух {npc.his} и показать {npc.him}, где её {npc.his} место.")
		
		saynn("После этого тебе понадобится достаточно места в камере, чтобы разместить там {npc.him}.")
		
		saynn("Каким рабом ты хочешь видеть {npc.him}?")

		for slaveTypeID in GlobalRegistry.getSlaveTypes():
			var theSlaveType:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveTypeID)
			if(!theSlaveType.canEnslaveAs()):
				continue
			if(!theSlaveType.canTeach(getCharacter(npcID))):
				addDisabledButton(theSlaveType.getVisibleName(), "[color=red]Несовместимо с этой рабыней[/color]\n"+theSlaveType.getVisibleDesc())
				continue
			addButton(theSlaveType.getVisibleName(), theSlaveType.getVisibleDesc(), "try_enslave", [slaveTypeID])
		
		addButton("CANCEL", "Вы передумали", "endthescene")
		
	if(state == "try_enslave"):
		playAnimation(StageScene.Choking, "idle", {npc=npcID})
		
		var theChar:DynamicCharacter = getCharacter(npcID)
		var enslaveQuest:NpcEnslavementQuest = theChar.getEnslaveQuest()
		var theSlaveTypeID = enslaveQuest.slaveType
		var theSlaveType:SlaveTypeBase = GlobalRegistry.getSlaveType(theSlaveTypeID)
		if(theSlaveType != null):
			saynn(theSlaveType.getEnslaveText(theChar))
		
		saynn("Пристально взглянув на {npc.him}, ты начинаешь лучше понимать, как именно надломить {npc.his} дух.")
		
		sayn("Вот что тебе нужно сделать (прогресс можно отслеживать в статусе личности):")

		saynn(enslaveQuest.getQuestStartText())
		
		addButton("Продолжить", "Что ж, пора приступать к делу", "endthescene")
		addButton("Придушить их", "(Переброс) Спросить еще раз вежливо", "try_enslave_choke")
		addButton("CANCEL", "Вы передумали", "stopquest_endthescene")
	
	if(state == "try_enslave_choke"):
		playAnimation(StageScene.Choking, "choke", {npc=npcID})
		
		saynn("Ты душишь {npc.him}, и это немного меняет дело.")
		
		sayn("Вот что тебе нужно сделать (прогресс можно отслеживать в статусе личности):")
		
		var theChar:DynamicCharacter = getCharacter(npcID)
		var enslaveQuest:NpcEnslavementQuest = theChar.getEnslaveQuest()
		saynn(enslaveQuest.getQuestStartText())
		
		addButton("Продолжить", "Что ж, пора приступать к делу", "endthescene")
		addButton("Сжимай сильнее", "(Переброс) Спросить еще более вежливо", "try_enslave_chokeevenmore")
		addButton("CANCEL", "Вы передумали", "stopquest_endthescene")
		
	if(state == "try_enslave_chokeevenmore"):
		playAnimation(StageScene.Choking, "hard", {npc=npcID})
		
		saynn("Ты так сильно душишь {npc.him}, что {npc.he} {npc.isAre} почти теряет сознание.")
		
		sayn("Вот что тебе нужно сделать (прогресс можно отслеживать в статусе личности):")
		
		var theChar:DynamicCharacter = getCharacter(npcID)
		var enslaveQuest:NpcEnslavementQuest = theChar.getEnslaveQuest()
		saynn(enslaveQuest.getQuestStartText())
		
		addButton("Продолжить", "Что ж, пора приступать к делу", "endthescene")
		addButton("CANCEL", "Вы передумали", "stopquest_endthescene")
		# Cancel quest button here?
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "stopquest_endthescene"):
		var theChar:DynamicCharacter = getCharacter(npcID)
		theChar.setEnslaveQuest(null)
		addMessage("You stopped trying to enslave "+theChar.getName())
		endScene()
		return
	
	if(_action == "try_enslave"):
		var theChar:DynamicCharacter = getCharacter(npcID)
		var newEnslaveQuest = NpcEnslavementQuest.new()
		newEnslaveQuest.setChar(theChar)
		newEnslaveQuest.setSlaveType(_args[0])
		newEnslaveQuest.generateTasks()
		theChar.setEnslaveQuest(newEnslaveQuest)
		GM.main.RS.sendSocialEvent("pc", npcID, SocialEventType.BeganGettingEnslaved)

	if(_action in ["try_enslave_choke", "try_enslave_chokeevenmore"]):
		var theChar:DynamicCharacter = getCharacter(npcID)
		if(theChar.hasEnslaveQuest()):
			var theEnslaveQuest = theChar.getEnslaveQuest()
			theEnslaveQuest.generateTasks()

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")


func getDebugActions():
	return [
		{
			"id": "quickEnslave",
			"name": "Quick Enslave",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "quickEnslave"):
		endScene()
		runScene("KidnapDynamicNpcScene", [npcID])
		GM.main.reRun()
