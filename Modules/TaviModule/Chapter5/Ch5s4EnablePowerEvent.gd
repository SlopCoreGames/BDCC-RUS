extends EventBase

func _init():
	id = "Ch5s4EnablePowerEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.SceneAndStateHook, ["EngineeringLoreComputerScene", ""])
	
func run(_triggerID, _args):
	if(getFlag("TaviModule.Ch5NewPlanSceneHappend") && !getFlag("TaviModule.Ch5SearchedLabFirstTime")):
		saynn("Появляется предчувствие, что этот компьютер может пригодиться... Но сначала нужно заглянуть в соседнюю комнату.")
		
		addDisabledButton("Миссия", "Сначала проверить соседнюю комнату")
	
	if(getFlag("TaviModule.Ch5NewPlanSceneHappend") && getFlag("TaviModule.Ch5SearchedLabFirstTime") && !getFlag("TaviModule.Ch5EnabledLabPower")):
		addButton("Миссия", "Поищи прототип гранаты", "startscene")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "startscene"):
		GM.main.endCurrentScene()
		runScene("Ch5s4EnablePowerScene")
		
