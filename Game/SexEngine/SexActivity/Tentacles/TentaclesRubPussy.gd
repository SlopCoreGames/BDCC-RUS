extends SexActivityBase
var waitTimer:int = 0
var altPose:int = POSE_GROPE
var shouldShowCumAnim:bool = false

const POSE_GROPE = 0

func _init():
	id = "TentaclesRubPussy"
	
	activityName = "Тереть киску"
	activityDesc = "Дать им почувствовать блаженство"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.DoOralOnSub: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.TentaclesSex: true,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	#if(!_subInfo.getChar().hasReachablePenis() && !_subInfo.getChar().hasReachableVagina()):
	if(!_subInfo.getChar().hasReachableVagina()):
		return false
	#if(_domInfo.getChar().isOralBlocked()):
	#	return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		if(getState() in ["blowjob", "lickingcock", "licking", "grinding"]):
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
	if(!getSub().hasReachableVagina()):
		return true
	return false

func startActivity(_args):
	altPose = RNG.pick([POSE_GROPE])
	
	var exposedThings:Array = []
	var genitalsText:String = "crotch"
	#if(getSub().hasPenis() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
	#	exposedThings.append(RNG.pick(["dick", "cock", "member"]))
	#	if(RNG.chance(50)):
	#		exposedThings.append("balls")
	if(getSub().hasVagina() && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
		exposedThings.append(RNG.pick(["pussy", "pussy", "slit", "kitty"]))
	if(exposedThings.size() > 0):
		genitalsText = "exposed "+Util.humanReadableList(exposedThings)
	
	addText("Тентакли обхватывают {sub.you}. Один отросток скользит вниз к {sub.yourHis} "+genitalsText+".")

func handjob_processTurn():
	stimulateLick(DOM_0, SUB_0, S_VAGINA, I_NORMAL, SPEED_MEDIUM)
	#stimulateStrokePenis(DOM_0, SUB_0, I_NORMAL, SPEED_MEDIUM)
	#doPussyLickingTurn(DOM_0, SUB_0)
	
	addText(RNG.pick([
		"Тентакль ласкает киску {sub.yourHis}.",
		"Тентакль скользит по чувствительным складкам {sub.yourHis}.",
		"Тентакль дразнит вход {sub.yourHis}, потирая его, но не входя внутрь.",
		"Тентакль кончиком описывает круги, лаская клитор {sub.yourHis}.",
		"Тентакль медленно водит кругами вокруг клитора {sub.yourHis}.",
		"Тентакль оглаживает вход в киску {sub.yourHis}, проходя по влажным складкам.",
		"Тентакль продолжает ритмично и дразняще ласкать киску {sub.yourHis}.",
	]))
	
	if(isCloseToCumming(SUB_0) && RNG.chance(30)):
		addText(RNG.pick([
			"{sub.You} {sub.youAre} вот-вот кончит!",
			"{sub.You} {sub.youAre} держит на самом краю оргазма.",
			"Киска {sub.Your} непроизвольно сжимается и дергается.",
			"Киска {sub.Your} течет от возбуждения.",
			"{sub.You} едва сдерживает {sub.youAre}, чтобы не кончить на {sub.yourself}.",
			"{sub.You} достигла {sub.yourHis} пика!",
		]))
	elif(getSubInfo().getArousal() > 0.2 && RNG.chance(20)):
		addText(RNG.pick([
			"Киска {sub.Your} вся мокрая от "+RNG.pick(["arousal", "need", "slickness"])+".",
			"Щель {sub.Your} сочит соками.",
			"Щель {sub.Your} пульсирует при каждом поглаживании.",
			"Клитор {sub.Your} пульсирует от каждого дразнящего движения.",
			"Киска {sub.Your} такая мокрая и скользкая от желания.",
		]))

func processTurn():
	#shouldShowCumAnim = false
	pass

#func licking_processTurn():
#	doPussyLickingTurn(DOM_0, SUB_0)

func getActions(_indx:int):
	if(_indx == DOM_0):
		#if(getSub().hasPenis()):
		#	addAction("cupballs", 0.2, "Cup balls", "Play with the their balls a bit")
		#if(getSub().hasVagina()):
		#	addAction("rubclit", 0.2, "Rub clit", "Play with the their clit a bit")
		if(getState() == ""):
			if(getSub().hasReachableVagina()):
				if(hasBodypartUncovered(SUB_0, S_VAGINA)):
					addAction("startHandjob", getContinueSexScore(DOM_0, SUB_0, S_VAGINA, S_HANDS) - getStopScore(), "Тереть киску", "Начать тереть их киску")
			#if(getSub().hasReachableVagina()):
			#	addAction("startpussylick", 1.0, "Lick pussy", "Start licking their pussy")

		if(getSubInfo().isReadyToCum() && !getSubInfo().canDoActions()):
			addAction("subcum", 1.0, "Оргазм", "Дай сабке кончить", {A_PRIORITY: 1001})
		
		if(getState() != ""):
			addAction("pause", getPauseSexScore(DOM_0, SUB_0, S_VAGINA, S_HANDS), "Пауза", "Прекратить трение")
		
		addAction("stop", getStopScore() - (10.0 if shouldShowCumAnim else 0.0), "Прекратить секс", "Прекратить секс")
	
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_ORAL_FOCUS, 30.0, 25.0)})
		if(getState() in ["blowjob", "lickingcock", "licking", "tonguefucking", "handjob"]):
			addAction("moan", getComplyScore(SUB_0)/3.0, "Стон", "Покажи, как тебе это нравится")
			
			if(isReadyToCumHandled(SUB_0)):
				addAction("subcum", 1.0, "Кончай!", "Ты вот-вот кончишь, и с этим уже ничего не поделаешь", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "pause"):
		state = ""
		addText("Тентакли замирают.")
	if(_id == "subcum"):
		shouldShowCumAnim = true
		satisfyGoals()
		cumGeneric(SUB_0, DOM_0)
		state = ""
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
			"Тентакль прижимается к киске {sub.your} {sub.pussyStretch} и начинает её тереть!",
		])
		stimulate(DOM_0, S_MOUTH, SUB_0, S_VAGINA, I_TEASE, Fetish.OralSexGiving, SPEED_SLOW)
		react(SexReaction.AboutToHandjobSub)
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
			
		addText("Тентакль отрывается от {sub.yourHis} "+genitalsText+".")

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
	if(state == "handjob" || state == "subabouttocumHandjob"):
		if(isCloseToCumming(SUB_0)):
			return [StageScene.TentaclesGrope, "gropefast", {pc=SUB_0, bodyState={}}]
		return [StageScene.TentaclesGrope, "grope", {pc=SUB_0, bodyState={}}]
	if(shouldShowCumAnim):
		set_deferred("shouldShowCumAnim", false)
		return [StageScene.TentaclesGrope, "cum", {pc=SUB_0, bodyState={hard=true}}]
	return [StageScene.TentaclesGrope, "tease", {pc=SUB_0}]

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 10
	return -1

func saveData():
	var data = .saveData()
	
	data["waitTimer"] = waitTimer
	data["altPose"] = altPose

	return data
	
func loadData(data):
	.loadData(data)
	
	waitTimer = SAVE.loadVar(data, "waitTimer", 0)
	altPose = SAVE.loadVar(data, "altPose", POSE_GROPE)
