extends LustAction

func _init():
	id = "StartGropeButt"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.canStartNewActivity(LustActivity.GropingButt)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "щупать задницу"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Начать ощупывать свою задницу"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	_lustState.startActivity(LustActivity.GropingButt)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты опускаешь одну руку к своей {pc.thick} заднице и крепко сжимаешь её. Да уж, жопа у тебя что надо — ладонь скользит по коже, исследуя каждый изгиб."
		text += "\n\n"
	else:
		text += "Ты кладешь свободную руку на задницу и слегка её потираешь. Твоя {pc.thick} жопа выставлена напоказ."
		text += "\n\n"

	if(RNG.chance(50) && pc.hasEffect(StatusEffect.HasCumInsideAnus)):
		text += "Из твоего ануса сочится немного спермы — след твоего недавнего секса."
		text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustButt",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.3,
		InterestTopic.MasculineBody : 0.3,
		InterestTopic.AndroBody : 0.3,
		InterestTopic.ThickButt : 0.4,
		InterestTopic.AverageButt : 0.4,
		InterestTopic.SlimButt : 0.4,
		InterestTopic.StuffedAss : 0.2,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.2,
		InterestTopic.ExposedAnus : 0.1,
		InterestTopic.ExposedPanties : 0.2,
		InterestTopic.LooseAnus : 0.1,
		InterestTopic.TightAnus : 0.1,
	}

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
