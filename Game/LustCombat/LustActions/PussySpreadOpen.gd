extends LustAction

func _init():
	id = "PussySpreadOpen"
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
	return "Развести киски"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Разведи свои чувствительные складки, чтобы показать, как сильно ты жаждешь секса"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Охваченная неистовым желанием, ты вставляешь два пальца в складки и раздвигаешь их. Между ними тянется видимая нить прозрачной смазки, пока ты держишь киску раздвинутой на радость любому счастливчику, который может это увидеть."
		text += "\n\n"
	else:
		text += "Ты раздвигаешь свою изголодавшуюся киску двумя пальцами, открывая невероятный вид; чем дольше ты держишь их так, тем длиннее становятся тянущиеся вниз струйки соков."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты открываешь такой великолепный вид на свою дырку, что противник просто не может не засмотреться на это непристойное зрелище."
		text += "\n\n"
	
	if(RNG.chance(60) && pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		text += "Ого, пока ты держишь щелочку раздвинутой, из неё всё больше и больше вытекает спермы, пачкая твои бёдра и капая на пол."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты настолько возбуждена, что опускаешь пальцы глубже в киску, раздвигая уже её саму. Пальцы скользят из-за обилия смазки, но тебе удается открыть потрясающий вид на влажные внутренние стенки и даже продемонстрировать готовую к траху шейку матки."
		text += "\n\n"

	return {
		text = text,
		lust = 2,
		anim = "LustRubAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.HasVaginaOnly : 0.5,
		InterestTopic.HasVaginaAndCock : 0.3,
		InterestTopic.NoCock : 0.6,
		InterestTopic.StuffedPussy : 1.0,
		InterestTopic.StuffedPussyOrAss : 0.5,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedPussy : 0.5,
		InterestTopic.ExposedAnus : 0.2,
		InterestTopic.ExposedCock : 0.1,
		InterestTopic.ExposedPanties : 0.3,
		InterestTopic.LoosePussy : 0.7,
		InterestTopic.TightPussy : 0.7,
		InterestTopic.TallyMarks : 0.2,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.3,
		InterestTopic.VaginalPlugs : 0.4,
		InterestTopic.Pregnant: 0.4,
	}

func getPriority():
	return 5

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
