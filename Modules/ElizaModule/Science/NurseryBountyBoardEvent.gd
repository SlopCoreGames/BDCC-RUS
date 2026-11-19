extends EventBase

func _init():
	id = "NurseryBountyBoardEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "medical_nursery")

func run(_triggerID, _args):
	if(getFlag("ElizaModule.s0hap")):
		addButtonUnlessLate("Bounty board", "Look at the bounty board", "board")
	else:
		addDisabledButton("Доска объявлений", "У вас нет доступа к этому... Может, кто-нибудь здесь сможет его вам дать?")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "board"):
		runScene("NurseryBountyBoardScene")
