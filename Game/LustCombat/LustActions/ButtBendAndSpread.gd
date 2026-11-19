extends LustAction

func _init():
	id = "ButtBendAndSpread"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.GropingButt)):
		return false
	#var pc:Player = _lustState.getCharacter()
	#if(!pc.hasBodypart(BodypartSlot.Vagina) || pc.isBodypartCovered(BodypartSlot.Vagina)):
	#	return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Раздвинуть и выгнуть задницу"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Наклонись вперед и разведи ягодицы"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(!pc.isBodypartCovered(BodypartSlot.Anus)):
		text += "Ты не можешь скрыть возбуждения: ты разворачиваешься и медленно наклоняешься вперед, удерживая ноги вместе до того самого момента, пока твое анус и другие интимные места не станут видны! Затем ты разводишь ноги и руками раздвигаешь ягодицы, выставляя всё напоказ."
		text += "\n\n"
	else:
		text += "Ты не можешь скрыть возбуждения: ты разворачиваешься и медленно наклоняешься вперед, наслаждаясь тем, как подчеркиваются твои изгибы. Затем ты разводишь ноги и руками раздвигаешь ягодицы. Пошло."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasBodypart(BodypartSlot.Vagina) && !pc.isBodypartCovered(BodypartSlot.Vagina)):
		text += "Твоя киска выставлена напоказ, она тоже широко раздвинута и выглядит очень маняще."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasBodypart(BodypartSlot.Penis) && !pc.isBodypartCovered(BodypartSlot.Penis)):
		text += "Твой {pc.cock} болтается между ног, выглядя очень эрегированным."
		text += "\n\n"
		
	if(RNG.chance(60) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Сперма, покрывающая всё твое тело, медленно стекает по тебе."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.isFullyNaked()):
		text += "Какая смелость — на тебе абсолютно нет одежды. И тебе это даже нравится: ты наслаждаешься вниманием, которое окружающие уделяют тебе и твоим интимным местам, это так мило."
		text += "\n\n"
	
	if(RNG.chance(40) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "И вау, чья-то сперма вытекает из твоего использованного отверстия и стекает по бедрам, создавая настоящий беспорядок. Но выглядит это чертовски горячо — любой, кто увидит тебя, решит, что ты прирожденная спермобабка."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.HasTallyMarks)):
		text += "Когда ты крутишь задом, окружающие могут заметить на твоём теле чёрные вертикальные линии — каждая из них служит меткой того, кто тебя использовал."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.HasBodyWritings)):
		text += "Кто-то оставил надписи на твоём теле, и сейчас любой может их отчётливо разглядеть."
		text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustButtRub",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.ThickButt : 0.6,
		InterestTopic.AverageButt : 0.6,
		InterestTopic.SlimButt : 0.6,
		InterestTopic.NoVagina : 0.3,
		InterestTopic.HasVaginaOnly : 0.1,
		InterestTopic.HasVaginaAndCock : 0.3,
		InterestTopic.BigCock : 0.2,
		InterestTopic.AverageCock : 0.2,
		InterestTopic.SmallCock : 0.2,
		InterestTopic.NoCock : 0.2,
		InterestTopic.HasCockOnly : 0.1,
		InterestTopic.StuffedPussy : 0.4,
		InterestTopic.StuffedAss : 0.4,
		InterestTopic.StuffedPussyOrAss : 0.2,
		InterestTopic.CoveredInCum : 0.4,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.3,
		InterestTopic.ExposedPussy : 0.3,
		InterestTopic.ExposedAnus : 0.3,
		InterestTopic.ExposedCock : 0.3,
		InterestTopic.ExposedPanties : 0.3,
		InterestTopic.LooseAnus : 0.6,
		InterestTopic.LoosePussy : 0.6,
		InterestTopic.TightAnus : 0.6,
		InterestTopic.TightPussy : 0.6,
		InterestTopic.TallyMarks : 0.2,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.5,
		InterestTopic.ButtPlugs : 0.5,
		InterestTopic.VaginalPlugs : 0.5,
	}

func getPriority():
	return 5

func skillNeeded():
	return 3

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
