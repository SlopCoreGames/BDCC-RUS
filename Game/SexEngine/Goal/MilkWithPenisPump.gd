extends SexGoalBase

func _init():
	id = SexGoal.MilkWithPenisPump

func getVisibleName():
	return "Использовать пенис-помпу на"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	if(_subInfo.getChar().hasReachablePenis() || _subInfo.getChar().getWornPenisPump() != null):
		return true
	return false

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
	}

func getGoalDefaultWeight():
	return 0.1

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Milk my dick!"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Beg the dom to milk your dick with a penis pump!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	#var _isVagFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null)

	if(!_isBusy && !_hasBlockedArms):
		return "{sub.You} {sub.youVerb('squeeze')} {sub.yourHis} {sub.penis}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to milk {sub.yourHis} {sub.penis}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Если у тебя есть помпа для члена, пожалуйста, используй её на мне! Мне нужно чувствовать, как она вытягивает каждую каплю.",
		"Умоляю, надень на мой член помпу и просто выкачай из меня всё до последней капли.",
		"Я буду очень послушной, только пожалуйста, используй помпу на моём члене. Мне нужно, чтобы меня опустошили.",
		"Я в твоём распоряжении. Пожалуйста, дои мой член помпой, если она у тебя есть, — обращайся со мной как со своей игрушкой.",
		"Если у тебя есть помпа... пожалуйста... мне нужно, чтобы меня доили до тех пор, пока мысли не поплывут.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.SeedMilking: 1.0,
	}
