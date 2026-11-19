extends LustAction

func _init():
	id = "AnalRubProstate"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.ProddingAnal)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Anus) || pc.isBodypartCovered(BodypartSlot.Anus)):
		return false
	if(!pc.hasBodypart(BodypartSlot.Penis)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc:Player = _lustState.getCharacter()
	if(pc.hasBoundArms()):
		return [false, "С заведенными за спину руками так не выйдет"]
	#if(pc.hasBlockedHands()):
	#	return [false, "You can't do that with blocked hands"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Теребить простату"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Сосредоточьтесь на точке G"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Страстный стон срывается с ваших губ, когда вы вводите палец в задницу достаточно глубоко, чтобы начать ритмично бить по простате. Ваша {pc.cock} каждый раз реагирует на это пульсацией и выделением прозрачной смазки, стекающей на пол."
		text += "\n\n"
	else:
		text += "Вы меняете положение пальцев так, чтобы каждый толчок задевал простату. Это настолько приятно, что ваша {pc.cock} почти непрерывно сочится предэякулятом, пока вы это делаете."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Вы стараетесь, чтобы ваш враг мог во всех деталях рассмотреть ваш {pc.thick} зад и ваш сочащийся член, пока вы ласкаете себя через анус."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.HasCumInsideAnus)):
		text += "Твои пальцы покрываются спермой твоих прошлых любовников; она служит отличной смазкой, позволяя тебе входить и выходить с еще большей силой."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.getLust() >= 50):
		text += "Ого, ваш член так сильно пульсирует и бьется, показывая, что вы на верном пути к оргазму через анальную стимуляцию."
		text += "\n\n"

	return {
		text = text,
		lust = 5,
		anim = "LustButtRub",
	}

func getLustTopics():
	return {
		InterestTopic.ThickButt : 0.2,
		InterestTopic.AverageButt : 0.2,
		InterestTopic.SlimButt : 0.2,
		InterestTopic.StuffedAss : 0.5,
		InterestTopic.StuffedPussyOrAss : 0.2,
		InterestTopic.FullyNaked : 0.4,
		InterestTopic.ExposedPussy : 0.3,
		InterestTopic.ExposedAnus : 0.8,
		InterestTopic.ExposedCock : 0.5,
		InterestTopic.BigCock : 0.4,
		InterestTopic.AverageCock : 0.4,
		InterestTopic.SmallCock : 0.4,
		InterestTopic.LooseAnus : 0.8,
		InterestTopic.TightAnus : 0.8,
		InterestTopic.TallyMarks : 0.1,
		InterestTopic.Bodywritings : 0.1,
		InterestTopic.ButtPlugs : 0.4,
		InterestTopic.VaginalPlugs : 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 3

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
