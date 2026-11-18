extends SceneBase

var choices:Array = [] # indicies
var extra:Dictionary = {} # id = indx
var selectedExtra:int = 0
var didPlanYourself:bool = false
var lastContext:RecruitContext = RecruitContext.new()

func _init():
	sceneID = "RecruitStartScene"

func _reactInit():
	makeSureChoicesFilled()

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return GM.main.RCS.getRecruit().charID
	if(_charID == "presenter"):
		return GM.main.RCS.getRecruit().getPresenterCharID()

func _run():
	if(!GM.main.RCS.hasCurrent()):
		saynn("ЧТО-ТО ПОШЛО НЕ ТАК, ТЕКУЩИЙ РЕКРУТ ОТСУТСТВУЕТ. ИЗВИНИТЕ.")
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		return
	aimCameraAndSetLocName("hideout_near_break_room")
	
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var _presenterID:String = _recruit.getPresenterCharID()
	var _hasPresenter:bool = !_presenterID.empty()
	if(state == ""):
		if(_hasPresenter):
			addCharacter(_presenterID)
			playAnimation(StageScene.Duo, "stand", {npc=_presenterID})
		else:
			playAnimation(StageScene.Solo, "stand")
		
		saynn("Вы стоите рядом с камерой, где содержится {npc.name}.")
		
		if(_hasPresenter):
			saynn("{presenter.name} охраняет вход.")
		
		saynn("Что будете делать?")
		
		#saynn(_recruit.getHistoryString())
		
		addButton("План", "Составить план и воплотить его в жизнь", "plan")
		addButton("Поговорить", "Поболтать с ними!", "talk")
		if(_recruit.hasHistory()):
			addButton("История", "Попытаться вспомнить свои старые планы", "history_menu")
		addButton("Отойти", "Вы передумали", "stepAway")
	
	if(state == "history_menu"):
		saynn("Вы пытаетесь вспомнить всё, что вы делали с {npc.name}...")
		saynn(_recruit.getHistoryString())
		addButton("Назад", "Назад к планированию", "")
	
	if(state == "plan"):
		sayn("Составить план, который сломает {npc.name} или заставит {npc.him} подчиниться.")
		
		saynn("Сложность: "+RecruitDifficulty.getName(_recruit.difficulty)+" ("+RecruitDifficulty.getDifficultyText(_recruit.difficulty)+")")
		
		var _choices:Array = _recruit.choices
		
		sayn("План:")
		for _i in _choices.size():
			var theChoice:Dictionary = _choices[_i]
			
			var pickedText:String = "Undecided"
			var theOptions:Array = theChoice["options"]
			for _ii in theOptions.size():
				var isSelected:bool = (choices.size() > _i) && (choices[_i] == _ii)
				var theOption:Array = theOptions[_ii]
				#var finalButtonIndx:int = baseButtonIndx + _ii*5
				
				if(isSelected):
					pickedText = theOption[1] + "\n - "+theOption[2]+""
			
			sayn(str(_i+1)+") "+theChoice["name"]+": "+pickedText)
		sayn("")
		
		var theExtras:Array = getExtras()
		if(!theExtras.empty()):
			sayn("Дополнительно:")
		var _ei:int = 0
		for theExtraEntry in theExtras:
			var theID:String = theExtraEntry["id"]
			
			if(extra.has(theID)):
				var theOption:Array = theExtraEntry["options"][extra[theID]]
				sayn(theExtraEntry["name"]+": "+theOption[1]+"\n - "+theOption[2])
			else:
				sayn(theExtraEntry["name"]+": Не определено")
			_ei += 1
		if(!theExtras.empty()):
			sayn("")
		
		for _i in _choices.size():
			var theChoice:Dictionary = _choices[_i]
			addExtraButtonAt(_i, theChoice["name"]+":", theChoice["desc"], "pickNextOption", [_i])
			
			var baseButtonIndx:int = _i
			var theOptions:Array = theChoice["options"]
			for _ii in theOptions.size():
				var isSelected:bool = (choices.size() > _i) && (choices[_i] == _ii)
				var theOption:Array = theOptions[_ii]
				var finalButtonIndx:int = baseButtonIndx + _ii*5
				
				if(!isSelected):
					addButtonAt(finalButtonIndx, theOption[1], theOption[2], "setOption", [_i, _ii])
				else:
					addDisabledButtonAt(finalButtonIndx, "["+theOption[1]+"]", "(Selected)\n" + theOption[2])
		
		_ei = 0
		for theExtraEntry in theExtras:
			var theID:String = theExtraEntry["id"]
			
			if(extra.has(theID)):
				var theOption:Array = theExtraEntry["options"][extra[theID]]
				addButton(theOption[1], theOption[2], "extraMenu", [_ei])
			else:
				addButton(theExtraEntry["name"], theExtraEntry["desc"], "extraMenu", [_ei])
			_ei += 1
		
		if(areChoicesFilled()):
			var theCanStart:Array = _recruit.isCombinationPossibleFinal(getChoicesIDs(), extra)
			if(theCanStart[0]):
				addButtonAt(9, "START", "Execute the plan!", "readyToDoPlan")
			else:
				saynn("[color=yellow]Текущий план невыполним[/color]: "+theCanStart[1])
		addButtonAt(14, "Cancel", "You changed your mind!", "")
		
		#saynn(_recruit.getHistoryString())
	
	if(state == "readyToDoPlan"):
		saynn("Вы подготовили план.")
		var thePresenterName:String = getCharacter(_recruit.getPresenterCharID()).getName()
		if(_hasPresenter):
			saynn("[say="+_recruit.getPresenterCharID()+"]"+_recruit.getPresenterDialogue()+"[/say]")
		addButton("Понял", "Сделать план самому", "startThePlan")
		addButton(thePresenterName, "(Пропустить сцену) Пусть "+thePresenterName+" выполнит план, чтобы тебе не пришлось на это смотреть", "helperStartsThePlan")
	
	if(state == "extraMenu"):
		saynn("Выбери, как хочешь поступить! Дополнительные варианты не влияют на результат.")
		
		addButton("Назад", "Вы передумали", "plan")
		var theExtras:Array = getExtras()
		var theExtra:Dictionary = theExtras[selectedExtra]
		
		sayn(theExtra["name"])
		
		var theOptions:Array = theExtra["options"]
		var _i:int = 0
		for theOption in theOptions:
			addButton(theOption[1], theOption[2], "pickExtra", [_i])
			sayn(str(_i+1)+") "+theOption[1]+"\n - "+theOption[2])
			_i += 1
	
	if(state == "afterPlan"):
		if(_hasPresenter):
			playAnimation(StageScene.Duo, "stand", {npc=_presenterID})
		else:
			playAnimation(StageScene.Solo, "stand")
		aimCameraAndSetLocName("hideout_near_break_room")
		sayn("План выполнен.")
		saynn("Сложность: "+RecruitDifficulty.getName(_recruit.difficulty)+" ("+RecruitDifficulty.getDifficultyText(_recruit.difficulty)+")")
		
		saynn(_recruit.getColorStringForChoices(lastContext.choiceIDs))
		
		if(lastContext.perfect):
			saynn("Все прошло идеально!")
		elif(lastContext.success):
			saynn("Успех! Не всё было безупречно, но вполне сойдет.")
		else:
			saynn("Было не совсем так...")
		
		# Start the next story scene
		# If replay more, just end it?
		if(GM.main.RCS.isReplayMode()):
			addButton("Продолжить", "Хватит веселиться", "continueAfterSuccess")
		elif(lastContext.success):
			addButton("Продолжить", "Смотреть, что будет дальше", "continueAfterSuccess")
		addButton("Попробовать снова", "Попробуй другой план!", "")
	
	if(state == "helperDoesThings"):
		playAnimation(StageScene.Solo, "stand")
		saynn("Ты приказываешь {presenter.name} приступить к выполнению плана.")
		
		saynn("Спустя некоторое время {presenter.he} возвращается...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "afterPlan")
	
	if(state == "afterTalked"):
		aimCameraAndSetLocName("hideout_near_break_room")
		if(_hasPresenter):
			addCharacter(_presenterID)
			playAnimation(StageScene.Duo, "stand", {npc=_presenterID})
		else:
			playAnimation(StageScene.Solo, "stand")
		saynn("Разговор с {npc.name} окончен!")
		addButton("Продолжить", "Смотреть, что будет дальше", "")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "stepAway"):
		var _recruit:RecruitBase = GM.main.RCS.getRecruit()
		if(GM.main.RCS.isReplayMode()):
			GM.main.RCS.clearCurrent()
		endScene()
		return
	if(_action == "continueAfterSuccess"):
		if(GM.main.RCS.isReplayMode()):
			GM.main.RCS.clearCurrent()
			endScene()
			return
		var _recruit:RecruitBase = GM.main.RCS.getRecruit()
		var theStorySceneID:String = _recruit.getStorySceneSuccess()
		GM.main.RCS.clearCurrent()
		endScene()
		runScene(theStorySceneID)
		return
	if(_action == "setOption"):
		choices[_args[0]] = _args[1]
		checkExtras()
		return
	if(_action == "extraMenu"):
		selectedExtra = _args[0]
	if(_action == "pickExtra"):
		extra[getExtras()[selectedExtra]["id"]] = _args[0]
		setState("plan")
		return
	if(_action == "pickNextOption"):
		choices[_args[0]] += 1
		var _recruit:RecruitBase = GM.main.RCS.getRecruit()
		var _choices:Array = _recruit.choices
		if(choices[_args[0]] >= _choices[_args[0]]["options"].size()):
			choices[_args[0]] = 0
		checkExtras()
		return
	
	if(_action == "talk"):
		aimCameraAndSetLocName("hideout_breakroom")
		var _recruit:RecruitBase = GM.main.RCS.getRecruit()
		runScene(_recruit.getTalkScene())
		setState("afterTalked")
		return
	
	if(_action == "startThePlan" || _action == "helperStartsThePlan"):
		didPlanYourself = (_action == "startThePlan")
		var _recruit:RecruitBase = GM.main.RCS.getRecruit()
		var theContext:RecruitContext = _recruit.createContext(getChoicesIDs(), getExtraWithIDs())
		var theSceneID:String = _recruit.getSceneToPlay(getChoicesIDs(), getExtraWithIDs())
		GM.main.RCS.submitContext(theContext)
		if(didPlanYourself):
			aimCameraAndSetLocName("hideout_breakroom")
			runScene(theSceneID, [theContext], "planScene")
			setState("afterPlan")
		else:
			setState("helperDoesThings")
			
		lastContext = theContext
		return
	
	setState(_action)

func makeSureChoicesFilled():
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var _choices:Array = _recruit.choices
	
	while(choices.size() < _choices.size()):
		choices.append(-1)
	while(choices.size() > _choices.size()):
		choices.pop_back()

func areChoicesFilled() -> bool:
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var _choices:Array = _recruit.choices
	if(_choices.size() != choices.size()):
		return false
	for theChoice in choices:
		if(theChoice < 0):
			return false
	return true

func getChoicesIDs() -> Array:
	var result:Array = []
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var _choices:Array = _recruit.choices
	var _i:int = 0
	for choiceIndx in choices:
		result.append(_choices[_i]["options"][choiceIndx][0])
		_i += 1
	return result

func getExtraWithIDs() -> Dictionary:
	var result:Dictionary = {}
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var theExtras := getExtras()
	
	for theExtra in theExtras:
		var theID:String = theExtra["id"]
		if(!extra.has(theID)):
			continue
		
		result[theID] = theExtra["options"][extra[theID]][0]
	
	return result

func getExtras() -> Array:
	if(!areChoicesFilled()):
		return []
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	return _recruit.getExtraChoices(getChoicesIDs(), extra)

func checkExtras():
	var _recruit:RecruitBase = GM.main.RCS.getRecruit()
	var _choices:Array = _recruit.choices
	if(!areChoicesFilled()):
		extra.clear()
		return
#	var extraChoices:Array = getExtras()
#	for theChoiceEntry in extraChoices:
#		var theId:String = theChoiceEntry["id"]
#		if(!extra.has(theId)):
#			extra[theId] = 0#theChoiceEntry["options"][0][0]

func saveData():
	var data = .saveData()
	
	data["selectedExtra"] = selectedExtra
	data["choices"] = choices
	data["extra"] = extra
	data["didPlanYourself"] = didPlanYourself
	data["lastContext"] = lastContext.saveData()

	return data

func loadData(data):
	.loadData(data)

	selectedExtra = SAVE.loadVar(data, "selectedExtra", 0)
	choices = SAVE.loadVar(data, "choices", [])
	extra = SAVE.loadVar(data, "extra", {})
	didPlanYourself = SAVE.loadVar(data, "didPlanYourself", false)
	lastContext.loadData(SAVE.loadVar(data, "lastContext", {}))
	
	makeSureChoicesFilled()
