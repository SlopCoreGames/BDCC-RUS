extends EventBase

func _init():
	id = "FightClubAnnouncerTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "fight_announcer")

func run(_triggerID, _args):
	if(GM.main.MS.isOnMission()):
		addDisabledButton("Диктор", "Нельзя делать это во время миссии")
		return
	if(!getFlag("FightClubModule.AnnouncerIntroduced")):
		addButtonUnlessLate("Диктор", "Подойди к парню", "announcerfirst")
	else:
		addButtonUnlessLate("Диктор", "Подойди к парню", "announcer")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "announcerfirst"):
		runScene("AnnouncerFirstTimeTalkScene")
		setFlag("FightClubModule.AnnouncerIntroduced", true)
	if(_method == "announcer"):
		runScene("AnnouncerTalkScene")
