extends EventBase

func _init():
	id = "ChemistryLabEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "med_researchlab")
	es.addTrigger(self, Trigger.TalkingToNPC, "eliza")

func run(_triggerID, _args):
	if(_triggerID == Trigger.TalkingToNPC):
		if(GM.pc.getTFHolder().hasActiveTransformations()):
			addButton("Я трансформируюсь!", "Попросить кошечку помочь тебе освоиться с меняющимся телом", "ask_help_tf")
	
	var hasLabAccess:bool = getModule("ElizaModule").hasLabAccess()
	if(!hasLabAccess):
		return

	if(_triggerID == Trigger.TalkingToNPC):
		if(getFlag("ElizaModule.s2hap") && GM.main.SCI.doesPCHaveUnknownStrangePills()):
			addButton("Странная таблетка!", "Заставить Элизу просканировать странную таблетку, которая у тебя есть", "scan_strange_pill")
		if(GM.main.SCI.hasTFsCanScan(GM.pc)):
			addButton("Пройти сканирование!", "Заставить Элизу просканировать эффекты твоих текущих трансформаций", "scan_tfs")
		return
	#if(getFlag("ElizaModule.firstDrugTestHappened")):
	addButton("Лаборатория", "Осмотреться в лаборатории", "lab")
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "lab"):
		runScene("ChemistryLabScene")
	if(_method == "scan_strange_pill"):
		GM.main.endCurrentScene()
		runScene("ElizaGenericUnlockDrugScene")
	if(_method == "scan_tfs"):
		GM.main.endCurrentScene()
		runScene("ElizaGenericTestDrugScene")
	if(_method == "ask_help_tf"):
		runScene("ElizaHelpGotTransformedScene")
