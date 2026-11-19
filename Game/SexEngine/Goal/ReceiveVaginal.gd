extends SexGoalBase

func _init():
	id = SexGoal.ReceiveVaginal

func getVisibleName():
	return "Скачка (вагинально)"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(!_domInfo.getChar().hasReachableVagina() || !_subInfo.getChar().hasReachablePenis()):
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
		dom.gotVaginaFuckedBy(sub.getID())
		if(RNG.chance(30)):
			dom.cummedOnBy(sub.getID())
		elif(!dom.hasWombIn(BodypartSlot.Vagina) || RNG.chance(OPTIONS.getSandboxOffscreenBreedingMult()*100.0)):
			dom.cummedInVaginaBy(sub.getID())

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Скачи на мне (ваг)"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Умоляй доминанта оседлать твой член своей киской!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isCockFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null)

	if(!_isBusy && !_hasBlockedArms && _isCockFree):
		return "{sub.You} {sub.youVerb('offer')} {dom.you}, чтобы оседлать {sub.yourHis} {sub.penis} своей {dom.yourHis} киской."
	
	return "{sub.You} {sub.youVerb('offer')} {dom.you}, чтобы оседлать {sub.yourHis} {sub.penis} своей {dom.yourHis} киской."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Мне нужно чувствовать тебя сверху, когда ты скачешь на моем члене. Разве это не звучит весело?",
		"Тебе стоит сесть на мой член сверху. Мне нужно чувствовать, как твоя киска обхватывает меня.",
		"Пожалуйста, трахни меня своей киской прямо на мой член. Мне это так нужно.",
		"Я весь твой. Пожалуйста, возьми меня, оседлай на своей киске, умоляю тебя.",
		"Не заставляй меня ждать, просто насади свою киску на мой член и скачи на мне.",
		"Я буду таким послушным для тебя, просто дай мне почувствовать, как ты скачешь на мне своей киской.",
		"В моей голове только твоя киска. Не хочешь оседлать мой член?",
		"Завладей моим членом, пожалуйста. Оседлай меня своей киской и сделай меня полностью своим.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.VaginalSexReceiving: 1.0,
	}
