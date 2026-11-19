extends NpcBreakTaskBase

func _init():
	id = "FuckThroughRinggag"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.1,
	}

func getNpcOwnerWeight(_npcOwner) -> float:
	return 0.1

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	if(!_pc.getInventory().hasItemID("ringgag") && !_npc.getInventory().hasItemIDEquipped("ringgag")):
		return false
	if(!_pc.hasReachablePenis() && !_pc.hasStrapons()):
		return false
	
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = 1

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.HolePenetrated):
		if(_event.getTargetChar() == _npc):
			var whichPart = _event.getField("hole", BodypartSlot.Vagina)
			if(whichPart == BodypartSlot.Head):
				if(!_npc.isOralBlocked() && _npc.isGagged()):
					advanceTask()
					return true
	return false

func getTaskString():
	return "Трахаться через кольцо-кляп"

func getTaskStringSlutLock():
	return "Получать еблю в рот через кольцо-кляп"

func getTaskHint(_isSlaveLevelup):
	return "Засунуть им в рот кольцо-кляп и трахать их в глотку своим членом или страпоном"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Иди, привыкай к тому, что в тебя будут совать всякое. Кто-нибудь обязательно захочет сделать это с кольцом-кляпом.",
		"Найди кого-нибудь, кто оттрахает твое милое личико прямо через кляп.",
		"Я хочу, чтобы твоим лицом пользовались как следует. А под «как следует» я имею в виду — через кольцо-кляп.",
		"Хочу, чтобы ты вернулась с саднившим горлом и использованным кольцом-кляпом во рту.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.FuckOral):
		return 2.0
	if(_sexGoalID == SexGoal.TieUp):
		return 1.0
	return 0.0
