extends NpcBreakTaskBase

func _init():
	id = "ChastityOrgasm"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 0.25,
	}

func getSlutlockWeight() -> float:
	return 0.2

func isPossibleFor(_npc, _isSlaveLevelup):
	if(!_npc.hasPenis()):
		return false
	if(_npc.getFetishHolder().getFetishValue(Fetish.AnalSexReceiving) < 0.0):
		return false
	if(!_npc.hasReachablePenis() && !_npc.isWearingChastityCage()):
		return false
	return true

func isPossibleForSlutlock(_npc):
	if(!_npc.hasPenis()):
		return false
	if(!_npc.canZoneOrgasm(BodypartSlot.Anus) && !_npc.hasReachableVagina()):
		return false
	if(!_npc.hasReachablePenis() && !_npc.isWearingChastityCage()):
		return false
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	if(!_pc.hasChastityCages()):
		return false
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = scaledRangeWithDifficulty(1, 2, _difficulty)

func onSexEvent(_npc, _event:SexEvent):
	if(_npc.isWearingChastityCage() && _event.getType() == SexEvent.Orgasmed):
		if(_event.getTargetChar() == _npc):
			advanceTask()
			return true
	return false

func getTaskString():
	return "Orgasm while chasted: "+getProgressString()

func getTaskHint(_isSlaveLevelup):
	return "Force them to orgasm while they are wearing a chastity cage"

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Время для испытания. Я хочу, чтобы ты кончила прямо в своей девайсной клетке.",
		"Докажи свою преданность. Кончи, пока ты всё еще заперта.",
		"Тебе не нужно быть свободной, чтобы достичь пика. Заставь себя кончить в целомудрии.",
		"Клетка не должна тебя останавливать. Я хочу видеть, как ты кончаешь сквозь неё.",
		"Настоящая шлюшка может кончить, даже когда она в клетке. Покажи мне, что ты настоящая шлюшка.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.FuckAnal):
		return 3.0
	if(_sexGoalID == SexGoal.StraponAnal):
		return 3.0
	if(_sexGoalID == SexGoal.FuckVaginal):
		return 2.0
	if(_sexGoalID == SexGoal.StraponVaginal):
		return 2.0
	return 0.0
