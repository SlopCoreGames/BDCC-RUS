extends LustAction

func _init():
	id = "PussyRubClit"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.SpreadingPussy)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Vagina) || pc.isBodypartCovered(BodypartSlot.Vagina)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Теребить клитор"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Удели немного внимания своей чувствительной бусинке"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Твой палец переключается на милый клитор, совершая плавные круговые движения. От этого твои заброшенные складки киски намокают всё сильнее. Мысли наполняются желанием."
		text += "\n\n"
	else:
		text += "Ты быстро трешь свой бугорок из стороны в сторону, издавая милый стон, пока соки твоей киски стекают по {pc.masc} бедрам."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты стараешься показать, какое наслаждение приносит тебе ласка клитора, надеясь довести противницу до отчаяния."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		text += "Пока ты играешь со своей киской, из твоей использованной дырочки вытекает старая сперма, создавая грязь."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasPenis()):
		text += "Твоя {pc.cock} пульсирует и течет от предэякулята, пока ты ласкаешь другие свои эрогенные зоны."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты чувствуешь невероятную близость; твоя мокрая щелка заметно пульсирует и брызжет соками."
		text += "\n\n"

	return {
		text = text,
		lust = 5,
		anim = "LustRubAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.3,
		InterestTopic.MasculineBody : 0.3,
		InterestTopic.AndroBody : 0.3,
		InterestTopic.HasVaginaOnly : 0.4,
		InterestTopic.HasVaginaAndCock : 0.4,
		InterestTopic.NoCock : 0.5,
		InterestTopic.StuffedPussy : 0.4,
		InterestTopic.StuffedPussyOrAss : 0.2,
		InterestTopic.FullyNaked : 0.8,
		InterestTopic.ExposedPussy : 1.0,
		InterestTopic.ExposedAnus : 0.3,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.5,
		InterestTopic.LoosePussy : 0.2,
		InterestTopic.TightPussy : 0.2,
		InterestTopic.TallyMarks : 0.3,
		InterestTopic.Bodywritings : 0.3,
		InterestTopic.BDSMRestraints : 0.3,
		InterestTopic.VaginalPlugs : 0.6,
		InterestTopic.Pregnant: 0.4,
	}

func getPriority():
	return 5

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
