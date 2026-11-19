extends SexActivityBase

var leashTimer:int = 0

func _init():
	id = "DomLeashesSub"
	
	activityName = "Схватить поводок"
	activityDesc = "Хватай поводок!"
	activityCategory = ["Humiliate"]

func getGoals():
	return {
		#SexGoal.SubUndressSub: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		#SexType.StocksSex: true,
		#SexType.SlutwallSex: true,
		SexType.BitchsuitSex: true,
	}

func isActivityImpossibleShouldStop() -> bool:
	if(!getSub().getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving)):
		return true
	return false

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_subInfo.getChar().getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving)):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return _domInfo.personalityScore({PersonalityStat.Subby: -0.05}) + _subInfo.getResistScoreSmooth()*0.05

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return []
	if(_indx == SUB_0):
		return [SexActivityTag.Leashed]
	return []

func getCheckTagsDom() -> Array:
	return []

func getCheckTagsSub() -> Array:
	return [SexActivityTag.Leashed]

func startActivity(_args):
	addText("{dom.You} {dom.youVerb('pull')} out a [b]leash[/b] and {dom.youVerb('start')} trying to clip it to {sub.your} collar!")
	react(SexReaction.LeashStart)

func init_processTurn():
	leashTimer += 1
	if(leashTimer >= 2):
		setState("leashed")
		addText("{dom.You} {dom.youVerb('clip')} превращает [b]поводок[/b] в {sub.your}ошейник!")
		react(SexReaction.Leashed)
		fetishAffect(SUB_0, Fetish.Bondage, 2.0)
		fetishAffect(DOM_0, Fetish.Rigging, 3.0)

func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state == "leashed"):
			addAction("stop", getStopSexScore(DOM_0), "Снять поводок", "Хватит их ошейниками держать", {A_CATEGORY: ["Humiliate"]})
			if(!getSubInfo().isUnconscious()):
				var yankScore:float = getDomInfo().getIsAngryScore() * 1.0 * max(0.1, 0.1 + getDomInfo().personalityScore({PersonalityStat.Mean: 1.0})) - getSubInfo().getAboutToPassOutScore() * getDomInfo().fetishScore({Fetish.UnconsciousSex: -1.0})
				addAction("yank", yankScore, "Дернуть за поводок", "Дерни за поводок посильнее!", {A_CATEGORY: ["Violence"]})
	if(_indx == SUB_0):
		if(state == ""):
			addAction("pullaway", getSubInfo().getResistScore(), "Сопротивляться поводку!", "Попытаться вырваться из ошейника", {A_CHANCE: getSubResistChance(90.0, 40.0)})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('unclip')} поводок с ошейника {sub.your}.")
		return 
	if(_id == "yank"):
		addText("{dom.You} [b]{dom.youVerb('yank')}[/b] на поводке {sub.your} [b]сильно[/b], удушая {sub.youHim}.")
		choke(DOM_0, SUB_0, CHOKE_VERYHARD)
		react(SexReaction.LeashYank, [50.0, 30.0])
		return 

	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getSubResistChance(90.0, 40.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('resist')} и {sub.youVerb('manage')}, чтобы не попасть на поводок к {dom.you}!")
			getDomInfo().addAnger(0.3)
			endActivity()
			fetishUp(SUB_0, Fetish.Bondage, -5.0)
			fetishUp(DOM_0, Fetish.Rigging, -4.0)
			return
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')} пытается сопротивляться, чтобы его не взяли на поводок, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			fetishUp(SUB_0, Fetish.Bondage, -3.0)
			return
			
func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.5
	if(getSub().hasBoundArms()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	
	return max(theChance, 5.0)
	
func getLeashes() -> Dictionary:
	if(state == ""):
		return {}
	return {
		DOM_0: SUB_0,
	}

func saveData():
	var data = .saveData()
	
	data["leashTimer"] = leashTimer

	return data
	
func loadData(data):
	.loadData(data)
	
	leashTimer = SAVE.loadVar(data, "leashTimer", 0)
