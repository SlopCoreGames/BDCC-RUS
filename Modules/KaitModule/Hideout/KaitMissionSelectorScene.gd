extends SceneBase

func _init():
	sceneID = "KaitMissionSelectorScene"

func sayMissionInfo(theMission:MissionBase, _isHistory:bool = false):
	sayn("Имя: [b] "+theMission.getName()+"[/b]")
	sayn("Описание: "+theMission.getDescription())
	
	var rewardStr:String = theMission.getRewardString()
	if(!rewardStr.empty()):
		sayn("Награда: "+rewardStr)
	if(_isHistory):
		var theChoices:Array = GM.main.MS.getDecisionsStrings(theMission.id)
		if(!theChoices.empty()):
			sayn("Решения:")
			sayn(Util.join(theChoices, "\n"))
	sayn("")

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Ты стоишь перед импровизированной доской заданий. Кейт стоит неподалеку. Что будешь делать?")

		#addButtonAt(9, "Kait", "Talk with the snow leopard", "endthescene")
		addButtonAt(9, "История", "Взгляни на историю своих миссий!", "history_menu")
		addButtonAt(14, "Отойти", "Вы передумали", "endthescene")
		
		saynn("[b]=== Миссии ====[/b]")
		
		var theMainMissions:Array = GM.main.MS.getAllPossibleMainMissions()
		if(theMainMissions.empty()):
			saynn("Основных миссий больше нет! Жди, пока разработчик добавит новые...")
		
		var _i:int = 1
		for theMission in theMainMissions:
			sayMissionInfo(theMission)
			addButton(theMission.getName(), "Начать эту миссию!", "startMission", [theMission.id])
			_i += 1
		
		var theSideMissions:Array = GM.main.MS.getAllPossibleSideMissions()
		if(!theSideMissions.empty()):
			saynn("[b]=== Побочные миссии ====[/b]")
			_i = 1
			for theMission in theSideMissions:
				sayMissionInfo(theMission)
				addButton(theMission.getName(), "Начать эту побочную миссию!", "startMission", [theMission.id])
				_i += 1
		
		sayn("[b]Статы[/b]")
		var theStats:Array = GM.main.MS.getMissionStats()
		saynn(Util.join(theStats, "\n"))
	
	if(state == "history_menu" || state == "replay_menu"):
		var _isReplay:bool = (state == "replay_menu")
		addButton("Назад", "Назад в предыдущее меню", "")
		saynn("[b]=== История ====[/b]")
		
		var theMainMissions:Array = GM.main.MS.getAllCompletedMainMissions()
		#if(theMainMissions.empty()):
		#	saynn("Миссий больше нет! Ждите, пока разработчик добавит новые..")
		
		var _i:int = 1
		for theMission in theMainMissions:
			sayMissionInfo(theMission, true)
			if(_isReplay):
				addButton(theMission.getName(), "Начать эту миссию!", "replayMission", [theMission.id])
			_i += 1
		
		var theSideMissions:Array = GM.main.MS.getAllCompletedSideMissions()
		if(!theSideMissions.empty()):
			saynn("[b]=== Побочные миссии ====[/b]")
			_i = 1
			for theMission in theSideMissions:
				sayMissionInfo(theMission, true)
				if(_isReplay):
					addButton(theMission.getName(), "Начать эту побочную миссию!", "replayMission", [theMission.id])
				_i += 1
		
		if(!_isReplay):
			addButton("Переиграть миссию", "Выберите миссию, которую хотите переиграть", "replay_menu")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "startMission"):
		endScene()
		GM.main.MS.startMission(_args[0])
		return
	if(_action == "replayMission"):
		endScene()
		GM.main.MS.startMission(_args[0], true, true, true)
		return

	setState(_action)

func getDebugActions():
	return [
	{
	"id": "completeNext",
	"name": "Выполнить следующее основное задание",
	"args": [
	],
	},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "completeNext"):
		GM.main.MS.autoCompleteNextMainMission()
