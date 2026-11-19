extends SexGoalBase

func _init():
	id = SexGoal.SpankSub

func getVisibleName():
	return "Подчиняться шлепкам"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.noViolence || _subInfo.isUnconscious()):
		return false
	if(_subInfo.getConsciousness() <= 0.5):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 0.1,
	}

func getGoalDefaultWeight():
	return 0.4

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	for _i in range(RNG.randi_range(0, 5)):
		sendSexEvent(_sexEngine, SexEvent.Spanked, _domInfo, _subInfo, {strongSpank=RNG.chance(20), pain=RNG.randi_range(0, 1)})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Spank me"

func getBegDesc() -> String:
	return "Beg the dom to spank your ass!"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	#var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	#var _isVagFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null)

	if(!_isBusy):
		return "{sub.You} {sub.youVerb('wiggle')} {sub.yourHis} butt at {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to spank {sub.yourHis} butt."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Шлепни меня по заднице, давай!",
		"Отшлепай меня, я была такой плохой.",
		"Умоляю, отлупи меня по заднице, чтобы всё покраснело.",
		"Мне так нужно порку, пожалуйста, сделай так, чтобы жгло.",
		"Можешь, пожалуйста, наказать мою задницу? Мне это нужно.",
		"Каждая клеточка моего тела жаждет жгучих ударов твоей ладони по моей заднице.",
		"Не заставляй меня долго умолять... просто отшлепай меня, пожалуйста!",
		"Всего несколько шлепков, а? Обещаю, ты еще скажешь мне «спасибо».",
		"Заставь меня ахать от шлепков по заднице, я тебя умоляю."
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Sadism: 1.0,
	}
