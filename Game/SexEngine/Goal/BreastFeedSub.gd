extends SexGoalBase

func _init():
	id = SexGoal.BreastFeedSub

func getVisibleName():
	return "Подцель кормления грудью"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	#if(!_subInfo.getChar().canBeMilked()):
	#	return false
	if(_subInfo.getChar().isOralBlocked()):
		return false
	
	return true
	
func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressDom: 1.0,
	}
	
func getGoalDefaultWeight():
	return 0.5

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	var madeLactate:bool = false
	for _i in range(RNG.randi_range(0, 3)):
		if(dom.stimulateLactation()):
			madeLactate = true
	
	var howMuchCollected:float = 0.0
	if(RNG.chance(50) && dom.hasBodypart(BodypartSlot.Breasts) && sub.hasBodypart(BodypartSlot.Head)):
		howMuchCollected = dom.getBodypart(BodypartSlot.Breasts).getFluids().transferTo(sub.getBodypart(BodypartSlot.Head), RNG.randf_range(0.4, 1.0), 50.0)
	
	if(RNG.chance(85) && !dom.hasPerk(Perk.MilkNoSoreNipples) && !dom.hasEffect(StatusEffect.SoreNipplesAfterMilking)):
		dom.addEffect(StatusEffect.SoreNipplesAfterMilking)
	
	sendSexEvent(_sexEngine, SexEvent.BreastFeeding, _subInfo, _domInfo, {madeLactate=madeLactate, loadSize=howMuchCollected, targetIsDom=true})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Breastfeed me"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Beg the dom to feed you with their milky tits!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to breastfeed {sub.youHim} with {dom.yourHis} {dom.breasts}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, мне нужно почувствовать твой вкус. Дай мне пососать твои сиськи.",
		"Я так изголодался по тебе... пожалуйста, накорми меня своим молоком.",
		"Позволь мне быть твоим послушным питомцем и попить из твоих титек.",
		"Пожалуйста, дай мне припасть к твоим соскам и пососать их. Мне это так нужно.",
		"Умоляю тебя, прижми свои великолепные сиськи к моему рту и накорми меня.",
		"Ничто не сделало бы меня счастливее, чем если бы ты меня кормила грудью. Ну пожалуйста?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Lactation: 1.0,
	}
