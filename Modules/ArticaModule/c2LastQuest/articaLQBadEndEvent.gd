extends EventBase

func _init():
	id = "articaLQBadEndEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "eliza")
	
func run(_triggerID, _args):
	if(getFlag("ArticaModule.lastQuestStarted") && !getFlag("ArticaModule.LQArticaGotDreamCatcher") && !getFlag("ArticaModule.LQArticaGotBrainwashed")):
		addButtonUnlessLate("Артика", "Попробуй узнать, сможет ли доктор Куинн помочь Артике", "badend")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "badend"):
		GM.main.endCurrentScene()
		runScene("articaLastQuestBadEndScene")

