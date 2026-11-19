extends NpcBreakTaskBase

func _init():
	id = "SwallowDrugs"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.3,
	}

func getSlutlockWeight() -> float:
	return 0.2

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func isPossibleForSlutlock(_npc):
	if(_npc.isOralBlocked()):
		return false
	return .isPossibleForSlutlock(_npc)

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = scaledRangeWithDifficulty(1, 1, _difficulty / 2.0)

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.DrugSwallowed):
		if(_event.getTargetChar() == _npc && _event.targetIsSub()):
			advanceTask()
			return true
	return false

func getTaskString():
	return "Проглотить таблетки: "+getProgressString()

func getTaskStringSlutLock():
	return "Заставить проглотить таблетки: "+getProgressString()

func getTaskHint(_isSlaveLevelup):
	return "Заставлять их принимать любые наркотики во время секса!"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Жри всё, что дают, и не смей ныть.",
		"Проглатывай всё, что тебе предлагают, поняла?",
		"Глотай любые таблетки, которые тебе подсовывают.",
	]

