extends EventBase

func _init():
	id = "GivingElizaPlantForAvyFightEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "eliza")
	
func run(_triggerID, _args):
	if(getFlag("FightClubModule.StolePlantForEliza") && !getFlag("FightClubModule.ReturnedPlantToEliza")):
		addButtonUnlessLate("Розовое растение", "Отдай Элизе растение, чтобы она сделала наркоту", "giveplant")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "giveplant"):
		GM.main.endCurrentScene()
		runScene("GivingElizaPlantForAvyFightScene")
		setFlag("FightClubModule.ReturnedPlantToEliza", true)

