extends NpcBreakTaskBase

func _init():
	id = "InflictPain"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.5,
	}

func getSlutlockWeight() -> float:
	return 0.5

func isPossibleFor(_npc, _isSlaveLevelup):
	if(_npc.getFetishHolder().getFetishValue(Fetish.Masochism) <= 0.0):
		return false
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = Util.mini(100, scaledRangeWithDifficulty(10, 33, _difficulty))

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.PainInflicted):
		if(_event.getTargetChar() == _npc):
			advanceTask(_event.getField("pain", 0))
			return true
	return false

func getTaskString():
	return "Испытывать боль во время секса: "+getProgressString("pain")

func getTaskHint(_isSlaveLevelup):
	return "Заставлять их испытывать боль во время секса"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"В следующий раз, когда я тебя увижу, всё твоё тело должно быть в синяках.",
		"Иди и набей себе синяков. Хочу их видеть.",
		"Иди и набей себе синяков, как настоящая больная сучка.",
		"Не смей показываться мне на глаза, пока не покроешься синяками."
	]
