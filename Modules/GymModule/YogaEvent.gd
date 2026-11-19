extends EventBase

func _init():
	id = "YogaEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "gym_yoga")

func run(_triggerID, _args):
	addButtonUnlessLate("Коврики для йоги", "Кто-то сказал «йога»?", "yoga")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "yoga"):
		runScene("YogaScene")
