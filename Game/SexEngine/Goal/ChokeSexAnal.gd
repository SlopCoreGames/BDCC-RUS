extends SexGoalBase

func _init():
	id = SexGoal.ChokeSexAnal

func getVisibleName():
	return "Анальный секс с удушением"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.noViolence):
		return false
	if(!_domInfo.getChar().hasReachablePenis() || !_subInfo.getChar().hasReachableAnus()):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	if(!_domInfo.getChar().canZoneOrgasm(BodypartSlot.Penis)):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubChoking: 1.0,
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 1.0,
		SexGoal.SubOptionalCondomOnDom: 1.0,
		SexGoal.SubOptionalApplyLubeOnSub: 0.5,
	}

func canLeadToSubsPregnancy(_sexEngine, _domInfo, _subInfo, _data):
	if(_subInfo.getChar().hasWombIn(BodypartSlot.Anus)):
		return true
	return false

func getGoalDefaultWeight():
	return 0.5

func domWantsToCum():
	return true

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	for _i in range(RNG.randi_range(0, 3)):
		sendSexEvent(_sexEngine, SexEvent.Choking, _domInfo, _subInfo, {strongChoke=RNG.chance(20)})
	
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(dom.hasReachablePenis()):
		sub.gotAnusFuckedBy(dom.getID())
		if(!sub.hasWombIn(BodypartSlot.Anus) || RNG.chance(OPTIONS.getSandboxOffscreenBreedingMult()*100.0)):
			sub.cummedInAnusBy(dom.getID())

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Choke+fuck my ass!"

func getBegCategory() -> Array:
	return BegCategoryChoking
	
func getBegDesc() -> String:
	return "Beg the dom to fuck your ass while choking you!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isHoleFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null)

	if(!_isBusy && !_hasBlockedArms && _isHoleFree):
		return "{sub.You} {sub.youVerb('spread')} {sub.yourHis} {sub.anusStretch} tailhole for {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to use {sub.yourHis} {sub.anusStretch} tailhole while also choking {sub.youHim}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, трахай меня в задницу, пока душишь, я хочу чувствовать, что ты полностью владеешь мной.",
		"Души меня и трахай в задницу, умоляю, мне нужно чувствовать тебя во всех смыслах.",
		"Я умоляю тебя, пожалуйста, используй мою задницу, пока твоя рука сжимает моё горло.",
		"Пожалуйста, мне нужен твой член в моей заднице и твоя рука на моем горле, не заставляй меня ждать.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Choking: 1.0,
		Fetish.AnalSexGiving: 1.0,
	}
