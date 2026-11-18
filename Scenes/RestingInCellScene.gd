extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "RestingInCellScene"

func _reactInit():
	GM.main.MRH.checkCanRestart()

func _run():
	if(state == ""):
		playAnimation(StageScene.Sleeping, "sleep")
		
		saynn("Ты ложишься на жесткую тюремную койку и устало вздыхаешь.")
		
		saynn("Что будете делать?")

		addButton("Встать", "Некогда отдыхать", "endthescene")

		addButton("Спать", "Спать до следующего дня, чтобы восстановить выносливость", "gosleep")

		var currentTime = GM.main.getTime()
		for t in [8, 10, 12, 14, 16, 18, 20, 22]:
			if(currentTime < t*60*60):
				addButton("Отдых до %02d:00" % [t], "Проснуться, когда наступит %02d:00" % [t], "restuntil", [t])
			else:
				addDisabledButton("Отдых до %02d:00" % [t], "На сегодня уже поздно")
		
		if(GM.main.MRH.canRestartMainRoute()):
			addExtraButtonAt(4, "Reset Main Route", "Reset the main route progress, allowing you to start another route if you want to!", "startReset")
		
	if(state == "rested"):
		saynn("Ты проводишь некоторое время в камере. Усталость немного отступает.")
		
		addButton("Продолжить", "Пора просыпаться", "endthescene")
		
	if(state == "slept"):
		playAnimation(StageScene.Sleeping, "sleep", {bodyState={naked=true}})
		
		saynn("Ты поспал в своей камере. Не самое приятное занятие, но тебе удалось восстановить силы.")
		
		saynn("Ты просыпаешься, когда во всей тюрьме начинают зажигаться огни.")
		
		saynn("Добро пожаловать в "+str(GM.main.getDays())+" день твоего срока.")
		
		addButton("Продолжить", "Пора просыпаться", "endthesceneandtriggerevents")
		
		GM.ES.triggerRun(Trigger.WakeUpInCell)

func _react(_action: String, _args):
	if(_action == "restuntil"):
		var newt = _args[0]
		
		var timePassed = GM.main.processTimeUntil(newt * 60 * 60)
		GM.pc.afterRestingInBed(timePassed)
		
		if(GM.ES.triggerReact(Trigger.Waiting, [timePassed])):
			endScene()
			return
		
		setState("rested")
		return
		
	if(_action == "gosleep"):
		if(GM.ES.triggerReact(Trigger.AboutToSleepInCell)):
			endScene()
			return
		
		GM.main.startNewDay()
		GM.pc.afterSleepingInBed()
		
		if(GM.ES.triggerReact(Trigger.SleepInCell)):
			pass
		
		setState("slept")
		return

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "endthesceneandtriggerevents"):
		GM.pc.updateAppearance()
		
		if(GM.ES.triggerReact(Trigger.WakeUpInCell)):
			GM.main.showLog()
			endScene()
			return
		GM.main.showLog()
		
		endScene()
		return
	
	if(_action == "startReset"):
		endScene()
		runScene("ResetMainRouteScene")
		return
	
	setState(_action)
