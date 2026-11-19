extends EventBase

func _init():
	id = "PSPCTentaclesEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringPlayerCell)

func run(_triggerID, _args):
	if(!getModule("ElizaModule").hasAccessToTentacles()):
		return
	addButton(getCharacter("PCTentacles").getName(), "Подойди к своему личному зеленому растению", "tentacles")

func getPriority():
	return 3

func onButton(_method, _args):
	if(_method == "tentacles"):
		runScene("PSPCTentaclesScene")
