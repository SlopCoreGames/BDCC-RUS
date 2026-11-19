extends Reference
class_name SlaveAuction

var charID:String = ""

var roundNumber:int = 0
var totalBidTimes:int = 0
var currentBid:int = 0
var lastBidderIndex:int = -1
var state:String = "start" # act react start ended
var canPresent:bool = true
var bidLastChances:int = 0

var startingBid:int = 10
var bidIncrease:int = 10
var relevantTraitBonus:float = 0.0
var presenterID:String = "mirri"

var actionText:String = ""
var extraActionTexts:Array = [] # no save

var slaveTraits:Dictionary = {}
var usedTraits:Dictionary = {}
var usedActions:Dictionary = {}

var slaveReactionType = AuctionSlaveReaction.Confused

var bidders:Array = []
var shouldEnd:bool = false

var isPCBeingSold:bool = false

func setCharID(newCharID:String):
	charID = newCharID
	isPCBeingSold = (charID == "pc")
	slaveReactionType = calculateSlaveReactionType()

func getChar() -> BaseCharacter:
	return GlobalRegistry.getCharacter(charID)

func getCharacter() -> BaseCharacter:
	return GlobalRegistry.getCharacter(charID)

func start(_args:Dictionary = {}):
	calculateSlaveTraits()
	generateBidders()
	presenterID = _args["presenterID"] if (_args.has("presenterID")) else "mirri"
	startingBid = _args["startingBid"] if (_args.has("startingBid")) else calculateStartingBid(getChar())
	bidIncrease = _args["bidIncrease"] if (_args.has("bidIncrease")) else calculateBidIncrease(getChar())
	relevantTraitBonus = _args["relevantTraitBonus"] if (_args.has("relevantTraitBonus")) else 0.0
	currentBid = startingBid

static func calculateSlaveTraitsStatic(theChar:BaseCharacter) -> Dictionary:
	var theTraits:Dictionary = {}
	for traitID in GlobalRegistry.getAuctionTraits():
		var trait:AuctionTrait = GlobalRegistry.getAuctionTrait(traitID)
		
		var score:float = trait.calculateScore(traitID, theChar)
		theTraits[traitID] = score
	return theTraits

func calculateSlaveTraits():
	slaveTraits = calculateSlaveTraitsStatic(getChar())

func generateBidders():
	bidders = GM.main.SAB.grabBidders()
	for bidder in bidders:
		bidder.setAuction(self)

func getText() -> String:
	if(state == "ended"):
		return actionText
	if(state == "react"):
		return actionText
	
	var isStart:bool = (state == "start")
	var theTexts:Array = []
	var bettingBeginsRound:int = getSoftEndRound()
	
	var slavesTraitsTexts:Array = []
	for traitID in slaveTraits:
		var score:float = slaveTraits[traitID]
		var trait:AuctionTrait = GlobalRegistry.getAuctionTrait(traitID)
		
		if(score > 0.0):
			var theName:String = trait.getName(traitID)
			if(usedTraits.has(traitID)):
				theName = "[color=#FF63E7]"+theName+"[/color]"
			
			#slavesTraitsTexts.append(theName+" ("+str(score)+")")
			slavesTraitsTexts.append(theName)
		
	if(isStart):
		theTexts.append("Аукцион вот-вот начнется. Ваша задача — продать своего раба за максимальное количество кредитов, заставляя участников торгов перебивать ставки друг друга.")
		theTexts.append("У покупателей разные предпочтения, которые можно узнать во время презентации раба. Старайтесь не акцентировать внимание на чертах, которые им не нравятся, и делайте упор на то, что им по душе.")
		theTexts.append("Аукцион закончится через 3 раунда (мягкий финал), если только вам не удастся поддерживать азарт торгов. Если после вашего действия поступит как минимум 2 новые ставки, вы получите возможность совершить еще одно действие.")
		theTexts.append("")
		theTexts.append("Начальная ставка: "+str(getStartingBid())+" кредитов. Минимальный шаг ставки: "+str(getBidIncrease())+" credits.")
		theTexts.append("Черты {slave.name}: "+Util.join(slavesTraitsTexts, ", "))
		theTexts.append("")
		theTexts.append(getBidderInfo())
		theTexts.append("")
		theTexts.append("Как вы хотите представить своего раба?")
	else:
		theTexts.append("Round №"+str(roundNumber)+((". Мягкий финал на раунде "+str(bettingBeginsRound)+".") if roundNumber < bettingBeginsRound else ". Достигнут мягкий финал. Аукцион завершится, если вы получите менее 2 новых ставок."))
		theTexts.append("Черты {slave.name}: "+Util.join(slavesTraitsTexts, ", "))
		theTexts.append("")
		theTexts.append(getBidderInfo())
		theTexts.append("")
		theTexts.append("Как вы хотите представить своего раба?")
	
	return Util.join(theTexts, "\n")

func doRandomAction():
	var theActions:Array = getActions()
	var possibleActions:Array = []
	for action in theActions:
		var canDoData:Array = canDoAction(action)
		if(canDoData[0]):
			possibleActions.append(action)
	doAction(RNG.pick(possibleActions))

func doBestAction():
	var theActions:Array = getActions()
	var actionToScore:Dictionary = {}
	
	var maxScore:float = 0.0
	
	for action in theActions:
		var canDoData:Array = canDoAction(action)
		if(canDoData[0]):
			var theScore:float = action.getAIScore(getChar(), self, slaveTraits)
			actionToScore[action] = theScore
			if(theScore > maxScore):
				maxScore = theScore
	
	if(actionToScore.empty()):
		Log.printerr("Something is wrong, we can't pick an auction action to do")
		return
	
	var filterScore:float = maxScore * 0.7
	
	var finalActionToScore:Dictionary = {}
	
	for action in actionToScore:
		var theScore:float = actionToScore[action]
		if(theScore >= filterScore):
			finalActionToScore[action] = theScore
	
	var theAction = RNG.pickWeightedDict(finalActionToScore)
	doAction(theAction)

func doRandomActionsUntilReact():
	if(state == "react" || state == "start" || state == "ended"):
		doBestAction()
	
	while(state != "react" && state != "ended"):
		doBestAction()

func getActions() -> Array:
	var result:Array = []
	
	if(state == "react"):
		result.append(GlobalRegistry.getAuctionAction("Продолжить"))
	elif(state == "ended"):
		result.append(GlobalRegistry.getAuctionAction("Продолжить"))
	elif(state == "start"):
		for actionID in GlobalRegistry.getAuctionActions():
			var theAction:AuctionAction = GlobalRegistry.getAuctionAction(actionID)
			if(theAction == null || theAction.getActionType() != AuctionActionType.Intro):
				continue
			result.append(theAction)
	else:
		for actionID in GlobalRegistry.getAuctionActions():
			var theAction:AuctionAction = GlobalRegistry.getAuctionAction(actionID)
			if(theAction == null || theAction.id == "Continue" || theAction.getActionType() == AuctionActionType.Intro):
				continue
			result.append(theAction)
	
	return result

func getState() -> String:
	return state

func getRoundNumber() -> int:
	return roundNumber

func onNewRound():
	state = "act"
	roundNumber += 1
	
	for bidder in bidders:
		bidder.onNewRound()

func canDoAction(_auctionAction:AuctionAction) -> Array:
	if(_auctionAction.getActionType() == AuctionActionType.Continue):
		return [true]
	
	if(_auctionAction.canOnlyUseOnce()):
		if(usedActions.has(_auctionAction.id)):
			return [false, "You already used this action"]
	
	var canUseInfo:Array = _auctionAction.canUse(getChar(), slaveTraits)
	if(!canUseInfo[0]):
		return canUseInfo
	
	if(_auctionAction.requiresAtLeastOneTraitForSlave()):
		var canUseAction:bool = false
		var traitsToCheck:Dictionary = _auctionAction.getTraits()
		if(!traitsToCheck.empty()):
			for traitID in traitsToCheck:
				if(slaveTraits.has(traitID) && slaveTraits[traitID] > 0.0):
					canUseAction = true
					break
		else:
			canUseAction = true
		
		if(!canUseAction):
			return [false, "Your slave lacks the traits required for this action"]
			
#	var traitsToCheck:Dictionary = _auctionAction.getTraits()
#	if(!traitsToCheck.empty()):
#		for traitID in traitsToCheck:
#			if(usedTraits.has(traitID)):
#				return [false, "You already showed this trait"]
	
	return [true]

func doAction(_auctionAction:AuctionAction):
	for bidder in bidders:
		bidder.clearDiscovered()
	extraActionTexts = []
	
	if(state == "ended"):
		shouldEnd = true
		return
	
	if(state == "react"):
		if(canPresent):
			onNewRound()
		
		if(!canPresent):
			bidLastChances += 1
			if(bidLastChances == 1):
				if(hasAnyBids()):
					saynnPresenter(str(currentBid)+" credits. Going once."+getGoingOnceText())
				else:
					saynnPresenter("No bids. Going once."+getGoingOnceTextNoBids())
			elif(bidLastChances == 2):
				if(hasAnyBids()):
					saynnPresenter(str(currentBid)+" credits. Going twice."+getGoingTwiceText())
				else:
					saynnPresenter("No bids. Going twice."+getGoingTwiceTextNoBids())
			elif(bidLastChances == 3):
				state = "ended"
				
				if(hasAnyBids()):
					saynnPresenter("SOLD!")
					
					var soldBidder:AuctionBidder = bidders[lastBidderIndex]
					
					sayn("Раб был продан "+soldBidder.name+" for "+str(currentBid)+" кредитами!")
					sayn("Всего ставок: "+str(totalBidTimes))
					saynn("Итоговая сумма: "+str(roundNumber))
					
					var totalTraitsPositive:int = 0
					var totalTraitsNegative:int = 0
					var totalRevealedTraitsPositive:int = 0
					var totalRevealedTraitsNegative:int = 0
					var totalHitTraitsPositive:int = 0
					var totalHitTraitsNegative:int = 0
					for bidderA in bidders:
						var bidder:AuctionBidder = bidderA
						totalTraitsPositive += bidder.likes.size()
						totalTraitsNegative += bidder.dislikes.size()
						for traitID in bidder.likes:
							var traitT = bidder.likes[traitID]
							if(traitT >= AuctionBidder.TRAIT_DISCOVERED):
								totalRevealedTraitsPositive += 1
							if(traitT >= AuctionBidder.TRAIT_HIT):
								totalHitTraitsPositive += 1
						for traitID in bidder.dislikes:
							var traitT = bidder.dislikes[traitID]
							if(traitT >= AuctionBidder.TRAIT_DISCOVERED):
								totalRevealedTraitsNegative += 1
							if(traitT >= AuctionBidder.TRAIT_HIT):
								totalHitTraitsNegative += 1
					if(totalTraitsPositive != 0 && totalTraitsNegative != 0):
						sayn("Суммарные черты участников: "+str(totalTraitsPositive+totalTraitsNegative)+", Положительные: "+str(totalTraitsPositive)+", Отрицательные: "+str(totalTraitsNegative))
						sayn("Открыто: "+str(totalRevealedTraitsPositive+totalRevealedTraitsNegative)+" ("+str(Util.roundF(float(totalRevealedTraitsPositive+totalRevealedTraitsNegative)/float(totalTraitsPositive+totalTraitsNegative)*100.0, 1))+"%), Положительные: "+str(totalRevealedTraitsPositive)+" ("+str(Util.roundF(float(totalRevealedTraitsPositive)/float(totalTraitsPositive)*100.0, 1))+"%), Отрицательные: "+str(totalRevealedTraitsNegative)+" ("+str(Util.roundF(float(totalRevealedTraitsNegative)/float(totalTraitsNegative)*100.0, 1))+"%)")
						sayn("Попадание: "+str(totalHitTraitsPositive+totalHitTraitsNegative)+" ("+str(Util.roundF(float(totalHitTraitsPositive+totalHitTraitsNegative)/float(totalTraitsPositive+totalTraitsNegative)*100.0, 1))+"%), Положительные: "+str(totalHitTraitsPositive)+" ("+str(Util.roundF(float(totalHitTraitsPositive)/float(totalTraitsPositive)*100.0, 1))+"%), Отрицательные: "+str(totalHitTraitsNegative)+" ("+str(Util.roundF(float(totalHitTraitsNegative)/float(totalTraitsNegative)*100.0, 1))+"%)")
				else:
					saynnPresenter("That's it.. Time is up.")
					
					saynn("Раба никто не купил...")
				
				actionText = Util.join(extraActionTexts, "")
				return
			
			doRoundOfBiddingWithChecks()
			actionText = Util.join(extraActionTexts, "")
			state = "react"
			#if(!canPresent):
			#	state = "react"
			#else:
			#	state = "act"
		return
	
	state = "react"
	
	var theResult:Dictionary = _auctionAction.onActFinal(getChar(), self, slaveTraits)
	if(!theResult.has("text")):
		theResult["text"] = "NO ACTION TEXT PROVIDED, FIX ME"
	
	saynn(theResult["text"])
	#actionText = theResult["text"]
	
	if(!theResult.has("traits")):
		theResult["traits"] = _auctionAction.getTraits()
	if(!theResult.has("desire")):
		theResult["desire"] = _auctionAction.getPassiveDesireGain()
	if(!theResult.has("slaveReaction")):
		theResult["slaveReaction"] = _auctionAction.getSlaveReaction(getChar(), getSlaveReactionType())
	
	#var extraTexts:Array = []
	saynn(theResult["slaveReaction"])
	
	var traits:Dictionary = theResult["traits"]
	if(!traits.empty()):
		for traitID in traits:
			usedTraits[traitID] = true
	usedActions[_auctionAction.id] = true
		
	var didPositiveReact:bool = false
	var didNegativeReact:bool = false
	for bidderA in getBiddersRandomOrder():
		var bidder:AuctionBidder = bidderA
		var reactResult:Dictionary = bidder.onAction(self, _auctionAction, theResult)
		
		if(reactResult["hitAnyLikes"] && reactResult["desireDelta"] > 0.0 && !didPositiveReact):
			didPositiveReact = true
			bidder.say(_auctionAction.getPositiveReaction(getChar(), slaveTraits))
		if(reactResult["hitAnyDislikes"] && reactResult["desireDelta"] < 0.0 && !didNegativeReact):
			didNegativeReact = true
			bidder.say(_auctionAction.getNegativeReaction(getChar(), slaveTraits))
	if(!didPositiveReact && !didNegativeReact && _auctionAction.getActionType() != AuctionActionType.Intro && _auctionAction.getActionType() != AuctionActionType.Ungrouped):
		RNG.pick(bidders).say(RNG.pick([
			"Хмм...",
			"..хм.. есть у кого какие мысли?",
			"Хм.. даже не знаю..",
		]))
		
	if(!_auctionAction.isEmphasizeAction()):
		for bidderA in getBiddersRandomOrder():
			var bidder:AuctionBidder = bidderA
			
			for traitID in traits:
				var _ok = bidder.hitTrait(self, traitID)
			#var _ok2 = bidder.discoverRandomTrait(self)
	
	var hadAnyLearns:bool = false
	for bidderA in bidders:
		var bidder:AuctionBidder = bidderA
		
		if(bidder.discoveredLikes.empty() && bidder.discoveredDislikes.empty()):
			continue
		
		var disTexts:Array = []
		var disLikesTexts:Array = []
		var disDisLikesTexts:Array = []
		
		for traitID in bidder.discoveredLikes:
			var traitObj:AuctionTrait = GlobalRegistry.getAuctionTrait(traitID)
			if(traitObj == null):
				continue
			disLikesTexts.append("[color=#"+bidder.getTraitColor(traitID).to_html(false)+"]"+traitObj.getName(traitID)+"[/color]")
		for traitID in bidder.discoveredDislikes:
			var traitObj:AuctionTrait = GlobalRegistry.getAuctionTrait(traitID)
			if(traitObj == null):
				continue
			disDisLikesTexts.append("[color=#"+bidder.getTraitColor(traitID).to_html(false)+"]"+traitObj.getName(traitID)+"[/color]")
		
		if(disLikesTexts.size() > 0):
			disTexts.append("предпочитает рабов с "+Util.humanReadableList(disLikesTexts)+" trait"+("s" if disLikesTexts.size() > 1 else ""))
		if(disDisLikesTexts.size() > 0):
			disTexts.append("не любит рабов с "+Util.humanReadableList(disDisLikesTexts)+" trait"+("s" if disDisLikesTexts.size() > 1 else ""))

		sayn("[i]"+getSlaverName()+" узнал(а), что "+bidder.name+" "+Util.join(disTexts, " and ")+".[/i]")
		hadAnyLearns = true
	if(hadAnyLearns):
		sayn("")

	if(roundNumber == getSoftEndRound()):
		saynnPresenter("We’re wrapping now, folks! Get your bids in while you can!")

	doRoundOfBiddingWithChecks()
		
	#if(!biddingTexts.empty()):
	#	extraTexts.append("")
	#	extraTexts.append_array(biddingTexts)
	
	#if(!extraTexts.empty()):
	#	actionText += "\n\n"+Util.join(extraTexts, "\n")
		
	actionText = Util.join(extraActionTexts, "")

func getSlaverName() -> String:
	if(isPCBeingSold):
		if(presenterID == "mirri"):
			return "Mirri"
		if(presenterID == "luxe"):
			return "Luxe"
		return GlobalRegistry.getCharacter(presenterID).getName()
	
	return "You"

func saynn(theText:String):
	extraActionTexts.append(theText+"\n\n")

func sayn(theText:String):
	extraActionTexts.append(theText+"\n")

func triggerSlaveBiddingReaction():
	var theReaction:String = getSlaveBiddingReactionText()
	if(theReaction != ""):
		saynn(theReaction)
	
	if(RNG.chance(40)):
		var theDialogueLine:String = getSlaveBiddingReactionDialogue()
		if(theDialogueLine != ""):
			saynn("[say=slave]"+theDialogueLine+"[/say]")

func doRoundOfBiddingWithChecks():
	var bidAmount:int = doRoundOfBidding()
	
	if(roundNumber >= getSoftEndRound()):
		if(bidAmount >= 2):
			#print("YAY. BID AMOUNT: "+str(bidAmount))
			if(isPCBeingSold):
				saynn("Так как "+getSlaverName()+" было сделано как минимум 2 новые ставки, вам могут представить еще варианты!")
			else:
				saynn("Так как было сделано как минимум 2 новые ставки, вы можете продолжать выставлять свою рабыню!")
			canPresent = true
			bidLastChances = 0
		else:
			canPresent = false
			if(isPCBeingSold):
				saynn("Так как "+getSlaverName()+" было сделано меньше 2 новых ставок после мягкого завершения, вам больше не будут предлагать варианты.")
			else:
				saynn("Так как было сделано меньше 2 новых ставок после мягкого завершения, вы больше не можете выставлять свою рабыню!")
	else:
		if(roundNumber == 0):
			if(isPCBeingSold):
				saynn("Аукцион начался!")
			else:
				saynn("Аукцион начался! Постарайтесь узнать как можно больше о предпочтениях участников до мягкого завершения.")
		else:
			if(isPCBeingSold):
				saynn("Раз уж идет раунд "+str(roundNumber)+" и мягкое завершение еще не наступило, "+getSlaverName()+" может предложить вам больше.")
			else:
				saynn("Раз уж идет раунд "+str(roundNumber)+" и мягкое завершение еще не наступило, вы можете выставить своего раба подороже.")
		canPresent = true
		bidLastChances = 0

func doRoundOfBidding() -> int:
	var resultBidAmount:int = 0
	
	var biddingRoundAmount:int = 1#3
	
	var biddersCopy:Array = []
	for bidder in bidders:
		if(lastBidderIndex != bidder.index):
			biddersCopy.append(bidder)
	biddersCopy.shuffle()
	for bidder in bidders:
		if(lastBidderIndex == bidder.index): # Current bidder is always last so they can bid back
			biddersCopy.append(bidder)
	
	
	for _i in range(biddingRoundAmount):
		for bidderA in biddersCopy:
			var bidder:AuctionBidder = bidderA
			if(lastBidderIndex == bidder.index):
				continue
			
			var chanceToBid:float = bidder.calculateChanceToBid()
			
			if(RNG.chance(chanceToBid / (_i+1))):
				var raiseChance:float = (bidder.desire - 1.5)*50.0
				var willRaise:bool = RNG.chance(raiseChance) && (totalBidTimes != 0)
				
				if(totalBidTimes != 0):
					currentBid += getBidIncrease()
				if(willRaise):
					currentBid += RNG.randi_range(2, 5) * getBidIncrease()
					for otherBidder in bidders:
						if(otherBidder == bidder):
							continue
						if(otherBidder.desire > 0.0):
							otherBidder.desire *= 0.5
							
				bidder.currentBid = currentBid
				lastBidderIndex = bidder.index
				bidder.onBid(totalBidTimes)
				
				if(totalBidTimes == 0):
					saynn("[say="+bidder.bidderID+"]Я уравняю ставку "+str(currentBid)+" кредитов.[/say]")
				else:
					var theDot:String = "."
					if(totalBidTimes > 10):
						theDot = "!"
					var prefix:String = ""
					if(willRaise):
						prefix = "I will raise it to "
						
					if(resultBidAmount == 0 || RNG.chance(80 - resultBidAmount*10 - totalBidTimes*3)):
						saynn("[say="+bidder.bidderID+"]"+prefix+str(currentBid)+" credits"+theDot+"[/say]")
					else:
						saynn("[say="+bidder.bidderID+"]"+prefix+str(currentBid)+" credits"+theDot+" "+bidder.getOutbidReaction()+"[/say]")
					
					
					#saynn(bidder.name+" выставил(а) "+str(currentBid)+" кредитов.")
				resultBidAmount += 1
				bidLastChances = 0
				totalBidTimes += 1
				
				if(resultBidAmount == 2):
					triggerSlaveBiddingReaction()
	
	return resultBidAmount

func getBidderInfo() -> String:
	var resultAr:Array = []
	
	for bidder in bidders:
		resultAr.append(Util.join(bidder.getBidderInfo(), "\n"))
	
	return Util.join(resultAr, "\n\n")

func getSoftEndRound() -> int:
	return 3

func getTotalBidTimes() -> int:
	return totalBidTimes

func getBiddersRandomOrder() -> Array:
	var result:Array = []
	result.append_array(bidders)
	result.shuffle()
	return result

func getPresenterID() -> String:
	return presenterID

func saynnPresenter(theText:String):
	saynn("[say=presenter]"+theText+"[/say]")

func unlockRandomTraitEachBidder():
	for bidder in bidders:
		bidder.discoverRandomTrait(self)

func unlockRandomRelevantTraitEachBidder():
	for bidder in bidders:
		bidder.discoverRandomRelevantTrait(self)

func unlockRandomTraitOfTypeEachBidder(_traitType):
	for bidder in bidders:
		bidder.discoverRandomTraitOfType(self, _traitType)

func unlockRandomTraitOfTypeEachBidderWithChance(_traitType, _chance:float):
	for bidder in bidders:
		if(RNG.chance(_chance + relevantTraitBonus*100.0)):
			bidder.discoverRandomTraitOfType(self, _traitType)

func unlockPercentageOfTraitsRandomBidder(howMuch:float, howMuchDesireToAdd:float = 0.0):
	var theBidder:AuctionBidder = RNG.pick(bidders)
	theBidder.desire += howMuchDesireToAdd
	
	var unlockedPerc:float = theBidder.getPercentageOfDiscoveredTraits()
	while(unlockedPerc < howMuch):
		var _ok = theBidder.discoverRandomTrait(self)
		if(!_ok):
			return
		
		unlockedPerc = theBidder.getPercentageOfDiscoveredTraits()

func calculateSlaveReactionType():
	var theCharacter:BaseCharacter = getCharacter()
	var thePersonality:Personality = theCharacter.getPersonality()
	var npcSlavery:NpcSlave
	var obedience:float = 0.0
	var trust:float = 0.0
	var love:float = 0.0
	var spoiling:float = 0.0
	var isMindBroken:bool = false
	if(theCharacter.isSlaveToPlayer()):
		npcSlavery = theCharacter.getNpcSlavery()
		obedience = npcSlavery.getObedience()
		isMindBroken = npcSlavery.isMindBroken()
		love = npcSlavery.getLove()
		trust = npcSlavery.getTrust()
		spoiling = npcSlavery.getSpoiling()
	
	if(isMindBroken):
		return AuctionSlaveReaction.MindBroken
	
	var reactionScores:Dictionary = {}
	reactionScores[AuctionSlaveReaction.Obedient] = obedience + thePersonality.getStat(PersonalityStat.Subby) * 0.5
	reactionScores[AuctionSlaveReaction.Confused] = love*0.5 + trust*0.5 - thePersonality.getStat(PersonalityStat.Mean) * 0.5 + thePersonality.getStat(PersonalityStat.Naive) * 0.5 + thePersonality.getStat(PersonalityStat.Brat) * 0.2
	reactionScores[AuctionSlaveReaction.Shy] = obedience*0.5 + love*0.5 - thePersonality.getStat(PersonalityStat.Mean) * 0.5 + thePersonality.getStat(PersonalityStat.Subby) * 0.5 + thePersonality.getStat(PersonalityStat.Coward) * 0.5
	reactionScores[AuctionSlaveReaction.Desperate] = trust*0.5 + spoiling - thePersonality.getStat(PersonalityStat.Naive) * 0.5 - thePersonality.getStat(PersonalityStat.Subby) * 0.5 + thePersonality.getStat(PersonalityStat.Impatient) * 0.5
	reactionScores[AuctionSlaveReaction.Angry] = trust + love*0.5 + thePersonality.getStat(PersonalityStat.Mean) - thePersonality.getStat(PersonalityStat.Subby) * 0.5 - thePersonality.getStat(PersonalityStat.Impatient) * 0.2 - thePersonality.getStat(PersonalityStat.Coward) * 0.3

	var maxScoreReaction = AuctionSlaveReaction.Confused
	var maxScoreScore:float = -9999.9
	
	for theReaction in reactionScores:
		if(reactionScores[theReaction] > maxScoreScore):
			maxScoreScore = reactionScores[theReaction]
			maxScoreReaction = theReaction
	
	
	return maxScoreReaction

func getSlaveReactionType():
	return slaveReactionType

func hasEnded() -> bool:
	return shouldEnd

func increaseBiddersDesire(howMuch:float):
	for bidder in bidders:
		bidder.desire += howMuch

func getSlaveBiddingReactionText() -> String:
	var _reactionType = getSlaveReactionType()
	if(_reactionType == AuctionSlaveReaction.Obedient):
		return RNG.pick([
			"{slave.name} еще ниже склоняет голову {slave.his}, с молчаливой покорностью принимая неистовый поток ставок.",
			"{slave.name} на мгновение поднимает взгляд; стремительные ставки лишь подтверждают положение {slave.his}, пока {slave.he} терпеливо ждет окончания торгов.",
			"Дыхание {slave.name} остается ровным, хотя пальцы {slave.his} едва заметно подергиваются в ответ на пристальное внимание.",
			"{slave.name} на мгновение закрывает {slave.his} глаза, словно смирившись с исходом и позволяя хаосу продолжаться.",
			"{slave.name} едва заметно кивает, словно безмолвно подтверждая {slave.his} ценность в глазах участников аукциона.",
			"{slave.name} стоит совершенно неподвижно, не подавая никаких видимых признаков реакции, пока разгорается аукционная война, полностью смирившись с судьбой {slave.his}.",
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			"Глаза {slave.name} слегка расширяются по мере того, как ставки растут, а замешательство во взгляде {slave.his} становится всё глубже.",
			"{slave.name} тревожно озирается по сторонам, и с каждым новым предложением отчаяние в глазах {slave.his} становится всё сильнее.",
			"{slave.name} прикусывает {slave.his} губу, и в выражении {slave.his} лица проскальзывает смесь грусти и неуверенности.",
			"{slave.name} вздрагивает при каждой новой ставке, и от растущих цифр {slave.him} чувствует себя всё более и более потерянной.",
			"{slave.name} часто моргает, словно пытаясь понять, почему {slave.him} уделяют столько внимания.",
			"Тихий, едва слышный вздох срывается с губ {slave.name}, ошеломленной нарастающим накалом аукционной войны.",
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			"Щеки {slave.name} краснеют всё сильнее с каждым новым повышением ставки — она явно ошеломлена таким вниманием.",
			"{slave.name} отводит взгляд, {slave.his} тело слегка дрожит, пока {slave.he} пытается скрыть {slave.his} смущение.",
			"{slave.name} подавляет всхлип, явно не привыкшая к тому, что за неё так сражаются.",
			"Всё лицо {slave.name} пылает багровым цветом, пока ставки продолжают расти, а из-за застенчивого нрава {slave.his}, {slave.him} нервно переминается с ноги на ногу.",
			"Дыхание {slave.name} учащается; от азарта торгов {slave.him} чувствует себя ещё более обнажённой.",
			"{slave.name} на мгновение зажмуривает {slave.his} глаза, пытаясь справиться с этим шквалом внимания.",
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"{slave.name} замерла как вкопанная; кажется, растущие ставки никак не влияют на {slave.him}.",
			"{slave.name} безучастно смотрит вдаль, совершенно не замечая яростной войны ставок, разгоревшейся вокруг {slave.him}.",
			"Тело {slave.name} слегка покачивается, но в глазах {slave.his} нет и тени осознания происходящего, пока цифры на табло растут.",
			"{slave.name} не моргает и не реагирует; лихорадочные торги для {slave.him} так же бессмысленны, как и всё остальное.",
			"Голова {slave.name} бессильно опущена, а в пустом взгляде {slave.his} нет ни малейшего признака узнавания.",
			"{slave.name} стоит на месте, словно безжизненная кукла, совершенно не затронутая хаосом вокруг {slave.him}.",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			"Дыхание {slave.name} срывается на паническое, когда торги усиливаются, а глаза {slave.his} мечутся между участниками аукциона.",
			"{slave.name} рвется в цепях, и с каждой новой ставкой ее отчаяние растет — безмолвная мольба о том, чтобы всё это поскорее закончилось.",
			"С губ {slave.name} срывается тихий всхлип; стремительно растущие ставки лишь усиливают замешательство и страх {slave.his}.",
			"{slave.name} ахает, качая {slave.his} головой, словно пытаясь отрицать происходящее и не в силах осознать воцарившийся хаос.",
			"{slave.name} извивается в оковах, заметно паникуя; от того, как растут ставки, ситуация для {slave.his} кажется всё более безнадёжной.",
			"Все тело {slave.name} дрожит, пока ставки взлетают всё выше — очевидно, что она чувствует себя загнанной в ловушку, из которой нет выхода.",
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			"Челюсти {slave.name} сжимаются всё сильнее с каждой новой ставкой, а во взгляде {slave.his} разгорается ярость.",
			"{slave.name} свирепо смотрит на толпу; в её глазах кипит ненависть, и она словно бросает вызов аукционистам, готовая в любой момент броситься на них в драку.",
			"{slave.name} growls under {slave.his} breath, the rising bids only fueling {slave.his} anger further.",
			"{slave.name} сплевывает на землю, и агрессивная борьба за ставки бесит {slave.him} еще сильнее.",
			"Глаза {slave.name} горят вызовом по мере того, как растут ставки; она явно не собирается смиренно принимать {slave.his} судьбу.",
			"{slave.name} дергается в {slave.his} оковах, и с каждой новой ставкой {slave.him} все решительнее пытается сопротивляться.",
		])
	return ""

func getSlaveBiddingReactionDialogue() -> String:
	var _reactionType = getSlaveReactionType()
	if(_reactionType == AuctionSlaveReaction.Obedient):
		return RNG.pick([
			'I’ll serve.. whoever wins.. I will do my best.',
			'I.. accept my fate. Whoever chooses me, I’m ready.',
			'Please.. I only want to be useful.',
			'I’ll obey.. I’ll obey anyone who wins.',
			'I was trained for this.. I won’t disappoint.',
			'I belong to whoever decides.. I’ll serve loyally.',
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			'Please.. stop this.. I don’t understand.',
			'I don’t know why.. this is happening.. please..',
			'I just want to go back.. please let me go.',
			'Why are you doing this? I didn’t ask for any of this..',
			'I don’t want to be sold.. Please, someone help me!',
			'This.. can’t be happening.. I don’t belong here.',
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			'Wh-why are they bidding so much for me?',
			'I.. I don’t know if I deserve this kind of attention.',
			'Th-they’re fighting over me.. I can’t believe it.',
			'I-I don’t understand.. why are they all looking at me?',
			'This is too much.. I don’t want them staring at me like that.',
			'They’re all watching me.. I-I don’t know what to do!',
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"...",
			"... ..",
			"... . . . ...",
			"..k.. h..",
			"..kh..",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			'Why are you bidding on me?! Stop! I don’t want this!',
			'Please, someone.. help me! Don’t leave me here!',
			'Let me go! Stop fighting for me! I don’t belong here!',
			'You can’t sell me! I’m not some object!',
			'Someone.. anyone.. please get me out of here!',
			'Stop bidding! I’m not for sale!',
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			'Keep bidding, you bastards. You won’t break me!',
			'I’m not afraid of you! You’ll regret this!',
			'You think you own me? I’ll tear you apart!',
			'Go ahead, fight over me. You’ll never control me.',
			'I’m not some prize! I’ll make you pay for this!',
			'Bid all you want, I’ll escape the moment you turn your back!',
		])
	return ""

func calculateStartingBid(_char:BaseCharacter) -> int:
	return 50

func calculateBidIncrease(_char:BaseCharacter) -> int:
	return 10

func getStartingBid() -> int:
	return startingBid

func getBidIncrease() -> int:
	return bidIncrease

func hasAnyBids() -> bool:
	return (lastBidderIndex >= 0)

func getAuctionResult() -> Dictionary:
	return {
		slaveID = charID,
		wasSold = (lastBidderIndex >= 0),
		winningBid = (currentBid if (currentBid >= 0) else 0),
		totalBidTimes = totalBidTimes,
		bidderIndex = lastBidderIndex,
	}

func getGoingOnceText() -> String:
	if(RNG.chance(50)):
		return ""
	return " "+RNG.pick([
		"Да ладно тебе, не упусти такой редкий шанс!",
		"Это твой шанс урвать главный приз!",
		"Будут еще предложения?",
		"Не медли, а то пожалеешь!",
		"Мы что, реально на этом остановимся?",
		"Это ваш последний шанс перебить ставку конкурентов!",
		"Уверяю вас, вы больше не найдете такой рабыни, как {slave.him}.",
		"Рабыня такого калибра заслуживает чуть больше энтузиазма!",
		"Кто готов предложить больше?",
		"Будут еще ставки?",
		"Еще ставки?",
		"Неужели вы дадите мне больше?",
		"Сможете предложить больше?",
	])

func getGoingTwiceText() -> String:
	return " "+RNG.pick([
		"Да ладно вам, это ваш последний шанс сделать ставку!",
		"Последний шанс! Не говорите потом, что я не предупреждал!",
		"Говорите сейчас, или потеряете эту шлюху навсегда!",
		"Я чувствую чьи-то колебания — решайтесь прямо сейчас!",
		"Есть тут кто достаточно смелый?",
		"Это ваш последний миг, чтобы забрать этот бриллиант!",
		"Неужели вы так легко позволите им уйти?",
		"Время тикает, есть последние предложения?",
		"Это правда всё, на что вы способны? Покажите мне финальную ставку!",
		"Вы сделаете этот ход решающим или упустите всё?"
	])

func getGoingOnceTextNoBids() -> String:
	return " "+RNG.pick([
		"Такой шанс выпадает не каждый день, ну же!",
		"Ни одной ставки? Вы упускаете выгоду!",
		"Этот раб стоит гораздо больше, чем тишина — кто начнет?",
		"Не позволяйте этому аукциону закончиться без единого предложения!",
		"Вы серьезно собираетесь пропустить такой прекрасный экземпляр?",
		"Это ваш момент, чтобы начать торги — не сдерживайте себя!",
		"Неужели никто не видит здесь потенциал?",
		"Первая ставка дает преимущество — кто ее сделает?",
		"Не стесняйтесь. Первая ставка может изменить всё!",
		"Я удивлена... неужели на такую редкость нет ставок?",
	])

func getGoingTwiceTextNoBids() -> String:
	return " "+RNG.pick([
		"Пора! Кто-нибудь, начните торги, иначе вы потеряете эту шлюшку навсегда!",
		"Последний шанс! Неужели вы все упустите эту красотку?",
		"Аукцион подходит к концу, кто сделает первую ставку?",
		"Поверить не могу, что всем плевать — докажите, что я ошибаюсь!",
		"Такой редкий шанс вот-вот ускользнет — не будьте теми, кто будет локти кусать!",
		"Я прямо чувствую ваше колебание в воздухе — всего одна ставка, и всё изменится!",
		"Эта рабыня заслуживает большего, чем просто молчание — кто начнет торги?",
		"Почти всё! Вы еще будете проклинать себя за то, что упустили её!",
		"Ставок всё еще нет? Делайте ставку прямо сейчас, пока аукцион не закрылся!",
	])

func saveData():
	var biddersData:Array = []
	for bidder in bidders:
		biddersData.append(bidder.saveData())
	
	return {
		charID = charID,
		roundNumber = roundNumber,
		totalBidTimes = totalBidTimes,
		currentBid = currentBid,
		lastBidderIndex = lastBidderIndex,
		state = state,
		canPresent = canPresent,
		bidLastChances = bidLastChances,
		startingBid = startingBid,
		bidIncrease = bidIncrease,
		relevantTraitBonus = relevantTraitBonus,
		actionText = actionText,
		slaveTraits = slaveTraits,
		usedTraits = usedTraits,
		usedActions = usedActions,
		slaveReactionType = slaveReactionType,
		shouldEnd = shouldEnd,
		bidders = biddersData,
		presenterID = presenterID,
		isPCBeingSold = isPCBeingSold,
	}

func loadData(_data):
	charID = SAVE.loadVar(_data, "charID", "rahi")
	roundNumber = SAVE.loadVar(_data, "roundNumber", 0)
	totalBidTimes = SAVE.loadVar(_data, "totalBidTimes", 0)
	currentBid = SAVE.loadVar(_data, "currentBid", 0)
	lastBidderIndex = SAVE.loadVar(_data, "lastBidderIndex", -1)
	state = SAVE.loadVar(_data, "state", "start")
	canPresent = SAVE.loadVar(_data, "canPresent", true)
	bidLastChances = SAVE.loadVar(_data, "bidLastChances", 0)
	startingBid = SAVE.loadVar(_data, "startingBid", 50)
	bidIncrease = SAVE.loadVar(_data, "bidIncrease", 10)
	relevantTraitBonus = SAVE.loadVar(_data, "relevantTraitBonus", 0.0)
	actionText = SAVE.loadVar(_data, "actionText", "")
	slaveTraits = SAVE.loadVar(_data, "slaveTraits", {})
	usedTraits = SAVE.loadVar(_data, "usedTraits", {})
	usedActions = SAVE.loadVar(_data, "usedActions", {})
	slaveReactionType = SAVE.loadVar(_data, "slaveReactionType", AuctionSlaveReaction.Confused)
	shouldEnd = SAVE.loadVar(_data, "shouldEnd", false)
	presenterID = SAVE.loadVar(_data, "presenterID", "mirri")
	isPCBeingSold = SAVE.loadVar(_data, "isPCBeingSold", false)
	
	bidders = []
	var biddersData = SAVE.loadVar(_data, "bidders", [])
	for bidderInfo in biddersData:
		var newBidder:AuctionBidder = AuctionBidder.new()
		newBidder.loadData(bidderInfo)
		newBidder.setAuction(self)
		bidders.append(newBidder)
