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
		
	addButtonUnlessLate("Final attack (alone)", "Use everything you learned to get the best possible chance at escaping from this place", "start")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "start"):
		runScene("Ch7s2aAloneScene")
