extends EventBase

func _init():
	id = "TaviTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "mining_taviroom")

func run(_triggerID, _args):
	if(!GM.main.getModuleFlag("TaviModule", "Tavi_IntroducedTo")):
		return
	# If we start another main route, we can't find Tavi anymore
	if(GM.main.hasCommittedToMainRoute() && !GM.main.hasCommittedToTaviMainRoute()):
		return
	
	if(checkCharacterBusy("TaviBusy", "Похоже, Тави здесь нет", "Tavi")):
		return
	
	saynn("Вы видите Тави: она сидит на ящике, в стороне от всех остальных.")
	addButtonUnlessLate("Тави", "Поговорить с Тави", "talk")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		runScene("TaviTalkScene")
