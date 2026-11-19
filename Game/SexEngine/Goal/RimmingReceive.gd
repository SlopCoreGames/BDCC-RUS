extends SexGoalBase

func _init():
	id = SexGoal.RimmingReceive

func getVisibleName():
	return "Получать римминг"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(!_domInfo.getChar().hasReachableAnus() || _subInfo.getChar().isOralBlocked()):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressDom: 1.0,
	}

func getGoalDefaultWeight():
	return 0.1

func domWantsToCum():
	return true

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Offer to rim"

func getBegDesc() -> String:
	return "Beg the dom to let you eat their butt out!"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)

	if(!_isBusy):
		return "{sub.You} {sub.youVerb('open')} {sub.yourHis} mouth wide for {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to let {sub.youHim} rim {dom.yourHis} butt."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно попробовать твою попку на вкус. Позволь мне ей поклониться.",
		"Пожалуйста, позволь мне служить тебе своим языком. Я хочу, чтобы тебе было невероятно хорошо.",
		"Пожалуйста, мне нужно попробовать тебя. Дай мне съесть эту прекрасную задницу.",
		"Мысль о том, как мой язык скользит по твоему анусу, сводит меня с ума. Ну пожалуйста?",
		"Позволь мне угодить тебе ртом. Умоляю, дай мне съесть эту идеальную задницу.",
		"Ты даже не представляешь, как сильно мне хочется отлизать тебя прямо сейчас. Ну пожалуйста?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.RimmingReceiving: 1.0,
	}
