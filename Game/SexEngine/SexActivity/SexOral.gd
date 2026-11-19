extends SexActivityBase
var waitTimer:int = 0
var straponHumps:int = 0
var isForce:bool = false
var isFacesit:bool = false

func _init():
	id = "SexOral"
	
	activityName = "Оральный секс"
	activityDesc = "Трахни им в рот!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.FuckOral: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.StocksSex: true,
		SexType.BitchsuitSex: true,
	}

func isStocksSex() -> bool:
	return getSexEngine().getSexTypeID() == SexType.StocksSex

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_domInfo.getChar().hasReachablePenis() && !_domInfo.getChar().hasReachableVagina() && !_domInfo.getChar().isWearingStrapon()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.PenisUsed, SexActivityTag.VaginaUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		var thetags:Array = [SexActivityTag.PreventsSubViolence, SexActivityTag.PreventsSubTeasing, SexActivityTag.HavingSex]
		if(state in ["blowjob", "deepthroat", "licking", "grinding"]):
			thetags.append(SexActivityTag.MouthUsed)
		return thetags
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.PenisUsed, SexActivityTag.VaginaUsed, SexActivityTag.HavingSex]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.MouthUsed, SexActivityTag.HavingSex]

func isStraponSex() -> bool:
	return getDom().isWearingStrapon()

func domSensitivity():
	var strapon = getDom().getWornStrapon()
	if(strapon == null):
		return 1.0
	
	return strapon.getStraponPleasureForDom()

func getDickName(dickName = null) -> String:
	if(isStraponSex()):
		return "strapon"
	if(dickName == null):
		return RNG.pick(["cock", "dick", "member"])
	return dickName

func startActivity(_args):
	var exposedThings:Array = []
	var genitalsText = "crotch"
	if(getDom().hasPenis() && hasBodypartUncovered(DOM_0, BodypartSlot.Penis)):
		exposedThings.append(RNG.pick(["dick", "cock", "member"]))
		if(RNG.chance(50)):
			exposedThings.append("balls")
	if(isStraponSex()):
		exposedThings.append(getDickName())
	if(getDom().hasVagina() && hasBodypartUncovered(DOM_0, BodypartSlot.Vagina)):
		exposedThings.append(RNG.pick(["pussy", "pussy", "slit", "kitty"]))
	if(exposedThings.size() > 0):
		genitalsText = "exposed "+Util.humanReadableList(exposedThings)
	
	if(!isStocksSex()):
		addText("{dom.You} {dom.youVerb('make')} {sub.you} встанет на колени, а затем "+RNG.pick(["{dom.youVerb('pull')}", "{dom.youVerb('bring')}"])+" {sub.yourHis} рот к {dom.yourHis} "+genitalsText+".")
	else:
		addText("{dom.You} {dom.youVerb('walk')} прямо к {sub.your} лицу, зажатому в колодках, а затем "+RNG.pick(["{dom.youVerb('present')}", "{dom.youVerb('show')}"])+" {dom.yourHis} "+genitalsText+".")

func processTurn():
	if(state in ["askingtosuck", "askingtolick"]):
		if(waitTimer > 2):
			getDomInfo().addAnger(0.3)
			state = ""
			return {text="{dom.You} надоело ждать."}
		elif(waitTimer > 0):
			var text = RNG.pick([
				"{dom.You} {dom.youAre} теряет терпение.",
			])
			getDomInfo().addAnger(0.2)
			waitTimer += 1
			return {text = text}
		waitTimer += 1
		return

	if(state in ["blowjob", "deepthroat"]):
		if(!isForce && getSubInfo().isUnconscious()):
			isForce = true
	if(state == "licking"):
		if(!isForce && getSubInfo().isUnconscious()):
			state = "grinding"
			isForce = true

func blowjob_processTurn():
	if(isStraponSex()):
		straponHumps += 1
		if(getSubInfo().isUnconscious() || (RNG.chance(20) && straponHumps > 5)):
			satisfyGoals()
	
	doBlowjobTurnDom()
		
func deepthroat_processTurn():
	if(isStraponSex()):
		straponHumps += 1
		if(getSubInfo().isUnconscious() || (RNG.chance(20) && straponHumps > 5)):
			satisfyGoals()
	
	doDeepthroatTurnDom()

func licking_processTurn():
	doPussyLickingTurnDom()
	react(SexReaction.DomsPussyGetsLicked, [10.0, 10.0])
	
func grinding_processTurn():
	doPussyGrindingTurnDom()
	react(SexReaction.GrindingFaceWithPussy, [10.0, 10.0])
	
func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state in [""]):
			if(getDom().hasReachablePenis() || isStraponSex()):
				addAction("cocktease", 1.0, "Дразнение членом", "Заставь их дразнить твой член, чтобы ты встал")
				
				if(getDomInfo().isReadyToPenetrate() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null && !getSub().isOralBlocked()):
					if(!getSub().isBitingBlocked()):
						addAction("asktosuck", 1.0 - getDomInfo().getAngerScore(), "Приказ открыть рот", "Прикажи сабке открыть рот, чтобы ты мог вставить туда свой член")
					var forcetosuckScore:float = 0.1 + getDomInfo().getAngerScore() + 0.3*float(getSub().isBitingBlocked())
					addAction("forcetosuck", forcetosuckScore, "Принуждение к минету", "Заставь эту сучку сосать твой член")
			if(getDom().hasReachableVagina()):
				var lustyEnough:float = 1.0
				if(getDom().hasReachablePenis() && !getDomInfo().isReadyToPenetrate()):
					lustyEnough = 0.1 # If dom is a herm, give them a chance to force bj too
				
				if(!getSub().isOralBlocked()):
					var asktolickScore:float = lustyEnough*(1.0 - getDomInfo().getAngerScore() - 0.9 * float(getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) != null))
					addAction("asktolick", asktolickScore, "Приказать лизать", "Попросить сабку лизнуть твою киску")
				
				var startgrindfaceScore:float = lustyEnough * (0.1 + getDomInfo().getAngerScore() - 0.9 * float(getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) != null))
				addAction("startgrindface", startgrindfaceScore, "Тереться лицом", "Втираться киской им в лицо")
		if(state in ["blowjob"]):
			var forcedeepthroatScore:float = fetish(DOM_0, Fetish.OralSexReceiving, -0.4) / 6.0
			addAction("forcedeepthroat", forcedeepthroatScore, "Заставить глубоко брать", "Заставить эту шлюху глубоко брать тебя")
		if(state in ["blowjob", "deepthroat"]):
			addEggStuffButton(DOM_0, SUB_0, BodypartSlot.Head)
			addTriggerStraponAction(DOM_0)
			
			if(isReadyToCumHandled(DOM_0) && isStraponSex()):
				addAction("domstraponcum", 1.0, "Кончай!", "Ты сейчас кончишь...", {A_PRIORITY: 1001})
			
			if(isReadyToCumHandled(DOM_0) && !isStraponSex()):
				addAction("bjcuminside", 1.0, "Кончить внутрь", "Заткнуть ей рот", {A_PRIORITY: 1001})
				addAction("bjpullout", 1.0, "Вытащить", "Вместо этого кончить ей прямо на лицо", {A_PRIORITY: 1001})
		if(state in ["deepthroat"]):
			var stopdeepthroatScore:float = getSubInfo().getAboutToPassOutScore() * 0.2 * (1.0 - personality(DOM_0, PersonalityStat.Mean)*0.5 - fetish(DOM_0, Fetish.UnconsciousSex))
			addAction("stopdeepthroat", stopdeepthroatScore, "Прекратить глубокий минет", "На сегодня глубокого минета хватит")
		if(state == "licking"):
			if(!isFacesit && (getSexType() == SexType.DefaultSex)):
				addAction("startFacesit", 0.07-personality(DOM_0, PersonalityStat.Subby)*0.05, "Сесть на лицо!", "Сесть на лицо, пока она тебя вылизывает!")
		if(state in ["licking", "grinding"]):
			if(isReadyToCumHandled(DOM_0)):
				addAction("pussycum", 1.0, "Кончай!", "Кончить прямо на сабку", {A_PRIORITY: 1001})
			
		addAction("stop", getStopScore(), "Прекратить оральный секс", "Прекратить оральный секс")

	if(_indx == SUB_0):
		if(state in ["askingtosuck"]):
			if((isStraponSex() || getDom().hasReachablePenis()) && getDomInfo().isReadyToPenetrate() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
				var openmouthScore:float = getSubInfo().getComplyScore() * fetish(SUB_0, Fetish.OralSexGiving, 0.5)
				addAction("openmouth", openmouthScore, "Открыть рот", "Пусть всё это "+getDickName()+" попадёт тебе в рот")
				addAction("notopenmouth", getResistScore(SUB_0), "Покачать головой", "Ты же не собираешься сосать их "+getDickName())
		if(state in ["askingtolick"]):
			var startlickingScore:float = getSubInfo().getComplyScore() * fetish(SUB_0, Fetish.OralSexGiving, 0.5)
			addAction("startlicking", startlickingScore, "Лизать киску", "Повинуйся приказам и начни вылизывать их")
			addAction("refusetolick", getResistScore(SUB_0), "Отказаться лизать", "Ты же не собираешься лизать их киску")

		if(state in ["", "blowjob", "askingtosuck", "licking", "askingtolick", "grinding"]):
			if(!getSub().isBitingBlocked()):
				addAction("bite", getResistScore(SUB_0)/4.0, "Укус", "Укуси их! Будет очень больно", {A_CHANCE: getSubBiteChance(50.0, 30.0)})
			addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0)})
		if(state in ["licking"]):
			addAction("prodpussy", getComplyScore(SUB_0)/2.0, "Потыкать языком", "Используй язык активнее")
		if(state in ["grinding"]):
			addAction("grindtongue", getComplyScore(SUB_0)/2.0, "Использовать язык", "Используй язык активнее")
		if(state in [""]):
			if(getDom().hasReachablePenis() || isStraponSex()):
				var teasecockScore:float = getComplyScore(SUB_0) * 0.5 + fetish(SUB_0, Fetish.OralSexGiving, 0.5)
				addAction("teasecock", teasecockScore, "Дразнить "+getDickName("cock"), "Показать их "+getDickName()+" немного любви")
			if(getDom().hasReachableVagina()):
				var teasevaginaScore:float = getComplyScore(SUB_0) * 0.5 + fetish(SUB_0, Fetish.OralSexGiving, 0.5)
				addAction("teasevagina", teasevaginaScore, "Дразнить киску", "Уделить внимание их киске")
		if(state in ["blowjob"]):
			var startdeepthroatingScore:float = getComplyScore(SUB_0) * fetish(SUB_0, Fetish.OralSexGiving, -0.5) * 0.1 
			addAction("startdeepthroating", startdeepthroatingScore, "Глубокий минет", "Пусть всё это "+getDickName()+" растянуть твое горло")
		if(state in ["deepthroat"]):
			var stopdeepthroatingScore:float = getComplyScore(SUB_0) * fetish(SUB_0, Fetish.OralSexGiving, -0.5) * 0.1 
			addAction("stopdeepthroating", stopdeepthroatingScore, "Перестать глубоко заглатывать", "Хватит растягивать горло!", {A_CHANCE: getSubStopDeepthroatChance()})


func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stuffegg"):
		doStuffEggInto(DOM_0, SUB_0, BodypartSlot.Head)
		return
	if(_id == "triggerStrapon"):
		triggerStrapon(_indx, SUB_0, BodypartSlot.Head)
		return
	if(_id == "domstraponcum"):
		getDom().cumOnFloor()
		getDomInfo().cum()
		addGenericOrgasmText(DOM_0)
		return
	if(_id == "cocktease"):
		var throughTheClothing:String = getThroughClothingText(DOM_0, BodypartSlot.Penis)
		var text:String = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('pull')}", "{dom.youVerb('bring')}", "{dom.youVerb('move')}"])+" {sub.yourHis} к {dom.yourHis} "+getDickName()+" and {dom.youVerb('make')} {sub.youHim} "+RNG.pick(["rub", "grind"])+" {sub.youHis} прижимается лицом к нему"+throughTheClothing+"."
		])
		if(isStocksSex()):
			text = RNG.pick([
				"{dom.You} "+RNG.pick(["{dom.youVerb('move')}", "{dom.youVerb('bring')}", "{dom.youVerb('move')}"])+" {dom.yourHis} "+getDickName()+" к {sub.yourHis} голове и {dom.youVerb('make')} {sub.youHim} "+RNG.pick(["rub", "grind"])+" {sub.youHis} прижимается лицом к нему"+throughTheClothing+"."
			])
		if(getDomInfo().isAngry()):
			text = RNG.pick([
				text,
				"{dom.You} "+RNG.pick(["{dom.youVerb('cocksmack')}", "{dom.youVerb('cockslap')}", "{dom.youVerb('cockwhip')}"])+" {sub.yourHis} щекой к {dom.yourHis} "+getDickName(RNG.pick(["dick", "member", "prick"]))+".",
			])
		getDomInfo().addLust(10.0 + getDomInfo().fetishScore({Fetish.OralSexReceiving: 5.0}))
		getDomInfo().addArousalForeplay(0.05)
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.3, -0.01)
		
		if(getDomInfo().isReadyToPenetrate() && hasBodypartUncovered(DOM_0, BodypartSlot.Penis) && !isStraponSex()):
			text += RNG.pick([
				" из твердого члена {dom.Your} сочится смазка "+RNG.pick(["pre", "precum", "arousal"])+".",
				" член {dom.Your} — это "+RNG.pick(["ready", "достаточно твердым"])+" что его запихнут в {sub.yourHis} рот.",
			])
		addText(text)
		return
	if(_id == "asktosuck"):
		state = "askingtosuck"
		waitTimer = 0
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.4, 0.0)
		addText("{dom.You} {dom.youVerb('order')} {sub.youHim} to "+RNG.pick(["открыть {sub.yourHis} рот", "раздвинуть {sub.yourHis} губы"])+".")
		react(SexReaction.OrderBlowjob)
		return
	if(_id == "asktolick"):
		state = "askingtolick"
		waitTimer = 0
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.4, 0.0)
		addText("{dom.You} {dom.youVerb('order')} {sub.youHim} to "+RNG.pick(["начать лизать {dom.yourHis} киску", "высунуть {sub.yourHis} язык и приняться за {dom.yourHis} киску"])+".")
		react(SexReaction.OrderLickPussy)
		return
	if(_id == "startgrindface"):
		isForce = true
		state = "grinding"
		var text = RNG.pick([
			"{dom.You} {dom.youVerb('press', 'presses')} {dom.yourHis} "+RNG.pick(["pussy", "slit", "kitty"])+" к {sub.yourHis} лицу и {dom.youVerb('proceed')}, чтобы тереться об него!",
		])
		if(getSub().bodypartHasTrait(BodypartSlot.Horns, PartTrait.HornsGraspable)):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('reach', 'reaches')} за {sub.yourHis} рога и использовать их как руль. ",
			]) + text
		
		stimulateGrindFace(DOM_0, SUB_0, I_LOW)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.3, -0.02)
		getDomInfo().addAnger(-0.05)
		addText(text)
		return
	if(_id == "forcetosuck"):
		var successChance:float = 30
		if(getSub().isBitingBlocked()):
			successChance = 100
		
		if(RNG.chance(successChance)):
			isForce = true
			state = "blowjob"
			stimulateSex(DOM_0, SUB_0, S_MOUTH, I_LOW)
			#affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.2, -0.05)
			getDomInfo().addAnger(-0.1)
			sendSexEvent(SexEvent.HolePenetrated, DOM_0, SUB_0, {hole=BodypartSlot.Head,engulfed=false,strapon=isStraponSex()})
			addText("{dom.You} {dom.youVerb('force')} {dom.yourHis} "+getDickName()+" "+RNG.pick(["сквозь {sub.yourHis} губы", "внутри {sub.yourHis} рта", "сквозь {sub.yourHis} зубы"])+" and {dom.youVerb('make')} {sub.you} "+RNG.pick(["suck", "blow"])+" {dom.youHim}!")
			return
		else:
			stimulateSex(DOM_0, SUB_0, S_MOUTH, I_TEASE)
			#affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.2, -0.01)
			getDomInfo().addAnger(0.05)
			addText("{dom.You} {dom.youVerb('try', 'tries')} to "+RNG.pick(["force", "push", "shove", "сильно впихнуть"])+" {dom.yourHis} "+getDickName()+" "+RNG.pick(["в {sub.yourHis} рот", "сквозь {sub.yourHis} губы", "сквозь {sub.yourHis} зубы"])+".")
			react(SexReaction.TryForceSuckPenis)
			return
	if(_id == "bjcuminside"):
		state = ""
		satisfyGoals()
		doCumBJDom(state == "deepthroat")
		applyTallymarkIfNeeded(BodypartSlot.Head)
		return
	if(_id == "bjpullout"):
		satisfyGoals()
		state = ""
		doCumBJFacialsDom()
		applyTallymarkIfNeeded(BodypartSlot.Head)
		return
	if(_id == "pussycum"):
		satisfyGoals()
		state = ""
		doCumPussyLickDom()
		return 
	if(_id == "forcedeepthroat"):
		if(!RNG.chance(getSub().getPenetrateChanceBy(BodypartSlot.Head, getDomID()))):
			var text:String = RNG.pick([
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы загнать {sub.you} поглубже в {dom.yourHis} "+getDickName()+" но горло {sub.yourHis} слишком узкое.",
				"{dom.You} {dom.youVerb('try', 'tries')}, заставляя {sub.you} глубоко брать {dom.yourHis} "+getDickName()+" но горло {sub.youHe} {sub.youAreHeIs} слишком узкое.",
			])
			if(isStocksSex()):
				text = RNG.pick([
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы пропихнуть {dom.yourHis} "+getDickName()+" поглубже, но горло {sub.yourHis} слишком узкое.",
				"{dom.You} {dom.youVerb('try', 'tries')}, заставляя {sub.you} глубоко брать {dom.yourHis} "+getDickName()+" но горло {sub.youHe} {sub.youAreHeIs} слишком узкое.",
				])
			getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(), true, 0.1)
			stimulateSex(DOM_0, SUB_0, S_MOUTH, I_TEASE)
			#affectSub(getDomInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.1, -0.05)
			#getDomInfo().addLust(0.1)
			#getDomInfo().addArousalSex(0.03)
			addText(text)
			return
		else:
			state = "deepthroat"
			var text:String = RNG.pick([
				"{dom.You} {dom.youVerb('shove')} {dom.yourHis} "+getDickName()+" глубже, и {dom.youVerb('force')} {sub.you}, чтобы {dom.youHim} заглотил всё до конца!",
			])
			if(getSub().bodypartHasTrait(BodypartSlot.Horns, PartTrait.HornsGraspable)):
				text = RNG.pick([
					"{dom.You} {dom.youVerb('reach', 'reaches')} за {sub.yourHis} рога и использовать их как руль. ",
				]) + text
			getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(), true, 0.2)
			stimulateSex(DOM_0, SUB_0, S_MOUTH, I_NORMAL)
			#affectSub(getDomInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.2, -0.05)
			#getDomInfo().addArousalSex(0.05 * domSensitivity())
			addText(text)
			return
	if(_id == "stopdeepthroat"):
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('let')} {sub.you}, чтобы прекратить глубокий минет {dom.yourHis} "+getDickName()+".",
		])
		if(!getSubInfo().isUnconscious() && getSubInfo().getConsciousness() < 1.0):
			text += RNG.pick([
				"{sub.You} {sub.youVerb('cough')} долго лижет, прежде чем снова приняться за сосание.",
			])
		state = "blowjob"
		addText(text)
		return
	if(_id == "stop"):
		endActivity()
		var exposedThings:Array = []
		var genitalsText:String = "crotch"
		if(getDom().hasPenis() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
			exposedThings.append(RNG.pick(["dick", "cock", "member"]))
			if(RNG.chance(50)):
				exposedThings.append("balls")
		if(isStraponSex()):
			exposedThings.append(getDickName())
		if(getDom().hasVagina() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
			exposedThings.append(RNG.pick(["pussy", "pussy", "slit", "kitty"]))
		if(exposedThings.size() > 0):
			genitalsText = "exposed "+Util.humanReadableList(exposedThings)
		
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourHis} "+genitalsText+" от губ {sub.yourHis}.")
		return
	if(_id == "startFacesit"):
		isFacesit = true
		addText("{dom.You} {dom.youVerb('bring')} {sub.you} на пол и {dom.youVerb('sit')} на лицо {sub.yourHis}!")
		return

	if(_id == "teasecock"):
		var throughTheClothing:String = getThroughClothingText(DOM_0, BodypartSlot.Penis)
		
		var text:String = ""
		if(getSub().isOralBlocked()):
			text = RNG.pick([
				"{sub.You} {sub.youVerb('nuzzle')} {dom.your} "+getDickName()+throughTheClothing+".",
			])
		else:
			text = RNG.pick([
				"{sub.You} "+RNG.pick(["{sub.youVerb('nuzzle')}", "{sub.youVerb('lick')}"])+" {dom.your} "+getDickName()+throughTheClothing+".",
			])
		
		stimulate(SUB_0, S_MOUTH, DOM_0, S_PENIS, I_TEASE, Fetish.OralSexGiving)
		#getDomInfo().addLust(10.0 + getDomInfo().fetishScore({Fetish.OralSexReceiving: 5.0}))
		#getDomInfo().addArousalForeplay(0.05*domSensitivity())
		
		if(getDomInfo().isReadyToPenetrate() && hasBodypartUncovered(DOM_0, BodypartSlot.Penis) && !isStraponSex()):
			text += RNG.pick([
				" из твердого члена {dom.Your} сочится смазка "+RNG.pick(["pre", "precum", "arousal"])+".",
				" член {dom.Your} — это "+RNG.pick(["ready", "достаточно твердым"])+" что его запихнут в {sub.yourHis} рот.",
			])
		
		addText(text)
		return
	if(_id == "teasevagina"):
		var throughTheClothing:String = getThroughClothingText(DOM_0, BodypartSlot.Vagina)
		var text:String = ""
		if(getSub().isOralBlocked()):
			text = RNG.pick([
				"{sub.You} {sub.youVerb('nuzzle')} {dom.your} "+RNG.pick(["pussy", "slit", "petals", "складки киски"])+throughTheClothing+".",
			])
		else:
			text = RNG.pick([
				"{sub.You} "+RNG.pick(["{sub.youVerb('nuzzle')}", "{sub.youVerb('lick')}"])+" {dom.your} "+RNG.pick(["pussy", "slit", "petals", "складки киски"])+throughTheClothing+".",
			])
		stimulate(SUB_0, S_MOUTH, DOM_0, S_VAGINA, I_TEASE, Fetish.OralSexGiving)
		#getDomInfo().addLust(10.0 + getDomInfo().fetishScore({Fetish.OralSexReceiving: 5.0}))
		#getDomInfo().addArousalForeplay(0.05)
		if(getDomInfo().isReadyToPenetrate() && hasBodypartUncovered(DOM_0, BodypartSlot.Vagina)):
			text += RNG.pick([
				" киска {dom.Your} выглядит "+RNG.pick(["wet", "moist", "needy", "очень мокрой"])+".",
			])
		addText(text)
		return
	if(_id == "openmouth"):
		isForce = false
		state = "blowjob"
		sendSexEvent(SexEvent.HolePenetrated, DOM_0, SUB_0, {hole=BodypartSlot.Head,engulfed=true,strapon=isStraponSex()})
		addText("{sub.You} {sub.youVerb('open')} {sub.yourHis} рот и {sub.youVerb('let')} {dom.your} "+getDickName()+" внутри, прежде чем обхватить губами {sub.yourHis}.")
		return
	if(_id == "notopenmouth"):
		state = ""
		getDomInfo().addAnger(0.2)
		addText("{sub.You} {sub.youVerb('refuse')}, чтобы заставить {sub.yourHis} открыть рот.")
		return
	if(_id == "startlicking"):
		isForce = false
		isFacesit = false
		state = "licking"
		addText("{sub.You} {sub.youVerb('stick')} {sub.yourHis} высунул язык и {sub.youVerb('press', 'presses')} его об {dom.your} "+RNG.pick(["pussy", "slit", "petals", "folds"])+" прежде чем приняться их лизать.")
		return
	if(_id == "refusetolick"):
		state = ""
		addText("{sub.You} {sub.youVerb('refuse')} лижет {dom.yourHis} киску.")
		getDomInfo().addAnger(0.2)
		return
	if(_id == "prodpussy"):
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('use')} {sub.yourHis} языком, чтобы "+RNG.pick(["тыкать в разрез {dom.yourHis} киски и слизывать все соки", "тыкаться в мокрый вход киски", "лизнуть мокрый вход киски"])+".",
		])
		
		if(getDom().hasEffect(StatusEffect.HasCumInsideVagina) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			if(RNG.chance(40)):
				if(getDom().bodypartTransferFluidsTo(BodypartSlot.Vagina, getSubID(), BodypartSlot.Head, 0.1, 20.0)):
					text += RNG.pick([ 
						" {sub.YouHe} {sub.youHeVerb('get')} "+Util.capitalizeFirstLetter(getDom().getBodypartContentsStringList(BodypartSlot.Vagina))+" на {sub.yourHis} язык, пока ест {dom.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+" наружу. [b]{sub.You} {sub.youVerb('swallow')} вылизывает всё до капли[/b].",
					])
		
		#getDomInfo().stimulateArousalZone(0.05, BodypartSlot.Vagina, 0.25)
		stimulate(SUB_0, S_MOUTH, DOM_0, S_VAGINA, I_LOW, Fetish.OralSexGiving, SPEED_SLOW)
		addText(text)
		return
	if(_id == "grindtongue"):
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('stick')} высунул(а) {sub.yourHis} язык и {sub.youVerb('catch', 'catches')} немного "+RNG.pick(["arousal", "juices"])+RNG.pick([" из этой мокрой киски","", " прямо на неё"," пока лицо {sub.yourHis} вжимают в"])+".",
		])
		
		if(getDom().hasEffect(StatusEffect.HasCumInsideVagina) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			if(RNG.chance(50)):
				if(getDom().bodypartTransferFluidsTo(BodypartSlot.Vagina, getSubID(), BodypartSlot.Head, 0.1, 20.0)):
					text += RNG.pick([ 
						" "+Util.capitalizeFirstLetter(getDom().getBodypartContentsStringList(BodypartSlot.Vagina))+" "+RNG.pick(["leaks", "oozes"])+" {sub.yourHis} высунутый язык {dom.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+". [b]{sub.You} заглатывает {sub.youVerb('swallow')} всё целиком[/b].",
					])
		
		stimulate(SUB_0, S_MOUTH, DOM_0, S_VAGINA, I_LOW, Fetish.OralSexGiving, SPEED_SLOW)
		#getDomInfo().stimulateArousalZone(0.05, BodypartSlot.Vagina, 0.25)
		addText(text)
		return
	if(_id == "bite"):
		if(isStraponSex() && (state in ["blowjob", "deepthroat"])):
			addText("{sub.You} {sub.youVerb('bite')} насаживается на {dom.your} страпон. Это почти не дает эффекта...")
			return
		
		var successChance:float = getSubBiteChance(50.0, 30.0)
		if(RNG.chance(successChance)):
			getDomInfo().addPain(10)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=10,isDefense=true,intentional=true})
			getDomInfo().addAnger(1.0 - getDomInfo().fetishScore({Fetish.Masochism: 0.5}))
			getDomInfo().addLust(-5 + 10 * getDomInfo().fetishScore({Fetish.Masochism: 1.0}))
			endActivity()
			addText("{sub.You} {sub.youVerb('bite')} хватает {dom.your} за гениталии! {dom.YouHe} {dom.youHeVerb('cry', 'cries')} от боли и {dom.youHeVerb('pull')} прочь.")
			return
		else:
			getDomInfo().addAnger(0.4)
			addText("{sub.You} {sub.youVerb('try', 'tries')} пытается укусить {dom.you}, но {dom.youHe} {dom.youHeVerb('avoid')} это!")
			return
	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getSubResistChance(30.0, 25.0)
		if(RNG.chance(successChance)):
			getDomInfo().addAnger(0.3)
			if(state in ["blowjob", "licking", "deepthroat"]):
				state = ""
			else:
				endActivity()
			addText("{sub.You} {sub.youVerb('pull')} от {dom.you}.")
			return
		else:
			getDomInfo().addAnger(0.1)
			addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			reactSub(SexReaction.ActivelyResisting, [50])
			return
	if(_id == "startdeepthroating"):
		if(!RNG.chance(getSub().getPenetrateChanceBy(BodypartSlot.Head, getDomID()))):
			getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(), true, 0.1)
			stimulateLick(SUB_0, DOM_0, S_PENIS, I_TEASE, SPEED_SLOW)
			#affectDom(getDomInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.2*domSensitivity(), -0.03)
			addText("{sub.You} {sub.youVerb('try', 'tries')} заглотить {dom.yourHis} "+getDickName()+" в горло {sub.yourHis}, но "+RNG.pick(["он слишком велик,", "{sub.youHe} {sub.youHeVerb('struggle')}", "{sub.youVerb('fail')}"])+".")
			return
		else:
			state = "deepthroat"
			stimulateLick(SUB_0, DOM_0, S_PENIS, I_NORMAL, SPEED_SLOW)
			getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(), true, 0.2)
			#affectDom(getDomInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.2*domSensitivity(), -0.03)
			#getDomInfo().addArousalForeplay(0.05*domSensitivity())
			addText("{sub.You} willingly {sub.youVerb('let')} {dom.yourHis} "+getDickName()+" глубоко в горле {sub.yourHis}, и {sub.youVerb('start')} делает глубокий минет!")
			return
	if(_id == "stopdeepthroating"):
		if(RNG.chance(getSubStopDeepthroatChance())):
			state = "blowjob"
			addText("{sub.You} {sub.youVerb('stop')} глубоко заглатывает это "+getDickName()+", а просто сосать его как обычно.")
			return
		else:
			getDomInfo().addAnger(0.05)
			var text:String = RNG.pick([
				"{sub.You} {sub.youVerb('try', 'tries')} пытается отстраниться, но {sub.youVerb('fail')}. {dom.You} {dom.youVerb('keep')} заставляет {sub.youHim} заглатывать {dom.youHim} по самые гланды!",
			])
			if(getDomInfo().isAngry() && RNG.chance(50)):
				getSubInfo().addPain(5)
				sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=5,isDefense=false,intentional=true})
				text += RNG.pick([
					" {sub.You} {sub.youVerb('receive')} — болезненная пощечина от {dom.youHim}.",
				])
			addText(text)
			return


func getSubStopDeepthroatChance() -> float:
	if(!getDomInfo().isAngry()):
		return 100.0
	var theChance = 40.0 - getDomInfo().getAngerScore()*20.0
	if(getSub().hasBlockedHands()):
		theChance *= 0.8
	if(getSub().hasBoundArms()):
		theChance *= 0.8
	if(getSub().isBitingBlocked()):
		theChance *= 0.5
	return max(theChance, 5.0)

func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.5
	if(getSub().hasBoundArms()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	
	return max(theChance, 5.0)

func getSubBiteChance(baseChance:float, domAngerRemoval:float) -> float:
	if(state in ["blowjob", "licking"]):
		return 100.0
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.9
	if(getSub().hasBoundArms()):
		theChance *= 0.9
	if(getSub().isBlindfolded()):
		theChance *= 0.5
	
	return max(theChance, 5.0)

func getAnimation():
	if(getSexType() == SexType.BitchsuitSex):
		if(state in ["", "askingtolick"]):
			return [StageScene.PuppySexOral, "tease", {pc=DOM_0, npc=SUB_0}]
		if(state in ["licking", "grinding"]):
			if(getDomInfo().isCloseToCumming() || (isStraponSex() && getSubInfo().isCloseToCumming())):
				return [StageScene.PuppySexOral, "grindfast", {pc=DOM_0, npc=SUB_0}]
			return [StageScene.PuppySexOral, "grind", {pc=DOM_0, npc=SUB_0}]
		if(state in ["blowjob", "deepthroat"]):
			if(getDomInfo().isCloseToCumming() || (isStraponSex() && getSubInfo().isCloseToCumming())):
				return [StageScene.PuppySexOral, "fast", {pc=DOM_0, npc=SUB_0}]
			return [StageScene.PuppySexOral, "sex", {pc=DOM_0, npc=SUB_0}]
			
		return [StageScene.PuppySexOral, "tease", {pc=DOM_0, npc=SUB_0}]
	
	if(isStocksSex()):
		if(state in ["", "askingtolick"]):
			return [StageScene.StocksSexOral, "tease", {npc=DOM_0, pc=SUB_0}]
		if(state in ["licking", "grinding"]):
			if(getDomInfo().isCloseToCumming()):
				return [StageScene.StocksSexOral, "pussyfast", {npc=DOM_0, pc=SUB_0}]
			return [StageScene.StocksSexOral, "pussy", {npc=DOM_0, pc=SUB_0}]
		if(state in ["blowjob", "deepthroat"]):
			if(getDomInfo().isCloseToCumming() || (isStraponSex() && getSubInfo().isCloseToCumming())):
				return [StageScene.StocksSexOral, "fast", {npc=DOM_0, pc=SUB_0}]
			return [StageScene.StocksSexOral, "sex", {npc=DOM_0, pc=SUB_0}]
			
		return [StageScene.StocksSexOral, "tease", {npc=DOM_0, pc=SUB_0}]
	
	if(state in ["", "askingtolick"]):
		return [StageScene.SexOral, "start", {pc=DOM_0, npc=SUB_0}]
	
	if(state in ["licking"]):
		if(isFacesit):
			if(isCloseToCumming(DOM_0)):
				return [StageScene.SexFaceSitting, "grind", {pc=DOM_0, npc=SUB_0}]
			return [StageScene.SexFaceSitting, "sit", {pc=DOM_0, npc=SUB_0}]
		if(isCloseToCumming(DOM_0)):
			return [StageScene.SexOral, "grind", {pc=DOM_0, npc=SUB_0}]
		return [StageScene.SexOral, "lick", {pc=DOM_0, npc=SUB_0}]
	if(state in ["grinding"]):
		if(isCloseToCumming(DOM_0)):
			return [StageScene.SexOralForced, "lickfast", {pc=DOM_0, npc=SUB_0}]
		return [StageScene.SexOralForced, "lick", {pc=DOM_0, npc=SUB_0}]
	
	if(state in ["blowjob", "deepthroat"]):
		if(isForce):
			if(getDomInfo().isCloseToCumming() || state == "deepthroat"):
				return [StageScene.SexOralForced, "suckfast", {pc=DOM_0, npc=SUB_0}]
			return [StageScene.SexOralForced, "suck", {pc=DOM_0, npc=SUB_0}]
		if(getDomInfo().isCloseToCumming() || state == "deepthroat"):
			return [StageScene.SexOral, "fast", {pc=DOM_0, npc=SUB_0}]
		return [StageScene.SexOral, "sex", {pc=DOM_0, npc=SUB_0}]
	
	if(state in ["askingtosuck"]):
		return [StageScene.SexOral, "tease", {pc=DOM_0, npc=SUB_0}]

func isActivityImpossibleShouldStop() -> bool:
	if(state in ["askingtolick", "licking", "grinding"]):
		if(!getDom().hasReachableVagina()):
			return true
	if(state in ["askingtosuck", "blowjob", "deepthroat"]):
		if(!getDom().hasReachablePenis() && !getDom().isWearingStrapon()):
			return true
	
	return false

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == DOM_0):
		if(isStraponSex()):
			return 5
		return 10
	return -1

func saveData():
	var data = .saveData()
	
	data["waitTimer"] = waitTimer
	data["straponHumps"] = straponHumps
	data["isForce"] = isForce
	data["isFacesit"] = isFacesit

	return data
	
func loadData(data):
	.loadData(data)
	
	waitTimer = SAVE.loadVar(data, "waitTimer", 0)
	straponHumps = SAVE.loadVar(data, "straponHumps", 0)
	isForce = SAVE.loadVar(data, "isForce", false)
	isFacesit = SAVE.loadVar(data, "isFacesit", false)
