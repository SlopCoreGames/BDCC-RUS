extends SexActivityBase
var cumAmount:int = 0

func _init():
	id = "Tribadism"
	
	activityName = "Трибадизм"
	activityDesc = "Секс, в котором вы третесь кисками друг о друга с подчиненной!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.Tribadism: 1.0,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_domInfo.getChar().hasReachableVagina() || !_subInfo.getChar().hasReachableVagina()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func isActivityImpossibleShouldStop() -> bool:
	if(!getSub().hasReachableVagina() || !getDom().hasReachableVagina()):
		return true
	
	return false

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.VaginaUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.VaginaUsed, SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing]
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.VaginaUsed, SexActivityTag.HavingSex]
func getCheckTagsSub() -> Array:
	return [SexActivityTag.VaginaUsed, SexActivityTag.HavingSex]

func startActivity(_args):
	addText("{dom.You} {dom.youVerb('lie')} наклонилась, {dom.youVerb('interlock')} ноги с {sub.you}, готовая начать тереться "+RNG.pick(["pussies", "щели кисок", "kitties", "clits"])+" друг о друга"+getThroughClothingText(DOM_0, BodypartSlot.Vagina)+"!")
	
	stimulateTribadism(DOM_0, SUB_0, I_TEASE)
	
	#affectSub(subInfo.fetishScore({Fetish.Tribadism: 1.0}), 0.1, -0.1, -0.01)
	#affectDom(domInfo.fetishScore({Fetish.Tribadism: 1.0}), 0.1, -0.03)
	react(SexReaction.AboutToRubPussiesTogether)

func grinding_processTurn():
	addTextPick([
		"{dom.You} {dom.youVerb('grind')} {dom.yourHis} "+RNG.pick(["pussy", "clit"])+" о щель {sub.name}.",
		"{dom.You} и {sub.you} занимаются сквизингом, трудя свои "+RNG.pick(["pussies", "vulvae"])+" друг о друга.",
		"{dom.You} "+RNG.pick(["dry {dom.youVerb('hump')}", "dry {dom.youVerb('fuck')}"])+" {sub.you}, стимулируя киски друг друга, "+RNG.pick(["pussies", "slits", "kitties"])+".",
	])
	
	stimulateTribadism(DOM_0, SUB_0, I_NORMAL)
#
#		affectSub(subInfo.fetishScore({Fetish.Tribadism: 1.0}), 0.1, -0.1, -0.01)
#		affectDom(domInfo.fetishScore({Fetish.Tribadism: 1.0}), 0.1, -0.03)
#		subInfo.stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
#		domInfo.stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
	
	if(OPTIONS.isContentEnabled(ContentType.CumStealing) && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
		if(RNG.chance(20) && getDom().bodypartShareFluidsWith(BodypartSlot.Vagina, getSubID(), BodypartSlot.Vagina, 0.2)):
			addTextPick([
				"{dom.You} и {sub.you} [b]делят немного спермы[/b], пока "+RNG.pick(["трутся кисками друг о друга", "занимаются трибадизмом", "scissoring"])+"!",
				"[b]Немного спермы перемешивается[/b] между ними "+RNG.pick(["pussies", "slits", "kitties"])+"!",
				"[b]Немного спермы перетекает из одной киски в другую[/b].",
			])
	
	if(isCloseToCumming(DOM_0) && isCloseToCumming(SUB_0)):
		addTextPick([
			"Обе любовницы "+RNG.pick(["похотливо стонут,", "moan", "слегка вздрагивая,"])+" когда приближаются к оргазму!",
			"{dom.You} {dom.youVerb('see')} что {sub.youHe} {sub.youAreHeIs} близко, и так {dom.youAreHeIs} {dom.youHe}.",
			"Обе "+RNG.pick(["pussies", "kitties", "щели кисок"])+" изливают немало возбуждающей смазки.",
			"Оба любовника вот-вот кончат!",
		])
	elif(isCloseToCumming(DOM_0)):
		addTextPick([
			"{dom.You} скоро кончит!",
			"{dom.Your} "+RNG.pick(["kitty", "pussy"])+" слегка подергивается от постоянного трения.",
			"От такого удовольствия {dom.you} скоро кончит!",
		])
	elif(isCloseToCumming(SUB_0)):
		addTextPick([
			"{sub.You} вот-вот кончит!",
			"{sub.Your} "+RNG.pick(["kitty", "pussy"])+" слегка подергивается от постоянного трения.",
			"От такого удовольствия {sub.you} скоро кончит!",
		])

	react(SexReaction.TribadismHappens, [10.0, 5.0])

func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Прекратить трибадизм", "Хватит тереться кисками")
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {
			A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_LEGS_FOCUS, 30.0, 25.0),
			A_PRIORITY: 2,
		})

func doAction(_indx:int, _action:String, _actionDict:Dictionary):
	if(_action == "stop"):
		endActivity()
		addTextPick([
			"{dom.You} отстранила {dom.yourHis} киску, прерывая веселье.",
		])
	if(_action == "pullaway"):
		var successChance:float = getResistChance(SUB_0, DOM_0, RESIST_LEGS_FOCUS, 30.0, 25.0)
		if(RNG.chance(successChance)):
			addText("{sub.You} {sub.youVerb('pull')} от {dom.you}.")
			getDomInfo().addAnger(0.3)
			if(getState() != ""):
				setState("")
			else:
				endActivity()
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			reactSub(SexReaction.ActivelyResisting, [50])

func init_getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("startgrinding", 1.0, "Начать тереться", "Начать тереться кисками друг о друга!", {A_PRIORITY: 4})

func init_doAction(_indx:int, _action:String, _actionDict:Dictionary):
	if(_action == "startgrinding"):
		setState("grinding")
		addTextPick([
			"{dom.You} начала тереться "+RNG.pick(["pussies", "kitties", "vulvae"])+" вместе с {sub.you}, лаская клиторы друг друга"+getThroughClothingText(DOM_0, BodypartSlot.Vagina)+"!",
		])
		stimulateTribadism(DOM_0, SUB_0, I_TEASE)

func grinding_getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("moanDom", 0.3, "Стон", "Покажи, как сильно тебе это нравится.", {A_PRIORITY: 3})
		if(isReadyToCum(DOM_0) && isHandlingOrgasms(DOM_0)):
			addAction("cumDom", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY:1001})
	if(_indx == SUB_0):
		addAction("moanSub", getComplyScore(SUB_0)/3.0, "Стон", "Покажи, как сильно тебе это нравится.", {A_PRIORITY: 3})
		if(isReadyToCum(SUB_0) && isHandlingOrgasms(SUB_0)):
			addAction("cumSub", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY:1001})

func grinding_doAction(_indx:int, _action:String, _actionDict:Dictionary):
	if(_action == "moanDom"):
		addTextPick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('let')} издать стон", "{dom.youVerb('moan')}", "{dom.youVerb('produce')} стонать", "{dom.youVerb('make')} издать звук удовольствия"])+" while "+RNG.pick(["трение кисками", "scissoring", "трение щелками"])+" with {sub.youHim}!",
		])
		moan(DOM_0)
	if(_action == "moanSub"):
		addTextPick([
			"{sub.You} "+RNG.pick(["{sub.youVerb('let')} стонет", "{sub.youVerb('moan')}", "{sub.youVerb('produce')} стон", "{sub.youVerb('make')} звук удовольствия"])+" while {sub.yourHis} "+RNG.pick(["pussy", "kitty", "slit"])+" трут!",
		])
		moan(SUB_0)
		
	if(_action == "cumDom"):
		stimulate(DOM_0, S_VAGINA, SUB_0, S_VAGINA, I_HIGH, Fetish.Tribadism)
		#subInfo.stimulateArousalZone(0.2, BodypartSlot.Vagina, 1.0)
		if(doCheckDoubleOrgasm()):
			satisfyGoals()
			return
		fetishAffect(DOM_0, Fetish.Tribadism, 3.0)
		
		cumAmount += 1
		if(cumAmount >= 2):
			satisfyGoals()
		
		getDom().cumOnFloor()
		getDomInfo().cum()
		sendSexEvent(SexEvent.UniqueOrgasm, SUB_0, DOM_0, {orgasmType="trib"})
		addGenericOrgasmText(DOM_0)
	if(_action == "cumSub"):
		stimulate(SUB_0, S_VAGINA, DOM_0, S_VAGINA, I_HIGH, Fetish.Tribadism)
		#domInfo.stimulateArousalZone(0.2, BodypartSlot.Vagina, 1.0)
		if(doCheckDoubleOrgasm()):
			satisfyGoals()
			return
		fetishAffect(SUB_0, Fetish.Tribadism, 3.0)
		
		cumAmount += 1
		if(cumAmount >= 2):
			satisfyGoals()
		
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="trib"})
		addGenericOrgasmText(SUB_0)

func doCheckDoubleOrgasm():
	if(isReadyToCum(DOM_0) && isHandlingOrgasms(DOM_0)):
		if(isReadyToCum(SUB_0) && isHandlingOrgasms(SUB_0)):
			getDom().cumOnFloor()
			getDomInfo().cum()
			sendSexEvent(SexEvent.UniqueOrgasm, SUB_0, DOM_0, {orgasmType="trib"})
			getSub().cumOnFloor(getDomID())
			getSubInfo().cum()
			sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="trib"})
			addText("[b]Двойной оргазм![/b]")
			addGenericOrgasmText(DOM_0)
			addGenericOrgasmText(SUB_0)
			fetishAffect(DOM_0, Fetish.Tribadism, 3.0)
			fetishAffect(SUB_0, Fetish.Tribadism, 3.0)
			return true
	return false
	
func getOrgasmHandlePriority(_indx:int) -> int:
	return 5

func getAnimation():
	if(getState() in [""]):
		return [StageScene.SexTribadism, "tease", {pc=DOM_0, npc=SUB_0}]
	if(isCloseToCumming(DOM_0)):
		return [StageScene.SexTribadism, "fast", {pc=DOM_0, npc=SUB_0}]
	return [StageScene.SexTribadism, "sex", {pc=DOM_0, npc=SUB_0}]

func saveData():
	var data = .saveData()
	
	data["cumAmount"] = cumAmount

	return data
	
func loadData(data):
	.loadData(data)
	
	cumAmount = SAVE.loadVar(data, "cumAmount", 0)
