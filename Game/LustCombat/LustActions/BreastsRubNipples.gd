extends LustAction

func _init():
	id = "BreastsRubNipples"
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
	if(pc.hasBlockedHands()):
		return [false, "You can't do that with blocked hands"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Теребить соски"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Устроить массаж своим булкам"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Желание становится невыносимым: твои пальцы прижимаются к чувствительным соскам, нежно лаская их, а ладонь полностью обхватывает твою {pc.breasts}. Ощущения великолепны, ты издаешь тихий стон, пока соски твердеют от стимуляции."
		text += "\n\n"
	else:
		text += "Твои кончики пальцев ложатся на упругие соски и начинают их слегка тереть. Эти точки настолько чувствительны, что ты инстинктивно сжимаешь свою {pc.breasts} чуть сильнее, разминая соски и стоная на весь зал."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Твое тело всё в смазке; вид того, как ты ласкаешь свои соски, пока с них капает чья-то сперма, выглядит невероятно похотливо."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Противник наблюдает за тобой, и ты надеешься, что устраиваешь ему достойное шоу."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasVagina()):
		text += "От того, что твои соски трут, твоя милая {pc.pussyStretch} пропитывается еще большим количеством соков."
		text += "\n\n"
	
	if(RNG.chance(20) && !pc.canBeMilked()):
		text += "Ты еще не кормишь грудью, но чувствуешь, что можешь привыкнуть к таким ощущениям — это так приятно, когда соски стимулируют подобным образом."
		text += "\n\n"

	if(pc.stimulateLactation()):
		text += "[b]Твоя {pc.breasts} протекает, выделяя немного {pc.milk}, ты начала лактацию![/b]"
		text += "\n\n"

	return {
		text = text,
		lust = 3,
		anim = "LustBreastsSqueeze",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.BigBreasts : 0.9,
		InterestTopic.SmallBreasts : 0.9,
		InterestTopic.MediumBreasts : 0.9,
		InterestTopic.NoBreasts : 0.9,
		InterestTopic.LactatingBreasts : 0.1,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedBreasts : 0.4,
		InterestTopic.ExposedBra : 0.4,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
		InterestTopic.Pregnant: 0.2,
	}

func getPriority():
	return 5

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
