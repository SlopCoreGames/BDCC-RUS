extends LustAction

func _init():
	id = "BraShakeOff"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.UnderwearTop)):
		return false
	var pc: Player = _lustState.getCharacter()
	if(!pc.hasBlockedHands()):
		return false
	var itemState: BraState = _args["itemState"]
	if(itemState.isRemoved()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	var itemState: BraState = _args["itemState"]
	return "Тряска"+itemState.casualName+" off"

func getVisibleDescription(_lustState: LustCombatState, _args):
	#var itemState: BraState = _args["itemState"]
	return "Раз уж руками дотянуться не получается, приходится просто стряхнуть это"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: BraState = _args["itemState"]
	itemState.removeNoAppearanceUpdate()
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(_lustState.isInBattle() && pc.hasNonFlatBreasts()):
		text += "Ты действуешь быстро, пытаясь стряхнуть свою <casualName>. Противник, кажется, заинтригован твоими стараниями. Твои {pc.breasts} колышутся в воздухе и игриво подпрыгивают, пока наконец не выскальзывают из-под ткани. После такого возбуждающего действия ты тихонько дышишь, чувствуя, как соски терлись о ткань, пока ты трясла грудью."
		text += "\n\n"
	elif(_lustState.isInBattle() && !pc.hasNonFlatBreasts()):
		text += "Ты действуешь быстро, пытаясь стряхнуть свою <casualName>. Противник, кажется, заинтригован твоими стараниями. Это дается нелегко, но в итоге тебе удается сдвинуть ткань достаточно высоко, чтобы обнажить свои {pc.breasts}. После такого возбуждающего действия ты тихонько дышишь, чувствуя, как соски терлись о ткань, пока ты трясла грудью."
		text += "\n\n"
	elif(!_lustState.isInBattle() && pc.hasNonFlatBreasts()):
		text += "Ты оглядываешься по сторонам, чтобы убедиться, что за тобой никто не подглядывает, и приступаешь к тому, чтобы стряхнуть свою <casualName>, прилагая немало усилий. Твои {pc.breasts} колышутся в воздухе и игриво подпрыгивают, пока наконец не выскальзывают из-под ткани. После такого возбуждающего действия ты тихонько дышишь, чувствуя, как соски терлись о ткань, пока ты трясла грудью."
		text += "\n\n"
	elif(!_lustState.isInBattle() && !pc.hasNonFlatBreasts()):
		text += "Оглядевшись по сторонам, чтобы убедиться, что за тобой никто не подглядывает, ты принимаешься стряхивать свою <casualName>, изрядно с этим намучившись. В конце концов тебе удается сдвинуть ткань достаточно высоко, чтобы обнажить свои {pc.breasts}. После такого возбуждающего действа ты тихонько дышишь, чувствуя, как соски ощутимо горели от трения, пока ты трясла грудью."
		text += "\n\n"
	
	if(RNG.chance(40) && pc.canBeMilked()):
		text += "Твоя грудь кажется довольно тяжелой, по ней можно заметить несколько капель {pc.milk}. Она так и просится, чтобы её подоили."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.hasBodywritings()):
		text += "Раздеваясь, ты выставляешь напоказ всё больше своих татуировок на теле — как пошло."
		text += "\n\n"
		
	if(RNG.chance(20) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "С твоих {pc.breasts} капает сперма, даже когда ты стоишь неподвижно; с первого взгляда очевидно, что ты неплохо развлеклась с другими."
		text += "\n\n"
	
	return {
		text = text.replace("<casualName>", itemState.casualName),
		anim = "LustBreastsShakeOff",
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
	return -3

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
