extends SexActivityBase

var boredTimer:int = 0

func _init():
	id = "DomRimSub"
	
	activityName = "Римская субмиссивность"
	activityDesc = "Полизать им задницу!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.RimSub: 1.0,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!(_subInfo.getChar().hasReachableAnus())):
		return false
	if(!(!_domInfo.getChar().isOralBlocked())):
		return false
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.PreventsSubTeasing, SexActivityTag.HavingSex, SexActivityTag.AnusUsed]
	return []

func getCheckTagsSub() -> Array:
	return [SexActivityTag.HavingSex, SexActivityTag.AnusUsed]

func startActivity(_args):
	addTextPick([
		"{dom.You} {dom.youVerb('kneel')} сзади, прижимаясь к {sub.you} и {dom.youVerb('spread')}, лаская {sub.yourHis} ягодицы.",
		"{dom.You} {dom.youVerb('kneel')} сзади, прижимаясь к {sub.you} и {dom.youVerb('prepare')}, чтобы заняться риммингом {sub.yourHis} задницы."
	])
	affectSub(getSubInfo().fetishScore({Fetish.RimmingReceiving: 1.0})+0.0, 0.1, 0.2, 0.0)
	react(SexReaction.AboutToRimSub)

func rimming_processTurn():
	#affectDom(getDomInfo().fetishScore({Fetish.RimmingGiving: 0.5})+0.1, 0.1, 0.0)
	#affectSub(getSubInfo().fetishScore({Fetish.RimmingReceiving: 1.0})+0.2, 0.1, -0.1, -0.01)
	#getSubInfo().stimulateArousalZone(0.05, BodypartSlot.Anus, 0.5)
	stimulateLick(DOM_0, SUB_0, S_ANUS, I_NORMAL)
	addTextPick([
		"{dom.You} {dom.youVerb('use')} {dom.yourHis} языком, слизывая влагу с {sub.yourHis} самого интимного места, чередуя дразнящие лизания с возбуждающими поцелуями.",
		"{dom.Your} языком ласкает {sub.yourHis} "+str(getRandomAnusWord())+", создавая размеренный ритм наслаждения.",
		"{dom.You} {dom.youVerb('rim')} {sub.yourHis} "+str(getRandomAnusWord())+".",
		"{dom.You} {dom.youVerb('lick')} и {dom.youVerb('lap')} в {sub.your} "+str(getRandomAnusWord())+", стараясь доставить максимально глубокие и приятные ощущения."
	])
	boredTimer += 1
	if(boredTimer > 10 && RNG.chance(20) && !getSubInfo().isCloseToCumming()):
		satisfyGoals()
	return

func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state in ["", "rimming"]):
			addAction("stop", getStopScore(), "Прекратить римминг", "Прекратить римминг")
		if(state in [""]):
			if(hasBodypartUncovered(SUB_0, BodypartSlot.Anus)):
				addAction("startRim", 1.0, "Начать римминг", "Попытаться начать римминг")
		if(state in ["rimming"]):
			addAction("prod", 0.2, "Тыкать", "Попытаться просунуть язык поглубже")
		if(state in ["rimming"]):
			if(isReadyToCumHandled(SUB_0) && !getSubInfo().canDoActions()):
				addAction("subcum", 1.0, "Оргазм подчиненной", "Подчиненная кончает!", {A_PRIORITY: 1001})
		if(state in ["rimming"]):
			if((!getDom().isBitingBlocked())):
				addAction("bite", getDomInfo().getSadisticActionStore(), "Укус", "Мягко прикусить анус")
		if(state in ["rimming"]):
			if((getDom().hasEffect(StatusEffect.HasCumInsideMouth)) && (getSub().getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null) && (!getDom().isOralBlocked()) && (OPTIONS.isContentEnabled(ContentType.CumStealing))):
				addAction("spitcum", 0.05 + fetish(DOM_0, Fetish.Breeding)*0.05, "Сплюнуть в анус", "Заставить часть спермы затечь в задницу")

	if(_indx == SUB_0):
		if(state in ["", "rimming"]):
			addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0)})
		if(state in ["rimming"]):
			addAction("moan", getSubInfo().getComplyScore()/3.0, "Стон", "Покажи, как тебе это нравится")
		if(state in ["rimming"]):
			if(isReadyToCumHandled(SUB_0)):
				addAction("cum", 1.0, "Кончай!", "Ты вот-вот кончишь, и с этим уже ничего не поделаешь", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stop"):
		addText("{dom.You} {dom.youVerb('quit')} rimming {sub.you}.")
		endActivity()
		return
	if(_id == "startRim"):
		state = "rimming"
		affectSub(getSubInfo().fetishScore({Fetish.RimmingReceiving: 1.0})+0.0, 0.1, -0.3, -0.01)
		addTextPick([
			"Язык {dom.Your} прокладывает дерзкий путь, дразняще очерчивая края {sub.your} "+str(getRandomAnusWord())+" прежде чем начать жадно лизать.",
			"{dom.You} {dom.youVerb('start')} лижет {sub.your} "+str(getRandomAnusWord())+" eagerly."
		])
		boredTimer = 0
		return
	if(_id == "prod"):
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('thrust')} засовывает {dom.yourHis} язык глубже в {sub.yourHis} "+str(getRandomAnusWord())+".",
			"{dom.You} {dom.youVerb('use')} использует {dom.yourHis} язык, чтобы проникнуть в {sub.yourHis} "+str(getRandomAnusWord())+"."
		])
		if(getSub().hasPenis() && RNG.chance(50)):
			text += RNG.pick([
				" Язык так мастерски массирует простату {sub.yourHis}!",
				" Язык {dom.YourHis} достает до простаты {sub.yourHis} и тычется в нее!",
				" Язык {dom.YourHis} стимулирует простату {sub.yourHis}!"
			])
			getSubInfo().stimulateArousalZone(0.15, BodypartSlot.Anus, 0.5)
		else:
			getSubInfo().stimulateArousalZone(0.1, BodypartSlot.Anus, 0.5)
		if(getSub().hasVagina() && RNG.chance(20)):
			text += RNG.pick([
				" {dom.YourHis} удается массировать точку G {sub.yourHis} через внутреннюю стенку!",
				" Киска {sub.YourHis} становится всё мокрее от стимуляции через внутреннюю стенку!"
			])
		if(getSub().hasEffect(StatusEffect.HasCumInsideAnus) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			if(RNG.chance(20)):
				if(getSub().bodypartTransferFluidsTo(BodypartSlot.Anus, getDomID(), BodypartSlot.Head, 0.1, 20.0)):
					text += RNG.pick([ 
						" "+Util.capitalizeFirstLetter(getSub().getBodypartContentsStringList(BodypartSlot.Anus))+" приземляется на язык {dom.yourHis}, вытекая из {sub.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["ass", "anus", "tailhole"])+" и [b]{dom.you} {dom.youVerb('swallow')} его[/b].",
					])
		addText(text)
		return
	if(_id == "subcum"):
		satisfyGoals()
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		state = ""
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="rim"})
		addGenericOrgasmText(SUB_0)
		return
	if(_id == "bite"):
		addTextPick([
			"{dom.You} {dom.youVerb('nibble')} on {sub.your} "+str(getRandomAnusWord())+".",
			"{dom.You} softly {dom.youVerb('bite')} {sub.your} "+str(getRandomAnusWord())+".",
			"{dom.You} softly {dom.youVerb('bite')} {sub.your} "+str(getRandomAnusWord())+", вызывая дрожь по всему позвоночнику {sub.yourHis}."
		])
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0, Fetish.RimmingReceiving: 0.5})+0.0, 0.1, -0.1, -0.05)
		getSubInfo().addPain(2)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=2,isDefense=false,intentional=true})
		return
	if(_id == "spitcum"):
		var mixtureText = getDom().getBodypartContentsStringList(BodypartSlot.Head)
		addText("{dom.You} {dom.youVerb('press', 'presses')} {dom.yourHis} губы прижаты к {sub.yourHis} "+str(getRandomAnusWord())+" and [b]{dom.youVerb('spit')} "+mixtureText+" в деле[/b]!")
		var howMuch:float = getDom().bodypartTransferFluidsToAmount(BodypartSlot.Head, getSubID(), BodypartSlot.Anus, 0.2, 20.0)
		affectSub(getSubInfo().fetishScore({Fetish.BeingBred: 1.0})-0.1, 0.02, -0.1, -0.05)
		sendSexEvent(SexEvent.HoleSpitted, DOM_0, SUB_0, {hole=BodypartSlot.Anus, loadSize=howMuch})
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
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь отстраниться от лица {dom.your}.",
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь убрать свою задницу {sub.yourHis} от рта {dom.your}.",
			])
			getDomInfo().addAnger(0.03)
		reactSub(SexReaction.Resisting, [50])
		return
	if(_id == "moan"):
		var text:String = RNG.pick([
			"{sub.You} "+RNG.pick(["{sub.youVerb('let')} стонет", "{sub.youVerb('moan')}", "{sub.youVerb('produce')} стон", "{sub.youVerb('make')} звук удовольствия"])+" while ",
		])
		if(getSub().isGagged()):
			text = RNG.pick([
				"{sub.You} "+RNG.pick(["{sub.youVerb('let')} издает приглушенный стон", "{sub.youVerb('try', 'tries')} застонать", "{sub.youVerb('produce')} приглушенный стон", "{sub.youVerb('make')} приглушенный звук удовольствия"])+" while ",
			])
		text += RNG.pick([
			"язык {dom.your} лижет {sub.yourHis} "+getRandomAnusWord()+"!",
		])
		addText(text)
		moan(SUB_0)
		return
	if(_id == "cum"):
		satisfyGoals()
		state = ""
		cumGeneric(SUB_0, DOM_0, UniqueOrgasm.Rim)
		fetishAffect(SUB_0, Fetish.RimmingReceiving, 3.0)
		fetishAffect(DOM_0, Fetish.RimmingGiving, 3.0)
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
	if(getSexType() == SexType.SlutwallSex):
		theChance *= 0.5
	
	return max(theChance, 5.0)
	
func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 10
	return -1
		
func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.SlutwallSex: true,
	}

func saveData():
	var data = .saveData()

	data["boredTimer"] = boredTimer

	return data

func loadData(_data):
	.loadData(_data)

	boredTimer = SAVE.loadVar(_data, "boredTimer", 0)

func getAnimation():
	if(state == ""):
		if(getSexType() == SexType.SlutwallSex):
			return [StageScene.SlutwallSexOral, "tease", {pc=SUB_0, npc=DOM_0}]
		return [StageScene.SexRimming, "tease", {pc=SUB_0, npc=DOM_0}]
	if(state == "rimming"):
		if(getSexType() == SexType.SlutwallSex):
			return [StageScene.SlutwallSexOral, "lick", {pc=SUB_0, npc=DOM_0}]
		if(getSubInfo().isCloseToCumming()):
			return [StageScene.SexRimming, "fast", {pc=SUB_0, npc=DOM_0}]
		return [StageScene.SexRimming, "sex", {pc=SUB_0, npc=DOM_0}]
