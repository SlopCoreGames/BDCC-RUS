extends EventBase

func _init():
	id = "Ch7s2aAloneEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "hall_mainentrance")

func run(_triggerID, _args):
	if(getFlag("TaviModule.Ch7CaptainSceneHappened")):
		return
	
	if(!getFlag("TaviModule.Ch7PlanningSceneHappened")):
		return
		
	saynn("Ты можешь начать финальную атаку прямо здесь и прямо сейчас. Но большую часть пути ты будешь [b]одна[/b]. Если хочешь помощи Тави, проверь её.")
		
	addButtonUnlessLate("Финальная атака (в одиночку)", "Используй всё, чему научилась, чтобы получить максимальный шанс сбежать из этого места", "start")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "start"):
		runScene("Ch7s2aAloneScene")
