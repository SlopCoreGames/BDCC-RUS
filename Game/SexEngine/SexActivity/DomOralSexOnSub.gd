extends SexActivityBase
var waitTimer:int = 0

func _init():
	id = "DomOralSexOnSub"
	
	activityName = "Оральный секс подчиненной"
	activityDesc = "Доставь ей удовольствие своим ртом"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.DoOralOnSub: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.SlutwallSex: true,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_subInfo.getChar().hasReachablePenis() && !_subInfo.getChar().hasReachableVagina()):
		return false
	if(_domInfo.getChar().isOralBlocked()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		if(getState() in ["blowjob", "lickingcock", "licking", "grinding", "tonguefucking"]):
			return [SexActivityTag.MouthUsed, SexActivityTag.HavingSex]
		return [SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.PreventsSubTeasing, SexActivityTag.HavingSex, SexActivityTag.PenisUsed, SexActivityTag.VaginaUsed] #SexActivityTag.PreventsSubViolence
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.MouthUsed, SexActivityTag.HavingSex]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.HavingSex, SexActivityTag.PenisUsed, SexActivityTag.VaginaUsed]

func isActivityImpossibleShouldStop() -> bool:
	if(getState() in ["blowjob", "lickingcock"]):
		if(!getSub().hasReachablePenis() && !getSub().isWearingStrapon()):
			return true
	if(getState() in ["licking", "grinding"]):
		if(!getSub().hasReachableVagina()):
			return true
	return false

func startActivity(_args):
	var exposedThings:Array = []
	var genitalsText:String = "crotch"
	if(getSub().hasPenis() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
		exposedThings.append(RNG.pick(["dick", "cock", "member"]))
		if(RNG.chance(50)):
			exposedThings.append("balls")
	if(getSub().hasVagina() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
		exposedThings.append(RNG.pick(["pussy", "pussy", "slit", "kitty"]))
	if(exposedThings.size() > 0):
		genitalsText = "exposed "+Util.humanReadableList(exposedThings)
	
	if(getSexType() != SexType.SlutwallSex):
		addText("{dom.You} {dom.youVerb('keep')} {sub.you} лежит на полу, поднося {dom.yourHis} рот к {sub.yourHis} "+genitalsText+".")
	else:
		addText("{dom.You} {dom.youVerb('kneel')} наклоняется и {dom.youVerb('bring')} {dom.yourHis} рот к {sub.yourHis} "+genitalsText+".")

func handjob_processTurn():
	stimulateStrokePenis(DOM_0, SUB_0, I_NORMAL, SPEED_SLOW)
	strokePenis(DOM_0, SUB_0)

func blowjob_processTurn():
	if(getSub().isWearingChastityCage()):
		setState("lickingcock")
		addText("{dom.You} {dom.youVerb('stop')} sucking {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+" когда на нем появляется девайс целомудрия!")
		return
	
	doBlowjobTurn(DOM_0, SUB_0)
	
func lickingcock_processTurn():
	stimulateLick(DOM_0, SUB_0, S_PENIS, I_TEASE)
#	affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0})+0.3, 0.1, -0.1, -0.01)
#	affectDom(getDomInfo().fetishScore({Fetish.OralSexGiving: 0.5})+0.6, 0.1, 0.0)
#	getSubInfo().stimulateArousalZone(0.06, BodypartSlot.Penis, 0.25)
	
	var clothingItem = getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis)
	var throughTheClothing = ""
	if(clothingItem != null):
		throughTheClothing = " through the "+clothingItem.getCasualName()
	var text = RNG.pick([
		"{dom.You} {dom.youAre} licking {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+ throughTheClothing +".",
		"{dom.You} {dom.youAre} проводит {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+ throughTheClothing +".",
	])
	
	if(getSubInfo().isReadyToCum()):
		text += RNG.pick([
			" {sub.YouHe} {sub.youAreHeIs} вот-вот кончит!",
			" {sub.YouHe} {sub.youAreHeIs} изводит {dom.youHim}, держа её на грани.",
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "member"])+" дергается и пульсирует.",
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "member"])+" сильно выделяет предэякулят.",
			" {sub.YouHe} {sub.youAreHeIs} едва сдерживает {sub.yourself} от оргазма.",
			" {sub.YouHe} достиг(ла) {sub.yourHis} пика!",
		])
	elif(getSubInfo().isCloseToCumming()):
		text += RNG.pick([
			" {sub.You} "+RNG.pick(["{sub.youVerb('let')} издает стоны", "{sub.youVerb('let')} стонет", "{sub.youVerb('breathe')} deeply"])+" while {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+" "+RNG.pick(["предсмазка капает", "слегка вздрагивает", "отзывается судорожным вздрагиванием", "становится тверже"])+"."
		])
	
	addText(text)
	
func licking_processTurn():
	doPussyLickingTurn(DOM_0, SUB_0)
	
func tonguefucking_processTurn():
	stimulateLick(DOM_0, SUB_0, S_VAGINA, I_LOW)
	#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0})+0.1, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo().fetishScore({Fetish.OralSexGiving: 0.5})+0.6, 0.1, 0.0)
	#getSubInfo().stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
	
	var text = RNG.pick([
		"{dom.You} "+RNG.pick(["{dom.youVerb('push', 'pushes')}", "{dom.youVerb('slide')}"])+" {dom.yourHis} входит и выходит из {sub.your} языком "+RNG.pick(["pussy", "щель киски", "flower", "slit", "kitty"])+".",
		"{dom.You} {dom.youVerb('tongue-fuck')} {sub.yourHis} "+RNG.pick(["pussy", "slit", "kitty"])+"!",
		"{dom.You} {dom.youVerb('slide')} {dom.yourHis} язык внутри {sub.yourHis} "+RNG.pick(["pussy", "slit", "kitty"])+", трахая его!",
	])
	
	if(getSub().hasEffect(StatusEffect.HasCumInsideVagina) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
		if(RNG.chance(20)):
			if(getSub().bodypartTransferFluidsTo(BodypartSlot.Vagina, getDomID(), BodypartSlot.Head, 0.1, 20.0)):
				text += RNG.pick([ 
					" "+Util.capitalizeFirstLetter(getSub().getBodypartContentsStringList(BodypartSlot.Vagina))+" приземляется на язык {dom.yourHis}, вытекая из {sub.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+" и [b]{dom.you} {dom.youVerb('swallow')} его[/b].",
				])
	
	if(getSubInfo().isReadyToCum()):
		text += RNG.pick([
			" {sub.YouHe} {sub.youAreHeIs} вот-вот кончит!",
			" {sub.YouHe} {sub.youAreHeIs}, когда {dom.youHim} доводит его до эджинга.",
			" {sub.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно дергается.",
			" {sub.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно течет от возбуждения.",
			" {sub.YouHe} {sub.youAreHeIs} едва удерживает {dom.yourself} от кончания.",
			" {sub.YouHe} достиг(ла) {sub.yourHis} пика!",
		])
	elif(getSubInfo().isCloseToCumming()):
		text += RNG.pick([
			" {sub.You} "+RNG.pick(["{sub.youVerb('let')} издает стоны", "{sub.youVerb('let')} стонет", "{sub.youVerb('breathe')} deeply"])+" в то время как киска {sub.yourHis} "+RNG.pick(["сочится соками", "течет от возбуждения", "возбуждается сильнее", "течет от возбуждения", "издает возбужденный запах"])+"."
		])
	
	addText(text)
	
func getActions(_indx:int):
	if(_indx == DOM_0):
		if(getSub().hasPenis()):
			addAction("cupballs", 0.2, "Сжать яички в ладонях", "Немного поиграть с яичками")
		if(getSub().hasVagina()):
			addAction("rubclit", 0.2, "Теребить клитор", "Немного поиграть с клитором")
		if(getState() == ""):
			if(getSub().hasReachablePenis()):
				addAction("startcocklick", 1.0, "Лизать член", "Начать лизать член")
				if(hasBodypartUncovered(SUB_0, S_PENIS)):
					addAction("startHandjob", 1.0, "Ласкать член", "Подготовить член, поглаживая его")
			if(getSub().hasReachableVagina()):
				addAction("startpussylick", 1.0, "Лизать киску", "Начать лизать киску")
		if(getState() == "lickingcock" || state == "handjob"):
			if(getSub().isReadyToPenetrate() && hasBodypartUncovered(SUB_0, BodypartSlot.Penis)):
				addAction("startblowjob", 1.0 if state != "handjob" else 0.1, "Отсосать", "Впусти этот член в рот")
		if(getState() == "licking"):
			if(hasBodypartUncovered(SUB_0, BodypartSlot.Vagina)):
				addAction("starttonguefuck", 1.0, "Языковой секс", "Трахать киску языком")
		if(getState() in ["licking", "tonguefucking"]):
			if(getDom().hasEffect(StatusEffect.HasCumInsideMouth) && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null && !getDom().isOralBlocked() && OPTIONS.isContentEnabled(ContentType.CumStealing)):
				addAction("spitcumintosubspussy", 0.01 + getDomInfo().fetishScore({Fetish.Breeding: 0.1}), "Плюнуть спермой в киску", "Запихнуть сперму в щель")
		
		if(getState() == "blowjob"):
			addEggStuffReceiveButton(DOM_0, SUB_0, BodypartSlot.Head)
		
		if(getState() in ["subabouttocum", "subabouttocumcock", "subabouttocumHandjob"] || ((getState() in ["licking", "tonguefucking", "lickingcock", "blowjob", "handjob"]) && getSubInfo().isReadyToCum() && !getSubInfo().canDoActions())):
			addAction("letsubcuminside", 1.0, "Внутри", "Дать сабке кончить тебе в рот", {A_PRIORITY: 1001})
			addAction("letsubcumoutside", 1.0, "Фейшал", "Дать сабке кончить на тебя", {A_PRIORITY: 1001})
			addAction("makesubcumavoidmess", 1.0, "Избегать грязи", "Дать сабке кончить, но не испачкаться", {A_PRIORITY: 1001})
		
		addAction("stop", getStopScore(), "Прекратить оральный секс", "Прекратить оральный секс")
	
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_ORAL_FOCUS, 30.0, 25.0)})
		if(getState() in ["blowjob", "lickingcock", "licking", "tonguefucking", "handjob"]):
			addAction("moan", getComplyScore(SUB_0)/3.0, "Стон", "Покажи, как тебе это нравится")
			
			if(isReadyToCumHandled(SUB_0)):
				if(getSexType() == SexType.SlutwallSex):
					addAction("cumondom", 1.0, "Кончай!", "Ты вот-вот кончишь, и с этим уже ничего не поделаешь", {A_PRIORITY: 1001})
				else:
					addAction("warndom", 0.5+getComplyScore(SUB_0)*0.5, "Предупредить доминанта", "Дать понять, что ты на грани", {A_PRIORITY: 1001})
					addAction("cumondom", 1.0, "Кончай!", "Кончить, не говоря об этом доминанту", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stuffegg"):
		doReceiveEggFrom(DOM_0, SUB_0, BodypartSlot.Head)
	if(_id == "spitcumintosubspussy"):
		doSpitCumIntoHoleDom(BodypartSlot.Vagina)
	if(_id == "makesubcumavoidmess"):
		satisfyGoals()
		var text:String = ""
		if(getState() in ["subabouttocum", "licking", "tonguefucking"]):
			text = RNG.pick([
				"{dom.You} слегка {dom.youVerb('lean')} в сторону и {dom.youVerb('let')} {sub.you} [b]кончает прямо на пол[/b]. {sub.YourHis} киска заливается сквиртом, оставляя после себя настоящий беспорядок! Но, к счастью, {dom.you} удалось всё это избежать.",
			])
			getSub().cumOnFloor(getDomID())
			getSubInfo().cum()
		else:
			text = RNG.pick([
				"{dom.You} слегка {dom.youVerb('lean')} в сторону и {dom.youVerb('let')} {sub.you} [b]кончает прямо на пол[/b]. Множество "+RNG.pick(["струй спермы", "нити семени"])+" попадают на неё, пока {sub.yourHis} член пульсирует и кончает, оставляя после себя настоящий беспорядок! Но, к счастью, {dom.you} удалось всё это избежать."
			])
			var condom:ItemBase = getSub().getWornCondom()
			if(condom != null):
				var breakChance:float = condom.getCondomBreakChance()
				
				if(RNG.chance(breakChance)):
					text = "[b]Презерватив порвался![/b] "+text
					condom.destroyMe()
					fetishUp(SUB_0, Fetish.Condoms, -15.0)
					fetishUp(DOM_0, Fetish.Condoms, -20.0)
				else:
					fetishAffect(SUB_0, Fetish.Condoms, 3.0)
					fetishAffect(DOM_0, Fetish.Condoms, 3.0)
					text = RNG.pick([
						"{dom.You} {dom.youVerb('hold')} {dom.yourHis} слегка поворачивает лицо в сторону от {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" когда он начинает пульсировать и [b]наполнять презерватив "+RNG.pick(["cum", "seed", "semen"])+"[/b]!",
					])
					getSub().cumInItem(condom)
					getSubInfo().cum()
					setState("")
					
					addText(text)
					return
			
			getSub().cumOnFloor(getDomID())
			getSubInfo().cum()
		
		setState("")
		addText(text)
	if(_id == "letsubcumoutside"):
		satisfyGoals()
		var text:String = ""
		if(getState() in ["subabouttocum", "licking", "tonguefucking"]):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('shift')} немного отстраняется и {dom.youVerb('let')} {sub.you} [b]кончает прямо на лицо {dom.yourHis}[/b]. Куча "+RNG.pick(["кисокских соков", "juices", "femcum", "женских соков"])+" летит на него, пока {sub.yourHis} течет фонтаном, оставляя после себя настоящий беспорядок!",
			])
			if(getDom().isOralBlocked()):
				getDom().cummedOnBy(getSubID(), FluidSource.Vagina)
			else:
				getDom().cummedInMouthBy(getSubID(), FluidSource.Vagina, 0.5)
				getDom().cummedOnBy(getSubID(), FluidSource.Vagina, 0.5)
			getSubInfo().cum()
		else:
			text = RNG.pick([
				"{dom.You} {dom.youVerb('shift')} немного отстраняется и {dom.youVerb('let')} {sub.you} [b]делает {dom.youHim} смачную минетную кончу[/b]. Множество "+RNG.pick(["струй спермы", "нити семени"])+" попадает на {dom.youHim}, пока {sub.yourHis} член пульсирует и кончает, оставляя после себя настоящий беспорядок!"
			])
			var condom:ItemBase = getSub().getWornCondom()
			if(condom != null):
				var breakChance:float = condom.getCondomBreakChance()
				
				if(RNG.chance(breakChance)):
					text = "[b]Презерватив порвался![/b] "+text
					condom.destroyMe()
					fetishUp(SUB_0, Fetish.Condoms, -15.0)
					fetishUp(DOM_0, Fetish.Condoms, -20.0)
				else:
					fetishAffect(SUB_0, Fetish.Condoms, 3.0)
					fetishAffect(DOM_0, Fetish.Condoms, 3.0)
					text = RNG.pick([
						"{dom.You} {dom.youVerb('hold')} {dom.yourHis} лицом к {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" когда он начинает пульсировать и [b]наполнять презерватив "+RNG.pick(["cum", "seed", "semen"])+"[/b]!",
					])
					getSub().cumInItem(condom)
					getSubInfo().cum()
					setState("")
					
					addText(text)
					return
			
			getDom().cummedOnBy(getSubID(), FluidSource.Penis)
			getSubInfo().cum()
		
		setState("")
		addText(text)
		return
	if(_id == "letsubcuminside"):
		satisfyGoals()
		var text:String = ""
		var condomBroke:bool = false
		if(getState() in ["subabouttocum", "licking", "tonguefucking"]):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('press', 'presses')} {dom.yourHis} губы прижаты к {sub.yourHis} "+RNG.pick(["pussy", "slit", "чувствительные складки", "petals"])+" и продолжают слизывать возбуждение, пока [b]{sub.you} {sub.youVerb('cum')}[/b]! Соки {sub.YourHis} хлещут в рот {dom.yourHis}, пока {sub.youHe} {sub.youHeVerb('squirt')}!",
			])
			getDom().cummedInMouthBy(getSubID(), FluidSource.Vagina)
			getSubInfo().cum()
		else:
			text = RNG.pick([
				"{dom.You} {dom.youVerb('hold')} {dom.yourHis} губы обхватывают {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" когда она начинает пульсировать, и [b]заталкивая {dom.your} рот, "+RNG.pick(["cum", "seed", "semen"])+"[/b]."
			])
			
			var condom:ItemBase = getSub().getWornCondom()
			if(condom != null):
				var breakChance = condom.getCondomBreakChance()
				condomBroke = getSub().shouldCondomBreakWhenFucking(getDom(), breakChance)
				if(condomBroke):
					text = "[b]Презерватив порвался![/b] "+text
					condom.destroyMe()
					fetishUp(SUB_0, Fetish.Condoms, -15.0)
					fetishUp(DOM_0, Fetish.Condoms, -20.0)
				else:
					fetishAffect(SUB_0, Fetish.Condoms, 3.0)
					fetishAffect(DOM_0, Fetish.Condoms, 3.0)
					text = RNG.pick([
						"{dom.You} {dom.youVerb('hold')} {dom.yourHis} губы обхватывают {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" когда она начинает пульсировать, и [b]наполняя презерватив внутри {dom.your} рта "+RNG.pick(["cum", "seed", "semen"])+"[/b]!",
					])
					getSub().cumInItem(condom)
					getSubInfo().cum()
					setState("")
					
					addText(text)
					return
			
			getDom().cummedInMouthByAdvanced(getSubID(), {condomBroke=condomBroke}, FluidSource.Penis)
			getSubInfo().cum()
		
		setState("")
		addText(text)
		return
	if(_id == "cupballs"):
		cupballs(DOM_0, SUB_0)
		stimulate(DOM_0, S_MOUTH, SUB_0, S_PENIS, I_TEASE, Fetish.OralSexGiving, SPEED_SLOW)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.1, -0.05, -0.01)
		
		return
	if(_id == "rubclit"):
		var text = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('rub')}", "{dom.youVerb('tease')}", "{dom.youVerb('play')} with"])+" немного ласкает клитор {sub.yourHis}, обеспечивая дополнительную стимуляцию.",
		])
		stimulate(DOM_0, S_HANDS, SUB_0, S_VAGINA, I_HIGH, Fetish.OralSexGiving, SPEED_VERYSLOW)
		#getSubInfo().stimulateArousalZone(0.05, BodypartSlot.Vagina, 0.2)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.0, -0.05, -0.01)
		
		addText(text)
		return
	if(_id == "startHandjob"):
		setState("handjob")
		addTextPick([
			"{dom.You} {dom.youVerb('wrap')} {dom.yourHis} пальцы вокруг {sub.yourHis} {sub.penisShort}!",
		])
		stimulate(DOM_0, S_MOUTH, SUB_0, S_PENIS, I_TEASE, Fetish.OralSexGiving, SPEED_SLOW)
		react(SexReaction.AboutToHandjobSub)
		return
	if(_id == "startcocklick"):
		setState("lickingcock")
		var clothingItem = getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis)
		var throughTheClothing:String = ""
		if(clothingItem != null):
			throughTheClothing = " через "+clothingItem.getCasualName()
		
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('bring')} {dom.yourHis} язык к {sub.yourHis} "+RNG.pick(["dick", "cock", "member", "shaft"])+" и {dom.youVerb('proceed')} вылизать его"+throughTheClothing+".",
		])
		
		stimulateLick(DOM_0, SUB_0, S_PENIS, I_TEASE, SPEED_SLOW)
		#getSubInfo().addLust(10.0 + getSubInfo().fetishScore({Fetish.OralSexReceiving: 5.0}))
		#getSubInfo().addArousalForeplay(0.05)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.0, -0.3, -0.01)
		
		if(getSubInfo().isReadyToPenetrate() && clothingItem == null):
			text += RNG.pick([
				" {sub.Your} твердый член течет "+RNG.pick(["pre", "precum", "arousal"])+".",
				" {sub.Your} член кажется "+RNG.pick(["ready", "достаточно твердым"])+" для минета.",
			])
		
		addText(text)
		return
	if(_id == "startpussylick"):
		setState("licking")
		var clothingItem = getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina)
		var throughTheClothing = ""
		if(clothingItem != null):
			throughTheClothing = " через "+clothingItem.getCasualName()
		
		var text = RNG.pick([
			"{dom.You} {dom.youVerb('stick')} {dom.yourHis} высунув язык и {dom.youVerb('press', 'presses')} его об {sub.your} "+RNG.pick(["pussy", "slit", "petals", "folds"])+" прежде чем приняться вылизывать {sub.youHim}"+throughTheClothing+".",
		])
		
		stimulateLick(DOM_0, SUB_0, S_VAGINA, I_TEASE, SPEED_SLOW)
		#getSubInfo().addLust(10.0 + getSubInfo().fetishScore({Fetish.OralSexReceiving: 5.0}))
		#getSubInfo().addArousalForeplay(0.05)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.0, -0.3, -0.01)
		addText(text)
		react(SexReaction.AboutToLickPussy)
		return
	if(_id == "startblowjob"):
		setState("blowjob")

		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('open')} {dom.yourHis} рот и {dom.youVerb('let')} {sub.your} "+RNG.pick(["cock", "dick", "member"])+" внутрь, обхватив {dom.yourHis} губами.",
		])
		getDom().gotOrificeStretchedBy(BodypartSlot.Head, getSubID(), true, 0.1)
		stimulateLick(DOM_0, SUB_0, S_PENIS, I_TEASE, SPEED_SLOW)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.1, -0.3, -0.01)
		sendSexEvent(SexEvent.HolePenetrated, SUB_0, DOM_0, {hole=BodypartSlot.Head,engulfed=true,strapon=false})
		addText(text)
		react(SexReaction.AboutToSuckSubOff)
		return
	if(_id == "starttonguefuck"):
		setState("tonguefucking")
		
		var text = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('find')}", "{dom.youVerb('reach', 'reaches')}"])+" for {sub.yourHis} "+RNG.pick(["дырочка киски", "киска входит в рот"])+" и {dom.youVerb('penetrate')} её, прежде чем начать двигать {dom.yourHis} языком туда-сюда, трахая её таким образом!",
		])
		stimulateLick(DOM_0, SUB_0, S_VAGINA, I_TEASE, SPEED_SLOW)
		#affectSub(getSubInfo().fetishScore({Fetish.OralSexReceiving: 1.0}), 0.1, -0.3, -0.01)
		addText(text)
		return
	if(_id == "stop"):
		endActivity()
		
		var exposedThings:Array = []
		var genitalsText:String = "crotch"
		if(getSub().hasPenis() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
			exposedThings.append(RNG.pick(["dick", "cock", "member"]))
			if(RNG.chance(50)):
				exposedThings.append("balls")
		if(getSub().hasVagina() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
			exposedThings.append(RNG.pick(["pussy", "pussy", "slit", "kitty"]))
		if(exposedThings.size() > 0):
			genitalsText = "exposed "+Util.humanReadableList(exposedThings)
			
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourHis} губы от {sub.yourHis} "+genitalsText+".")

	if(_id == "warndom"):
		if(state == "handjob"):
			setState("subabouttocumHandjob")
		elif(getState() in ["licking", "tonguefucking"]):
			setState("subabouttocum")
		else:
			setState("subabouttocumcock")
		addText("{sub.You} {sub.youVerb('warn')} {dom.youHim} that {sub.youHe} {sub.youAreHeIs} "+RNG.pick(["вот-вот кончит", "close", "совсем близко"])+".")
		getDomInfo().addAnger(-0.05)
		reactSub(SexReaction.WarnAboutToCum)
		return
	if(_id == "cumondom"):
		satisfyGoals()
		
		if(getState() in ["licking", "tonguefucking"]):
			doCumPussyLickSub(true)
			setState("")
			return
		if(getState() == "lickingcock" || state == "handjob"):
			doCumBJFacialsSub(true)
			setState("")
			return
		if(getState() == "blowjob"):
			doCumBJSub(true)
			setState("")
			return
		
		#addText("SOMETHING WENT WRONG")
		return
	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getResistChance(SUB_0, DOM_0, RESIST_ORAL_FOCUS, 30.0, 25.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('pull')} от {dom.you}.")
			getDomInfo().addAnger(0.3)
			if(getState() != ""):
				setState("")
			else:
				endActivity()
			return
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			reactSub(SexReaction.ActivelyResisting, [50])
			return
	if(_id == "moan"):
		if(state in ["licking", "tonguefucking", "lickingcock", "blowjob"]):
			var text:String = RNG.pick([
				"{sub.You} "+RNG.pick(["{sub.youVerb('let')} стонет", "{sub.youVerb('moan')}", "{sub.youVerb('produce')} стон", "{sub.youVerb('make')} звук удовольствия"])+" while ",
			])
			if(getSub().isGagged()):
				text = RNG.pick([
					"{sub.You} "+RNG.pick(["{sub.youVerb('let')} издает приглушенный стон", "{sub.youVerb('try', 'tries')} застонать", "{sub.youVerb('produce')} приглушенный стон", "{sub.youVerb('make')} приглушенный звук удовольствия"])+" while ",
				])
			if(getState() == "licking"):
				text += RNG.pick([
					"{dom.you} {dom.youAre} licking {sub.yourHis} "+RNG.pick(["pussy", "чувствительные складки", "kitty", "petals", "мокрая киска"])+".",
				])
			if(getState() == "tonguefucking"):
				text += RNG.pick([
					"{dom.you} {dom.youAre} tongue-fucking {sub.yourHis} "+RNG.pick(["pussy", "чувствительные складки", "kitty", "petals", "мокрая киска"])+".",
				])
			if(getState() == "lickingcock"):
				text += RNG.pick([
					"{dom.you} {dom.youAre} "+RNG.pick(["licking", "teasing", "preparing"])+" {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+".",
				])
			if(getState() == "blowjob"):
				text += RNG.pick([
					"{dom.you} {dom.youAre} "+RNG.pick(["sucking"])+" {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+".",
				])
			addText(text)
		else:
			if(getSub().isGagged()):
				addTextPick([
					"{sub.You} "+RNG.pick(["{sub.youVerb('let')} издает приглушенный стон","{sub.youVerb('moan')}", "{sub.youVerb('produce')} приглушенный стон", "{sub.youVerb('make')} приглушенный звук удовольствия"])+".",
				])
			else:
				addTextPick([
					"{sub.You} "+RNG.pick(["{sub.youVerb('let')} стонет","{sub.youVerb('moan')}", "{sub.youVerb('produce')} стон", "{sub.youVerb('make')} звук удовольствия"])+".",
				])
		moan(SUB_0)
		return


func getAnimation():
	if(getSexType() == SexType.SlutwallSex):
		if(getState() in [""]):
			return [StageScene.SlutwallSexOral, "tease", {pc=SUB_0, npc=DOM_0}]
		if(state == "handjob" || state == "subabouttocumHandjob"):
			return [StageScene.SlutwallSexOral, "handjob", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
		
		if(getState() in ["licking", "subabouttocum", "tonguefucking"]):
			if(getSubInfo().isCloseToCumming()):
				return [StageScene.SlutwallSexOral, "lickfast", {pc=SUB_0, npc=DOM_0}]
			return [StageScene.SlutwallSexOral, "lick", {pc=SUB_0, npc=DOM_0}]
		
		if(getState() in ["blowjob", "subabouttocumcock"]):
			if(getSubInfo().isCloseToCumming()):
				return [StageScene.SlutwallSexOral, "blowjobfast", {pc=SUB_0, npc=DOM_0}]
			return [StageScene.SlutwallSexOral, "blowjob", {pc=SUB_0, npc=DOM_0}]
		
		if(getState() in ["lickingcock"]):
			if(getSubInfo().isCloseToCumming()):
				return [StageScene.SlutwallSexOral, "lickfast", {pc=SUB_0, npc=DOM_0}]
			return [StageScene.SlutwallSexOral, "lick", {pc=SUB_0, npc=DOM_0}]
		
	
	if(getState() in [""]):
		return [StageScene.SexOral, "start", {pc=SUB_0, npc=DOM_0}]
	if(state == "handjob" || state == "subabouttocumHandjob"):
		if(isCloseToCumming(SUB_0)):
			return [StageScene.SexHandjob, "fast", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
		return [StageScene.SexHandjob, "sex", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
	
	if(getState() in ["licking", "subabouttocum", "tonguefucking"]):
		if(getSubInfo().isCloseToCumming()):
			return [StageScene.SexOral, "lickfast", {pc=SUB_0, npc=DOM_0}]
		return [StageScene.SexOral, "lick", {pc=SUB_0, npc=DOM_0}]
	
	if(getState() in ["blowjob", "subabouttocumcock"]):
		if(getSubInfo().isCloseToCumming()):
			return [StageScene.SexOral, "fast", {pc=SUB_0, npc=DOM_0}]
		return [StageScene.SexOral, "sex", {pc=SUB_0, npc=DOM_0}]
	
	if(getState() in ["lickingcock"]):
		return [StageScene.SexOral, "tease", {pc=SUB_0, npc=DOM_0}]
		
func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 10
	return -1

func saveData():
	var data = .saveData()
	
	data["waitTimer"] = waitTimer

	return data
	
func loadData(data):
	.loadData(data)
	
	waitTimer = SAVE.loadVar(data, "waitTimer", 0)
