extends LustAction

func _init():
	id = "UniformExposeCrotch"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.Body)):
		return false
		
	var itemState: ShirtAndShortsState = _args["itemState"]
	if(itemState.areShortsPulledDown()):
		return false
	
	var pc:Player = _lustState.getCharacter()
	if(pc.hasBoundArms() || pc.hasBlockedHands()):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	#var itemState: ShirtAndShortsState = _args["itemState"]
#	var pc:Player = _lustState.getCharacter()
#	if(pc.hasBoundArms()):
#		return [false, "You can't do that with bound arms"]
#	if(pc.hasBlockedHands()):
#		return [false, "You can't do that with blocked hands"]
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Обнажить промежность"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Спустить шорты униформы"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: ShirtAndShortsState = _args["itemState"]
	itemState.pullDownShorts(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(!pc.isBodypartCovered(BodypartSlot.Anus)):
		text += "Ты просовываешь два пальца под шорты и начинаешь дразняще стягивать их вниз, обнажая свою {pc.thick} {pc.masc} задницу."
		text += "\n\n"
		
		if(pc.hasPenis()):
			text += "В процессе кончик твоей {pc.cock} цепляется за ленту, она тянет его вниз, а затем он резко отскакивает, когда шорты падают на пол. Твой член полностью обнажен, как и все остальное хозяйство."
			text += "\n\n"
		elif(pc.hasVagina()):
			text += "Когда шорты сползают, твоя влажная, жаждущая щелочка тоже оказывается на виду. Как неприлично~. Мысль о том, что твои интимные места может увидеть кто угодно, наполняет тебя диким желанием."
			text += "\n\n"
	else:
		text += "Ты просовываешь два пальца под шорты и начинаешь дразняще стягивать их вниз, обнажая нижнее белье. Приятно чувствовать, как ткань скользит по твоим {pc.thick} бедрам; возможно, тебе стоит раздеваться почаще."
		text += "\n\n"
	
	if(pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Когда ты стягиваешь шорты, становится видно, сколько спермы скопилось у тебя внутри — так грязно."
		text += "\n\n"
	
	if(!pc.isBodypartCovered(BodypartSlot.Anus) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "Твоя использованная дырочка, кажется, набита чьей-то спермой; то, как она капает на пол, выглядит невероятно похотливо."
		text += "\n\n"
	
	if(_lustState.isInBattle()):
		text += "Кажется, враг внимательно наблюдает за тобой, пока ты исполняешь для него этот маленький стриптиз~"
		text += "\n\n"
	
	return {
		text = text,
		anim = "ClothingBottomPullDown",
	}

func getPriority():
	return -4

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.ThickButt : 0.2,
		InterestTopic.AverageButt : 0.2,
		InterestTopic.SlimButt : 0.2,
		InterestTopic.NoVagina : 0.5,
		InterestTopic.HasVaginaOnly : 0.5,
		InterestTopic.HasVaginaAndCock : 0.2,
		InterestTopic.BigCock : 0.5,
		InterestTopic.AverageCock : 0.5,
		InterestTopic.SmallCock : 0.5,
		InterestTopic.NoCock : 0.5,
		InterestTopic.HasCockOnly : 0.2,
		InterestTopic.StuffedPussy : 0.4,
		InterestTopic.StuffedAss : 0.4,
		InterestTopic.StuffedPussyOrAss : 0.2,
		InterestTopic.FullyNaked : 0.2,
		InterestTopic.ExposedPussy : 0.4,
		InterestTopic.ExposedAnus : 0.4,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.3,
		InterestTopic.LooseAnus : 0.1,
		InterestTopic.LoosePussy : 0.1,
		InterestTopic.TightAnus : 0.1,
		InterestTopic.TightPussy : 0.1,
		InterestTopic.ButtPlugs : 0.2,
		InterestTopic.VaginalPlugs : 0.2,
	}

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
