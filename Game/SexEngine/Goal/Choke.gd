extends SexGoalBase

func _init():
	id = SexGoal.Choke

func getVisibleName():
	return "Подтип удушения"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.noViolence || _subInfo.isUnconscious()):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
	}

func getGoalDefaultWeight():
	return 0.2

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	for _i in range(RNG.randi_range(0, 5)):
		sendSexEvent(_sexEngine, SexEvent.Choking, _domInfo, _subInfo, {strongChoke=RNG.chance(20)})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Придуши меня!"

func getBegCategory() -> Array:
	return BegCategoryChoking

func getBegDesc() -> String:
	return "Умоляй доминанта сжать твою шею!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)

	if(!_isBusy):
		return "Обнаженная шея {sub.You} {sub.youVerb('offer')} {dom.you} {sub.yourHis}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы придушить {sub.youHim}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, я хочу чувствовать твою руку на своей шее.",
		"Удуши меня, я хочу чувствовать, что ты владеешь мной.",
		"Умоляю, перекрой мне воздух хоть на секунду... или на дольше.",
		"Я только и могу думать о твоих руках на моей шее. Ну пожалуйста?",
		"Будь грубее, прошу. Сжимай моё горло сильнее.",
		"Я хочу чувствовать себя совершенно беспомощной. Удуши меня!",
		"Пожалуйста, я буду такой послушной, только если ты меня придушишь.",
		"Обхвати мою шею пальцами и сжимай крепко. Ну пожалуйста?"
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Choking: 1.0,
	}
