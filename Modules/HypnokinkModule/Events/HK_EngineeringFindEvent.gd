extends EventBase

func _init():
	id = "EngineeringFindVisor"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "med_researchlab")
	
func run(_triggerID, _args):
	if(!getFlag("HypnokinkModule.GotEngineeringFreebieVisor")):
		saynn("На одном из столов лежит что-то интересное.")
		
		addButton("Посылка", "В углу стоит посылка", "take_freebie")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "take_freebie"):
		setFlag("HypnokinkModule.GotEngineeringFreebieVisor", true)
		runScene("GetEngineeringFreebieVisor")
