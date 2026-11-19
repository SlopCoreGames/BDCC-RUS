extends SexGoalBase

func _init():
	id = SexGoal.FuckOral

func getVisibleName():
	return "Отсосать"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if((!_domInfo.getChar().hasReachablePenis() && !_domInfo.getChar().hasReachableVagina()) || _subInfo.getChar().isOralBlocked()):
		return false
	if(!_domInfo.getChar().canZoneOrgasm(BodypartSlot.Penis) && !_domInfo.getChar().canZoneOrgasm(BodypartSlot.Vagina)):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressDom: 1.0,
	}

func domWantsToCum():
	return true

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	if(dom.hasReachablePenis() && RNG.chance(50)):
		sub.gotThroatFuckedBy(dom.getID())
		if(RNG.chance(50)):
			sub.cummedInMouthBy(dom.getID())
		else:
			sub.cummedOnBy(dom.getID(), FluidSource.Penis)
	elif(dom.hasReachableVagina()):
		if(RNG.chance(50)):
			sub.cummedInMouthBy(dom.getID(), FluidSource.Vagina, RNG.randf_range(0.4, 0.8))
		else:
			sub.cummedOnBy(dom.getID(), FluidSource.Vagina, RNG.randf_range(0.4, 0.8))

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

	if(RNG.chance(20)):
		var zone = BodyWritingsZone.getRandomZone()
		var writingID = BodyWritings.getRandomWritingIDForZone(zone)
		sub.addBodywriting(zone, writingID)
		sendSexEvent(_sexEngine, SexEvent.BodyWritingAdded, _domInfo, _subInfo, {zone=zone,writingID=writingID})
	
	if(RNG.chance(20) || sub.hasTallymarks() || (_sexEngine.getSexTypeID() in [SexType.StocksSex, SexType.SlutwallSex])):
		if(!sub.isPlayer() || !GM.main.getEncounterSettings().isGoalDisabledForSubPC(SexGoal.AddTallymarks)):
			sub.addTallymarkFace()

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Предложить ротик"

func getBegCategory() -> Array:
	return BegCategorySex

func getBegDesc() -> String:
	return "Умоляй домина, чтобы он оттрахал тебе лицо!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)

	if(!_isBusy):
		return "{sub.You} {sub.youVerb('open')} {sub.yourHis} широко раскрывает рот для {dom.you}."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы использовать {sub.yourHis} рот."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	var hasVag:bool = _domInfo.getChar().hasReachableVagina()
	var hasPP:bool = _domInfo.getChar().hasReachablePenis()
	
	if(hasVag && hasPP):
		return RNG.pick([
			"Умоляю, трахни мне рот своим членом... или просто разминай мой язык, просто используй меня.",
			"Используй моё лицо как хочешь, просто позволь мне служить тебе.",
			"Мне нужно, чтобы твоя киска была у меня во рту, пожалуйста, разминай мой язык... Или просто засунь свой член мне в глотку.",
			"Пожалуйста, позволь мне поклоняться твоей киске или члену своим ртом.",
			"Пожалуйста, мне нужен твой член во рту... или твоя киска на моем языке, просто используй моё лицо.",
			"Умоляю, дай мне тебя попробовать. Трахни мне рот или оседлай мой язык, мне нужно почувствовать тебя.",
			"Пожалуйста, используй моё лицо. Я хочу, чтобы ты кончил на него или трахал мне глотку, пока я не перестану дышать.",
			"Мне нужно, чтобы ты меня уничтожил(а). Пожалуйста, трахни мне рот своим членом или задуши меня своей киской.",
		])
	if(hasVag):
		return RNG.pick([
			"Пожалуйста, дай мне тебя попробовать.",
			"Мне нужно почувствовать тебя на своем языке, пожалуйста.",
			"Используй моё лицо, умоляю тебя.",
			"Позволь мне боготворить тебя губами, пожалуйста.",
			"Потрись об меня, мне это нужно.",
			"Пожалуйста, просто сядь мне на лицо и используй меня.",
			"Я просто одержим желанием лизать твою киску.",
			"Пожалуйста, позволь мне довести тебя до оргазма языком.",
			"Я буду послушной, только дай мне отсосать тебе.",
			"Задуши меня своей киской, пожалуйста.",
			"Оседлай моё лицо, мне нужно чувствовать тебя.",
		])
	return RNG.pick([
		"Пожалуйста, используй мой рот, мне нужно чувствовать тебя.",
		"Умоляю, оттрахай мне лицо.",
		"Не заставляй меня ждать, просто засунь свой член мне в глотку.",
		"Пожалуйста, забей свой член мне в горло и используй меня.",
		"Пожалуйста, растяни мне глотку, просто оттрахай мне рот.",
		"Просто схвати меня за голову и возьми всё, что тебе нужно, пожалуйста.",
		"Я буду послушной, обещаю, только, пожалуйста, оттрахай мне лицо."
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.OralSexReceiving: 1.0,
	}
