extends EventBase

func _init():
	id = "minesHandlerEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "mining_shafts_entering")

func run(_triggerID, _args):
	if(GM.pc.getStamina() > 0):
		if(!GM.main.getFlag("Mining_IntroducedToMinning", false)):
			addButtonWithChecks("Работать", "Посмотреть, в чем дело", "first_time", [], [ButtonChecks.NotLate, ButtonChecks.NotHandsBlocked])
		else:
			addButtonWithChecks("Работать", "Пойти поработать в шахтах", "not_first_time", [], [ButtonChecks.NotLate, ButtonChecks.NotHandsBlocked])
	else:
		addDisabledButton("Работать", "Ты слишком вымотан, чтобы работать")
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "first_time"):
		runScene("FirstTimeInMinesScene")
	if(_method == "not_first_time"):
		runScene("WorkInMinesScene")
