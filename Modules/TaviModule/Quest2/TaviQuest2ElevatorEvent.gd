extends EventBase

func _init():
	id = "TaviQuest2ElevatorEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.InsideElevator)

func run(_triggerID, _args):
	if(!GM.QS.isActive("TaviQuest2") || !getModuleFlag("TaviModule", "Tavi_Quest2MetHer", false)):
		return
	
	if(GM.pc.getLocation() == "cd_elevator"):
		return
	addButton("Командная палуба", "Там, где живут все верхушки", "commanddeck")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "commanddeck"):
		GM.pc.setLocation("cd_elevator")
		GM.main.endCurrentScene()
		GM.main.reRun()
