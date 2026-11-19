extends LustAction

func _init():
	id = "AnalSpreadOpen"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.ProddingAnal)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Anus) || pc.isBodypartCovered(BodypartSlot.Anus)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc:Player = _lustState.getCharacter()
	if(pc.hasBoundArms()):
		return [false, "You can't do that with bound arms"]
	#if(pc.hasBlockedHands()):
	#	return [false, "You can't do that with blocked hands"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Раздвинуть анус"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Растянуть анус"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Охваченная похотью и жаждой ласки, ты разводишь ягодицы и двумя пальцами растягиваешь свое {pc.analStretch} заднее отверстие настолько широко, насколько это возможно. Как же это похотливо."
		text += "\n\n"
	else:
		text += "Ты раздвигаешь ягодицы и двумя пальцами растягиваешь свою готовую к траху дырочку, невольно издавая при этом тихий стон."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты открываешь такой великолепный вид на свою дырку, что противник просто не может не засмотреться на это непристойное зрелище."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.HasCumInsideAnus)):
		text += "Ого, пока ты держишь задницу раздвинутой, из неё всё сильнее вытекает сперма, пачкая твои бёдра и капая на пол."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.getLust() >= 50):
		text += "Ты настолько возбуждена, что начинаешь покачивать бёдрами и стонать от одной лишь мысли о том, что кто-то воспользуется твоей дырочкой."
		text += "\n\n"

	return {
		text = text,
		lust = 2,
		anim = "LustButtRub",
	}

func getLustTopics():
	return {
		InterestTopic.ThickButt : 0.3,
		InterestTopic.AverageButt : 0.3,
		InterestTopic.SlimButt : 0.3,
		InterestTopic.StuffedAss : 1.0,
		InterestTopic.StuffedPussyOrAss : 0.5,
		InterestTopic.FullyNaked : 0.4,
		InterestTopic.ExposedPussy : 0.3,
		InterestTopic.ExposedAnus : 0.8,
		InterestTopic.ExposedCock : 0.3,
		InterestTopic.LooseAnus : 1.0,
		InterestTopic.TightAnus : 1.0,
		InterestTopic.TallyMarks : 0.1,
		InterestTopic.Bodywritings : 0.1,
		InterestTopic.ButtPlugs : 0.2,
	}

func getPriority():
	return 5

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
