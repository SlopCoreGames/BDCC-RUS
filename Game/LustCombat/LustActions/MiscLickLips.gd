extends LustAction

func _init():
	id = "MiscLickLips"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	var pc: Player = _lustState.getCharacter()
	if(pc.isGagged()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Облизывать губы"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Показать свой язычок и губки"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты слегка приоткрываешь губы, позволяя языку высунуться наружу. Ты проводишь им по всему контуру рта, а затем игриво чмокаешь воздух."
		text += "\n\n"
	else:
		text += "Ты дразняще прикусываешь нижнюю губу и отводишь взгляд в сторону, принимая милое и похотливое выражение лица."
		text += "\n\n"
	
	if(RNG.chance(70) && pc.hasEffect(StatusEffect.HasCumInsideMouth)):
		text += "По твоей губе стекает капля спермы. Любому, кто на тебя посмотрит, будет очевидно, что ты не так давно занималась оральным сексом."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Твое лицо покрыто чьей-то смазкой, сейчас ты выглядишь как настоящая мокрая распутная девчонка. Когда ты высовываешь язык, ты чувствуешь её на вкус."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.isBlindfolded()):
		text += "Тот факт, что ты с повязкой на глазах, делает твои движения еще более горячими."
		text += "\n\n"

	if(_lustState.isInBattle() && pc.hasPerk(Perk.NakedStunningLips) && RNG.chance(10 + sqrt(pc.getStat(Stat.Sexiness)))):
		var enemy:BaseCharacter = _lustState.getEnemyCharacter()
		if(enemy != null && enemy.getLustLevel() >= 0.3):
			enemy.addEffect(StatusEffect.Stunned, [1])
			text += "[b]Враг ошеломлен твоими губами![/b]"
			text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "TauntLustComeHere",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.2,
		InterestTopic.SlimBody : 0.2,
		InterestTopic.AverageMassBody : 0.2,
		InterestTopic.StuffedThroat : 1.0,
		InterestTopic.CoveredInCum : 0.8,
		InterestTopic.CoveredInLotsOfCum : 0.6,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedPanties : 0.2,
		InterestTopic.ExposedBra : 0.2,
		InterestTopic.TallyMarks : 0.5,
		InterestTopic.Bodywritings : 0.5,
		InterestTopic.Gags : 0.5,
		InterestTopic.Blindfolds : 0.8,
		InterestTopic.BDSMRestraints : 0.3,
	}

func getPriority():
	return 4

func isTease():
	return true

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
