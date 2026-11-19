extends SexGoalBase

func _init():
	id = SexGoal.StraponVaginal

func getVisibleName():
	return "Вагинальный секс в страпоне"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	if(_subInfo.isUnconscious()):
		return false
	if(!_domInfo.getChar().canWearOrWearingStrapon() || !_subInfo.getChar().hasReachableVagina()):
		return false
	
	return true
	
func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
		SexGoal.SubUndressDom: 1.0,
		SexGoal.SubWearStraponOnDom: 1.0,
		SexGoal.SubOptionalApplyLubeOnSub: 0.5,
	}

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Offer pussy"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Beg the dom to fuck your pussy with a strapon!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isVagFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null)

	if(!_isBusy && !_hasBlockedArms && _isVagFree):
		return "{sub.You} {sub.youVerb('spread')} {sub.yourHis} {sub.vaginaStretch} pussy."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to fuck {sub.yourHis} {sub.vaginaStretch} pussy with a strapon."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно почувствовать, как ты трахаешь мою киску. Подойдёт любая игрушка.",
		"Трахни мою киску, используй игрушку, умоляю тебя!",
		"Мне так сильно нужен дилдо в мою киску.",
		"Трахни мою киску, она вся твоя. Если надо, используй страпон...",
		"Я буду такой послушной, только пожалуйста, трахни мою киску... любой игрушкой.",
		"Позволь мне почувствовать тебя глубоко внутри моей киски, пожалуйста. Используй игрушку...",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.StraponSexVaginal: 1.0,
	}
