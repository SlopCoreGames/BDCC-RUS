extends EventBase

func _init():
	id = "ArticaGreenhousesStealFlowerEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "main_greenhouses")

func run(_triggerID, _args):
	if(!getFlag("ArticaModule.TentaclesPcHasFlower") && !getFlag("ArticaModule.TentaclesArticaHasFlower")):
		if(getFlag("ArticaModule.eventTentacles", 0) >= 1):
			addButton("Украсть цветок", "Украсть цветок, который необходим Артике", "stealplant")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "stealplant"):
		setFlag("ArticaModule.TentaclesPcHasFlower", true)
		addMessage("You stole the flower that Artica needs. Go give it to her!")
		addExperienceToPlayer(50)
		GM.main.reRun()
