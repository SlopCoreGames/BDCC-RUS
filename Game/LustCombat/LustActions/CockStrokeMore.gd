extends LustAction

func _init():
	id = "CockStrokeMore"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.StrokingCock)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Penis) || pc.isBodypartCovered(BodypartSlot.Penis)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Драть сильнее"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Дрочить на себя"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Сдавленный стон срывается с твоих губ, когда ты жадно проводишь {pc.masc} пальцами по всей длине своего {pc.cock}."
		text += "\n\n"
	else:
		text += "Чувствуя возбуждение, ты сначала ласкаешь кончик своего {pc.cock}, а затем сосредотачиваешься на движениях, приближающих тебя к оргазму."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты демонстрируешь врагу свой член во всей красе, пока дрочишь. Ты ухмыляешься, надеясь, что им нравится это зрелище."
		text += "\n\n"
	
	if(RNG.chance(10) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Столько спермы на твоем теле... Ты зачерпываешь немного пальцами и используешь её как смазку — не хочется переводить драгоценную жижу."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты чувствуешь, что финиш уже близко: твой член так и пульсирует и подергивается, и при каждом движении по стволу на кончике появляется капля предэякулята, стекающая по твоим пальцам."
		text += "\n\n"
	
	if(RNG.chance(20) && pc.hasVagina()):
		text += "Пока ты дразнишь свой член, твоя щель становится всё более жадной и влажной; ты чувствуешь, как из неё сочатся соки, пока ты фокусируешься на другом наборе своих бубенцов. Стоны невозможно скрыть."
		text += "\n\n"

	return {
		text = text,
		lust = 5,
		anim = "LustStrokeAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.HasVaginaAndCock : 0.2,
		InterestTopic.BigCock : 1.0,
		InterestTopic.AverageCock : 1.0,
		InterestTopic.SmallCock : 1.0,
		InterestTopic.HasCockOnly : 0.2,
		InterestTopic.CoveredInCum : 0.1,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.2,
		InterestTopic.ExposedCock : 0.6,
		InterestTopic.ExposedPanties : 0.1,
		InterestTopic.BDSMRestraints : 0.3,
		InterestTopic.Pregnant: 0.4,
	}

func getPriority():
	return 5

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
