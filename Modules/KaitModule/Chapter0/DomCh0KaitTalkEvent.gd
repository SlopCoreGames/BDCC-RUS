extends EventBase

func _init():
	id = "DomCh0KaitTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "fight_corner_sw")
	es.addTrigger(self, "ArenaFighterPCWon")

func run(_triggerID, _args):
	if(GM.main.hasCommittedToMainRoute()):
		return
	if(_triggerID == "ArenaFighterPCWon"):
		if(getFlag("KaitModule.talkedKaitArena")):
			var amountWon:int = GlobalRegistry.getModule("FightClubModule").getAmountFightersWon()
			if(amountWon == 3):
				#if(GM.main.shouldExecuteOnceCodeblocksRun()):
				saynn("[center][i]Кейт готова принять тебя в команду! Поговори с ней![/i][/center]")
		return
	
	addButton("Кейт", "Поговорить со снежным барсом-сиренью", "talk")
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		if(!getFlag("KaitModule.talkedKaitArena")):
			setFlag("KaitModule.talkedKaitArena", true)
			if(getFlag("KaitModule.gotMetByKait")):
				runScene("DomCh0ArenaApproach")
				addMessage("Task updated!")
			else:
				getFlag("KaitModule.gotMetByKait", true) # ehh
				runScene("DomCh0ArenaApproachFirst")
				addMessage("New task added!")
			return
		
		runScene("DomCh0KaitTalkScene")
