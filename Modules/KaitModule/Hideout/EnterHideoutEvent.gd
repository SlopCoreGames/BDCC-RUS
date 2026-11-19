extends EventBase

func _init():
	id = "EnterHideoutEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "hideout_enter")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "hideout_enter")
	es.addTrigger(self, Trigger.EnteringRoom, "fight_announcer")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "fight_announcer")
	es.addTrigger(self, Trigger.EnteringRoom, "gym_secret")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "gym_secret")

func run(_triggerID, _args):
	var hasHideout:bool = getModule("KaitModule").hasHideoutAccess()
	if(!hasHideout):
		return
	var isDoingRec:bool = GM.main.RCS.hasCurrent()
	
	var theRoomID:String = _args[0]
	
	if(theRoomID == "hideout_enter"):
		if(isDoingRec):
			addDisabledButton("Выйти из убежища", "Нельзя выйти из убежища, пока не завершишь вербовку!")
		else:
			addButton("Выйти из убежища", "Покинуть убежище!", "go", ["fight_announcer"])
			addButton("Выйти из арены", "Выйти из убежища, а затем и из арены! Так будет быстрее.", "go", ["gym_secret"])
	elif(theRoomID == "fight_announcer" || theRoomID == "gym_secret"):
		addButton("Убежище", "Войти в убежище", "go", ["hideout_enter"])
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "go"):
		GM.pc.setLocation(_args[0])
		GM.main.reRun()
