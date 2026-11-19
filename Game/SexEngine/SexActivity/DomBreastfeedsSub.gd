extends SexActivityBase
var gropeAmount:int = 0
var kneadBonus:int = 0
var noticedSore:bool = false

func _init():
	id = "DomBreastfeedsSub"
	
	activityName = "Подцель кормления грудью"
	activityDesc = "Накорми их своей грудью!"
	activityCategory = ["Breasts"]

func getGoals():
	return {
		SexGoal.BreastFeedSub: 1.0,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 0.0

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.BreastsUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex]
	return []

func startActivity(_args):
	addText("{dom.You} {dom.youVerb('sit')} на {sub.your} коленях и {dom.youVerb('push', 'pushes')} {dom.yourHis}"+getThroughClothingTextCustom(DOM_0, BodypartSlot.Breasts, " clothed")+" грудью в лицо {sub.yourHis}.")
	stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_TEASE)
	noticedSore = getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)
	react(SexReaction.DomBreastfeedsSubStart, [100, 50])

func onSwitchFrom(_otherActivity, _args):
	return

func getExtraDomText(hasMilk:bool) -> String:
	var result:Array = []
	
	if(hasMilk && RNG.chance(30)):
		result.append(RNG.pick([
			"Одинокие капли {dom.milk} стекают по губам {sub.yourHis}.",
			"Соски {dom.YourHis} сочатся {dom.milk}.",
			"Соски {dom.YourHis} довольно сильно текут.",
			"Твердые соски {dom.YourHis} выделяют {dom.milk}.",
			"Кажется, грудь {dom.YourHis} полна {dom.milk}.",
		]))
		
	if(!hasMilk && RNG.chance(20)):
		result.append(RNG.pick([
			" Соски {dom.YourHis} стимулируют.",
			" Соски {dom.YourHis} затвердели от прикосновения губ {sub.yourHis}.",
			" Соски {dom.YourHis} затвердели от поглаживаний.",
		]))
		
	if(getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking) && RNG.chance(50)):
		result.append(RNG.pick([
			"Соски {dom.YourHis} болят!",
			"Соски {dom.YourHis} садят, отчего это причиняет боль.",
			"Соски {dom.YourHis} садят, что вызывает {dom.youHim} дискомфорт.",
			"Соски {dom.YourHis} садят, что приносит {dom.youHim} боль.",
		]))
	
	if(result.size() > 0):
		return " "+Util.join(result, " ")
	return ""

func processTurn():
	if(kneadBonus > 0):
		kneadBonus -= 1

func feeding_processTurn():
	gropeAmount += 1
	var breasts:BodypartBreasts = getDom().getBodypart(BodypartSlot.Breasts)
	var milkProduciton:FluidProduction = breasts.getFluidProduction()
	var fluids:Fluids = breasts.getFluids()
	
	if(milkProduciton.getFluidAmount() < 5.0):
		var text = RNG.pick([
			"{sub.You} {sub.youVerb('try', 'tries')} сосет {dom.your} грудь, но молоко не идет.",
			"{sub.You} {sub.youVerb('suckle')} сосет {dom.your} соски, но молоко не идет.",
			"{sub.You} {sub.youVerb('suckle')} сосет {dom.your} соски, ловя послевкусие {dom.yourHis} молока.",
			"{sub.You} {sub.youVerb('lick')} и {sub.youVerb('put')} надавливает на {dom.your} соски, пытаясь их подоить.",
			"{dom.You} {dom.youAre} пытается кормить грудью {sub.you}, но {dom.youHe} {dom.youAreHeIs} не лактирует.",
		])
		text += getExtraDomText(false)
		
		if(getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			getDomInfo().addPain(1)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=1,isDefense=false,intentional=false})
		
		var suddenlyLactating = false
		if(RNG.chance(30) && getDom().stimulateLactation()):
			suddenlyLactating = true
			text += RNG.pick([
				" У {dom.You} внезапно началось [b]лактация[/b]!",
				" У {dom.Your} внезапно начали [b]лактировать[/b] груди!",
				" Грудь {dom.Your} внезапно начала [b]производить {dom.milk}[/b]!",
			])
		
		stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_NORMAL, SPEED_SLOW)
#		affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
#		affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
#		subInfo.addArousalForeplay(0.05)
#		domInfo.addArousalForeplay(0.05)
		
		if(!noticedSore && getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			noticedSore = true
			text += RNG.pick([
				" Соски {dom.Your} стали казаться [b]чувствительными и болезненными[/b].",
			])
		
		sendSexEvent(SexEvent.BreastFeeding, SUB_0, DOM_0, {madeLactate=suddenlyLactating, loadSize=0.0, targetIsDom=true})
		
		addText(text)
		react(SexReaction.DomBreastfeedsSub, [30, 30])
	else:
		var extraMessages:Array = []
		var fluidByAmount:Dictionary = fluids.getFluidAmountByType()
		var totalAmount:float = fluids.getFluidAmount()

		var minAmount:float = RNG.randf_range(1.0, 10.0)
		var minRatio:float = 0.001
		if(kneadBonus > 0):
			if(kneadBonus == 1):
				minAmount = RNG.randf_range(10.0, 20.0)
				minRatio = 0.02
			else:
				minAmount = RNG.randf_range(5.0, 50.0)
				minRatio = 0.01
		var howMuchCollected:float = getDom().getBodypart(BodypartSlot.Breasts).getFluids().transferTo(getSub().getBodypart(BodypartSlot.Head), minRatio, minAmount)
		var howMuchCollectedStr:String = str(Util.roundF(howMuchCollected, 1))+" ml"
		
		if(howMuchCollected > 0.0):
			for fluidID in fluidByAmount:
				var share:float = fluidByAmount[fluidID] / totalAmount
				
				var swallowData:Dictionary = getSub().doSwallow(fluidID, share*howMuchCollected*10.0)
				if(swallowData.has("text") && swallowData["text"] != ""):
					extraMessages.append(swallowData["text"])
		
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('feed')} on {dom.your} "+RNG.pick(["leaky", "lactating"])+" nipples, consuming "+howMuchCollectedStr+".",
			"{sub.You} {sub.youVerb('suckle')} соски {dom.your}, ощущая вкус {dom.milk} на {sub.yourHis} языке, поглощая "+howMuchCollectedStr+" этого.",
			"{sub.You} {sub.youVerb('breastfeed')} on {dom.your} {dom.breasts}, consuming "+howMuchCollectedStr+".",
			"{dom.You} {dom.youAre} кормит грудью {sub.you}, заставляя {sub.youHim} поглощать "+howMuchCollectedStr+".",
		])
		if(extraMessages.size() > 0):
			text += " "+Util.join(extraMessages)
		text += getExtraDomText(true)
		
		if(getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			getDomInfo().addPain(1)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=1,isDefense=false,intentional=false})
		
#		affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
#		affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
#		subInfo.addArousalForeplay(0.1)
#		domInfo.addArousalForeplay(0.1)
		stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_NORMAL, SPEED_SLOW)
		getDomInfo().stimulateArousalZone(0.1, BodypartSlot.Breasts, 1.0)
		
		if(gropeAmount > 20 && RNG.chance(2) && !getDom().hasPerk(Perk.MilkNoSoreNipples) && !getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			if(getDom().addEffect(StatusEffect.SoreNipplesAfterMilking)):
				text += RNG.pick([
					" Соски {dom.Your} стали казаться [b]болезненными[/b] после столь долгого кормления.",
				])
		
		sendSexEvent(SexEvent.BreastFeeding, SUB_0, DOM_0, {madeLactate=false, loadSize=howMuchCollected, targetIsDom=true})
		
		addText(text)
		react(SexReaction.DomBreastfeedsSub, [30, 30])

func getActions(_indx:int):
	if(_indx == DOM_0):
		if(getState() == ""):
			if(hasBodypartUncovered(DOM_0, BodypartSlot.Breasts) && !getSub().isOralBlocked()):
				addAction("forcefeed", 1.0, "Принудительное кормление", "Попытаться заставить их.", {A_CHANCE: 30})
		if(getState() == "feeding"):
			var moanScore:float = max(0.1, fetish(DOM_0, Fetish.Lactation)*0.5 + personality(DOM_0, PersonalityStat.Subby)*0.5)
			addAction("moan", moanScore, "Стон", "Покажи, как тебе это нравится")
			var praiseScore:float = -getDomInfo().getAngerScore() + max(0.0, fetish(DOM_0, Fetish.Lactation)*0.5 - personality(DOM_0, PersonalityStat.Subby)*0.5)
			addAction("praise", praiseScore, "Похвала", "Говорить им, как хорошо у них получается")
		if(isReadyToCumHandled(DOM_0)):
			addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})
		
		var stopScore:float = 1.0
		var breasts:BodypartBreasts = getDom().getBodypart(BodypartSlot.Breasts)
		if(breasts):
			var milkProduciton:FluidProduction = breasts.getFluidProduction()
			stopScore = (0.35 if ((gropeAmount > 5 && milkProduciton.getFluidAmount() < 5.0) || gropeAmount > 10) else 0.0)
		addAction("stop", stopScore, "Прекратить кормление", "Хватит кормить")
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Сопротивляться кормлению", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)})
		if(getState() == ""):
			if(hasBodypartUncovered(DOM_0, S_BREASTS) && !getSub().isOralBlocked()):
				var startFeedScore:float = getSubInfo().getComplyScore()*0.5 + fetish(SUB_0, Fetish.Lactation)*0.3 + personality(SUB_0, PersonalityStat.Subby)*0.3
				addAction("startfeed", startFeedScore, "Начать кормить", "Кормись их грудью!")
		if(getState() == "feeding"):
			if(!getSub().hasBoundArms()):
				var kneadScore:float = fetish(SUB_0, Fetish.Lactation) * (0.5 / float(Util.maxi(1, kneadBonus+1)))
				addAction("knead", kneadScore, "Разминать грудь", "Разминай их грудь, чтобы усилить приток молока")
		
		
func doAction(_indx:int, _actionID:String, _action:Dictionary):
	if(_actionID == "cum"):
		getDom().cumOnFloor()
		getDomInfo().cum()
		
		var extraText:String = ""
		if(getDom().isLactating()):
			extraText = ", {dom.yourHis} {dom.breasts} squirt {dom.milk} out from this nipple orgasm"
		
		getDomInfo().stimulateArousalZone(0.0, BodypartSlot.Breasts, 2.0)
		sendSexEvent(SexEvent.UniqueOrgasm, SUB_0, DOM_0, {orgasmType="breasts"})
		addGenericOrgasmText(DOM_0, extraText)
	if(_actionID == "praise"):
		addTextPick([
			"{dom.You} {dom.youVerb('praise')} {sub.you}!",
			"{dom.You} {dom.youVerb('praise')} {sub.you} за кормление из {dom.yourHis} {dom.breasts}!",
			"{sub.You} {sub.youAre}, когда {dom.youHim} хвалят.",
		])
		getSubInfo().addFear(-0.02)
		getSubInfo().addLust(5)
		getDomInfo().addArousalForeplay(0.02)
		react(SexReaction.DomBreastfeedPraise)
	if(_actionID == "moan"):
		var moanText:String = RNG.pick([
			"{dom.youVerb('moan')}"
		])
		if(getDom().isGagged()):
			moanText = RNG.pick([
				"{dom.youVerb('let')} издает приглушенные стоны",
				"{dom.youVerb('let')} издает приглушенный стон",
				"{dom.youVerb('let')} издает приглушенный звук удовольствия",
			])
		
		addTextPick([
			"{dom.You} "+moanText+" пока кормит грудью {sub.you}!",
			"{dom.You} "+moanText+" пока сосут соски {dom.yourHis}!",
			"{dom.You} "+moanText+" с жадностью!",
		])
		moan(DOM_0)
	if(_actionID == "forcefeed"):
		if(RNG.chance(30)):
			setState("feeding")
			addText("{dom.You} {dom.youVerb('force')} {sub.you}, чтобы начать кормиться из {dom.yourHis} {dom.breasts}!")
			
			stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_TEASE)
#			affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
#			affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
#			subInfo.addArousalForeplay(0.05)
#			domInfo.addArousalForeplay(0.05)
		else:
			addTextPick([
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы заставить {sub.you} начать кормиться из {dom.yourHis} {dom.breasts}.",
				"{dom.You} {dom.youVerb('pull')} {sub.your} подносит голову к {dom.yourHis} груди, пытаясь начать сосать {sub.youHim}.",
			])
			
			stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_TEASE, SPEED_VERYSLOW)
			#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
			#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
	if(_actionID == "stop"):
		endActivity()
		satisfyGoals()
		addText("{dom.You} {dom.youVerb('quit')} feeding {sub.youHim}.")

	if(_actionID == "startfeed"):
		setState("feeding")
		addText("{sub.You} начал(а) активно сосать {dom.your} {dom.breasts}!")
		
		stimulateBreasts(SUB_0, DOM_0, S_MOUTH, I_TEASE)
		#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
		#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
		#subInfo.addArousalForeplay(0.05)
		#domInfo.addArousalForeplay(0.05)
	if(_actionID == "knead"):
		if(getDom().canBeMilked()):
			kneadBonus += 2
			addTextPick([
				"{sub.You} {sub.youVerb('knead')} {dom.yourHis} {dom.breasts}, и поток {dom.milk} усиливается!",
				"{sub.You} {sub.youVerb('knead')} {dom.yourHis} {dom.breasts} одновременно с кормлением грудью.",
				"{sub.You} {sub.youVerb('knead')} {dom.yourHis} {dom.breasts}.",
				"{sub.You} {sub.youVerb('massage')} {dom.yourHis} {dom.breasts}.",
			])
				
			if(RNG.chance(10) && getDom().isLactating() && !getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				var breasts:BodypartBreasts = getDom().getBodypart(BodypartSlot.Breasts)
				var milkProduciton:FluidProduction = breasts.getFluidProduction()
				if(milkProduciton != null):
					milkProduciton.fillPercent(RNG.randf_rangeX2(0.05, 0.5))
					addTextPick([
						"От стимуляции грудь становится тяжелее.",
						"Стимуляция груди заставляет её вырабатывать больше {dom.milk}.",
						"Грудь {dom.YourHis} вырабатывает больше {dom.milk}.",
					])
			if(getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				getDomInfo().addPain(3)
				sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=3,isDefense=false,intentional=false})
			
			stimulateBreasts(SUB_0, DOM_0, S_HANDS, I_NORMAL)
			#domInfo.stimulateArousalZone(0.2, BodypartSlot.Breasts, 1.0)
			#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
			#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
		else:
			addTextPick([
				"{sub.You} {sub.youVerb('knead')} {dom.yourHis} {dom.breasts}, стимулируя их.",
				"{sub.You} {sub.youVerb('massage')} {dom.yourHis} {dom.breasts}, лаская их.",
				"{sub.You} {sub.youVerb('knead')} {dom.yourHis} {dom.breasts} с помощью {sub.yourHis} рук.",
			])
			stimulateBreasts(SUB_0, DOM_0, S_HANDS, I_NORMAL)
			#domInfo.stimulateArousalZone(0.2, BodypartSlot.Breasts, 1.0)
			#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
			#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
			
			if(getDom().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				getDomInfo().addPain(3)
				sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=3,isDefense=false,intentional=false})
			
			if(RNG.chance(70) && getDom().stimulateLactation()):
				addTextPick([
					"{dom.You} внезапно начал(а) [b]лактацию[/b]!",
					"Грудь {dom.Your} внезапно начала [b]лактировать[/b]!",
					"Грудь {dom.Your} внезапно начала [b]выделять {dom.milk}[/b]!",
				])
	if(_actionID == "pullaway"):
		var successChance:float = getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('pull')} от {dom.your} груди.")
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
	if(_indx == DOM_0):
		return 3
	return -1

func getAnimationPriority():
	return 1

func getAnimation():
	if(state in [""]):
		return [StageScene.BreastFeeding, "teasealt", {pc=DOM_0, npc=SUB_0}]
	return [StageScene.BreastFeeding, "feedalt", {pc=DOM_0, npc=SUB_0}]

func saveData():
	var data = .saveData()
	
	data["gropeAmount"] = gropeAmount
	data["kneadBonus"] = kneadBonus
	data["noticedSore"] = noticedSore

	return data
	
func loadData(data):
	.loadData(data)
	
	gropeAmount = SAVE.loadVar(data, "gropeAmount", 0)
	kneadBonus = SAVE.loadVar(data, "kneadBonus", 0)
	noticedSore = SAVE.loadVar(data, "noticedSore", false)
