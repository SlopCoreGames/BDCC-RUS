extends LustAction

func _init():
	id = "UniformShakeShortsOff"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.Body)):
		return false
	
	var itemState: ShirtAndShortsState = _args["itemState"]
	if(itemState.areShortsPulledDown()):
		return false
		
	var pc: Player = _lustState.getCharacter()
	if(!pc.hasBlockedHands() && !pc.hasBoundArms()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Сбросить шорты встряхиванием"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Руки заняты, поэтому тебе приходится вилять всем телом, чтобы стянуть шорты"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: ShirtAndShortsState = _args["itemState"]
	itemState.pullDownShorts(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(!pc.isBodypartCovered(BodypartSlot.Anus)):
		text += "Ты виляешь {pc.masc} бедрами из стороны в сторону, пытаясь стянуть шорты. Наконец, дело начинает двигаться! Шорты медленно сползают вниз, обнажая твою {pc.thick} задницу."
		text += "\n\n"
		
		if(pc.hasPenis()):
			text += "Лента зацепилась за твой твердый {pc.cock}, но после того как ты еще немного потрясла задом, она поддается, полностью обнажая твой член!"
			text += "\n\n"
		elif(pc.hasVagina()):
			text += "Когда шорты падают на пол, твоя влажная, жаждущая щелочка тоже оказывается на виду. Какая шалунья~. Мысль о том, что твои интимные места может увидеть кто угодно, переполняет тебя желанием."
			text += "\n\n"
	else:
		text += "Ты виляешь {pc.masc} бедрами из стороны в сторону, пытаясь стянуть шорты. Наконец, дело начинает двигаться: шорты медленно сползают вниз, обнажая твое нижнее белье. Приятно чувствовать, как ткань скользит по твоим {pc.thick} бедрам; возможно, тебе стоит раздеваться почаще."
		text += "\n\n"
	
	if(pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Когда ты стягиваешь шорты, становится видно, сколько спермы скопилось у тебя внутри — так грязно."
		text += "\n\n"
	
	if(!pc.isBodypartCovered(BodypartSlot.Anus) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "Твоя использованная дырочка, кажется, набита чьей-то спермой; то, как она капает на пол, выглядит невероятно похотливо."
		text += "\n\n"
	
	if(_lustState.isInBattle()):
		text += "Кажется, враг внимательно наблюдает за тем, как ты исполняешь для него этот маленький стриптиз~"
		text += "\n\n"
	
	return {
		text = text,
		anim = "LustButtShakeOff",
	}

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

func getPriority():
	return -4

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
