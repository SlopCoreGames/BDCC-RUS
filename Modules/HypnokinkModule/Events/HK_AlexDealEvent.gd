extends EventBase

func _init():
	id = "AlexVionDealEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "alexrynard")
	
func run(_triggerID, _args):
	if(getFlag("HypnokinkModule.Vion_HaveCage")):
		addButtonUnlessLate("Вернуть датапад", "Отдать Алексу его датапад и клетку Вион", "finish_deal")
		return
	
	if(not getFlag("HypnokinkModule.VionTopicKnown_Chastity") or getFlag("HypnokinkModule.Vion_HaveDatapad") or getFlag("HypnokinkModule.Vion_FreedFromCage")):
		return
		
	if(not getFlag("AlexRynardModule.ch1HypnovisorHappened")):
		addDisabledButton("Проблема Виона", "Лучше подожди, пока Алекс не станет к тебе дружелюбнее")
	else:
		addButtonUnlessLate("Проблема Виона", "Может, Алекс знает, где раздобыть ту штуковину, которую хотела Вион", "make_deal")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "make_deal"):
		GM.main.endCurrentScene()
		runScene("Alex_TalkAboutVion")
	if(_method == "finish_deal"):
		GM.main.endCurrentScene()
		runScene("Alex_GiveCage")
