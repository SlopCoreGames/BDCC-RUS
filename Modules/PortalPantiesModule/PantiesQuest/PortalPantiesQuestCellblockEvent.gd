extends EventBase

func _init():
	id = "PortalPantiesQuestCellblockEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_orange_nearcell")
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_lilac_nearcell")
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_red_nearcell")
	
func run(_triggerID, _args):
	if(getFlag("PortalPantiesModule.Panties_FleshlightsAskedAlex") && !getFlag("PortalPantiesModule.Panties_FleshlightsFoundFleshlights")):
		addButtonUnlessLate("Осмотреться вокруг", "Поискать свои флешлайты", "searchfleshlights")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "searchfleshlights"):
		if(GM.pc.getLocation() in ["cellblock_orange_nearcell", "cellblock_lilac_nearcell"]):
			GM.main.addMessage("Ты оглядываешься по сторонам, но никого с твоими флешлайтами не находишь. Возможно, они в другом блоке")
			GM.main.reRun()
		else:
			runScene("PortalPantiesQuestCellblockScene")
			setFlag("PortalPantiesModule.Panties_FleshlightsFoundFleshlights", true)
	

