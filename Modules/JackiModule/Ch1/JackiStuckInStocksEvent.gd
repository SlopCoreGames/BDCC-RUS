extends EventBase

func _init():
	id = "JackiStuckInStocksEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "main_punishment_spot")

func run(_triggerID, _args):
	if(!getFlag("JackiModule.Jacki_StocksSceneHappened") && getFlag("JackiModule.Jacki_FirstTimeEncountered")):
		saynn("Вы замечаете кого-то, запертого в одном из колодок. Это человек, которого вы узнаёте. Рядом с ним стоит женщина-охранница.")

		addButtonUnlessLate("Inmate", "(chastity piercings, urethra penetration) See what is happening there", "jackiscene")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "jackiscene"):
		setFlag("JackiModule.Jacki_StocksSceneHappened", true)
		runScene("JackiStuckInStocksScene")
