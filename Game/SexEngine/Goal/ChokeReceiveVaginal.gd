extends SexGoalBase

func _init():
	id = SexGoal.ChokeReceiveVaginal

func getVisibleName():
	return "Скачки + Удушение (Вагинально)"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.noViolence):
		return false
	if(!_domInfo.getChar().hasReachableVagina() || !_subInfo.getChar().hasReachablePenis()):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	if(!_subInfo.getChar().canZoneOrgasm(BodypartSlot.Penis)):
		return false
	if(_sexEngine.getSexTypeID() == SexType.TentaclesSex):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubChoking: 1.0,
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 1.0,
		SexGoal.SubOptionalCondomOnSub: 0.5,
		SexGoal.SubOptionalApplyLubeOnDom: 0.1,
	}

func getGoalDefaultWeight():
	return 0.5

func domWantsToCum():
	return true

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	for _i in range(RNG.randi_range(0, 3)):
		sendSexEvent(_sexEngine, SexEvent.Choking, _domInfo, _subInfo, {strongChoke=RNG.chance(20)})
	
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(sub.hasReachablePenis()):
		dom.gotVaginaFuckedBy(sub.getID())
		if(!dom.hasWombIn(BodypartSlot.Vagina) || RNG.chance(OPTIONS.getSandboxOffscreenBreedingMult()*100.0)):
			dom.cummedInVaginaBy(sub.getID())

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Choke+ride me (vag)"

func getBegCategory() -> Array:
	return BegCategoryChoking
	
func getBegDesc() -> String:
	return "Beg the dom to ride your cock with their pussy while also choking you!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to ride {sub.yourHis} cock while choking {sub.youHim}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, я хочу чувствовать, как твоя киска насаживается на мой член, пока твоя рука сжимает моё горло.",
		"Умоляю, обхвати мою шею руками и возьми мой член своей идеальной киской.",
		"Пожалуйста, дай мне почувствовать, как ты кончаешь на мой член, пока ты перекрываешь мне дыхание.",
		"Трахни меня своей мокрой киской и крепко сожми моё горло, пожалуйста, я умоляю.",
		"Позволь мне принадлежать тебе, чувствовать, как твоя киска доит мой член, пока ты контролируешь моё дыхание, пожалуйста.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Choking: 1.0,
		Fetish.VaginalSexReceiving: 1.0,
	}
