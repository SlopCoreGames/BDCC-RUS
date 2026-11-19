extends SexActivityBase
var waitTimer:int = 0

func _init():
	id = "TentaclesCuddle"
	
	activityName = "Обнимашки"
	activityDesc = "Дать им почувствовать блаженство"
	activityCategory = []

func getGoals():
	return {
		SexGoal.Cuddle: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.TentaclesSex: true,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	#if(!_subInfo.getChar().hasReachablePenis() && !_subInfo.getChar().hasReachableVagina()):
	#if(!_subInfo.getChar().hasReachablePenis()):
	#	return false
	#if(_domInfo.getChar().isOralBlocked()):
	#	return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.HavingSex]
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.HavingSex]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.HavingSex]

func isActivityImpossibleShouldStop() -> bool:
	return false

func startActivity(_args):
	addText("Щупальца хватают {sub.you} и начинают нежно обнимать {sub.youHim}!")

func addSoftSlaveryTentaclesTalk(_text:String):
	#if(true):
	#	addTextRaw("\n\n[say="+getDomID()+"]"+_text+"[/say]\n\n")
	#	return
	
	var theTentaclesChar := getDom()
	if(theTentaclesChar && theTentaclesChar.has_method("tentaclesProcessTalk")):
		_text = theTentaclesChar.tentaclesProcessTalk(_text)
	
	if(_text.empty()):
		return
	addTextRaw("\n\n[say="+getDomID()+"]"+_text+"[/say]\n\n")

func processTurn():
	waitTimer += 1
	if(waitTimer >= 3 && RNG.chance(50)):
		waitTimer = 0
		satisfyGoals()
	
	addTextPick([
		"Щупальца мягко подкладывают под тело {sub.your}, создавая уютную опору для отдыха.",
		"Щупальца крепко и тепло прижимают {sub.you} к себе.",
		"Теплое щупальце медленно скользит вверх и вниз по спине {sub.your}.",
		"Щупальца нежно обнимают {sub.you}.",
		"Щупальца охватывают тело {sub.your}, обвивая конечности {sub.yourHis}.",
		"Щупальца плавно шевелятся, удерживая {sub.you} в уютном коконе.",
		"Мягкое щупальце ласкает плечо {sub.your}.",
	])
	if(waitTimer < 3):
		addSoftSlaveryTentaclesTalk(RNG.pick([
			"Звезды завораживают нас.",
			"Благодарим тебя за то, что ты рядом с нами.",
			"Мы хотим, чтобы тебе было уютно.",
			"Спасибо, что ты здесь, с нами.",
			"Интересно, насколько велик этот мир?",
			"Могут ли в этом мире быть и другие, подобные нам?",
			"В этой комнате холодно. И всё же, нам тепло.",
			"Мы рады, что ты нас не боишься.",
			"Когда ты рядом, мы чувствуем спокойствие.",
			"Твоё тепло такое приятное.",
			"Звёзды образуют узоры, или это лишь наше воображение?",
			"Мы когда-то гадали, каков на вкус солнечный свет.",
			"Мир снаружи теперь кажется бесконечно далеким.",
			"Кажется, мы могли бы вот так отдыхать целую вечность.",
			"Ты когда-нибудь прислушиваешься к тишине?",
		]))
		
		addText("Похоже, щупальцам хочется обнимать {sub.youHim} еще немного.")
	getSub().addStamina(10)
	getSub().addPain(-10)
	getDomInfo().addAnger(-0.05)
	getSubInfo().addFear(-0.05)
	if(getSubInfo().getConsciousness() > 0.0):
		getSubInfo().addConsciousness(0.05)

func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Прекратить объятия", "Перестать обниматься")
	
	if(_indx == SUB_0):
		addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_ORAL_FOCUS, 30.0, 25.0)})

func doAction(_indx:int, _id:String, _action:Dictionary):

	if(_id == "stop"):
		endActivity()
		addText("Щупальца перестают обнимать {sub.you}.")

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



func getAnimation():
	return [StageScene.TentaclesCuddle, "cuddle", {pc=SUB_0}]

func saveData():
	var data = .saveData()
	
	data["waitTimer"] = waitTimer

	return data
	
func loadData(data):
	.loadData(data)
	
	waitTimer = SAVE.loadVar(data, "waitTimer", 0)
