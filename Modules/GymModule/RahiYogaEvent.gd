extends EventBase

func _init():
	id = "RahiYogaEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.ApproachedYogaMats)

func run(_triggerID, _args):
	if(!getModuleFlag("RahiModule", "Rahi_Introduced")):
		return
	
	if(GM.main.getTime() <= 7*60*60):
		saynn("Вы замечаете знакомую кису, занимающуюся йогой")		
		
		addButtonUnlessLate("Rahi", "Spy on the kitty doing yoga", "rahi")
	else:
		addDisabledButton("Рахи", "Посетите ранним утром")


func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "rahi"):
		runScene("RahiYogaScene")
