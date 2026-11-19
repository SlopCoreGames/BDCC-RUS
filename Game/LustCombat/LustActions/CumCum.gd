extends LustAction

func _init():
	id = "CumCum"
	isOrgasmAction = true
	
func shouldShow(_lustState: LustCombatState, _args):
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Кончить"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Отдайся оргазму... Если ты в бою, ты проиграешь и полностью подчинишься врагу"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)
	var pc: Player = _lustState.getCharacter()
	pc.orgasmFrom(pc.getID())
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты чувствуешь, как приближается пик, и решаешь не сопротивляться. Ты издаешь серию страстных стонов, прежде чем перевалить за вершину и наконец кончить. Волны оргазма захлестывают всё тело, заставляя тебя дрожать и извиваться, проживая каждую из них."
		text += "\n\n"
	else:
		text += "Экстатические волны внезапно накрывают тебя, не оставляя выбора, кроме как кончить. Ты издаешь долгие стоны, пока тело предает тебя: мышцы начинают сокращаться и напрягаться, руки и ноги дрожат, а глаза сияют от похоти и желания."
		text += "\n\n"
	
	if(pc.hasPenis()):
		var ejacPlace : String = "по всему полу"
		var condom:ItemBase = pc.getWornCondom()
		var broke : bool = false
		if(condom != null):
			ejacPlace = "в свой презерватив"
			var breakChance:float = condom.getCondomBreakChance()
			broke = (RNG.chance(breakChance)) # condom broke
			if(broke):
				condom.destroyMe()
			else:
				pc.cumInItem(condom)
		var ppump = pc.getWornPenisPump()
		if(ppump!=null):
			ejacPlace = "в пенис-помпу"
			pc.cumInItem(ppump)
			var penis:BodypartPenis = pc.getBodypart(BodypartSlot.Penis)
			penis.getFluidProduction().drain()
		
		
		if(_lustState.isDoingActivity(LustActivity.StrokingCock)):
			text += "Ты ласкаешь себя, доходя до самого пика, пока твой {pc.cock} не начинает пульсировать и " + ("выстреливать струями горячей липкой {pc.cum} " if pc.getWornChastityCage()==null else "слабо брызгать струйками {pc.cum} сквозь клетку ") + ejacPlace+"." + (" Презерватив рвется, и всё содержимое выливается на пол." if broke else "") + " Ты чувствуешь, как твои яйца опустошаются, пока ствол извергается снова и снова каждую секунду."
			text += "\n\n"
		else:
			text += "Твой {pc.cock} начинает пульсировать, " + ("выстреливать струями горячей липкой {pc.cum} " if pc.getWornChastityCage()==null else "слабо брызгать струйками {pc.cum} сквозь клетку ") + ejacPlace+" даже когда ты его не ласкаешь." + (" Презерватив рвется, и всё содержимое выливается на пол." if broke else "") + " Ты чувствуешь, как твои яйца выжимают досуха, пока ты не кончишь окончательно."
			text += "\n\n"
	
	if(pc.canBeMilked() && _lustState.isDoingActivity(LustActivity.GropingChest)):
		text += "Твои соски брызжут вместе с твоим {pc.milk}, пока ты тискаешь их во время оргазма! Почти непрерывный поток {pc.milk} хлещет из твоей {pc.breasts} и стекает по твоим изгибам, пока ты корчишься от удовольствия."
		text += "\n\n"
	
	if(pc.hasVagina()):
		if(_lustState.isDoingActivity(LustActivity.SpreadingPussy)):
			text += "Твоя киска брызжет девичьими соками на твои пальцы и пол. Ты сжимаешь ноги вокруг руки, чувствуя, как твоя щелка пульсирует и из нее течет еще больше девичьей спермы, покрывая твои {pc.masc} бедра. Ты вынимаешь пальцы из своей щели и издаешь очередной стон."
			text += "\n\n"
		else:
			text += "Твоя киска пульсирует и разбрызгивает девичьи соки по твоим бедрам и полу."
			text += "\n\n"

	if(_lustState.isDoingActivity(LustActivity.ProddingAnal)):
		text += "Кольцо твоего {pc.analStretch} сжимается вокруг пальцев. Неконтролируемые спазмы мышц, сдавливающие пальцы, приносят тебе невероятное дополнительное наслаждение."
		text += "\n\n"

	return {
		text = text,
		came = true,
		lostBattle = true,
		anim = "LustOrgasmAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.BigCock : 0.2,
		InterestTopic.AverageCock : 0.2,
		InterestTopic.SmallCock : 0.2,
		InterestTopic.HasVaginaOnly : 0.4,
		InterestTopic.HasCockOnly : 0.2,
		InterestTopic.HasVaginaAndCock : 0.4,
		InterestTopic.StuffedPussy : 0.2,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.2,
	}

func getPriority():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 10], [Skill.CumLover, 5]]
	return [[Skill.CumLover, 5]]

func getVisibility():
	return RNG.randf_range(0.1, 0.4)
