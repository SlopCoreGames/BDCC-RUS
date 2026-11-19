extends LustAction

func _init():
	id = "TeasePussy"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isDoingActivity(LustActivity.SpreadingPussy)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Vagina) || !pc.isBodypartCovered(BodypartSlot.Vagina)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Ласкать киску"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Поласкать свою киску через одежду"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Твоя рука скользит вниз к прикрытой паху и замирает там. Ты чувствуешь, что под тканью скрываются жаждущие половые губы и милый клитор. Твои пальцы очерчивают щелочку, а затем нежно массируют чувствительную точку, заставляя тебя издать томный стон."
		text += "\n\n"
	else:
		text += "Ты незаметно просовываешь руку к своей щелочке. Ты обводишь пальцем контуры киски, а затем нащупываешь крошечный клитор. Ты начинаешь теребить его через ткань, дразня себя и издавая тихие звуки удовольствия."
		text += "\n\n"
		
	if(RNG.chance(30) && _lustState.isInBattle()):
		text += "Ты ухмыляешься врагу, продолжая дразнить свою щелочку. Ты ясно даешь понять: если они хотят этого, им придется попотеть."
		text += "\n\n"
		
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		text += "Пока ты продолжаешь теребить щелочку через одежду, выделяется смазка. Смазка от твоих предыдущих любовников оставляет темные пятна на ткани и стекает по твоим {pc.masc} бедрам. Ну ты и грязнуля~."
		text += "\n\n"
		
	if(RNG.chance(20) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Столько спермы на твоем теле... Ты зачерпываешь немного пальцами и втираешь её в промежность — нельзя же давать такому доброму делу пропасть зря."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.getLust() >= 50):
		text += "Твоя киска такая мокрая и сочная, что кажется, ты кончишь, просто дразня себя... Ты сильнее прижимаешь одежду, заставляя её глубже вжиматься в чувствительные складки."
		text += "\n\n"
		
	if(RNG.chance(20) && pc.hasPenis()):
		text += "Пока ты ласкаешь свою киску, твой {pc.cock} становится только тверже и выделяет всё больше предэякулята, оставляя очередное влажное пятно на ткани."
		text += "\n\n"
	
	if(RNG.chance(50)):
		text += RNG.pick([
			"[say=pc]Да, моя киска так приятно горит..[/say]",
			"[say=pc]Блядь, как же хочется всадить себе пальцы поглубже..[/say]",
			"[say=pc]Любой может увидеть, как я тереблю свою жаждущую киску..[/say]",
			"[say=pc]Ох, блядь..[/say]",
		])
		text += "\n\n"
		
		if(_lustState.isInPublic() && !_lustState.isInBattle()):
			text += "Ты надеешься, что никто этого не услышал... Пытаешься держать рот на замке, но ощущения просто зашкаливают..."
			text += "\n\n"
		
	return {
		text = text,
		lust = 1,
		anim = "LustRubAttack",
	}

func getLustTopics():
	return {
		InterestTopic.HasVaginaOnly : 0.8,
		InterestTopic.HasVaginaAndCock : 0.8,
		InterestTopic.StuffedPussy : 0.7,
		InterestTopic.StuffedPussyOrAss : 0.4,
		InterestTopic.CoveredInCum : 0.4,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.3,
		InterestTopic.ExposedPussy : 0.6,
		InterestTopic.ExposedBreasts : 0.3,
		InterestTopic.ExposedCock : 0.3,
		InterestTopic.ExposedPanties : 0.7,
		InterestTopic.ExposedBra : 0.5,
		InterestTopic.LoosePussy : 0.3,
		InterestTopic.TightPussy : 0.3,
		InterestTopic.VaginalPlugs : 0.7,
	}

func getPriority():
	return 4

func isTease():
	return true

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
