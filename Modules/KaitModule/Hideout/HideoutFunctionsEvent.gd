extends EventBase

func _init():
	id = "HideoutFunctionsEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "hideout_near_break_room")
	es.addTrigger(self, Trigger.EnteringRoom, "hideout_hq")

func run(_triggerID, _args):
	var isDoingRec:bool = GM.main.RCS.hasCurrent()
	var isOnMission:bool = GM.main.MS.isOnMission()
	var theRoomID:String = _args[0]
	
	if(theRoomID == "hideout_hq" && getFlag("KaitModule.introCompleted")):
		if(isOnMission):
			addDisabledButton("Доска заданий", "Вы уже выполняете миссию")
			if(GM.main.MS.canCancelCurrentMission()):
				addButton("Отменить миссию", "Отменить текущую миссию", "cancelMission")
		elif(isDoingRec):
			addDisabledButton("Доска заданий", "Вы не можете сделать это, пока вербуете кого-то")
		else:
			addButtonWithChecks("Доска заданий", "Посмотри, какие миссии тебе доступны сейчас!", "missionboard", [], [[ButtonChecks.NotLate]])
			if(!checkCharacterBusy("KaitBusy", "Seems like Kait isn't here", "Kait")):
				addButtonWithChecks("Кейт", "Поговорить со снежным барсом!", "kaittalk", [], [[ButtonChecks.NotLate]])
	
	if(theRoomID == "hideout_near_break_room" && isDoingRec):
		var theRecName:String = GM.main.RCS.getRecruitName()
		addButton("Вербовать"+str(theRecName), "Составь план того, как именно ты хочешь вербовать людей"+theRecName, "doRec")
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "doRec"):
		runScene("RecruitStartScene")
	if(_method == "missionboard"):
		runScene("KaitMissionSelectorScene")
	if(_method == "cancelMission"):
		addMessage("Вы отменили текущую миссию!")
		GM.main.MS.cancelCurrentMission()
	if(_method == "kaittalk"):
		runScene("KaitTalkScene")
