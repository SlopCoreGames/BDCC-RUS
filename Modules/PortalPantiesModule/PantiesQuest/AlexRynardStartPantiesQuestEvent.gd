extends EventBase

func _init():
	id = "AlexRynardStartPantiesQuestEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "alexrynard")
	
func run(_triggerID, _args):
	if(!getFlag("PortalPantiesModule.Panties_AskedAlex")):
		addButtonUnlessLate("Титры", "Спросить, может ли он чем-то помочь", "startpanties")
	else:
		if(!getFlag("PortalPantiesModule.Panties_GavePantiesToAlex")):
			if(GM.pc.getInventory().hasItemID("plainPanties")):
				addButtonUnlessLate("Отдать трусики", "Отдать Алексу женские трусики, которые он хотел", "givepanties")
			else:
				addDisabledButton("Отдать трусики", "В твоём инвентаре нет обычных женских трусиков")

		if(getFlag("PortalPantiesModule.Panties_FleshlightsGotStolen") && !getFlag("PortalPantiesModule.Panties_FleshlightsAskedAlex")):
			addButtonUnlessLate("Трусики!", "Спросить, какого черта вообще происходит", "alexpantieswtf")

		if(getFlag("PortalPantiesModule.Panties_FleshlightsFoundFleshlights") && !getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex")):
			addButtonUnlessLate("Флешлайты", "Вернуть ему флешлайты", "alexreturnpanties")



func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "startpanties"):
		runScene("AlexRynardStartPantiesQuestScene")
		setFlag("PortalPantiesModule.Panties_AskedAlex", true)
	if(_method == "givepanties"):
		runScene("AlexRynardPantiesQuestGivePanties")
		setFlag("PortalPantiesModule.Panties_GavePantiesToAlex", true)
		GM.pc.getInventory().removeXOfOrDestroy("plainPanties", 1)
	if(_method == "alexpantieswtf"):
		runScene("AlexRynardPantiesQuestWTFScene")
		setFlag("PortalPantiesModule.Panties_FleshlightsAskedAlex", true)
	if(_method == "alexreturnpanties"):
		runScene("AlexRynardPantiesQuestReturnFleshlightsScene")
		setFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex", true)
