extends LustAction

func _init():
	id = "PussyFinger"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.SpreadingPussy)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Vagina) || pc.isBodypartCovered(BodypartSlot.Vagina)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "ласкать киску пальцами"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Доставить себе удовольствие"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты вводишь и выводишь палец в свою {pc.pussyStretch} киску, смазывая её своими соками. Это чертовски приятно; ты издаешь стон наслаждения и продолжаешь трахать себя пальцами на глазах у любого, кому посчастливится на это посмотреть."
		text += "\n\n"
	else:
		text += "Ты вгоняешь несколько пальцев в свою {pc.pussyStretch} щелочку, заталкивая их глубоко и с силой, нащупывая точку G. Благодаря смазке пальцы легко скользят внутри, нещадно трахая твою жаждущую киску."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		text += "По мере того как ты доводишь себя до оргазма, из твоей щели сочится конча, смешиваясь с женскими выделениями — так грязно и сладко."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты стараешься выставить напоказ, какое наслаждение это тебе приносит, чтобы заставить противницу завидовать."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasPenis()):
		text += "Твоя {pc.cock} пульсирует и течет от предэякулята, пока ты ласкаешь другие свои эрогенные зоны."
		text += "\n\n"
	
	var theAnim:String = "LustRubAttack"
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты чувствуешь, что финиш совсем близко: твоя мокрая киска брызжет соками, а мягкие внутренние стенки сжимаются вокруг пальцев, когда ты входишь еще глубже."
		text += "\n\n"
		theAnim = "LustRubAttackFast"

	return {
		text = text,
		lust = 5,
		anim = theAnim,
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.HasVaginaOnly : 0.4,
		InterestTopic.HasVaginaAndCock : 0.4,
		InterestTopic.NoCock : 0.5,
		InterestTopic.StuffedPussy : 0.8,
		InterestTopic.StuffedPussyOrAss : 0.4,
		InterestTopic.FullyNaked : 0.7,
		InterestTopic.ExposedPussy : 0.7,
		InterestTopic.ExposedAnus : 0.3,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.4,
		InterestTopic.LoosePussy : 0.7,
		InterestTopic.TightPussy : 0.7,
		InterestTopic.TallyMarks : 0.3,
		InterestTopic.Bodywritings : 0.3,
		InterestTopic.BDSMRestraints : 0.3,
		InterestTopic.VaginalPlugs : 0.1,
		InterestTopic.Pregnant: 0.4,
	}

func getPriority():
	return 5

func skillNeeded():
	return 3

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
