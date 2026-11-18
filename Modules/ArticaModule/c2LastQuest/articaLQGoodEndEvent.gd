extends EventBase

func _init():
	id = "articaLQGoodEndEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "rahi")
	es.addTrigger(self, Trigger.TalkingToNPC, "rahiSlavery")
	
func run(_triggerID, _args):
	if(getFlag("ArticaModule.lastQuestStarted") && !getFlag("ArticaModule.LQArticaGotDreamCatcher") && !getFlag("ArticaModule.LQArticaGotBrainwashed")):
		saynn("Вы замечаете... что она вовсю вовсю во что-то тайком играет.")
		
		addButton("Что-то...", "Что это там за кошечка делает?", "goodend")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "goodend"):
		GM.main.endCurrentScene()
		runScene("articaLastQuest2Scene")

