extends EventBase

func _init():
	id = "DomCh1RahiRecEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "rahi")
	es.addTrigger(self, Trigger.TalkingToNPC, "rahiSlavery")
	
func run(_triggerID, _args):
	if(getFlag("KaitModule.joinedTeam") && !getFlag("KaitModule.caughtRahi")):
		if(_args[0] == "rahi"):
			addButton("Вербовка!", "(Путь Дома) Попытаться завербовать эту кошку в свою команду", "rahiIntro")
		else:
			addButton("Вербовка!", "(Путь Дома) Попытаться завербовать Рахи в свою команду", "rahiSlavery")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "rahiIntro"):
		GM.main.endCurrentScene()
		runScene("DomCh1RahiRecScene")
	if(_method == "rahiSlavery"):
		GM.main.endCurrentScene()
		runScene("DomCh1RahiRecEnsScene")

