extends EventBase

func _init():
	id = "Ch5s2DefeatedGuardEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.DefeatedDynamicNPC)
	
func run(_triggerID, _args):
	if(getFlag("TaviModule.Ch5NewPlanSceneHappend") && !getFlag("TaviModule.Ch5StoleDatapadFromNova") && !getFlag("TaviModule.Ch5StoleDatapadFromGuard")):
		if(getFlag("TaviModule.Ch5LastGuardLooted", "") == _args[0]):
			addDisabledButton("Датапад", "Ты уже проверял их")
		else:
			var character = getCharacter(_args[0])
			if(character.getCharacterType() == CharacterType.Guard):
				addButton("Датапад", "Посмотри, нет ли у них датапада", "checkdatapad", [_args[0]])

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "checkdatapad"):
		setFlag("TaviModule.Ch5LastGuardLooted", _args[0])
		increaseFlag("TaviModule.Ch5GuardsLooted")
		
		var amountLooted = getFlag("TaviModule.Ch5GuardsLooted", 0)
		if((RNG.chance(10) && amountLooted > 0) || amountLooted > 3):
			addMessage("У этого охранника был датапад! Ты забрала его. Задача обновлена!")
			addExperienceToPlayer(100)
			setFlag("TaviModule.Ch5StoleDatapadFromGuard", true)
		else:
			addMessage("У этого охранника нет датапада. Придётся поискать у кого-то другого.")
		GM.main.reRun()
