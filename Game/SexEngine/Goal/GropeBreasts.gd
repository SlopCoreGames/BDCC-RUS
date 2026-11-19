extends SexGoalBase

func _init():
	id = SexGoal.GropeBreasts

func getVisibleName():
	return "Щипание груди"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	return true
	
func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 0.1,
	}
	
func getGoalDefaultWeight():
	return 0.5

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	#var dom = _domInfo.getChar()
	var madeLactate:bool = false
	for _i in range(RNG.randi_range(0, 3)):
		if(sub.stimulateLactation()):
			madeLactate = true
	
	sendSexEvent(_sexEngine, SexEvent.BreastsGroped, _domInfo, _subInfo, {madeLactate=madeLactate})

	if(RNG.chance(50)):
		sendSexEvent(_sexEngine, SexEvent.PainInflicted, _domInfo, _subInfo, {pain=RNG.randi_range(1, 20),isDefense=false,intentional=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Пощупай меня"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Умоляй доминанта потискать твои сиськи!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	var _isBusy:bool = _sexEngine.hasTag(_subInfo.charID, SexActivityTag.HavingSex)
	var _hasBlockedArms:bool = _subInfo.getChar().hasBlockedHands() || _subInfo.getChar().hasBoundArms()
	var _isTitsFree:bool = (_subInfo.getChar().getFirstItemThatCoversBodypart(BodypartSlot.Breasts) == null)

	if(!_isBusy && !_hasBlockedArms && _isTitsFree):
		return "{sub.You} {sub.youVerb('squeeze')} {sub.yourHis} {sub.breasts} tightly."
	
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы он пощупал {sub.yourHis} {sub.breasts}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно, чтобы твои руки были на моих сиськах...",
		"Умоляю, почувствуй, какими твердыми стали мои соски от тебя. Потискай мои сиськи.",
		"Просто прикоснись, пожалуйста, мне нужно почувствовать, как твои руки сжимают мою грудь.",
		"Я так сильно хочу, чтобы твои руки были повсюду на моих сиськах.",
		"Я буду послушной, только пожалуйста, позволь твоим рукам ласкать мою грудь.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Lactation: 1.0,
	}
