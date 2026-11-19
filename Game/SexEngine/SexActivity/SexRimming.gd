extends SexActivityBase

var boredTimer:int = 0
var waitTimer:int = 0

func _init():
	id = "SexRimming"
	
	activityName = "Римминг"
	activityDesc = "Заставь их сосать твою задницу!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.RimmingReceive: 1.0,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!(_domInfo.getChar().hasReachableAnus())):
		return false
	if(!(!_subInfo.getChar().isOralBlocked())):
		return false
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.AnusUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing]
	return []

func getCheckTagsSub() -> Array:
	return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex]

func startActivity(_args):
	affectSub(getSubInfo().fetishScore({Fetish.RimmingGiving: 1.0})+0.0, 0.1, -0.1, -0.01)
	addText("{dom.You} {dom.youVerb('force')} {sub.you} на {sub.yourHis} коленях и {dom.youVerb('position')} {dom.yourself} перед {sub.youHim}, приглашая начать лизать {dom.yourHis} задницу.")
	react(SexReaction.OrderRimming)
	return

func init_processTurn():
	if(hasBodypartUncovered(DOM_0, BodypartSlot.Anus)):
		waitTimer += 1
	
	if(waitTimer > 2):
		getDomInfo().addAnger(0.05)
		addText("{dom.You} {dom.youVerb('lose')} {dom.yourHis} patience.")

func rimming_processTurn():
	#affectDom(getDomInfo().fetishScore({Fetish.RimmingReceiving: 1.0})+0.3, 0.1, 0.0)
	#affectSub(getSubInfo().fetishScore({Fetish.RimmingGiving: 1.0})+0.0, 0.1, -0.1, -0.01)
	
	addTextPick([
		"{sub.You} {sub.youVerb('rim')} {dom.yourHis} "+str(getRandomAnusWord())+".",
		"{sub.You} {sub.youVerb('drag')} {sub.yourHis} языком по {dom.yourHis} "+str(getRandomAnusWord())+" круговыми движениями.",
		"{sub.You} {sub.youVerb('lick')} {dom.yourHis} "+str(getRandomAnusWord())+".",
		"{sub.You} {sub.youVerb('prod')} {dom.yourHis} "+str(getRandomAnusWord())+" языком {sub.yourHis}."
	])
	boredTimer += 1
	if(boredTimer > 10 && RNG.chance(20) && !getDomInfo().isCloseToCumming()):
		satisfyGoals()
	if(getDom().hasPenis() && RNG.chance(50)):
		addTextPick([
			"Язык так хорошо массирует простату {dom.yourHis}!",
			"Язык {sub.YourHis} достает до простаты {dom.yourHis} и тычет в нее!",
			"Язык {sub.YourHis} стимулирует простату {dom.yourHis}!"
		])
	#	getDomInfo().stimulateArousalZone(0.1, BodypartSlot.Anus, 1.0)
	#else:
	#	getDomInfo().stimulateArousalZone(0.05, BodypartSlot.Anus, 1.0)
	stimulateLick(SUB_0, DOM_0, S_ANUS, I_NORMAL)
	
	if(getDom().hasVagina() && RNG.chance(20)):
		addTextPick([
			"Языку {sub.YourHis} удается массировать точку G {dom.yourHis} через переднюю стенку!",
			"Киска {dom.YourHis} становится всё мокрее от стимуляции через стенку!"
		])
	if(getDom().hasEffect(StatusEffect.HasCumInsideAnus) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
		if(RNG.chance(20)):
			if(getDom().bodypartTransferFluidsTo(BodypartSlot.Anus, getSubID(), BodypartSlot.Head, 0.1, 20.0)):
				addText(Util.capitalizeFirstLetter(getDom().getBodypartContentsStringList(BodypartSlot.Anus))+" ложится на {sub.yourHis} язык, вытекая из {dom.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["ass", "anus", "tailhole"])+" и [b]{sub.you} {sub.youVerb('swallow')} [/b].")

func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state in ["", "rimming"]):
			addAction("stop", getStopScore(), "Стой", "Хватит давать им лизать себя")
		if(state in [""]):
			if((getDom().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null)):
				addAction("forcerim", getDomInfo().getAngerScore(), "Заставить лизать", "Заставить их лизать твою задницу", {A_CHANCE: 30})
		if(state in ["rimming"]):
			addAction("moan", 0.5, "Стон", "Показать, как тебе это нравится")
		if(state in ["rimming"]):
			if(isReadyToCumHandled(DOM_0)):
				addAction("cum", 1.0, "Кончай!", "Ты вот-вот кончишь, и с этим уже ничего не поделаешь", {A_PRIORITY: 1001})

	if(_indx == SUB_0):
		if(state in ["", "rimming"]):
			addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0)})
		if(state in [""]):
			if((getDom().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null)):
				var startrimScore:float = getSubInfo().getComplyScore() * fetish(SUB_0, Fetish.RimmingGiving)
				addAction("startrim", startrimScore, "Начать римминг", "Начать лизать их задницу")
		if(state in ["", "rimming"]):
			if((!getSub().isBitingBlocked())):
				addAction("bite", getResistScore(SUB_0) / 4.0, "Кусь!", "Укуси их за задницу!", {A_CHANCE: getSubResistChance(60.0, 45.0)})
		if(state in ["rimming"]):
			var prodScore:float = getSubInfo().getComplyScore() * fetish(SUB_0, Fetish.RimmingGiving)
			addAction("prod", prodScore, "Тыкать", "Попытаться просунуть язык поглубже")

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stop"):
		addText("{dom.You} {dom.youVerb('stop')} заставляет {sub.you} лизать {dom.youHim}.")
		endActivity()
		return
	if(_id == "forcerim"):
		if(RNG.chance(30)):
			addText("{dom.You} {dom.youVerb('force')} заставляет {sub.you} начать лизать {dom.youHim}!")
			state = "rimming"
		else:
			getDomInfo().addAnger(0.05)
			addText("{dom.You} {dom.youVerb('try', 'tries')}, чтобы {sub.you} отлизала {dom.youHim}.")
		affectSub(getSubInfo().fetishScore({Fetish.RimmingGiving: 1.0})+0.0, 0.05, -0.1, -0.01)
		return
	if(_id == "moan"):
		var text:String = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('let')} издать стон", "{dom.youVerb('moan')}", "{dom.youVerb('produce')} стонать", "{dom.youVerb('make')} издать звук удовольствия"])+" while ",
		])
		if(getDom().isGagged()):
			text = RNG.pick([
				"{dom.You} "+RNG.pick(["{dom.youVerb('let')} издает приглушенный стон", "{dom.youVerb('try', 'tries')} застонать", "{dom.youVerb('produce')} приглушенный стон", "{dom.youVerb('make')} приглушенный звук удовольствия"])+" while ",
			])
		text += RNG.pick([
			"{sub.your} языком лижет {dom.yourHis} "+getRandomAnusWord()+"!",
		])
		addText(text)
		moan(DOM_0)
		return
	if(_id == "cum"):
		satisfyGoals()
		getDom().cumOnFloor()
		getDomInfo().cum()
		state = ""
		sendSexEvent(SexEvent.UniqueOrgasm, SUB_0, DOM_0, {orgasmType=UniqueOrgasm.Rim})
		addGenericOrgasmText(DOM_0)
		fetishAffect(DOM_0, Fetish.RimmingReceiving, 3.0)
		fetishAffect(SUB_0, Fetish.RimmingGiving, 3.0)
		return

	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getSubResistChance(30.0, 25.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('pull')} от {dom.you}.")
			getDomInfo().addAnger(0.3)
			if(state != ""):
				state = ""
			else:
				endActivity()
		else:
			addTextPick([
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь отстраниться от задницы {dom.your}.",
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь отстраниться от жопы {dom.your}.",
			])
			getDomInfo().addAnger(0.03)
		reactSub(SexReaction.Resisting, [50])
		return
	if(_id == "startrim"):
		state = "rimming"
		affectDom(getDomInfo().fetishScore({Fetish.RimmingReceiving: 1.0})+0.0, 0.1, -0.1)
		affectSub(getSubInfo().fetishScore({Fetish.RimmingGiving: 1.0})+0.0, 0.1, -0.05, -0.01)
		addTextPick([
			"{sub.You} {sub.youVerb('begin')} с нетерпением облизать {dom.yourHis} "+str(getRandomAnusWord())+".",
			"{sub.You} {sub.youVerb('lean')} ближе и {sub.youVerb('begin')}, чтобы лизнуть {dom.yourHis} "+str(getRandomAnusWord())+".",
			"{sub.You} {sub.youVerb('begin')} с готовностью облизать {dom.yourHis} "+str(getRandomAnusWord())+"."
		])
		return
	if(_id == "prod"):
		getDomInfo().stimulateArousalZone(0.04, BodypartSlot.Anus, 0.25)
		getDomInfo().addAnger(-0.03)
		addTextPick([
			"{sub.You} охотно {sub.youVerb('thrust')} {sub.yourHis}, просовывая язык глубже в {dom.yourHis} "+str(getRandomAnusWord())+".",
			"{sub.You} охотно {sub.youVerb('slide')} {sub.yourHis}, просовывая язык за {dom.yourHis} анальное кольцо и {sub.youVerb('lap')} внутренние стенки.",
			"{sub.You} eagerly {sub.youVerb('eat')} {dom.yourHis} "+str(getRandomAnusWord())+" out."
		])
		return
	if(_id == "bite"):
		if(getSubResistChance(60.0, 45.0)):
			addText("{sub.You} {sub.youVerb('bite')} {dom.your} задницей! {dom.YouHe} {dom.youHeVerb('grunt')} от боли и {dom.youHeVerb('pull')} прочь.")
			getDomInfo().addPain(5)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=10,isDefense=true,intentional=true})
			getDomInfo().addAnger(1.0 - getDomInfo().fetishScore({Fetish.Masochism: 0.5}))
			getDomInfo().addLust(-5 + 10 * getDomInfo().fetishScore({Fetish.Masochism: 1.0}))
			if(state == ""):
				endActivity()
			state = ""
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')} пытается укусить {dom.you}, но {dom.youHe} {dom.youHeVerb('avoid')} это!")
			getDomInfo().addAnger(0.4)
		return

func getRandomAnusWord() -> String:
	return RNG.pick(["задний вход", "anus", "tailhole"])
	
func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.5
	if(getSub().hasBoundArms()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	
	return max(theChance, 5.0)
	
func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == DOM_0):
		return 10
	return -1

func saveData():
	var data = .saveData()

	data["boredTimer"] = boredTimer
	data["waitTimer"] = waitTimer

	return data

func loadData(_data):
	.loadData(_data)

	boredTimer = SAVE.loadVar(_data, "boredTimer", 0)
	waitTimer = SAVE.loadVar(_data, "waitTimer", 0)

func getAnimation():
	if(state == ""):
		return [StageScene.SexRimming, "tease", {pc=DOM_0, npc=SUB_0}]
	if(state == "rimming"):
		if(getDomInfo().isCloseToCumming()):
			return [StageScene.SexRimming, "fast", {pc=DOM_0, npc=SUB_0}]
		return [StageScene.SexRimming, "sex", {pc=DOM_0, npc=SUB_0}]
