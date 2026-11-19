extends NpcBreakTaskBase

func _init():
	id = "Choke"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.4,
	}

func getSlutlockWeight() -> float:
	return 0.2

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	if(_pc.getFetishHolder().getFetishValue(Fetish.Choking) < 0.2):
		return false
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = scaledRangeWithDifficulty(3, 6, _difficulty)

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.Choking):
		if(_event.getTargetChar() == _npc):
			advanceTask()
			return true
	return false

func getTaskString():
	return "Принимать удушение: "+getProgressString("times")

func getTaskHint(_isSlaveLevelup):
	return "Душить их во время секса"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Я хочу, чтобы твое горло было в синяках. Пусть тебя как следует придушат.",
		"Тебе нужно почувствовать себя собственностью. Пусть тебя душат во время секса.",
		"Твой воздух — это привилегия. Найди кого-нибудь, кто будет душить тебя до искр из глаз.",
		"Хороший трах обязательно включает руку на горле. Иди и дай себя придушить.",
		"Покажи мне, что ты это вынесешь. Пусть тебя душат, пока голова не пойдет кругом.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.Choke):
		return 3.0
	return 0.0
