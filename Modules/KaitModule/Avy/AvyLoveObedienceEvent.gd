extends EventBase

func _init():
	id = "AvyLoveObedienceEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "avy")
	
func run(_triggerID, _args):
	if(!getModule("KaitModule").hasHideoutAccess()):
		return
	
	var theLove:int = GM.main.MS.getAvyLove()
	var theObedience:int = GM.main.MS.getAvyObedience()
	
	if(theLove >= 2):
		addButton("Секс", "Посмотреть, какую похоть можно творить с Эви", "lovemenu")
	if(theObedience >= 2):
		addButton("Доминировать", "Посмотреть, как можно подчинить эту дикгёрл", "obeymenu")
	
	if(theLove >= 4 || theObedience >= 4):
		addButton("Покормить", "Что-нибудь скормить Эви", "feedmenu")

func getPriority():
	return 33

func onButton(_method, _args):
	if(_method == "lovemenu"):
		GM.main.endCurrentScene()
		runScene("AvyLoveMenuScene")
	if(_method == "obeymenu"):
		GM.main.endCurrentScene()
		runScene("AvyObedienceMenuScene")
	if(_method == "feedmenu"):
		GM.main.endCurrentScene()
		runScene("FeedSomethingScene", ["avy"])

