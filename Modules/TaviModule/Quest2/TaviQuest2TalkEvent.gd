extends EventBase

func _init():
	id = "TaviQuest2TalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "hall_mainentrance")

func run(_triggerID, _args):
	if(!GM.main.getModuleFlag("TaviModule", "Tavi_Quest2Started", false) || GM.main.getModuleFlag("TaviModule", "Tavi_Quest2MetHer", false)):
		return
	
	if(GM.main.getDays() > GM.main.getModuleFlag("TaviModule", "Tavi_Quest2Day", 0)):
		addButtonUnlessLate("Тави", "Дождаться появления Тави", "talk")
	else:
		addDisabledButton("Тави", "Подожди до завтра, прежде чем делать это")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		runScene("TaviQuest2Meet")
