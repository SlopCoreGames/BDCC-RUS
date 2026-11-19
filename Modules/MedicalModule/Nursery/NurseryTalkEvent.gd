extends EventBase

func _init():
	id = "NurseryTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "medical_nursery")

func run(_triggerID, _args):
	saynn("Медсестра за стойкой бросает на тебя мимолетный взгляд, когда ты входишь, но быстро возвращается к своим делам. Полагая, если бы у тебя было что-то важное, ты бы просто спросил или сказал ей об этом.")
	addButtonUnlessLate("Nurse", "Talk to the nurse", "talk")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		runScene("NurseryTalkScene")
