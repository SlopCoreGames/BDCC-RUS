extends SexGoalBase

func _init():
	id = SexGoal.Pawjob

func getVisibleName():
	return "Павджоб"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundLegs()):
		return false
	if(!_subInfo.getChar().hasReachablePenis()):
		return false
	if(!_subInfo.getChar().canZoneOrgasm(BodypartSlot.Penis)):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 0.1,
		SexGoal.SubOptionalCondomOnSub: 0.2,
	}

func getGoalDefaultWeight():
	return 0.3

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(sub.hasReachablePenis()):
		if(RNG.chance(30)):
			sub.cummedOnBy(sub.getID())
		elif(RNG.chance(30)):
			dom.cummedOnBy(sub.getID())
	
	sendSexEvent(_sexEngine, SexEvent.UniqueOrgasm, _domInfo, _subInfo, {orgasmType=UniqueOrgasm.Feet})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Pawjob"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Умоляй домина, чтобы он сделал тебе минет рукой!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы сделать {sub.youHim} минет рукой."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Позволишь мне почувствовать, как твои мягкие {dom.feet} ласкают мой член?",
		"Я бы всё отдал, чтобы твои {dom.feet} ласкали мой член.",
		"Твои {dom.feet} выглядят так идеально, пожалуйста, дай мне получить от них удовольствие.",
		"Ты могла бы... использовать свои {dom.feet} чтобы довести меня? Пожалуйста?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.FeetplayGiving: 1.0,
	}
