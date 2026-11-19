extends LustAction

func _init():
	id = "TeaseBreasts"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isDoingActivity(LustActivity.GropingChest)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Breasts) || !pc.isBodypartCovered(BodypartSlot.Breasts)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Ласкать грудь"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Потирать и сжимать грудь через одежду"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Охваченная похотью, ты хватаешь свои прикрытые одеждой {pc.breasts} и нежно сжимаешь их, позволяя пальцам погружаться в ткань. Ты издаешь тихий звук удовольствия, чувствуя, как твердые соски проступают сквозь одежду и трутся о твои ладони. Как же это возбуждает."
		text += "\n\n"
	else:
		text += "Ты проводишь руками по бокам своих {pc.masc} и обхватываешь {pc.breasts}. Массируя сиськи, ты чувствуешь, как соски трутся о ткань, прикрывающую их — это так возбуждает. Ты тихонько стонешь, продолжая теребить свою грудь через одежду."
		text += "\n\n"

	if(RNG.chance(30) && _lustState.isInBattle()):
		text += "Ты стараешься слегка отвернуться от врага, чтобы твоё дразнение произвело больший эффект: им не обязательно видеть, как ты разминаешь свои сиськи, одних твоих звуков хватит, чтобы любого свело с ума от похоти."
		text += "\n\n"
		
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Ты вся покрыта спермой, в том числе и твоя грудь; так приятно разминать её, пока капли семени стекают по твоим пальцам."
		text += "\n\n"
	
	if(pc.hasVagina() && pc.getLust() >= 50):
		text += "От того, что ты дразнишь свою грудь, там, внизу, становится так мокро, твоя киска буквально течет от женских соков... Ты не останавливаешься, не в силах сдержать тихий стон."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.canBeMilked()):
		text += "Ты замечаешь несколько темных пятен на своей одежде — твои {pc.breasts} лактируют! Ты находишь свои соски и чуть сильнее надавливаешь на них, выдавливая еще больше {pc.milk} и увеличивая влажные пятна."
		text += "\n\n"
	
	if(RNG.chance(50)):
		text += RNG.pick([
			"[say=pc]Как же хорошо..[/say]",
			"[say=pc]Черт возьми, да, хочу еще..[/say]",
			"[say=pc]Моя сиська... кажется, все видят, как я ласкаю себя... так горячо.[/say]",
			"[say=pc]Ох, блядь..[/say]",
		])
		text += "\n\n"
		
		if(_lustState.isInPublic() && !_lustState.isInBattle()):
			text += "Ты надеешься, что никто этого не услышал... Пытаешься держать рот на замке, но ощущения просто зашкаливают..."
			text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustBreastsAttack",
	}

func getLustTopics():
	return {
		InterestTopic.BigBreasts : 1.0,
		InterestTopic.SmallBreasts : 1.0,
		InterestTopic.MediumBreasts : 1.0,
		InterestTopic.NoBreasts : 1.0,
		InterestTopic.LactatingBreasts : 0.3,
		InterestTopic.CoveredInCum : 0.3,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.4,
		InterestTopic.ExposedPussy : 0.2,
		InterestTopic.ExposedBreasts : 0.4,
		InterestTopic.ExposedCock : 0.2,
		InterestTopic.ExposedPanties : 0.1,
		InterestTopic.ExposedBra : 0.5,
		InterestTopic.TallyMarks : 0.3,
		InterestTopic.Bodywritings : 0.5,
		InterestTopic.BDSMRestraints : 0.2,
	}

func getPriority():
	return 4

func isTease():
	return true

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
