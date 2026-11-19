extends EventBase

func _init():
	id = "EnslaveDynamicNpcEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.DefeatedDynamicNPC)
	es.addTrigger(self, Trigger.AfterSexWithDefeatedDynamicNPC)

func run(_triggerID, _args):
	var npcID = _args[0]
	var character:DynamicCharacter = getCharacter(npcID)
	
	if(!character.isDynamicCharacter()):
		return
	
	if(character.isSlaveToPlayer()):
		return
		
	if(character.hasEnslaveQuest()):
		var canKidnapInfo:Array = getModule("NpcSlaveryModule").canKidnapCharacterReason(character)
		
		if(canKidnapInfo[0]):
			addButton("Похитить!", "Попытаться затащить их в свою камеру", "dokidnap", [_args[0]])
		else:
			addDisabledButton("Похитить!", canKidnapInfo[1] if canKidnapInfo.size() > 1 else "Они еще не готовы к похищению")
	else:
		if(!getModule("NpcSlaveryModule").canEnslave()):
			if(_triggerID == Trigger.DefeatedDynamicNPC):
				addDisabledButton("Поработить!", "Твоя камера слишком мала для этого. Сначала найди того, кто сможет её улучшить.")
			return
		
		if(!character.hasEnslaveQuest() ):
			var canEnslaveInfo:Array = getModule("NpcSlaveryModule").canStartEnslavingCharacterReason(character)
			
			if(canEnslaveInfo[0]):
				addButton("Поработить!", "Попытаться поработить их", "doenslave", [_args[0]])
			else:
				addDisabledButton("Поработить!", canEnslaveInfo[1] if canEnslaveInfo.size() > 1 else "Сейчас ты не можешь их поработить...")
		

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "doenslave"):
		runScene("EnslaveDynamicNpcScene", [_args[0]])
	if(_method == "dokidnap"):
		GM.main.endCurrentScene()
		runScene("KidnapDynamicNpcScene", [_args[0]])
