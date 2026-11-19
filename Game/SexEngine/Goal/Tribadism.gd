extends SexGoalBase

func _init():
	id = SexGoal.Tribadism

func getVisibleName():
	return "Трибадизм"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(!_domInfo.getChar().hasReachableVagina() || !_subInfo.getChar().hasReachableVagina()):
		return false
	if(!_subInfo.getChar().canZoneOrgasm(BodypartSlot.Vagina) && !_domInfo.getChar().canZoneOrgasm(BodypartSlot.Vagina)):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 1.0,
	}

func domWantsToCum():
	return true

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(sub.hasReachableVagina() && dom.hasReachableVagina()):
		dom.rubsVaginasWith(sub.getID())
		
		if(RNG.chance(30)):
			dom.cummedOnBy(sub.getID(), FluidSource.Vagina)
		if(RNG.chance(30)):
			sub.cummedOnBy(dom.getID(), FluidSource.Vagina)

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Offer to trib"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Beg the dom to rub your pussies against each other!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isVagFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null)

	if(!_isBusy && !_hasBlockedArms && _isVagFree):
		return "{sub.You} {sub.youVerb('spread')} {sub.yourHis} {sub.vaginaStretch} pussy."
	
	return "{sub.You} {sub.youVerb('beg')} to do some scissoring with {dom.you}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно почувствовать тебя... Давай потрёмся кисками друг о друга, умоляю!",
		"Мне нужно почувствовать, какая ты мокрая. Пожалуйста, пусть наши киски поцелуются.",
		"Дай мне почувствовать тебя... пожалуйста, давай тереться друг о друга, пока у меня мозги не поплывут.",
		"Я так жажду, чтобы наши клиторы скользили друг о друга. Пожалуйста, исполни моё желание.",
		"Дай мне почувствовать жар твоей киски о мою. Мне это так нужно.",
		"Я буду такой послушной, только давай займёмся ножницами. Мне это жизненно необходимо...",
		"Пожалуйста, умоляю, дай мне почувствовать, как твоя киска втирается в мою. Я больше не могу ждать.",
		"Используй меня, пусть наши тела переплетутся. Пожалуйста, потри свою киску о мою.",
		"Твоя киска о мою — это всё, чего я хочу. Ну пожалуйста!",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Tribadism: 1.0,
	}
