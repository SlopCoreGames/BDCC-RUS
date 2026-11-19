extends SexGoalBase

func _init():
	id = SexGoal.RimSub

func getVisibleName():
	return "Римская субмиссивность"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(!_subInfo.getChar().hasReachableAnus() || _domInfo.getChar().isOralBlocked()):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
	}

func getGoalDefaultWeight():
	return 0.1

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Попросить отлизать анус"

func getBegDesc() -> String:
	return "Умолять домина, чтобы он отлизал тебе попой!"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isHoleFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null)

	if(!_isBusy && !_hasBlockedArms && _isHoleFree):
		return "{sub.You} {sub.youVerb('spread')} {sub.yourHis} {sub.anusStretch} анус для {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} отлизать {sub.yourHis} {sub.anusStretch} задний проход."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно почувствовать, как твой язык лижет мою задницу.",
		"Я буду такой послушной, если ты просто отлизаешь мне анус, ну пожалуйста.",
		"Твой язык в моей заднице — это было бы так охеренно, ну пожалуйста?",
		"Только твой язык, дразнящий моё отверстие... это всё, о чём я могу думать. Ну пожалуйста?",
		"Можешь, пожалуйста, просто отлизать мне задницу? Мне это безумно нужно.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.RimmingGiving: 1.0,
	}
