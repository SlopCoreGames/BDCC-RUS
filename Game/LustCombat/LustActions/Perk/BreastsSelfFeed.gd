extends LustAction

func _init():
	id = "BreastsSelfFeed"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	#if(!_lustState.isInBattle()):
	#	return false
	#if(!_lustState.isDoingActivity(LustActivity.GropingChest)):
	#	return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Breasts)):# || pc.isBodypartCovered(BodypartSlot.Breasts)):
		return false
	if(!pc.hasPerk(Perk.MilkSelfFeed)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc:Player = _lustState.getCharacter()
	#if(!pc.hasPerk(Perk.MilkSquirt)):
	#	return [false, "Requires a \"Battle Cow\" perk"]
	
	if(pc.hasBoundArms()):
		return [false, "You can't do that with bound arms"]
	if(pc.hasBlockedHands()):
		return [false, "You can't do that with blocked hands"]
	if(!pc.canBeMilked()):
		return [false, "You need to be lactating to do this"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Кормить себя молоком"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Сжать грудь и поймать немного молока ртом, облегчая боль в зависимости от количества"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)
	
	var pc:Player = _lustState.getCharacter()
	pc.stimulateLactation()
	#pc.milk(0.2)
	
	var extraMessages = []
	var fluids:Fluids = pc.getBodypart(BodypartSlot.Breasts).getFluids()
	var fluidByAmount = fluids.getFluidAmountByType()
	for fluidID in fluidByAmount:
		var swallowData:Dictionary = pc.doSwallow(fluidID, fluidByAmount[fluidID] * 0.4)
		if(swallowData.has("text") && swallowData["text"] != ""):
			extraMessages.append(swallowData["text"])
	
	fluids.transferTo(pc.getBodypart(BodypartSlot.Head), 0.4, 100.0)
	
	var text = ""
	if(pc.hasBigBreasts()):
		text += "Ты быстро хватаешь свои {pc.breasts} и крепко сжимаешь их, направляя соски к самому рту. Твоя грудь достаточно большая, чтобы ты могла дотянуться губами до одного из сосков и присосаться к нему."
		text += "\n\n"
		
		text += "После достаточной стимуляции твои соски внезапно выбрасывают мощную струю {pc.milk} прямо тебе в рот. Ты издаешь стон, пробуя на вкус собственный продукт."
		text += "\n\n"
		
		#pc.addStamina(50)
	else:
		text += "Ты быстро прижимаешь руки к своим {pc.breasts} и сжимаешь их изо всех сил, направляя соски прямо к губам. Твоя грудь недостаточно велика, чтобы дотянуться до нее губами, поэтому ты просто сильнее разминаешь ее и широко открываешь рот."
		text += "\n\n"
	
		text += "После достаточной стимуляции твои соски внезапно выбрасывают мощную струю {pc.milk} прямо тебе в рот. Ты издаешь стон, пробуя на вкус собственный продукт."
		text += "\n\n"
		
		#pc.addStamina(50)

	text += Util.join(extraMessages, " ")+"\n\n"

	return {
		text = text,
		lust = 3,
		anim = "LustBreastsSelfFeed",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.BigBreasts : 0.7,
		InterestTopic.SmallBreasts : 0.7,
		InterestTopic.MediumBreasts : 0.7,
		InterestTopic.NoBreasts : 0.7,
		InterestTopic.LactatingBreasts : 1.0,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedBreasts : 0.5,
		InterestTopic.ExposedBra : 0.5,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Milking, 10]]
	return []
