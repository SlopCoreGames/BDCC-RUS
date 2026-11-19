extends EventBase

func _init():
	id = "RishaGymEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.ApproachedWeightsBench)

func run(_triggerID, _args):
	if(GM.main.getTime() >= 22*60*60):
		saynn("Вы замечаете Ришу, сидящую на одной из скамей")
		
		addButtonUnlessLate("Risha", "Ask what's up", "risha")
	else:
		addDisabledButton("Риша", "Приходите после 22:00")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "risha"):
		runScene("RishaGymScene")
