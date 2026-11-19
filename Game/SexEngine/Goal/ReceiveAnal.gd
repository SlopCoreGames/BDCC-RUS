extends SexGoalBase

func _init():
	id = SexGoal.ReceiveAnal

func getVisibleName():
	return "Верхом (Анальный)"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(!_domInfo.getChar().hasReachableAnus() || !_subInfo.getChar().hasReachablePenis()):
		return false
	if(!_subInfo.getChar().canZoneOrgasm(BodypartSlot.Penis)):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 1.0,
		SexGoal.SubOptionalCondomOnSub: 0.5,
		SexGoal.SubOptionalApplyLubeOnDom: 0.1,
	}

func domWantsToCum():
	return true

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(sub.hasReachablePenis()):
		dom.gotAnusFuckedBy(sub.getID())
		if(RNG.chance(30)):
			dom.cummedOnBy(sub.getID())
		elif(!dom.hasWombIn(BodypartSlot.Anus) || RNG.chance(OPTIONS.getSandboxOffscreenBreedingMult()*100.0)):
			dom.cummedInAnusBy(sub.getID())

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Ride me (anal)"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Beg the dom to ride your cock with their ass!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isCockFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null)

	if(!_isBusy && !_hasBlockedArms && _isCockFree):
		return "{sub.You} {sub.youVerb('offer')} {dom.you} to ride {sub.yourHis} {sub.penis} with {dom.yourHis} ass."
	
	return "{sub.You} {sub.youVerb('offer')} {dom.you} to ride {sub.yourHis} {sub.penis} with {dom.yourHis} ass."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Мне нужно чувствовать тебя сверху, когда ты скачешь на моем члене. Разве это не звучит весело?",
		"Тебе стоит сесть на мой член верхом. Мне нужно чувствовать, как твои тугие стенки обхватывают меня.",
		"Пожалуйста, мне нужно, чтобы ты насаживалась на мой член своей анусной дыркой. Я так этого хочу.",
		"Я весь твой. Пожалуйста, возьми меня и оседлай на задницу, умоляю тебя.",
		"Не заставляй меня ждать, просто насади свою дырку на мой член и скачи на мне.",
		"Я буду таким послушным для тебя, просто дай мне почувствовать, как ты скачешь на мне своей задницей.",
		"Твоя задница — это всё, о чем я могу думать. Не хочешь оседлать мой член?",
		"Завладей моим членом, пожалуйста. Оседлай меня своей дыркой и сделай меня полностью своим.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.AnalSexReceiving: 1.0,
	}
