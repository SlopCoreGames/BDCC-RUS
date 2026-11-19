extends LustAction

func _init():
	id = "UniformExposeChest"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.Body)):
		return false
		
	var itemState: ShirtAndShortsState = _args["itemState"]
	if(itemState.isShirtOpened()):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	#var itemState: ShirtAndShortsState = _args["itemState"]
	var pc:Player = _lustState.getCharacter()
	if(pc.hasBoundArms()):
		return [false, "You can't do that with bound arms"]
	if(pc.hasBlockedHands()):
		return [false, "You can't do that with blocked hands"]
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Обнажить сиськи"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Расстегни рубашку и покажи, что под ней"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: ShirtAndShortsState = _args["itemState"]
	itemState.openShirt(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(!pc.isBodypartCovered(BodypartSlot.Breasts)):
		text += "Ты хватаешься за рубашку своей униформы и начинаешь украдкой расстегивать пуговицы, наслаждаясь тем, как твоя грудь постепенно открывается миру. Ты чувствуешь, как твердые соски трутся о ткань. Наконец, дойдя до самого низа, ты раздвигаешь края одежды, полностью обнажая свои {pc.breasts}!"
		text += "\n\n"
		
		if(RNG.chance(50) && pc.hasNonFlatBreasts()):
			text += RNG.pick([
				"[say=pc]Ох черт, мои сиськи на виду. Любой может их заметить, если посмотрит на меня... это так возбуждает~[/say]",
				"[say=pc]Так приятно выставлять свои сиськи напоказ, надо делать это почаще~[/say]",
				"[say=pc]Какая свобода~. Не терпится потереть свои упругие соски.[/say]",
			])
			text += "\n\n"
	else:
		text += "Ты хватаешься за рубашку своей униформы и начинаешь украдкой расстегивать пуговицы, наслаждаясь тем, как твоя грудь постепенно открывается. Ты чувствуешь, как твердые соски трутся о ткань. Наконец, дойдя до самого низа, ты раздвигаешь края одежды, обнажая то, что под ней."
		text += "\n\n"

	if(pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Расстегнутая рубашка открывает вид на то, сколько спермы размазано по твоим {pc.breasts}, ну ты и грязнуля~"
		text += "\n\n"
	
	if(RNG.chance(50) && pc.isVisiblyPregnant()):
		text += "Твой живот выглядит совсем как у беременной; без рубашки еще очевиднее, что ты носишь чье-то потомство!"
		text += "\n\n"
	
	if(_lustState.isInBattle()):
		text += "Враг, кажется, внимательно следит за твоими руками. И ты готов устроить ему настоящее шоу."
		text += "\n\n"
	
	return {
		text = text,
		anim = "ClothingTopOpen",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.BigBreasts : 0.4,
		InterestTopic.SmallBreasts : 0.4,
		InterestTopic.MediumBreasts : 0.4,
		InterestTopic.NoBreasts : 0.4,
		InterestTopic.LactatingBreasts : 0.1,
		InterestTopic.CoveredInCum : 0.1,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.1,
		InterestTopic.ExposedBreasts : 0.1,
		InterestTopic.ExposedBra : 0.1,
		InterestTopic.Bodywritings : 0.1,
		InterestTopic.BDSMRestraints : 0.1,
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
