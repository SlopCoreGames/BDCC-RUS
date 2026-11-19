extends SexGoalBase

func _init():
	id = SexGoal.MilkWithBreastPump

func getVisibleName():
	return "Использовать молокоотсос на"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
	}

func getGoalDefaultWeight():
	return 0.5

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Milk me!"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Beg the dom to milk your breasts with a breast pump!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	#var _isVagFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null)

	if(!_isBusy && !_hasBlockedArms):
		return "{sub.You} {sub.youVerb('squeeze')} {sub.yourHis} {sub.breasts} for {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to milk {sub.yourHis} {sub.breasts}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Моя грудь такая тяжелая, она просто ноет от желания... если у тебя есть молокоотсосы, пожалуйста, используй их.",
		"Я буду послушной, только умоляю, подои мою грудь.",
		"Если у тебя есть молокоотсосы, примени их на мне... мне это безумно нужно.",
		"Каждая клеточка моего тела молит о том, чтобы ты прицепил к моим сиськам молокоотсосы и выкачал всё до капли.",
		"Пожалуйста, я хочу быть твоей послушной маленькой коровкой, просто подои меня.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Lactation: 1.0,
	}
