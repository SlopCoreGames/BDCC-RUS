extends EventBase

func _init():
	id = "SlutwallPlayerEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "fight_slutwall")
	
func run(_triggerID, _args):
	addButtonUnlessLate("Стенка для шлюх", "Пусть другие используют тебя! Свободно не выбраться, так что выбирай с умом!", "slutwall")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "slutwall"):
		GM.main.IS.startInteraction("InSlutwall", {inmate="pc"})
		#runScene("SlutwallPlayerScene")
