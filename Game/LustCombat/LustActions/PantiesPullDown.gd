extends LustAction

func _init():
	id = "PantiesPullDown"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.UnderwearBottom)):
		return false
	var pc: Player = _lustState.getCharacter()
	if(pc.hasBlockedHands()):
		return false
	var itemState: PantiesState = _args["itemState"]
	if(itemState.arePantiesPulledDown() || itemState.isRemoved()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	var itemState: PantiesState = _args["itemState"]
	return "Тянуть"+itemState.casualName+" down"

func getVisibleDescription(_lustState: LustCombatState, _args):
	var itemState: PantiesState = _args["itemState"]
	return "Спустить свои "+itemState.casualName

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: PantiesState = _args["itemState"]
	itemState.pullPantiesDown(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(true):
		text += "Охваченная похотью, ты просовываешь два пальца под свои <casualName> и тянешь их вниз, обнажая свою киску."
		text += "\n\n"
		
	if(pc.hasPenis()):
		text += "Твой {pc.cock} быстро выпрыгивает на свободу, и капля предэякулята блестит, скатываясь с кончика."
		text += "\n\n"
	
	if(pc.hasVagina()):
		text += "Твоя милая щелочка теперь полностью открыта для любого, кто может тебя увидеть, как же это похотливо! Твои манящие чувствительные складки ощущают легкий ветерок свежего воздуха."
		text += "\n\n"
		
	if(RNG.chance(50) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "Как только ты спускаешь <casualName>, из твоей раздолбанной дырочки начинает сочиться сперма, напоминая о прошлых похотливых приключениях и показывая, какая ты конченая спермотека."
		text += "\n\n"
		
	if(RNG.chance(70) && pc.getLust() >= 50 && pc.hasVagina()):
		text += "Ого, твоя киска насквозь пропитана соками, а все эти возбуждающие мысли в голове заставляют тебя течь еще сильнее."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.hasVagina() && pc.hasEffect(StatusEffect.InHeat)):
		text += "Жар сводит тебя с ума; ты на мгновение раздвигаешь половые губы, и поток твоих соков начинает стекать по пальцам. Блядь, тебе так хочется, чтобы тебя использовали."
		text += "\n\n"
		
	if(RNG.chance(30) && pc.hasVagina()):
		text += RNG.pick([
			"[say=pc]Хм, может, раздвинуть ноги?.. Очень хочется...[/say]",
			"[say=pc]Моя киска такая мокрая...[/say]",
			"[say=pc]Yes-s~[/say]",
		])
		text += "\n\n"
	
	return {
		text = text.replace("<casualName>", itemState.casualName),
		anim = "ClothingBottomPullDownFull",
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
	return -6

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
