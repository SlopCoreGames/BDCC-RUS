extends SexActivityBase
var gropeAmount:int = 0
var kneadBonus:int = 0
var noticedSore:bool = false

func _init():
	id = "DomBreastfeedsOnSub"
	
	activityName = "Кормить грудью сабку"
	activityDesc = "Попытаться покормиться из их груди!"
	activityCategory = ["Breasts"]

func getGoals():
	return {
		SexGoal.BreastFeedOnSub: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.TentaclesSex: true,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 0.0

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.BreastsUsed, SexActivityTag.HavingSex]
	return []

func startActivity(_args):
	if(isTentaclesSex()):
		addTextPick([
			"Щупальца хватают и приподнимают {sub.you}, одно из толстых щупалец зависает рядом с {sub.yourHis}"+getThroughClothingTextCustom(SUB_0, S_BREASTS, " clothed")+" nipples."
		])
	else:
		addTextPick([
			"{dom.You} {dom.youVerb('lean')} совсем близко к {sub.your} {sub.breasts}, {dom.yourHis} губы замирают у {sub.yourHis}"+getThroughClothingTextCustom(SUB_0, S_BREASTS, " clothed")+" nipples.",
		])
	
	stimulateBreasts(DOM_0, SUB_0, S_MOUTH, I_TEASE)
	#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
	#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
	
	noticedSore = getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)
	react(SexReaction.DomBreastfeedsOnSubStart, [100, 50])

func onSwitchFrom(_otherActivity, _args):
	return

func getExtraSubText(hasMilk:bool) -> String:
	var result:Array = []
	
	if(hasMilk && RNG.chance(30)):
		if(isTentaclesSex()):
			result.append(RNG.pick([
				"Одинокие капли {sub.milk} стекают по {sub.yourHis} {sub.breasts}.",
				"Из сосков {sub.YourHis} сочится {sub.milk}.",
				"Соски {sub.YourHis} довольно сильно текут.",
				"Из твердых сосков {sub.YourHis} сочится {sub.milk}.",
				"Кажется, грудь {sub.YourHis} переполнена {sub.milk}.",
			]))
		else:
			result.append(RNG.pick([
				"Одинокие капли {sub.milk} стекают по губам {dom.yourHis}.",
				"Из сосков {sub.YourHis} сочится {sub.milk}.",
				"Соски {sub.YourHis} довольно сильно текут.",
				"Из твердых сосков {sub.YourHis} сочится {sub.milk}.",
				"Кажется, грудь {sub.YourHis} переполнена {sub.milk}.",
			]))
		
	if(!hasMilk && RNG.chance(20)):
		if(isTentaclesSex()):
			result.append(RNG.pick([
				" {sub.YourHis} соски стимулируют.",
				" {sub.YourHis} соски затвердели от постоянного высасывания.",
				" {sub.YourHis} соски затвердели от потираний.",
			]))
		else:
			result.append(RNG.pick([
				" {sub.YourHis} соски стимулируют.",
				" {sub.YourHis} соски затвердели от прикосновения {dom.yourHis} губ.",
				" {sub.YourHis} соски затвердели от потираний.",
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
	if(kneadBonus > 0):
		kneadBonus -= 1

func feeding_processTurn():
	gropeAmount += 1
	var breasts:BodypartBreasts = getSub().getBodypart(BodypartSlot.Breasts)
	var milkProduciton:FluidProduction = breasts.getFluidProduction()
	var fluids:Fluids = breasts.getFluids()
	
	if(milkProduciton.getFluidAmount() < 5.0):
		var text:String
		if(isTentaclesSex()):
			text = RNG.pick([
				"Щупальца качают и разминают {sub.your} грудь, но молоко не идет.",
				"Щупальца ритмично сжимаются вокруг груди {sub.your}, сосание {sub.your} сосков оказывается тщетным.",
				"Скользкие отростки работают с каждым соском {sub.your}, надавливая и потягивая в попытке выжать молоко.",
				"Щупальца качают и разминают {sub.your} {sub.breasts}, неустанно всасывая {sub.yourHis} соски.",
				"Щупальца продолжают пытаться подоить {sub.you}, пульсируя вокруг {sub.yourHis} {sub.breasts}.",
			])
			text += getExtraSubText(false)
		else:
			text = RNG.pick([
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы покормиться из {sub.your} груди, но молоко не идет.",
				"{dom.You} {dom.youVerb('suckle')} {sub.your} соски, но молоко не идет.",
				"{dom.You} {dom.youVerb('suckle')} {sub.your} соски, преследуя послевкусие {sub.yourHis} молока.",
				"{dom.You} {dom.youVerb('lick')} и {dom.youVerb('put')} давят на {sub.your} соски, пытаясь их подоить.",
			])
			text += getExtraSubText(false)
		
		if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			getSubInfo().addPain(1)
			sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=1,isDefense=false,intentional=false})
		
		var suddenlyLactating = false
		if(RNG.chance(30) && getSub().stimulateLactation()):
			suddenlyLactating = true
			text += RNG.pick([
				" У {sub.You} внезапно началась [b]лактация[/b]!",
				" Грудь {sub.Your} внезапно начала [b]лактировать[/b]!",
				" Грудь {sub.Your} внезапно начала [b]выделять {sub.milk}[/b]!",
			])
		
		#stimulate(DOM_0, S_MOUTH, SUB_0, S_BREASTS, I_TEASE, Fetish.Lactation)
		stimulateBreasts(DOM_0, SUB_0, S_MOUTH, I_NORMAL, SPEED_SLOW)
#		affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
#		affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
#		subInfo.addArousalForeplay(0.05)
#		domInfo.addArousalForeplay(0.05)
		
		if(!noticedSore && getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			noticedSore = true
			if(isTentaclesSex()):
				text += RNG.pick([
					" Соски {sub.Your} стали казаться [b]чувствительными и болезненными[/b] после всех попыток сцеживания.",
				])
			else:
				text += RNG.pick([
					" Соски {sub.Your} стали [b]болезненными[/b] после {dom.yourHis} попыток.",
				])
		
		sendSexEvent(SexEvent.BreastFeeding, DOM_0, SUB_0, {madeLactate=suddenlyLactating, loadSize=0.0, targetIsDom=false})
		
		addText(text)
		react(SexReaction.DomBreastfeedsOnSub, [10, 30])
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
		var howMuchCollected = getSub().getBodypart(BodypartSlot.Breasts).getFluids().transferTo(getDom().getBodypart(BodypartSlot.Head), minRatio, minAmount)
		var howMuchCollectedStr = str(Util.roundF(howMuchCollected, 1))+" ml"
		
		if(howMuchCollected > 0.0):
			for fluidID in fluidByAmount:
				var share:float = fluidByAmount[fluidID] / totalAmount
				
				var swallowData:Dictionary = getDom().doSwallow(fluidID, share*howMuchCollected*10.0)
				if(swallowData.has("text") && swallowData["text"] != ""):
					extraMessages.append(swallowData["text"])
		
		var text:String
		if(isTentaclesSex()):
			text = RNG.pick([
				"Щупальца доят грудь {sub.your}, их всасывающие кончики вытягивают и поглощают "+howMuchCollectedStr+" of {sub.yourHis} {sub.milk}.",
				"Щупальца стимулируют молочные соски {sub.your} пульсирующим ритмом, собирая "+howMuchCollectedStr+" of {sub.milk}.",
				"Щупальца питаются упругими сосками {sub.your}, разминая и доя их, собирая "+howMuchCollectedStr+" {sub.milk} в процессе.",
			])
		else:
			text = RNG.pick([
				"{dom.You} активно {dom.youVerb('feed')} в {sub.your} подтекающие соски, поглощая "+howMuchCollectedStr+".",
				"{dom.You} {dom.youVerb('suckle')} в {sub.your} соски, ощущая вкус {sub.milk} на {dom.yourHis} языке, поглощая "+howMuchCollectedStr+" этого.",
				"{dom.You} {dom.youVerb('breastfeed')} on {sub.your} {sub.breasts}, consuming "+howMuchCollectedStr+".",
			])
		if(extraMessages.size() > 0):
			text += " "+Util.join(extraMessages)
		text += getExtraSubText(true)
		
		if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			getSubInfo().addPain(1)
			sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=1,isDefense=false,intentional=false})
		
#		affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
#		affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
#		subInfo.addArousalForeplay(0.1)
#		domInfo.addArousalForeplay(0.1)
#		subInfo.stimulateArousalZone(0.1, BodypartSlot.Breasts, 1.0)
		stimulateBreasts(DOM_0, SUB_0, S_MOUTH, I_NORMAL, SPEED_SLOW)
		
		if(gropeAmount > 20 && RNG.chance(2) && !getSub().hasPerk(Perk.MilkNoSoreNipples) && !getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			if(getSub().addEffect(StatusEffect.SoreNipplesAfterMilking)):
				text += RNG.pick([
					" {sub.Your} соски начали казаться [b]болезненными[/b] после такого долгого кормления.",
				])
		
		sendSexEvent(SexEvent.BreastFeeding, DOM_0, SUB_0, {madeLactate=false, loadSize=howMuchCollected, targetIsDom=false})
		
		addText(text)
		react(SexReaction.DomBreastfeedsOnSub, [10, 30])
	
func getActions(_indx:int):
	if(_indx == DOM_0):
		if(getState() == ""):
			if(hasBodypartUncovered(SUB_0, BodypartSlot.Breasts)):
				addAction("startfeed", 1.0, "Начать кормить", "Начни сосать их!")
		
		if(getState() == "feeding"):
			addAction("knead", (0.5 / float(Util.maxi(1, kneadBonus+1))), "Разминать грудь", "Разминай их грудь, чтобы усилить приток молока")
		
		var breasts:BodypartBreasts = getSub().getBodypart(BodypartSlot.Breasts)
		var stopScore:float = 1.0
		if(breasts):
			var milkProduciton:FluidProduction = breasts.getFluidProduction()
			stopScore = (0.35 if ((gropeAmount > 5 && milkProduciton.getFluidAmount() < 5.0) || gropeAmount > 20) else 0.0)
			
		addAction("stop", stopScore, "Прекратить кормление", "Хватит кормить")
	
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Сопротивляться кормлению", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)})
		
		if(getState() == "feeding"):
			var moanScore:float = max(0.1, fetish(SUB_0, Fetish.Lactation)*0.5 + personality(SUB_0, PersonalityStat.Subby)*0.5)
			addAction("moan", moanScore, "Стон", "Покажи, как тебе это нравится")
		
		if(isReadyToCumHandled(SUB_0)):
			addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})
		
func doAction(_indx:int, _actionID:String, _action:Dictionary):
	if(_actionID == "knead"):
		if(getSub().canBeMilked()):
			kneadBonus += 2
			if(isTentaclesSex()):
				addTextPick([
					"Щупальца обвивают {sub.yourHis} {sub.breasts} и разминают их, стараясь усилить приток {sub.milk}.",
					"Щупальца ласкают и массируют {sub.yourHis} {sub.breasts}.",
					"Щупальца разминают {sub.yourHis} {sub.breasts}, одновременно выкачивая из них жидкость.",
					"Щупальца разминают {sub.yourHis} {sub.breasts}.",
				])
			else:
				addTextPick([
					"{dom.You} {dom.youVerb('knead')} {sub.yourHis} {sub.breasts}, и приток {sub.milk} усиливается!",
					"{dom.You} {dom.youVerb('knead')} {sub.yourHis} {sub.breasts} прямо во время кормления.",
					"{dom.You} {dom.youVerb('knead')} {sub.yourHis} {sub.breasts}.",
					"{dom.You} {dom.youVerb('massage')} {sub.yourHis} {sub.breasts}.",
				])
				
			if(RNG.chance(10) && getSub().isLactating() && !getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				var breasts:BodypartBreasts = getSub().getBodypart(BodypartSlot.Breasts)
				var milkProduciton:FluidProduction = breasts.getFluidProduction()
				if(milkProduciton != null):
					milkProduciton.fillPercent(RNG.randf_rangeX2(0.05, 0.5))
					addTextPick([
						"От стимуляции грудь становится тяжелее.",
						"Из-за стимуляции груди в ней вырабатывается всё больше {sub.milk}.",
						"Грудь {sub.YourHis} вырабатывает всё больше {sub.milk}.",
					])
			if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				getSubInfo().addPain(3)
				sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=3,isDefense=false,intentional=false})
			
			stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_NORMAL)
			#subInfo.stimulateArousalZone(0.2, BodypartSlot.Breasts, 1.0)
			#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.1, -0.01)
			#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.1, -0.03)
		else:
			if(isTentaclesSex()):
				addTextPick([
					"Щупальца обвивают {sub.yourHis} {sub.breasts} и разминают их, усиливая стимуляцию.",
					"Дополнительные щупальца подключаются, чтобы массировать {sub.yourHis} {sub.breasts}, стимулируя их.",
					"Щупальца разминают {sub.yourHis} {sub.breasts}, время от времени сильно сжимая их.",
				])
			else:
				addTextPick([
					"{dom.You} {dom.youVerb('knead')} {sub.yourHis} {sub.breasts}, стимулируя их.",
					"{dom.You} {dom.youVerb('massage')} {sub.yourHis} {sub.breasts}, стимулируя их.",
					"{dom.You} {dom.youVerb('knead')} {sub.yourHis} {sub.breasts} с помощью {dom.yourHis} рук.",
				])
			stimulateBreasts(DOM_0, SUB_0, S_HANDS, I_NORMAL)
			#subInfo.stimulateArousalZone(0.2, BodypartSlot.Breasts, 1.0)
			#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
			#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
			
			if(getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				getSubInfo().addPain(3)
				sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=3,isDefense=false,intentional=false})
			
			if(RNG.chance(70) && getSub().stimulateLactation()):
				addTextPick([
					"У {sub.You} внезапно началась [b]лактация[/b]!",
					"Грудь {sub.Your} внезапно начала [b]лактировать[/b]!",
					"Грудь {sub.Your} внезапно начала [b]вырабатывать {sub.milk}[/b]!",
				])
	if(_actionID == "startfeed"):
		setState("feeding")
		if(isTentaclesSex()):
			addText("Щупальца начинают жадно сосать {sub.your} {sub.breasts}!")
		else:
			addText("{dom.You} начал(а) активно сосать {sub.your} {sub.breasts}!")
		
		stimulateBreasts(DOM_0, SUB_0, S_MOUTH, I_TEASE)
		#affectSub(subInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.1, -0.01)
		#affectDom(domInfo.fetishScore({Fetish.Lactation: 1.0}), 0.02, -0.03)
		#subInfo.addArousalForeplay(0.05)
		#domInfo.addArousalForeplay(0.05)
	if(_actionID == "stop"):
		satisfyGoals()
		endActivity()
		addText("{dom.You} {dom.youVerb('quit')} сосет(ет) грудь {sub.yourHis}.")

	if(_actionID == "cum"):
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		
		var extraText:String = ""
		if(getSub().isLactating()):
			extraText = ", {sub.yourHis} {sub.breasts} squirt {sub.milk} out from this nipple orgasm"
		
		getSubInfo().stimulateArousalZone(0.0, BodypartSlot.Breasts, 2.0)
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="breasts"})
		addGenericOrgasmText(SUB_0, extraText)
	if(_actionID == "pullaway"):
		var successChance:float = getResistChance(SUB_0, DOM_0, RESIST_BREASTS_FOCUS, 30.0, 25.0)
		if(RNG.chance(successChance)):
			if(isTentaclesSex()):
				addText("{sub.You} {sub.youVerb('pull')} от голодных щупалец.")
			else:
				addText("{sub.You} {sub.youVerb('pull')} от губ {dom.your}.")
			getDomInfo().addAnger(0.3)
			if(getState() != ""):
				setState("")
			else:
				failGoals()
				endActivity()
		else:
			if(isTentaclesSex()):
				addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от щупалец, но {sub.youVerb('fail')}.")
			else:
				addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			reactSub(SexReaction.ActivelyResisting, [50])
	if(_actionID == "moan"):
		var moanText = RNG.pick([
			"{sub.youVerb('moan')}"
		])
		if(getSub().isGagged()):
			moanText = RNG.pick([
				"{sub.youVerb('let')} издает приглушенные стоны",
				"{sub.youVerb('let')} издает приглушенный стон",
				"{sub.youVerb('let')} издает приглушенный звук удовольствия",
			])
		
		if(isTentaclesSex()):
			addTextPick([
				"{sub.You} "+moanText+" пока щупальца доят её грудь!",
				"{sub.You} "+moanText+" пока щупальца сосут {sub.yourHis} соски!",
				"{sub.You} "+moanText+" с жадностью!",
			])
		else:
			addTextPick([
				"{sub.You} "+moanText+" кормя {dom.you} грудью!",
				"{sub.You} "+moanText+" пока её {sub.yourHis} соски сосут!",
				"{sub.You} "+moanText+" с жадностью!",
			])
		moan(SUB_0)
#		getDomInfo().addAnger(-0.02)
#		getDomInfo().addLust(5)
#		getSubInfo().addArousalForeplay(0.02)

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 3
	return -1

func getAnimationPriority():
	return 1

func getAnimation():
	if(isTentaclesSex()):
		if(state in [""]):
			return [StageScene.TentaclesCuddle, "breaststease", {pc=SUB_0}]
		return [StageScene.TentaclesCuddle, "breasts", {pc=SUB_0}]
	
	if(state in [""]):
		return [StageScene.BreastFeeding, "tease", {npc=DOM_0, pc=SUB_0}]
	return [StageScene.BreastFeeding, "feed", {npc=DOM_0, pc=SUB_0}]
	
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
