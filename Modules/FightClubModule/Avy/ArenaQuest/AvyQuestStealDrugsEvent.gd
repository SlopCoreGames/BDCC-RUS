extends EventBase

func _init():
	id = "AvyQuestStealDrugsEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "main_greenhouses")
	
func run(_triggerID, _args):
	if(getFlag("FightClubModule.StolePlantForEliza")):
		return
	if(getFlag("FightClubModule.GotTaskToStealPlant")):
		saynn("Вы замечаете те самые светящиеся розовые растения, о которых рассказывала доктор Куинн.")

		addButton("Розовое растение", "Украсть это!", "stealplant")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "stealplant"):
		setFlag("FightClubModule.StolePlantForEliza", true)
		addMessage("Ты украл розовое растение, задание обновлено!")
		addExperienceToPlayer(50)
		GM.main.reRun()
