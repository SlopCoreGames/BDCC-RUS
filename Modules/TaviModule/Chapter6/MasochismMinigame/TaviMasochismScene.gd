extends SceneBase

var minigame = null

func _init():
	sceneID = "TaviMasochismScene"
	
	minigame = preload("res://Modules/TaviModule/Chapter6/MasochismMinigame/MasochismMinigame.gd").new()

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		addCharacter("tavi")
		
		saynn("В этой мини-игре тебе нужно довести уровень боли Тави до точного целевого значения, используя доступные тебе действия.")
		
		saynn("В зависимости от сложности, тебе будут доступны разные действия.")
		
		saynn("Мини-игра закончится после определенного количества ходов или если уровень боли Тави будет превышать целевое значение более одного хода.")
		
		saynn("Выберите сложность")
		var masochismScore = getModule("TaviModule").getSkillScore("taviSkillMasochism")
		var difficulties = minigame.getAllDifficulties()
		for _i in range(difficulties.size()): #masochismScore+1
			if(masochismScore >= _i || _i == 0):
				var difficulty = difficulties[_i]
				addButton(str(_i+1)+". "+difficulty["name"], "Выбрать эту сложность", "start", [_i])
			else:
				var difficulty = difficulties[_i]
				addDisabledButton(str(_i+1)+". "+difficulty["name"], "Повысить навык мазохизма Тави")
		
	if(state == "failturns"):
		saynn("Тебе не удалось довести боль Тави до нужного уровня за отведенное количество ходов.")
	if(state == "failsafeword"):
		saynn("Тави шипит, подавая знак, что ей слишком больно. Ты останавливаешься, прежде чем причинить ей реальный вред.")
		
	if(state in ["failsafeword", "failturns"]):
		addButton("Попробовать снова", "Сбросить мини-игру", "tryagain")
		addButton("Сдаться", "Не стоит того", "endthescene")
	
	if(state == "playing"):
		# Show the text of the previous action
		addButtonAt(13, "Give up", "Not worth it", "endthescene")
		addButtonAt(14, "Try again", "Reset the minigame", "tryagain")
	
	if(state == "youwon"):
		saynn("Успех!")
		
		# Replace with continue
		#addButton("Попробовать снова", "Сбросить мини-игру", "tryagain")
		#addButton("Сдаться", "Не стоит того", "endthescene")
		addButton("Продолжить", "Смотреть, что будет дальше", "start_outcome")
	
	if(state in ["playing", "failturns", "failsafeword", "youwon"]):
		saynn(minigame.getLastText())
		
		var animData = minigame.getAnimation()
		if(animData.size() >= 3):
			playAnimation(animData[0], animData[1], animData[2])
		
		sayn("Целевая боль: "+str(Util.roundF(minigame.targetPain, 1)))
		sayn("Текущая боль Тави: "+str(Util.roundF(minigame.pain, 1)))
		if(minigame.air > 0):
			sayn("Запас воздуха Тави: "+str((5 - minigame.air)*20)+"%")
		sayn("")
		saynn("Осталось действий: "+str(minigame.actionsLeft))
		var currentEffects = minigame.getEffectsReadable()
		if(currentEffects.size() > 0):
			sayn("Текущие эффекты:")
			for effect in currentEffects:
				sayn(effect)
			sayn("")
		
		sayn("Доступные действия:")
		var currentActions = minigame.getActionsReadable()
		for actionID in currentActions:
			var action = currentActions[actionID]
			
			sayn(action["name"]+": "+action["shortdesc"])
			if(state == "playing"):
				addButton(action["name"], action["desc"], "doAction", [actionID])
		sayn("")
	

		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "start"):
		minigame.startDifficulty(_args[0])
		setState("playing")
		return

	if(_action == "doAction"):
		processTime(60)
		minigame.doAction(_args[0])
		if(minigame.shouldEndSuccess):
			#print("shouldEndSuccess")
			# Run scene
			setState("youwon")
			getModule("TaviModule").advanceSkill("taviSkillMasochism")
			return
		if(minigame.shouldEndFail):
			#print("shouldEndFail")
			setState("failturns")
			return
		if(minigame.shouldSafeWord):
			#print("shouldSafeWord")
			setState("failsafeword")
		if(minigame.shouldEndUnconscious):
			#print("shouldEndUnconscious")
			# run scene
			endScene()
			runScene("TaviMasochismUnconsciousScene")
			return
		return

	if(_action == "start_outcome"):
		runScene("TaviMasochismOutcomesScene", [minigame.shouldPlayStateOnWin])
		endScene()
		return

	if(_action == "tryagain"):
		minigame.tryAgain()
		setState("playing")
		return

	setState(_action)



func saveData():
	var data = .saveData()

	data["minigame"] = minigame.saveData()

	return data

func loadData(data):
	.loadData(data)

	minigame.loadData(SAVE.loadVar(data, "minigame", {}))
