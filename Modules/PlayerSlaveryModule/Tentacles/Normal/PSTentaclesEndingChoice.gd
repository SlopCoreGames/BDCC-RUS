extends SceneBase

var biggestStat = -1
var nomoretime = false

func _init():
	sceneID = "PSTentaclesEndingChoice"

func _initScene(_args = []):
	nomoretime = _args[0] if _args.size() > 0 else true

func _reactInit():
	addCharacter(GM.main.PS.getTentaclesCharID())

func resolveCustomCharacterName(_charID):
	if(_charID == "ten"):
		return GM.main.PS.getTentaclesCharID()
	if(_charID == "sci1"):
		return GM.main.PS.getScientist1CharID()
	if(_charID == "sci2"):
		return GM.main.PS.getScientist2CharID()

func _run():
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(state == ""):
		biggestStat = _tentacles.getBiggestStat()
		if (!nomoretime):
			saynn("Вы приближаетесь к {psTentacles}..")

		else:
			saynn("Времени на что-либо с щупальцами почти не осталось.. Ученые вот-вот вернутся.")

			saynn("Вы приближаетесь к {psTentacles}.. Пора сделать свой окончательный выбор..")

		if (biggestStat == _tentacles.STAT_ANGER):
			saynn("Щупальца выглядят очень разъяренными. Их кончики буквально сверлят вас взглядом.")

		elif (biggestStat == _tentacles.STAT_AGILITY):
			saynn("Щупальца выглядят очень активными, все отростки нетерпеливо колышутся.")

		elif (biggestStat == _tentacles.STAT_MIND):
			saynn("Щупальца выглядят немного меланхолично, все отростки понуро покачиваются.")

		else:
			saynn("Щупальца выглядят очень похотливыми. Их кончики все блестят от соков.")

		saynn("Инъектор всё еще у вас. Что вы хотите сделать?")

		if (!nomoretime):
			addButton("Проехали", "Вы пока не хотите ничего делать", "endthescene")
		else:
			addDisabledButton("Проехали", "Это больше не вариант..")
		addButton("Впрыснуть щупальца", "Впрыснуть в щупальца состав, превращающий их в безмозглое растение", "do_inject")
		if (_tentacles.getStat(_tentacles.STAT_ANGER) >= 10 && _tentacles.getStat(_tentacles.STAT_AGILITY) >= 10):
			addButton("Кровавая баня", "Ваши щупальца настолько разъярены и сильны, что вы можете приказать им перерезать всех вокруг!", "ending_angeragility")
		else:
			addDisabledButton("Кровавая баня", "Вашим щупальцам либо не хватает ярости (Ярость "+str(_tentacles.anger)+"/10), либо не хватает силы (Ловкость "+str(_tentacles.agility)+"/10)")
		if (_tentacles.getStat(_tentacles.STAT_ANGER) >= 10 && _tentacles.getStat(_tentacles.STAT_MIND) >= 10):
			addButton("Кукловод", "Ваши щупальца настолько разъярены и умны, что вы можете приказать им перерезать всех вокруг!", "ending_angermind")
		else:
			addDisabledButton("Кукловод", "Вашим щупальцам либо не хватает ярости (Ярость "+str(_tentacles.anger)+"/10) или недостаточно сообразительны (Интеллект "+str(_tentacles.mind)+"/10)")
		if (_tentacles.getStat(_tentacles.STAT_ANGER) >= 10 && _tentacles.getStat(_tentacles.STAT_LUST) >= 10):
			addButton("Размножение", "Твои щупальца настолько разъярены и полны похоти, что ты можешь приказать им трахать всех подряд!", "ending_angerlust")
		else:
			addDisabledButton("Размножение", "Вашим щупальцам либо не хватает ярости (Ярость "+str(_tentacles.anger)+"/10) или недостаточно похотливы (Похоть "+str(_tentacles.lust)+"/10)")
		if (_tentacles.getStat(_tentacles.STAT_AGILITY) >= 10 && _tentacles.getStat(_tentacles.STAT_MIND) >= 10):
			addButton("Тихий побег", "Твои щупальца достаточно сильны и умны, чтобы попытаться незаметно сбежать из этой биолаборатории...", "ending_agilitymind")
		else:
			addDisabledButton("Тихий побег", "Твоим щупальцам либо не хватает силы (Ловкость "+str(_tentacles.agility)+"/10) или не хватает ума (Интеллект "+str(_tentacles.mind)+"/10)")
		if (_tentacles.getStat(_tentacles.STAT_AGILITY) >= 10 && _tentacles.getStat(_tentacles.STAT_LUST) >= 10):
			addButton("Охотиться и ловить", "Твои щупальца настолько сильны и похотливы, что ты можешь заставить их вырваться на свободу, трахая всех подряд!", "ending_agilitylust")
		else:
			addDisabledButton("Охотиться и ловить", "Твоим щупальцам либо не хватает силы (Ловкость "+str(_tentacles.agility)+"/10) или недостаточно похотливы (Похоть "+str(_tentacles.lust)+"/10)")
		if (_tentacles.getStat(_tentacles.STAT_MIND) >= 10 && _tentacles.getStat(_tentacles.STAT_LUST) >= 10):
			addButton("Рабы удовольствий", "Твои щупальца достаточно умны и похотливы, чтобы подчинить разум каждого и превратить их в секс-рабов!", "ending_mindlust")
		else:
			addDisabledButton("Рабы удовольствий", "Твои щупальца либо недостаточно умны (Разум "+str(_tentacles.mind)+"/10) или недостаточно похотливы (Похоть "+str(_tentacles.lust)+"/10)")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_inject"):
		endScene()
		runScene("PSTentaclesInjectEnding")
		return

	if(_action == "ending_angeragility"):
		endScene()
		runScene("PSTentaclesEndingAngerAgility")
		return

	if(_action == "ending_angermind"):
		endScene()
		runScene("PSTentaclesEndingAngerMind")
		return

	if(_action == "ending_angerlust"):
		endScene()
		runScene("PSTentaclesEndingAngerLust")
		return

	if(_action == "ending_agilitymind"):
		endScene()
		runScene("PSTentaclesEndingAgilityMind")
		return

	if(_action == "ending_agilitylust"):
		endScene()
		runScene("PSTentaclesEndingAgilityLust")
		return

	if(_action == "ending_mindlust"):
		endScene()
		runScene("PSTentaclesEndingMindLust")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["biggestStat"] = biggestStat
	data["nomoretime"] = nomoretime

	return data

func loadData(data):
	.loadData(data)

	biggestStat = SAVE.loadVar(data, "biggestStat", -1)
	nomoretime = SAVE.loadVar(data, "nomoretime", false)
