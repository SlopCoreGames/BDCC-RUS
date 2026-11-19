extends SexGoalBase

func _init():
	id = SexGoal.UseTFDrug

func getVisibleName():
	return "Принять трансформирующий препарат"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.disableTFPills || _subInfo.getChar().isOralBlocked()):
		return false
	if(_subInfo.isUnconscious() && !OPTIONS.isContentEnabled(ContentType.ForcedPermanentTFs)):
		return false
	# If we're hypnotized even a little bit, we should avoid TF pills if the pc hates them
	if(_subInfo.getChar().isPlayer() && !OPTIONS.isContentEnabled(ContentType.ForcedPermanentTFs)):
		if(GM.pc.hasEffect(StatusEffect.UnderHypnosis) && GM.pc.getFetishHolder().getFetishValue(Fetish.TFReceiving) <= 0.0):
			return false
	
	return true
	
func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
	}
	
func getGoalDefaultWeight():
	return 0.2

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Преобрази меня"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Умоляй доминанта дать тебе любой трансформирующий препарат!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы дать {sub.youHim} [color=#"+Color.cyan.to_html()+"]таблетку трансформации[/color]."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Пожалуйста, измени меня! Накорми меня чем угодно!",
		"Пожалуйста, дай мне что-нибудь, что меня изменит. Я хочу быть твоей идеальной игрушкой.",
		"Мне так нужно трансформироваться... Пожалуйста, преврати меня в кого угодно, кого пожелаешь.",
		"Пожалуйста, заставь меня измениться, трансформируй меня. Я этого хочу.",
		"Пожалуйста, мне нужно преобразиться. У тебя есть какие-нибудь наркотики?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.TFGiving: 1.0,
	}
