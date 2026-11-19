extends EventBase

func _init():
	id = "RahiTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "main_bench2")

func run(_triggerID, _args):
	if(checkCharacterBusy("RahiBusy", "Похоже, кошечки здесь нет", "Rahi")):
		return
	
	if(getModuleFlag("RahiModule", "Rahi_NotThereToday", false)):
		saynn("Похоже, кошечки здесь нет")
		
		addDisabledButton("Рахи", "Сегодня её здесь нет")
		return
	
	if(!getModuleFlag("RahiModule", "Rahi_Introduced")):
		saynn("Вы видите какую-то неизвестную кошку, сидящую на скамейке")
	else:
		saynn("Вы видите Кошечку, сидящую на скамейке")
	addButtonUnlessLate("Рахи", "Поговорить с кошкообразной", "talk")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk"):
		runScene("RahiTalkScene")
