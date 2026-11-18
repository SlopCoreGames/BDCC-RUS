extends EventBase

func _init():
	id = "StationDefaultInteractionsEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "main_bathroom1")
	es.addTrigger(self, Trigger.EnteringRoom, "main_bathroom2")

func run(_triggerID, _args):
	var theRoomID = _args[0]
	
	if(theRoomID in ["main_bathroom1", "main_bathroom2"]):
		addButton("Зеркало", "Изменить прическу", "mirror")
		addButton("Туалет", "Найти свободную кабинку", "toilet")
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "mirror"):
		runScene("ChangeHaircutScene")
	if(_method == "toilet"):
		runScene("ToiletScene")
