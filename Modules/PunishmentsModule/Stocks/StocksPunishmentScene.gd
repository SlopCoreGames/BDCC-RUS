extends "res://Scenes/SceneBase.gd"

var amountOfEventsPassed = 0

func _init():
	sceneID = "StocksPunishmentScene"

func _reactInit():
	GM.pc.getInventory().forceEquipRemoveOther(GlobalRegistry.createItem("StocksStatic"))

func _run():
	if(state == ""):
		playAnimation(StageScene.Stocks, "idle")
		GM.pc.setLocation("main_punishment_spot")
		aimCamera("main_punishment_spot")
		
		saynn("Ты зажат в колодах, и почти ничего не можешь с этим поделать. Движения твоей головы и рук скованы гигантской металлической рамой с тремя отверстиями; из-за её наклона тебе приходится постоянно стоять, сильно наклонившись вперед, выставляя задницу напоказ. Лодыжки скованы цепями, так что и ими особо не пошевелишь. Ты абсолютно беспомощен.")

		saynn("Всё, что тебе остается — это ждать, пока мимо проходят заключенные и персонал, занятые своими делами. Хотя некоторые смотрят на тебя с любопытством.")

		addButton("Подождать", "Вести себя тихо и попытаться отдохнуть (С тобой могут что-то сделать, но тебя никогда не трахнут против воли)", "wait")
		addButton("Шуметь", "Попросить освободить тебя. Возможно, ты получишь не совсем то внимание, на которое рассчитываешь (Может случиться что угодно)", "be_loud")
		addButton("Сопротивление", "Может, получится как-нибудь сбежать", "struggle")
		if(!GM.pc.getInventory().hasLockedStaticRestraints()):
			addButton("Побег", "Сладкая свобода!", "endthescene")
		else:
			addDisabledButton("Побег", "Пока колоды заперты, сбежать невозможно")

	if(state == "wait"):
		saynn("Ты решаешь вести себя тихо. Тебя заставляют стоять в неудобной позе — это унизительно, но зато можно немного отдохнуть.")
		
		addButton("Продолжить", "Что теперь?", "afterjustwait")


	if(state == "be_loud"):
		# (if not blindfolded)
		if(!GM.pc.isBlindfolded()):
			saynn("Ты оглядываешься по сторонам, насколько это позволяют оковы, и громко умоляешь о помощи.")

		# (if blindfolded)
		else:
			saynn("Ты не особо понимаешь, есть ли кто-то рядом, но всё равно умоляешь.")

		saynn("[say=pc]"+RNG.pick([
			"Кто-нибудь, помогите мне!",
			"Кто-нибудь, пожалуйста, освободите меня.",
			"Я застряла здесь, кто-нибудь может помочь?",
			"Я не могу пошевелиться, я застряла.",
			"Поможете немножко?",
		])+"[/say]")

		# (forced random interaction)

		addButton("Продолжить", "Посмотреть, что будет", "afterbeloud")

	if(state == "sleeping"):
		saynn("Кажется, вокруг никого нет, уже очень поздно. Огни вокруг начинают гаснуть один за другим. Ого, неужели о тебе забыли?")
		
		saynn("Похоже, спать придётся вот так — зажатым в колодах.")
		
		addButton("Спать", "Ну и ладно", "aftersleep")

	if(state == "aftersleep"):
		saynn("Ты просыпаешься вовремя, как и все остальные, но с одной разницей: ты всё ещё скован в колодах.")

		saynn("Добро пожаловать в "+str(GM.main.getDays())+" твоего срока")
		
		addButton("Продолжить", "Что дальше?", "")

func triggerRandomEvent(escapeChance, _lewdChance, _willingSexChance, _unWillingSexChance, _nothingChance):
	var eventType = RNG.pickWeighted(["StocksEscape", "StocksEvent", "StocksWillingSex", "StocksUnWillingSex", ""], [escapeChance, _lewdChance, _willingSexChance, _unWillingSexChance, _nothingChance])
	
	if(eventType == "StocksEscape"):
		if(GM.ES.triggerReact("StocksEscape")):
			endScene()
			return true
	
	if(eventType == "StocksEvent"):
		if(GM.ES.triggerReact("StocksEvent")):
			return true

			
	if(eventType == "StocksWillingSex"):
		if(GM.ES.triggerReact("StocksWillingSex")):
			return true
			
	if(eventType == "StocksUnWillingSex"):
		if(GM.ES.triggerReact("StocksUnWillingSex")):
			return true
	
	return false

func getEscapeChance(isLoud = false):
	if(amountOfEventsPassed < 10):
		return 0.0
	if(amountOfEventsPassed > 40):
		return 10.0
		
	if(isLoud):
		return max(3.0, amountOfEventsPassed / 8.0)
		
	return max(2.0, amountOfEventsPassed / 10.0)

func _react(_action: String, _args):
	if(_action == "aftersleep"):
		GM.main.startNewDay()
		GM.pc.afterSleeping()
		GM.main.showLog()
	
	if(_action == "wait" || _action == "be_loud"):
		processTime(60*30)
		if(GM.main.isVeryLate()):
			setState("sleeping")
			return

	
	if(_action == "afterbeloud"):
		GM.pc.addStamina(50)
		triggerRandomEvent(getEscapeChance(true), 20, 30, 30, 30)
		setState("")
		GM.main.showLog()
		amountOfEventsPassed += 1
		return
	
	if(_action == "afterjustwait"):
		GM.pc.addStamina(50)
		triggerRandomEvent(getEscapeChance(), 20, 20, 0, 50)
		setState("")
		GM.main.showLog()
		amountOfEventsPassed += 1
		return
	
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "struggle"):
		runScene("StrugglingScene", [false, false])
		setState("")
		return
	
	setState(_action)

func _onSceneEnd():
	GM.pc.getInventory().clearStaticRestraints()


func saveData():
	var data = .saveData()
	
	data["amountOfEventsPassed"] = amountOfEventsPassed
	
	return data
	
func loadData(data):
	.loadData(data)
	
	amountOfEventsPassed = SAVE.loadVar(data, "amountOfEventsPassed", 0)

func getDebugActions():
	return [
		{
			"id": "instantEscape",
			"name": "Мгновенный побег",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "instantEscape"):
		endScene()
		GM.main.reRun()
