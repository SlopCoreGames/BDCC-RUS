extends EventBase

func _init():
	id = "ElizaQuestEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "eliza")
	es.addTrigger(self, Trigger.EnteringRoom, "med_lobbymain")

func run(_triggerID, _args):
	if(_triggerID == Trigger.TalkingToNPC):
		var amountOfNurseryTasks:int = GM.main.SCI.getAmountOfCompletedNurseryTasks()
		
		if(getFlag("ElizaModule.s0hap") && !getFlag("ElizaModule.s1hap") && amountOfNurseryTasks >= 3):
			addButton("Лаборантка", "Сказать Элизе, что ты выполнил заказы в детском отделении", "s1")
			
		if(getFlag("ElizaModule.s1hap") && !getFlag("ElizaModule.s2hap") && GM.main.SCI.doesPCHaveUnknownStrangePills()):
			addButton("Странная таблетка!", "Заставить Элизу просканировать странную таблетку, которая у тебя есть", "s2")
		
		if(getFlag("ElizaModule.s6DateHap") && !getFlag("ElizaModule.s7hap")):
			var amountOfPillsUnlocked:int = GM.main.SCI.getUnlockedStrangePillsCount()
			var amountOfPillsTested:int = GM.main.SCI.getTestedStrangePillsCount()
			
			if(amountOfPillsUnlocked >= GM.main.SCI.getTotalStrangePillCount() && amountOfPillsTested >= 10):
				addButton("История...", "Сказать Элизе, что все препараты теперь разблокированы и большинство из них протестировано.", "s7")
			else:
				addDisabledButton("История...", "Разблокировать все таблетки ("+str(GM.main.SCI.getUnlockedStrangePillsCount())+"/"+str(GM.main.SCI.getTotalStrangePillCount())+") и протестировать как минимум 10 из них ("+str(GM.main.SCI.getTestedStrangePillsCount())+"/10), чтобы завершить историю Элизы.")
				
	else:
		if(getFlag("ElizaModule.s6hap") && !getFlag("ElizaModule.s6DateHap")):
			if(GM.main.isVeryLate()):
				addButton("Встретиться с Элизой", "Потусить с Элизой", "s6date")
			else:
				addDisabledButton("Встретиться с Элизой", "Вы сможете встретиться с Элизой после того, как её смена закончится в 23:00")
		

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "s1"):
		GM.main.endCurrentScene()
		setFlag("ElizaModule.s1hap", true)
		runScene("Eliza1DrugIntroScene")
	if(_method == "s2"):
		GM.main.endCurrentScene()
		setFlag("ElizaModule.s2hap", true)
		GM.pc.getInventory().removeFirstOf("TFPill")
		runScene("Eliza2FirstDrugScene")
	if(_method == "s6date"):
		setFlag("ElizaModule.s6DateHap", true)
		runScene("Eliza6DateScene")
	if(_method == "s7"):
		GM.main.endCurrentScene()
		setFlag("ElizaModule.s7hap", true)
		setFlag("ElizaModule.storyCompleted", true)
		runScene("Eliza7EndingScene")
