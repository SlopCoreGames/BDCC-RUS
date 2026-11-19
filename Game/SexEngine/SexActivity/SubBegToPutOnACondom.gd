extends SexActivityBase

func _init():
	id = "SubBegToPutOnACondom"
	startedByDom = false
	startedBySub = true
	
	activityName = "Умолять о презервативе"
	activityDesc = "Умолять их надеть презерватив"
	activityCategory = ["Beg"]

func getGoals():
	return {
		SexGoal.SubOptionalCondomOnDom: 0.2,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.StocksSex: true,
		SexType.SlutwallSex: true,
		SexType.BitchsuitSex: true,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 0.0

func getStartActions(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var sub:BaseCharacter = _subInfo.getChar()
	var dom:BaseCharacter = _domInfo.getChar()
	if(dom.getWornCondom() != null):
		return
	
	if(!dom.hasReachablePenis() || dom.getInventory().hasSlotEquipped(InventorySlot.Penis) || dom.getFirstItemThatCoversBodypart(BodypartSlot.Penis) != null):
		return
	
	if(_subInfo.shouldFullyObey()):
		return
	
	var begScore:float = getActivityScore(_sexEngine, _domInfo, _subInfo) * _subInfo.fetishScore({Fetish.BeingBred: -1.0})
	addStartAction(["beg"], "Умолять использовать презерватив", "Просить доминанта надеть презерватив", begScore, {A_CATEGORY: getCategory(), A_CHANCE: calculateSuccessChance(_domInfo, _subInfo, 100.0)})
	if(sub.isPlayer() && sub.hasCondoms() && !sub.hasBlockedHands()):
		addStartAction(["offer"], "Предложить презерватив", "Умолять доминанта использовать твой презерватив", begScore, {A_CATEGORY: getCategory(), A_CHANCE: calculateSuccessChance(_domInfo, _subInfo, 130.0, 0.5)})

func calculateSuccessChance(_domInfo: SexDomInfo, _subInfo: SexSubInfo, baseChance:float = 100.0, angerMult:float = 1.0) -> float:
	var successChance = 0.1 -_domInfo.fetishScore({Fetish.Breeding: 0.5}) + _domInfo.fetishScore({Fetish.Condoms: 1.0})
	successChance = successChance * baseChance
	if(successChance > 0.0):
		successChance *= max(0.0, 1.0 - _domInfo.getAngerScore() * angerMult)
	if(_subInfo.getChar().isGagged()):
		successChance *= 0.5
	return max(successChance, 5.0)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.PenisInside]
	return []

func startActivity(_args):
	if(_args[0] in ["beg", "offer"]):
		var condomBeggingReaction = SexReaction.BeggingForCondom
		endActivity()
		var text:String = ""
		if(_args[0] == "beg"):
			text = RNG.pick([
				"{sub.You} {sub.youVerb('beg')} {dom.youHim} умоляет надеть презерватив.",
			])
		else:
			condomBeggingReaction = SexReaction.OfferingACondom
			text = RNG.pick([
				"{sub.You} {sub.youVerb('offer')} {dom.youHim} умоляет надеть один из {sub.yourHis} презервативов.",
			])
		if(getDomInfo().getChar().isPlayer()):
			addText(text)
			reactSub(condomBeggingReaction)
			return
		
		if(getDomInfo().hasMemory("TiredOfCondomOffers")):
			text += RNG.pick([
				" {dom.You} {dom.youVerb('ignore')} {sub.yourHis} begging.",
			])
			getDomInfo().addAnger(0.05)
			addText(text)
			reactSub(condomBeggingReaction)
			return
		
		var successChance:float
		if(_args[0] == "beg"):
			successChance = calculateSuccessChance(getDomInfo(), getSubInfo(), 100.0)
		else:
			successChance = calculateSuccessChance(getDomInfo(), getSubInfo(), 130.0, 0.5)
		
		if(RNG.chance(successChance)):
			if(_args[0] == "beg"):
				text += RNG.pick([
					" {dom.You} {dom.youVerb('nod')} и {dom.youVerb('put')} надевают один из {dom.yourHis} презервативов на {dom.yourHis} член.",
				])
			else:
				text += RNG.pick([
					" {dom.You} {dom.youVerb('nod')} и {dom.youVerb('put')} надевают {sub.yourHis} презерватив на {dom.yourHis} член.",
				])
			
			var condomItem:ItemBase = GlobalRegistry.createItem("UsedCondom")
			getDom().getInventory().forceEquipStoreOther(condomItem)
			if(getSub().isPlayer() && _args[0] == "offer"):
				condomItem.breakChance = getSub().useBestCondom()
			
			addText(text)
			reactSub(condomBeggingReaction)
			return
		else:
			var superFailChance:float = getDomInfo().getAngerScore() * 30.0
			if(RNG.chance(superFailChance)):
				getDomInfo().remember("TiredOfCondomOffers")
				text += RNG.pick([
					" {dom.You} {dom.youVerb('get')} очень раздражен тем, как {sub.yourHis} умоляет.",
				])
				getDomInfo().addAnger(0.2)
				addText(text)
				reactSub(condomBeggingReaction)
				return
			
			getDomInfo().addAnger(0.1)
			text += RNG.pick([
				" {dom.You} {dom.youVerb('shake')} {dom.yourHis} head.",
			])
			
			addText(text)
			reactSub(condomBeggingReaction)
			return

