extends LustAction

func _init():
	id = "BraPullUp"
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isInventorySlotBlocked(InventorySlot.UnderwearTop)):
		return false
	var pc: Player = _lustState.getCharacter()
	if(pc.hasBlockedHands()):
		return false
	var itemState: BraState = _args["itemState"]
	if(itemState.isBraPulledUp() || itemState.isRemoved()):
		return false
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	var itemState: BraState = _args["itemState"]
	return "Тянуть"+itemState.casualName+" up"

func getVisibleDescription(_lustState: LustCombatState, _args):
	#var itemState: BraState = _args["itemState"]
	return "Полностью обнажить сиськи"

func doAction(_lustState: LustCombatState, _args):
	var _item:ItemBase = getItem(_lustState, _args)
	
	var itemState: BraState = _args["itemState"]
	itemState.pullBraUp(false)
	
	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(_lustState.isInBattle() && pc.hasNonFlatBreasts()):
		text += "Ты решаешь привлечь внимание противника, обхватив свои {pc.breasts} ладонями и подчеркивая их пышность. Затем ты просовываешь пальцы под <casualName> и небрежно задираешь его вверх, заставляя свои прелестные титьки выпрыгнуть наружу. Ты сжимаешь их локтями, демонстрируя свою грудь во всей красе."
		text += "\n\n"
	elif(_lustState.isInBattle() && !pc.hasNonFlatBreasts()):
		text += "Ты решаешь привлечь внимание противника, накрыв свои {pc.breasts} ладонями. Затем ты просовываешь палец под <casualName> и небрежно задираешь его вверх, обнажая свою плоскую грудь с милыми маленькими сосками."
		text += "\n\n"
	elif(!_lustState.isInBattle() && pc.hasNonFlatBreasts()):
		text += "Ты оглядываешься по сторонам, проверяя, нет ли лишних глаз, а затем просовываешь пальцы под <casualName> и воровато задираешь его вверх, пока {pc.breasts} не выскочат наружу. Такая шалунья! Ты прикрываешь соски и сжимаешь их руками. Ощущение того, как они свободно колышутся, полностью обнаженные на виду у всех, заводит тебя до безумия."
		text += "\n\n"
	elif(!_lustState.isInBattle() && !pc.hasNonFlatBreasts()):
		text += "Оглядевшись по сторонам, чтобы убедиться, что лишних глаз нет, ты запускаешь пальцы под <casualName> и незаметно задираешь её вверх, пока твои {pc.breasts} не оказываются полностью на виду. Ты еще какое-то время прикрываешь соски пальцами, прежде чем обнажить и их. Это так пошло — постоянный риск заставляет тебя невероятно возбуждаться."
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
		anim = "ClothingTopPullUp",
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
