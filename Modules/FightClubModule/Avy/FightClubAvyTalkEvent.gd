extends EventBase

func _init():
	id = "FightClubAvyTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "fight_neararena")
	
func run(_triggerID, _args):
	if(GM.main.MS.isOnMission()):
		addDisabledButton("Эви", "Нельзя делать это во время миссии")
		return
	
	saynn("Ави стоит у ограждений, образующих импровизированную арену.")
	
	if(!getFlag("FightClubModule.AnnouncerIntroduced")):
		addDisabledButton("Эви", "Сначала поговори с ведущим")
	else:
		if(!getFlag("FightClubModule.AvyIntroduced")):
			addButtonUnlessLate("Avy", "Approach the dickgirl", "avyfirst")
		else:
			if(getFlag("FightClubModule.AvyIsInSlutwall")):
				addDisabledButton("Эви", "Ави всё ещё застряла в шлюзовой стене")
			else:
				addButtonUnlessLate("Avy", "Approach the dickgirl", "avy")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "avyfirst"):
		runScene("AvyFirstTimeTalkScene")
		setFlag("FightClubModule.AvyIntroduced", true)
	if(_method == "avy"):
		runScene("AvyTalkScene")
