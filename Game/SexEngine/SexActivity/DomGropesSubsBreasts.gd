extends SexActivityBase
var gropeAmount:int = 0
var alsoCock:bool = false
var noticedSore:bool = false

func _init():
	id = "DomGropesSubsBreasts"
	
	activityName = "Тискать грудь"
	activityDesc = "Стиснув их грудь посильнее!"
	activityCategory = ["Breasts"]

func getGoals():
	return {
		SexGoal.GropeBreasts: 1.0,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_subInfo.getChar().hasNonFlatBreasts()):
		return 0.0
	
	if(_subInfo.getChar().canBeMilked()):
		return max(0.0, _domInfo.fetishScore({Fetish.Lactation: 0.02}))
	return max(0.0, _domInfo.fetishScore({Fetish.Lactation: 0.01}))

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func isActivityImpossibleShouldStop() -> bool:
	if(alsoCock):
		if(!getSub().hasReachablePenis()):
			return true
	return false

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.HandsUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.BreastsUsed, SexActivityTag.HavingSex]
	return []

func startActivity(_args):
	addText("{dom.You} {dom.youVerb('put')} {dom.yourHis} кладет руки на {sub.your} {sub.breasts} и начинает их прощупывать"+getThroughClothingText(SUB_0, BodypartSlot.Breasts)+".")
	
	stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_TEASE)
	
	noticedSore = getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)
	
	react(SexReaction.DomAboutToStartGropingSubsBreasts, [100, 50])

func getExtraSubText() -> String:
	var result:Array = []
	
	if(getSub().canBeMilked() && RNG.chance(30)):
		result.append(RNG.pick([
			"Одинокие капли {sub.milk} стекают по {dom.yourHis} пальцам.",
			"Из сосков {sub.YourHis} сочится {sub.milk}.",
			"Соски {sub.YourHis} довольно сильно текут.",
			"Из твердых сосков {sub.YourHis} сочится {sub.milk}.",
			"Кажется, грудь {sub.YourHis} переполнена {sub.milk}.",
			"Грудь {sub.YourHis} сочится молоком.",
		]))
	if(!getSub().canBeMilked() && RNG.chance(10)):
		result.append(RNG.pick([
			"Соски {sub.YourHis} стимулируют.",
			"Соски {sub.YourHis} затвердели от прикосновений.",
			"Соски {sub.YourHis} затвердели от ласк.",
			"Из сосков {sub.yourHis} ничего не течет.",
			"Грудь {sub.YourHis} тискают, но ничего не выделяется.",
		]))
		
	if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking) && RNG.chance(50)):
		result.append(RNG.pick([
			"{sub.YourHis} соски садят!",
			"{sub.YourHis} соски садят, отчего это становится болезненным.",
			"{sub.YourHis} соски садят, что вызывает {sub.youHim} дискомфорт.",
			"{sub.YourHis} соски садят, что приносит {sub.youHim} боль.",
		]))
	
	if(result.size() > 0):
		return " "+Util.join(result, " ")
	return ""

func processTurn():
	gropeAmount += 1

func init_processTurn():
	addTextPick([
		"Руки {dom.You} {dom.youVerb('hold')} {dom.yourHis} на груди {sub.your}.",
		"Руки {dom.You} {dom.youVerb('hold')} {dom.yourHis} на {sub.your} {sub.breasts}.",
		"Руки {dom.You} {dom.youVerb('rest')} {dom.yourHis} на груди {sub.your}.",
	])

func groping_processTurn():
	var throughTheClothing:String = getThroughClothingText(SUB_0, BodypartSlot.Breasts)
	
	var text = RNG.pick([
		"{dom.You} активно {dom.youVerb('grope')} {sub.your} грудь"+throughTheClothing+".",
		"{dom.You} активно {dom.youVerb('rub')} {sub.your} грудь"+throughTheClothing+".",
		"{dom.You} {dom.youVerb('grope')} {sub.your} {sub.breasts}"+throughTheClothing+".",
		"{dom.You} {dom.youVerb('massage')} {sub.your} {sub.breasts}"+throughTheClothing+".",
		"{dom.You} {dom.youVerb('knead')} {sub.your} {sub.breasts}"+throughTheClothing+".",
		"{dom.You} {dom.youVerb('rub')} and {dom.youVerb('knead')} {sub.your} {sub.breasts}"+throughTheClothing+".",
		"{dom.You} {dom.youVerb('play')} with {sub.your} {sub.breasts}"+throughTheClothing+".",
	])
	text += getExtraSubText()
	
	if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
		getSubInfo().addPain(1)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=1,isDefense=false,intentional=false})
	
	if(RNG.chance(10) && getSub().isLactating() && !getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
		var breasts:BodypartBreasts = getSub().getBodypart(BodypartSlot.Breasts)
		var milkProduciton:FluidProduction = breasts.getFluidProduction()
		if(milkProduciton != null):
			milkProduciton.fillPercent(RNG.randf_rangeX2(0.05, 0.5))
			text += RNG.pick([
				" От стимуляции грудь становится тяжелее.",
				" Из-за стимуляции груди вырабатывают больше {sub.milk}.",
				" Грудь {sub.YourHis} вырабатывает больше {sub.milk}.",
			])
	
	var suddenlyLactating:bool = false
	if(getSub().stimulateLactation()):
		suddenlyLactating = true
		text += RNG.pick([
			" У {sub.You} внезапно началась [b]лактация[/b]!",
			" Грудь {sub.Your} внезапно начала [b]лактировать[/b]!",
			" Грудь {sub.Your} внезапно начала [b]выделять {sub.milk}[/b]!",
		])
	
	stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_NORMAL, SPEED_SLOW)
	
	if(!noticedSore && getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
		noticedSore = true
		text += RNG.pick([
			" После стольких ласк соски {sub.Your} стали казаться [b]чувствительными[/b].",
		])
	
	if(alsoCock):
		if(!getSubInfo().isReadyToPenetrate()):
			alsoCock = false
		else:
			stimulate(DOM_0, S_HANDS, SUB_0, S_PENIS, I_LOW, Fetish.SeedMilking, SPEED_VERYSLOW)
			#subInfo.stimulateArousalZone(0.05, BodypartSlot.Penis, 0.25)
			text += RNG.pick([
				" Свободная рука {dom.YourHis} ласкает {sub.yourHis} {sub.penis}.",
				" Свободная рука {dom.YourHis} ласкает {sub.youHim}.",
				" {dom.YouHe}, а также {dom.youAreHeIs} ласкает {sub.youHim}.",
				" {dom.YouHe} и {dom.youAreHeIs} одновременно ласкают {sub.youHim}.",
			])
	
	sendSexEvent(SexEvent.BreastsGroped, DOM_0, SUB_0, {madeLactate=suddenlyLactating})
	
	addText(text)
	react(SexReaction.DomGropesSubsBreasts, [10, 20])
	
	
func getActions(_indx:int):
	if(_indx == DOM_0):
		if(getState() == ""):
			addAction("startgrope", 1.0, "Начать тискать", "Начни тискать их!")
		if(getState() == "groping"):
			addAction("squeeze", 0.2, "Сжимать грудь", "Сжимай их грудь крепче!")
			if(!alsoCock && getSubInfo().isReadyToPenetrate() && getSub().hasReachablePenis() && hasBodypartUncovered(SUB_0, BodypartSlot.Penis)):
				addAction("startstrokecock", 0.3, "Ласкать член", "Также ласкать их член")
		addAction("stop", (0.15 if gropeAmount > 7 else 0.0), "Перестать тискать", "Хватит тискать")
	
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Сопротивляться тисканьям", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)})
		if(isReadyToCumHandled(SUB_0)):
			addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY:1001})
		
func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "startstrokecock"):
		alsoCock = true
		addText("{dom.You} также начал(а) ласкать {sub.your} {sub.penis}!")
	if(_id == "squeeze"):
		if(getSub().canBeMilked()):
			var howMuchCollected:float = getSub().getBodypart(BodypartSlot.Breasts).getFluids().drainPercent(0.1)
			var howMuchCollectedStr:String = str(Util.roundF(howMuchCollected, 1))+" ml"
					
			addText("{dom.You} {dom.youVerb('squeeze')} крепко сжимает {sub.yourHis} {sub.breasts} и "+howMuchCollectedStr+" из {sub.milk} вытекает.")
		else:
			addTextPick([
				"{dom.You} {dom.youVerb('squeeze')} {sub.yourHis} {sub.breasts} tightly.",
				"{dom.You} {dom.youVerb('squeeze')} крепко сжимает {sub.yourHis} {sub.breasts}, но ничего не вытекает.",
			])
		stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_NORMAL)
	if(_id == "startgrope"):
		var throughTheClothing:String = getThroughClothingText(SUB_0, BodypartSlot.Breasts)
		setState("groping")
		addText("{dom.You} начал(а) активно тискать {sub.you}"+throughTheClothing+"!")
		
		stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_TEASE)
		
		react(SexReaction.DomStartsGropingSubsBreasts, [100, 50])
	if(_id == "stop"):
		endActivity()
		satisfyGoals()
		addText("{dom.You} {dom.youVerb('quit')} тискает грудь {sub.yourHis}.")
	
	if(_id == "cum"):
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		var extraText:String = ""
		if(getSub().isLactating()):
			extraText = ", {sub.yourHis} {sub.breasts} брызжет {sub.milk} из этого соска во время оргазма"
		getSubInfo().stimulateArousalZone(0.0, BodypartSlot.Breasts, 2.0)
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="breasts"})
		addGenericOrgasmText(SUB_0, extraText)
	
	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('pull')} убирает(ся) от рук {dom.your}.")
			getDomInfo().addAnger(0.3)
			if(getState() != ""):
				setState("")
			else:
				failGoals()
				endActivity()
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			reactSub(SexReaction.ActivelyResisting, [50])

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 3
	return -1

func getAnimationPriority():
	return 1

func getAnimation():
	if(state in [""]):
		return [StageScene.BreastGroping, "tease", {pc=DOM_0, npc=SUB_0}]
	if(alsoCock):
		return [StageScene.BreastGroping, "stroke", {pc=DOM_0, npc=SUB_0}]
	return [StageScene.BreastGroping, "grope", {pc=DOM_0, npc=SUB_0}]
	

func saveData():
	var data = .saveData()
	
	data["gropeAmount"] = gropeAmount
	data["alsoCock"] = alsoCock
	data["noticedSore"] = noticedSore

	return data
	
func loadData(data):
	.loadData(data)
	
	gropeAmount = SAVE.loadVar(data, "gropeAmount", 0)
	alsoCock = SAVE.loadVar(data, "alsoCock", false)
	noticedSore = SAVE.loadVar(data, "noticedSore", false)
