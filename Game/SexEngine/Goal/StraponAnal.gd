extends SexGoalBase

func _init():
	id = SexGoal.StraponAnal

func getVisibleName():
	return "Анальный страпон"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	if(_subInfo.isUnconscious()):
		return false
	if(!_domInfo.getChar().canWearOrWearingStrapon() || !_subInfo.getChar().hasReachableAnus()):
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
	return "Peg me!"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Beg the dom to fuck your ass with a strapon!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isHoleFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null)

	if(!_isBusy && !_hasBlockedArms && _isHoleFree):
		return "{sub.You} {sub.youVerb('spread')} {sub.yourHis} {sub.anusStretch} tailhole for {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to peg {sub.yourHis} {sub.anusStretch} tailhole."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"У тебя есть страпон? Пожалуйста, мне нужно почувствовать тебя внутри своей задницы...",
		"Используй страпон на моей заднице, умоляю тебя.",
		"У тебя есть страпон? Трахни меня в зад, я больше не могу ждать.",
		"Наполни мою задницу, мне это так нужно. Используй дилдо, мне плевать...",
		"Я буду такой послушной для тебя, только, пожалуйста, сделай мне пеггинг.",
		"Пожалуйста, мне нужно, чтобы ты меня растянул. У тебя есть страпон?..",
	])

func getBegDenyDialogue() -> String:
	return RNG.pick([
		"С чего бы мне делать тебе пеггинг?",
		"Хочешь, чтобы тебя оттрахали страпоном? Серьёзно? Нет.",
		"Никакого пеггинга для тебя.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.StraponSexAnal: 1.0,
	}
