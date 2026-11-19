extends NpcBreakTaskBase

func _init():
	id = "Spank"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.4,
	}

func getSlutlockWeight() -> float:
	return 0.1

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = scaledRangeWithDifficulty(3, 6, _difficulty)

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.Spanked):
		if(_event.getTargetChar() == _npc):
			advanceTask()
			return true
	return false

func getTaskString():
	return "Полученные шлепки: "+getProgressString()

func getTaskHint(_isSlaveLevelup):
	return "Шлепайте их по заднице во время секса, подойдет любой шлепок"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Твоей заднице не хватает красок. Иди и покраснь её.",
		"Найди кого-нибудь, кто оставит отпечатки ладоней на твоих ягодицах.",
		"Я хочу, чтобы когда я тебя нашел, твоя задница была саднившей и в отметинах.",
		"Твой тыл заслуживает внимания. Иди и получи хорошую порцию шлепков.",
		"Иди и пусть тебя шлепают, пока задница не станет приятно горячей.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.SpankSub):
		return 3.0
	return 0.0
