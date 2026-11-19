extends EventBase

func _init():
	id = "NovaTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "yard_novaspot")

func run(_triggerID, _args):
	if(checkCharacterBusy("NovaBusy", "Похоже, Новы здесь нет", "Nova")):
		return
	
	if(!GM.main.getModuleFlag("NovaModule", "Nova_Introduced")):
		saynn("Вы видите, как по этой зоне патрулирует какой-то охранник")
	else:
		saynn("Вы видите, как по этой зоне патрулирует Нова")
	if(GM.main.getModuleFlag("NovaModule", "Nova_NotThereToday", false)):
		addDisabledButton("Нова", "Сегодня её здесь нет")
	else:
		addButtonUnlessLate("Нова", "Поговорить с хаски", "talk")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		runScene("NovaTalkScene")
