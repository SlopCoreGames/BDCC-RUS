extends EventBase

func _init():
	id = "AlexCh2S4CollectPartsEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.DefeatedDynamicNPC)
	es.addTrigger(self, Trigger.EnteringRoom, "eng_storage")

func arun(_triggerID, _args):
	if(!GM.main.getModuleFlag("CellblockModule", "Cellblock_GreenhouseLooted", false)):
		addButtonUnlessLate("Украсть", "Попробовать что-нибудь украсть", "steal_apple")
	else:
		addDisabledButton("Украсть", "Слишком опасно делать это снова сегодня")
	
func run(_triggerID, _args):
	if(getFlag("AlexRynardModule.ch2CheckAlexSceneHappened") && !getFlag("AlexRynardModule.ch2FinalSceneHappened")):
		if(_triggerID == Trigger.DefeatedDynamicNPC):
			if(getFlag("AlexRynardModule.ch2LastCheckedNPC", "") == _args[0]):
				addDisabledButton("Детали!", "Ты уже проверял их")
			else:
				var character = getCharacter(_args[0])
				if(character != null && character.getCharacterType() == CharacterType.Engineer):
					addButton("Детали!", "Проверить, есть ли нужные детали", "checkparts", [_args[0]])
		if(_triggerID == Trigger.EnteringRoom):
			if(getFlag("AlexRynardModule.ch2StolePartsStorageDay", -1) >= GM.main.getDays()):
				addDisabledButton("Детали!", "Ты уже искал детали сегодня")
			else:
				addButton("Детали!", "Украсть немного деталей для Алекса", "stealparts")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "stealparts"):
		setFlag("AlexRynardModule.ch2StolePartsStorageDay", GM.main.getDays())
		increaseFlag("AlexRynardModule.ch2FoundParts", 5)
		addExperienceToPlayer(50)
		addMessage("Вы нашли 5 деталей, которые нужны Алексу. Теперь у вас.. "+str(getFlag("AlexRynardModule.ch2FoundParts", 0)))
		if(getFlag("AlexRynardModule.ch2FoundParts", 0) >= 10):
			addMessage("У вас есть все необходимые детали, идите поговорить с Элизой!")
		GM.main.reRun()
	
	if(_method == "checkparts"):
		setFlag("AlexRynardModule.ch2LastCheckedNPC", _args[0])
		increaseFlag("AlexRynardModule.ch2FoundParts")
		
		addExperienceToPlayer(10)
		addMessage("Вы нашли одну из деталей, которые нужны Алексу. Теперь у вас.. "+str(getFlag("AlexRynardModule.ch2FoundParts", 0)))
		if(getFlag("AlexRynardModule.ch2FoundParts", 0) >= 10):
			addMessage("У вас есть все необходимые детали, идите поговорить с Элизой!")
		GM.main.reRun()
