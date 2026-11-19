extends LustAction

func _init():
	id = "CumCumOnEnemy"
	isOrgasmAction = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isInBattle()):
		return false
	var pc: Player = _lustState.getCharacter()
	if(!pc.hasPerk(Perk.CumCumOnOpponent)):
		return false
	if(!pc.hasPenis() && !pc.hasVagina()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc: Player = _lustState.getCharacter()
	if(pc.getStamina() <= 0):
		return [false, "You don't have enough stamina to do this"]
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Кончить на врага"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Потратьте 40 выносливости, чтобы сбить врага с ног и кончить прямо на него, покрывая всё его тело своей спермой/соками!"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)
	var pc: Player = _lustState.getCharacter()
	pc.orgasmFrom(pc.getID())
	pc.addStamina(-40)
	
	var enemy = _lustState.getEnemyCharacter()
	if(enemy != null):
		if(pc.hasPenis()):
			enemy.addEffect(StatusEffect.NPCCoveredInCum, [3, "cum"])
		elif(pc.hasVagina()):
			enemy.addEffect(StatusEffect.NPCCoveredInCum, [3, "girlcum"])
		enemy.addEffect(StatusEffect.Stunned, [1])
	
	var theAnim:String = "LustRubAttackFast"
	var text = ""
	if(pc.hasPenis()):
		text += "Вы чувствуете, как оргазм захватывает ваше тело. Но вместо того чтобы просто замереть, вы набрасываетесь на противника, сбивая его с ног и прижимая к полу. Затем вы используете эту возможность, чтобы довести себя до самого края!"
		text += "\n\n"
	
		text += "Ваш {pc.cock} начинает пульсировать, выбрасывая струи горячей липкой {pc.cum} прямо на противника, покрывая его с головы до ног. Вы чувствуете, как ваши яички опустошаются, пока ствол каждую секунду извергает всё больше и больше {pc.cum}, пока вы окончательно не изверглись."
		text += "\n\n"
	
		text += "Замешательство противника дает вам достаточно времени, чтобы слезть с него и прийти в себя после оргазма."
		text += "\n\n"
		theAnim = "LustStrokeAttackFast"
	elif(pc.hasVagina()):
		text += "Вы чувствуете, как оргазм захватывает ваше тело. Но вместо того чтобы просто замереть, вы набрасываетесь на противника, сбивая его с ног и прижимая к полу. Затем вы используете эту возможность, чтобы тереть свою киску, заставляя себя дойти до самого края."
		text += "\n\n"
	
		text += "Вы издаете несколько страстных стонов, когда ваша киска начинает заливать врага сквиртом, покрывая его с головы до ног. Ваши ноги дрожат, тело бьет озноб, вы выгибаете спину, наслаждаясь волнами удовольствия и унижая противника тем, что кончаете прямо на него."
		text += "\n\n"
		
		text += "Смятение противницы дает тебе достаточно времени, чтобы слезть с нее и прийти в себя после оргазма."
		text += "\n\n"
		theAnim = "LustRubAttackFast"

	return {
		text = text,
		came = true,
		#lostBattle = true,
		anim = theAnim,
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.BigCock : 0.1,
		InterestTopic.AverageCock : 0.1,
		InterestTopic.SmallCock : 0.1,
		InterestTopic.HasVaginaOnly : 0.3,
		InterestTopic.HasCockOnly : 0.1,
		InterestTopic.HasVaginaAndCock : 0.3,
		InterestTopic.StuffedPussy : 0.1,
		InterestTopic.CoveredInCum : 0.1,
		InterestTopic.CoveredInLotsOfCum : 0.1,
	}

func getPriority():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 3], [Skill.CumLover, 10]]
	return []
