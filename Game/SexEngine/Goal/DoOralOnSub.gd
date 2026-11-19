extends SexGoalBase

func _init():
	id = SexGoal.DoOralOnSub

func getVisibleName():
	return "Сделать минет сабке"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if((!_subInfo.getChar().hasReachablePenis() && !_subInfo.getChar().hasReachableVagina()) || _domInfo.getChar().isOralBlocked()):
		return false
	if(!_subInfo.getChar().canZoneOrgasm(BodypartSlot.Penis) && !_subInfo.getChar().canZoneOrgasm(BodypartSlot.Vagina)):
		return false

	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 1.0,
	}

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(sub.hasReachablePenis() && RNG.chance(50)):
		dom.gotThroatFuckedBy(sub.getID())
		if(RNG.chance(50)):
			dom.cummedInMouthBy(sub.getID())
		else:
			dom.cummedOnBy(sub.getID(), FluidSource.Penis)
	elif(sub.hasReachableVagina()):
		if(RNG.chance(50)):
			dom.cummedInMouthBy(sub.getID(), FluidSource.Vagina, RNG.randf_range(0.4, 0.8))
		else:
			dom.cummedOnBy(sub.getID(), FluidSource.Vagina, RNG.randf_range(0.4, 0.8))

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Ask for oral"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Beg the dom to pleasure your cock or pussy with their mouth!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	#var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var hasVag:bool = _subInfo.getChar().hasReachableVagina()
	var hasPP:bool = _subInfo.getChar().hasReachablePenis()

	if(hasVag && hasPP):
		return "{sub.You} {sub.youVerb('beg')} {dom.you} to pleasure {sub.yourHis} pussy or cock."
	if(hasVag):
		return "{sub.You} {sub.youVerb('beg')} {dom.you} to pleasure {sub.yourHis} {sub.pussyStretch} pussy."
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to pleasure {sub.yourHis} cock."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	var hasVag:bool = _subInfo.getChar().hasReachableVagina()
	var hasPP:bool = _subInfo.getChar().hasReachablePenis()
	
	if(hasVag && hasPP):
		return RNG.pick([
			"Пожалуйста, мне нужно почувствовать твои губы на своей киске... или на члене.",
			"Твои губы так приятно ощущались бы на моем члене, ну пожалуйста? Моя киска тоже не прочь...",
			"Я просто умираю от желания почувствовать твой язык на своей киске... или вокруг члена...",
			"Можешь отсосать мне? Или лизнуть... Я буду очень послушной для тебя.",
			"Мне нужно, чтобы твой рот оказался между моих ног, пожалуйста, умоляю тебя.",
		])
	if(hasVag):
		return RNG.pick([
			"Я только и могу думать о том, как твой язык слизывает соки из моей киски, пожалуйста...",
			"Пожалуйста, мне так сильно нужно, чтобы ты занялась моей киской ртом.",
			"Твой язык — это всё, о чем я могу думать... пожалуйста, попробуй меня на вкус.",
			"Умоляю тебя, отсоси мне киску. Мне нужно почувствовать твои губы на ней.",
			"Всего лишь глоток, пожалуйста? Дай мне почувствовать твой язык на моей киске.",
			"Мне нужно, чтобы твое лицо оказалось у меня между ног. Пожалуйста, не заставляй меня ждать.",
			"Твои губы сейчас так хорошо бы ощущались на моей киске, ну пожалуйста?",
		])
	return RNG.pick([
		"Пожалуйста, мне нужно почувствовать твой рот на моем члене.",
		"Окутай мой член своими губами, умоляю тебя.",
		"Я сделаю всё что угодно, только отсоси мне.",
		"Пожалуйста, мне нужно чувствовать влажное тепло твоего языка на моем члене.",
		"Пожалуйста, дай мне кончить в этот идеальный рот.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.OralSexGiving: 1.0,
	}
