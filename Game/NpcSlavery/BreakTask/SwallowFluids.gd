extends NpcBreakTaskBase

func _init():
	id = "SwallowFluids"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.All : 1.0,
	}

func getSlutlockWeight() -> float:
	return 0.7

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func isPossibleForSlutlock(_npc):
	if(_npc.isOralBlocked()):
		return false
	return .isPossibleForSlutlock(_npc)

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	if(_pc.hasReachablePenis()):
		return true
	if(_pc.hasVagina()):
		return true
	if(_pc.hasStrapons()):
		return true
	
	return false

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = scaledRangeWithDifficulty(50, 100, _difficulty)

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.StraponCreampied || _event.getType() == SexEvent.HoleSpitted || _event.getType() == SexEvent.SwallowFluid):
		if(_event.getTargetChar() == _npc):
			if(_event.getType() == SexEvent.SwallowFluid):
				var fluidID:String = _event.getField("fluidID", "Cum")
				var fluidObj:FluidBase = GlobalRegistry.getFluid(fluidID)
				if(fluidObj && fluidObj.canImpregnate()):
					advanceTask(_event.getField("loadSize", 0))
					return true
			else:
				if(_event.getField("hole", BodypartSlot.Head) in [BodypartSlot.Head]):
					advanceTask(_event.getField("loadSize", 0))
					return true
	return false

func getTaskString():
	return "Глотать сперму: "+str(Util.roundF(currentAmount, 1))+"/"+str(Util.roundF(needAmount, 1))+"ml"

func getTaskHint(_isSlaveLevelup):
	return "Заставить их проглотить столько жидкости."

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Я хочу, чтобы ты проглатывала каждую последнюю каплю, которую тебе дают.",
		"Иди и выпей столько спермы, сколько сможешь в себя влить.",
		"Каждая порция, которую тебе предложат, должна отправляться прямиком тебе в глотку.",
		"Я хочу, чтобы, когда я найду тебя в следующий раз, ты была полна проглоченной спермы.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.FuckOral):
		return 3.0
	return 0.0
