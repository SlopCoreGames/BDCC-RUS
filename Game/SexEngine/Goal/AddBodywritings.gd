extends SexGoalBase

func _init():
	id = SexGoal.AddBodywritings

func getVisibleName():
	return "Добавить надписи на теле"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 0.3,
	}

func getGoalDefaultWeight():
	return 0.0

#func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
#	var sub = _subInfo.getChar()
#
#	var zone:int = BodyWritingsZone.getRandomZone()
#	if(_sexEngine.getSexTypeID() == SexType.SlutwallSex):
#		zone = BodyWritingsZone.getRandomZoneLowerPart()
#
#	var writingID:String = BodyWritings.getRandomWritingIDForZone(zone)
#	var isPermanent:bool = false
#	sub.addBodywriting(zone, writingID, isPermanent)
#	sendSexEvent(_sexEngine, SexEvent.BodyWritingAdded, _domInfo, _subInfo, {zone=zone,writingID=writingID,isPermanent=false})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Попросить надписи на теле"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Умолять домина, чтобы он(а) что-нибудь написал(а) на твоем теле!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы написать на теле {sub.yourHis}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Я хочу быть твоим холстом... Пожалуйста...",
		"Мне нужно, чтобы ты исписал меня целиком... Ну пожалуйста?",
		"Пожалуйста... Напиши на моем теле что-нибудь приятное...",
		"Пожалуйста... Напиши на моем теле что-нибудь пошлое...",
		"Оставишь мне надписи на теле в подарок?",
		"Возьмешь маркер и опишешь меня так, чтобы все видели...?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Bodywritings: 1.0,
	}
