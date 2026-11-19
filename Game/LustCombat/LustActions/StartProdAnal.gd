extends LustAction

func _init():
	id = "StartProdAnal"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.canStartNewActivity(LustActivity.ProddingAnal)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Anus) || pc.isBodypartCovered(BodypartSlot.Anus)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Продукт-анализ"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Начинаешь ковырять в своем анусе"

func doAction(_lustState: LustCombatState, _args):
	_lustState.startActivity(LustActivity.ProddingAnal)

	#var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты опускаешь свободную руку к заднице и разводишь ягодицы двумя пальцами, а третьим начинаешь тыкать в свой {pc.analStretch} анус. Ты быстро смазываешь палец слюной, чтобы он с легкостью скользнул внутрь."
		text += "\n\n"
	else:
		text += "Ты издаешь милый звук, когда два твоих пальца начинают ковырять в твоем {pc.analStretch} анусе, прежде чем в итоге погрузиться внутрь."
		text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustButtRub",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.3,
		InterestTopic.MasculineBody : 0.3,
		InterestTopic.AndroBody : 0.3,
		InterestTopic.ThickButt : 0.2,
		InterestTopic.AverageButt : 0.2,
		InterestTopic.SlimButt : 0.2,
		InterestTopic.StuffedAss : 0.3,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.2,
		InterestTopic.ExposedAnus : 0.4,
		InterestTopic.ExposedPanties : 0.3,
		InterestTopic.LooseAnus : 0.3,
		InterestTopic.TightAnus : 0.3,
	}

func isTease():
	return true

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
