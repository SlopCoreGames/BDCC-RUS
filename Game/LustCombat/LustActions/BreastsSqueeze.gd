extends LustAction

func _init():
	id = "BreastsSqueeze"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.GropingChest)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Breasts) || pc.isBodypartCovered(BodypartSlot.Breasts)):
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
	return "Сжимать грудь"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Хорошенько сжать свои сиськи"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Чувствуя сильное возбуждение, ты погружаешь пальцы глубже в свою {pc.breasts}, прежде чем приняться с жадностью ласкать и сжимать их. Твердые соски упираются в твои ладони, пока ты разминаешь грудь, издавая тихие стоны."
		text += "\n\n"
	else:
		text += "Ты крепче обхватываешь свою {pc.breasts} и страстно массируешь её, сильнее вдавливая пальцы в мягкую плоть и проводя ладонями по соскам. Это приносит такое удовольствие, что ты невольно тихо стонешь, продолжая ласкать свою грудь."
		text += "\n\n"
	
	if(RNG.chance(30) && _lustState.isInBattle()):
		text += "Ты не забываешь напоказ продемонстрировать свои шикарные сиськи противнику, сжимая их всё сильнее, чтобы враг понял, что именно он упускает."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Ты вся покрыта спермой, в том числе и твоя грудь; так приятно разминать её, пока капли семени стекают по твоим пальцам."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasVagina() && pc.getLust() >= 50):
		text += "От того, как ты дразнишь свою грудь, там, внизу, становится так мокро — твоя киска буквально течет от женских соков... Ты не останавливаешься, издавая очередной тихий стон."
		text += "\n\n"
	
	if(RNG.chance(40) && pc.canBeMilked()):
		text += "Твоя грудь кажется довольно тяжелой. Пока ты ласкаешь себя, ты замечаешь, как несколько капель {pc.milk} струятся по твоим сиськам. Они так и просятся, чтобы их как следует подоили."
		text += "\n\n"

	if(pc.stimulateLactation()):
		text += "[b]Твоя {pc.breasts} протекает, выделяя немного {pc.milk}, ты начала лактацию![/b]"
		text += "\n\n"

	return {
		text = text,
		lust = 2,
		anim = "LustBreastsSqueeze",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.2,
		InterestTopic.SlimBody : 0.2,
		InterestTopic.AverageMassBody : 0.2,
		InterestTopic.BigBreasts : 0.8,
		InterestTopic.SmallBreasts : 0.8,
		InterestTopic.MediumBreasts : 0.8,
		InterestTopic.NoBreasts : 0.8,
		InterestTopic.LactatingBreasts : 0.3,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedBreasts : 0.5,
		InterestTopic.ExposedBra : 0.4,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
		InterestTopic.Pregnant: 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
