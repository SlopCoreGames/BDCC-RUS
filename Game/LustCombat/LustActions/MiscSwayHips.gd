extends LustAction

func _init():
	id = "MiscSwayHips"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Качать бедрами"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Устроить кокетливый танец, демонстрируя свои изгибы"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты расставляешь ноги на ширине плеч и начинаешь вилять своими {pc.masc} ягодицами из стороны в сторону и вверх-вниз, отчего твои бедра и булки следуют за движениями с небольшой задержкой. Ты позволяешь своему {pc.thick} телу исполнять этот гипнотический танец какое-то время."
		text += "\n\n"
	else:
		text += "Ты добавляешь больше амплитуды в движения бедрами, исполняя соблазнительный танец на месте. Никакой спешки, только медленные и сексуальные движения: ты виляешь своими {pc.thick} {pc.masc} бедрами из стороны в сторону, выставляя напоказ каждый свой изгиб."
		text += "\n\n"
		
	if(RNG.chance(60) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Сперма, покрывающая всё твоё тело, медленно стекает вниз. Когда ты двигаешься и виляешь бедрами, за тобой тянется липкий след. И тебе это даже нравится — ты наслаждаешься этой тягучей грязью."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.isFullyNaked()):
		text += "Какая смелость — на тебе абсолютно нет одежды. И тебя это не смущает; ты наслаждаешься вниманием, которое окружающие уделяют тебе и твоим интимным местам, — это дарит невероятное чувство свободы."
		text += "\n\n"
	
	if(RNG.chance(40) && pc.hasBodypart(BodypartSlot.Breasts) && !pc.isBodypartCovered(BodypartSlot.Breasts)):
		text += "Твои {pc.breasts} на виду у всех. Твердые, возбужденные соски двигаются вместе с телом и задевают воздух, пока ты трясешь задницей."
		text += "\n\n"
	
	if(RNG.chance(40) && pc.hasBodypart(BodypartSlot.Penis) && !pc.isBodypartCovered(BodypartSlot.Penis)):
		text += "Твой твердый как камень {pc.cock} выставлен напоказ и сочит предэякулят, а яички покачиваются в воздухе."
		text += "\n\n"
		
	if(RNG.chance(40) && pc.hasBodypart(BodypartSlot.Vagina) && !pc.isBodypartCovered(BodypartSlot.Vagina)):
		text += "Ты не прячешь свою щелочку, а дразняще выставляешь напоказ влажные чувствительные складки, когда разворачиваешься и начинаешь тереть бедра друг о друга."
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

	if(_lustState.isInBattle() && pc.hasPerk(Perk.NakedMagicHips) && RNG.chance(20 + sqrt(pc.getStat(Stat.Vitality)))):
		var enemy:BaseCharacter = _lustState.getEnemyCharacter()
		if(enemy != null):
			enemy.addEffect(StatusEffect.Weakness, [2])
			text += "[b]Твои бедра ослабили врага![/b]"
			text += "\n\n"
	
	if(_lustState.isInBattle() && pc.hasPerk(Perk.HypnosisHypnoticAllure) && pc.hasEffect(StatusEffect.Suggestible)):
		var stacks = HypnokinkUtil.getSuggestibleStacks(pc)
		if(RNG.chance(stacks)):
			var enemy:BaseCharacter = _lustState.getEnemyCharacter()
			if(enemy != null):
				enemy.addEffect(StatusEffect.Suggestible, [RNG.randi_range(5,15)])
				text += "[b]Твои бедра загипнотизировали врага![/b]"
				text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustBodyAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 1.0,
		InterestTopic.MasculineBody : 1.0,
		InterestTopic.AndroBody : 1.0,
		InterestTopic.ThickBody : 0.8,
		InterestTopic.SlimBody : 0.8,
		InterestTopic.AverageMassBody : 0.8,
		InterestTopic.CoveredInCum : 0.7,
		InterestTopic.CoveredInLotsOfCum : 0.5,
		InterestTopic.FullyNaked : 0.7,
		InterestTopic.ExposedPussy : 0.4,
		InterestTopic.ExposedAnus : 0.4,
		InterestTopic.ExposedBreasts : 0.4,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.4,
		InterestTopic.ExposedBra : 0.4,
		InterestTopic.TallyMarks : 0.8,
		InterestTopic.Bodywritings : 0.8,
		InterestTopic.Gags : 0.3,
		InterestTopic.Blindfolds : 0.3,
		InterestTopic.BDSMRestraints : 0.4,
		InterestTopic.ButtPlugs : 0.5,
		InterestTopic.VaginalPlugs : 0.5,
		InterestTopic.Pregnant: 1.0,
	}

func getPriority():
	return 4

func isTease():
	return true

func getExperience(_lustState: LustCombatState, _args):
	var arr = []
	var pc:Player = _lustState.getCharacter()
	
	if(pc.hasPerk(Perk.HypnosisHypnoticAllure)):
		arr += [[Skill.Hypnosis, 1]]
		
	if(_lustState.isInPublic()):
		arr += [[Skill.Exhibitionism, 1]]
		
	return arr
