extends EventBase

func _init():
	id = "NuraFindToolEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "eng_assemblylab")

func run(_triggerID, _args):
	if(GM.main.getFlag("CellblockModule.FoundNura")):
		if(!GM.main.getFlag("CellblockModule.NuraFoundTool")):
			saynn("Вы замечаете какой-то инструмент на одном из рабочих столов. Промышленный шприц, к которому прикреплены какие-то микросхемы.")
		
			addButton("Инструмент-шприц", "Схватить его", "nura")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "nura"):
		GM.main.addMessage("You grab the syringe tool and store it. Maybe someone here can use it. But not you.")
		
		GM.main.setFlag("CellblockModule.NuraFoundTool", true)
		GM.main.reRun()
