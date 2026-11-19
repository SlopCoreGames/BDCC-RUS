extends EventBase

func _init():
	id = "AlexS1IntroEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "alexrynard")
	es.addEventCheck(self, "AlexRynardBusy")
	
func run(_triggerID, _args):
	# Must finish portal panties quest first
	if(!getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex") && !getFlag("PortalPantiesModule.Panties_PcDenied")):
		return
	if(getFlag("AlexRynardModule.ch1StopAlexContent")):
		return
	
	if(getFlag("AlexRynardModule.ch2SceneNum", 0) >= 1):
		addButtonUnlessLate("Упражнения на доверие", "Оценить их", "do_trust")
	
	
	if(!getFlag("AlexRynardModule.ch1IntroSceneHappened")):
		addButtonUnlessLate("Пошловато?", "Спросить, не хочет ли он чего-нибудь эдакого", "startIntro")
		return
	
	if(!getFlag("AlexRynardModule.ch1FirstFuckup")):
		addButtonUnlessLate("Смотреть", "Наблюдать за работой Алекса", "watchWork")
		return
	
	if(getFlag("AlexRynardModule.ch1NextDaySceneHappened") && !getFlag("AlexRynardModule.ch1HypnovisorHappened")):
		addButtonUnlessLate("Помочь", "Помочь ему починить датапады", "helpRepair")
		return
	
	if(getFlag("AlexRynardModule.ch2SceneNum", 0) <= 6):
		addButtonUnlessLate("Помочь", "Помочь ему починить датапады", "helpRepair2")
		return
		
	if(!getFlag("AlexRynardModule.ch2GotRektHappened")):
		addButtonUnlessLate("Помочь", "Помочь ему починить датапады", "helpRepair3")
	
func react(_triggerID, _args):
	if(getFlag("AlexRynardModule.ch1FirstFuckup") && !getFlag("AlexRynardModule.ch1NextDaySceneHappened")):
		setFlag("AlexRynardModule.ch1NextDaySceneHappened", true)
		runScene("AlexS3NextDayScene")
		return true
	
	return false

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "startIntro"):
		GM.main.endCurrentScene()
		runScene("AlexS1IntroScene")
	if(_method == "helpRepair"):
		GM.main.endCurrentScene()
		runScene("AlexS4FixingDatapadsScene")
	if(_method == "helpRepair2"):
		GM.main.endCurrentScene()
		runScene("AlexCh2s1Scene")
	if(_method == "helpRepair3"):
		GM.main.endCurrentScene()
		runScene("AlexCh2s3Scene")
	if(_method == "watchWork"):
		GM.main.endCurrentScene()
		runScene("AlexS2SittingNearScene")
	if(_method == "do_trust"):
		GM.main.endCurrentScene()
		runScene("AlexTrustExercisesMenuScene")

func eventCheck(_checkID, _args = []):
	if(getFlag("AlexRynardModule.ch2GotRektHappened") && !getFlag("AlexRynardModule.ch2FinalSceneHappened")):
		return {busy=true}
