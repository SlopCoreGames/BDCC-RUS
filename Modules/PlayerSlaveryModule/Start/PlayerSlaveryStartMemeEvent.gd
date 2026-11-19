extends EventBase

func _init():
	id = "PlayerSlaveryStartMemeEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "fight_meme")

func run(_triggerID, _args):
	saynn("Вы замечаете, что на полу здесь лежит кредитный чип.")
	
	addButton("Кредитный чип", "На полу лежит кредитный чип", "credits")

func getPriority():
	return 11

func onButton(_method, _args):
	if(_method == "credits"):
		runScene("PlayerSlaveryStartMemeScene")
