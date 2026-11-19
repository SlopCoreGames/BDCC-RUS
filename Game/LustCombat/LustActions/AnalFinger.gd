extends LustAction

func _init():
	id = "AnalFinger"
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
	return "Палец в анус"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Ублажать свою задницу"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Тихий стон срывается с твоих губ, когда ты водишь пальцами туда-сюда в своей попке. Чем дольше ты это делаешь, тем меньше сопротивления оказывает твой {pc.analStretch} анальный сфинктер."
		text += "\n\n"
	else:
		text += "Ты проталкиваешь пальцы глубже в свой {pc.analStretch} анус, исследуя себя, а затем вынимаешь их, оставляя пустоту, которая медленно стягивается."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты стараешься, чтобы враг мог во всех деталях рассмотреть твою {pc.thick} задницу и {pc.masc} бёдра, пока ты ласкаешь себя пальцами."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.HasCumInsideAnus)):
		text += "Твои пальцы покрываются спермой твоих прошлых любовников; она служит отличной смазкой, позволяя тебе входить и выходить с еще большей силой."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasPenis()):
		text += "Твой {pc.cock} пульсирует, когда ты время от времени задеваешь свою точку удовольствия."
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
		InterestTopic.ExposedCock : 0.1,
		InterestTopic.LooseAnus : 1.0,
		InterestTopic.TightAnus : 1.0,
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
