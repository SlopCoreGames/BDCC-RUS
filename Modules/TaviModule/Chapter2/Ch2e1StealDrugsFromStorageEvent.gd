extends EventBase

func _init():
	id = "Ch2e1StealDrugsFromStorageEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "medical_storage")
	
func run(_triggerID, _args):
	if(GM.QS.isActive("Ch2ElizaQuest") && !getFlag("TaviModule.ch2PCStoleDrugs")):
		saynn("Вы замечаете ящик, в котором лежат флаконы с тем самым красным наркотиком, который вам нужно украсть.")
		
		addButtonUnlessLate("Наркотики Тави", "Стибрить наркоту!", "stealdrugs")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "stealdrugs"):
		GM.main.addMessage("Ты открываешь ящик и воруешь особые флаконы!")
		GM.main.addMessage("Задание выполнено!")
		GM.pc.addExperience(100)
		setFlag("TaviModule.ch2PCStoleDrugs", true)
		GM.main.reRun()
