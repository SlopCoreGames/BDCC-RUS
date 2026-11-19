extends LustAction

func _init():
	id = "PantiesMoveAside"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.UnderwearBottom)):
		return false
	var pc: Player = _lustState.getCharacter()
	if(pc.hasBlockedHands()):
		return false
	var itemState: PantiesState = _args["itemState"]
	if(itemState.arePantiesShiftedAside() || itemState.isRemoved()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Сдвинуть трусики в сторону"

func getVisibleDescription(_lustState: LustCombatState, _args):
	if(_args.has("itemName")):
		return "Сдвинь свои "+_args["itemName"]+" aside"
	return "Сдвинь трусики в сторону"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: PantiesState = _args["itemState"]
	itemState.shiftPantiesAside(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(true):
		text += "Охваченная похотью, ты хватаешься за края своих трусиков и отодвигаешь их, обнажая то, что под ними."
		text += "\n\n"
		
	if(pc.hasPenis()):
		text += "Твой {pc.cock} быстро выпрыгивает на свободу, и капля предэякулята блестит, скатываясь с кончика."
		text += "\n\n"
	
	if(pc.hasVagina()):
		text += "Твоя милая щелочка теперь полностью открыта для любого, кто может тебя увидеть, как же это похотливо! Твои манящие чувствительные складки ощущают легкий ветерок свежего воздуха."
		text += "\n\n"
		
	if(RNG.chance(50) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "Как только ты сдвигаешь трусики, из твоей использованной дырочки начинает сочиться сперма, напоминая о твоих прошлых похотливых приключениях и демонстрируя, какая ты настоящая спермостручка."
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
		text = text,
		anim = "ClothingBottomPullDown",
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
