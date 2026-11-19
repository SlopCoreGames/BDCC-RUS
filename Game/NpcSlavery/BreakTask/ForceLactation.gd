extends NpcBreakTaskBase

func _init():
	id = "ForceLactation"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.2,
	}

func getSlutlockWeight() -> float:
	return 0.2

func isPossibleFor(_npc, _isSlaveLevelup):
	if(!_npc.hasNonFlatBreasts()):
		return false
	if(_npc.isLactating()):
		return false
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	return true

func isCompletedFor(_npc):
	if(_npc.isLactating()):
		return true
	return false

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = 1

func onSexEvent(_npc, _event:SexEvent):
	return false

func getTaskString():
	return "Force to lactate"

func getTaskStringSlutLock():
	return "Begin lactating"

func getTaskHint(_isSlaveLevelup):
	return "Squeeze their breasts until the milk starts coming out"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Эти сиськи здесь не просто для красоты. Доведи их до состояния, пока не потечёт молоко.",
		"Мне нужно твоё молоко. Найди кого-нибудь, кто будет мять твои титьки, пока из них не потечёт струйками.",
		"Твоё предназначение — кормить. Пусть твои соски хорошенько разминают, пока не начнёшь лактировать.",
		"Пора твоей груди принести пользу. Иди и дай себя подоить.",
		"Из тебя выйдет отличная дойная корова. Иди и развлекайся, пока не начнёшь выдавать молоко.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.BreastFeedOnSub):
		return 1.0
	if(_sexGoalID == SexGoal.GropeBreasts):
		return 2.0
	if(_sexGoalID == SexGoal.MilkWithBreastPump):
		return 1.0
	return 0.0
