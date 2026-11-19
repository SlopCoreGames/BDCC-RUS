extends Reference

var allActions = {}
var allEffects = {}

var amountOfTurns = 5

var pain = 0
var air = 0
var targetPain = 0
var currentEffects = {}
var avaiableActions = []
var actionsLeft = 5
var shouldSafeWord = false
var shouldEndSuccess = false
var shouldEndFail = false
var shouldEndUnconscious = false
var isBot = false
var isPlaying = true
var state = ""
var shouldPlayStateOnWin = ""
var currentDifficulty = {}
var lastAnimation = []
var lastText = ""

func _init():
	allActions = getAllActions()
	allEffects = getAllStatusEffects()

func getActionsReadable():
	var result = {}
	for actionID in getAvaiableActions():
		var action = allActions[actionID].duplicate()
		if(!action.has("desc")):
			action["desc"] = action["shortdesc"]
		
		var desc = action["shortdesc"]
		var desc2 = action["desc"]
		if(action.has("effects")):
			for effectData in action["effects"]:
				var effect = allEffects[effectData[0]]
				desc += ", "+effect["name"] +" for "+str(effectData[1])+" turns ("+effect["desc"]+")"
				desc2 += "\n"+effect["name"] +" for "+str(effectData[1])+" turns ("+effect["desc"]+")"
		action["shortdesc"] = desc
		action["desc"] = desc2
		
		result[actionID] = action
	return result

func getEffectsReadable():
	var result = []
	for effectID in currentEffects:
		var effect = allEffects[effectID]
		var howManyTurns = currentEffects[effectID]
		
		result.append(effect["name"]+": "+effect["desc"]+" (Поворот налево: "+str(howManyTurns)+")")
	return result

func startDifficulty(theDiff):
	var allDiffs = getAllDifficulties()
	
	var selectedDiff = allDiffs[theDiff]
	avaiableActions = selectedDiff["actions"]
	amountOfTurns = selectedDiff["amountOfActions"]
	shouldPlayStateOnWin = selectedDiff["winID"]
	currentDifficulty = selectedDiff
	
	targetPain = 0
	isPlaying = false
	while(targetPain <= 0):
		targetPain = calculateTargetPain()
	isPlaying = true
	resetPlayData()
	
func resetPlayData():
	shouldSafeWord = false
	shouldEndSuccess = false
	shouldEndFail = false
	isBot = false
	pain = 0
	air = 0
	currentEffects.clear()
	actionsLeft = amountOfTurns
	state = ""
	lastAnimation = currentDifficulty["defaultAnimation"]
	lastText = currentDifficulty["introText"]

func tryAgain():
	resetPlayData()

func getAvaiableActions():
	if(state == ""):
		return avaiableActions
	
	var theActions = []
	for actionID in allActions:
		var action = allActions[actionID]
		if(!action.has("state")):
			continue
		if(action["state"] == state):
			theActions.append(actionID)
	return theActions

func calculateTargetPain():
	resetPlayData()
	
	var sequence = []
	isBot = true
	actionsLeft = amountOfTurns
	while(actionsLeft > 0):
		var myAvaiableActions = getAvaiableActions()
		var goodStartingActions = []
		for actionID in myAvaiableActions:
			var theAction = allActions[actionID]
			if(pain == 0 && theAction.has("cantBeFirstAction") && theAction["cantBeFirstAction"]):
				continue
			if(actionsLeft == 1 && theAction.has("cantBeLastAction") && theAction["cantBeLastAction"]):
				continue
			if(theAction.has("air") && theAction["air"] > 0):
				var newAir = air + theAction["air"]
				if(newAir >= 5):
					continue
			if(sequence.size() > 0 && theAction.has("previousCantBe")):
				if(sequence.back() in theAction["previousCantBe"]):
					continue
			goodStartingActions.append(actionID)
		var randomAction
		if(goodStartingActions.size() == 0):
			randomAction = "FAIL"
			return 0
		else:
			randomAction = RNG.pick(goodStartingActions)
		
		#if(_i >= 3 && RNG.chance(1)):
		#	return pain
		#if(randomAction == "FAIL"):
		#	return 0
		doAction(randomAction)
		sequence.append(randomAction)
	
	targetPain = pain
	if(targetPain in currentDifficulty["avoidTargets"]):
		return 0
	
	if(!testSequence(sequence)):
		return 0
	print(sequence)
	
	return pain

func testSequence(sequence):
	resetPlayData()
	
	var testedActions = avaiableActions.duplicate()
	var allowedToNotUse = avaiableActions.size() - amountOfTurns
	if(allowedToNotUse < 0):
		allowedToNotUse = 0
	for actionID in sequence:
		if(testedActions.has(actionID)):
			testedActions.erase(actionID)
	if(testedActions.size() > allowedToNotUse):
		return false
	
	#var lastActionID = sequence.back()
	#if(allActions[lastActionID].has("cantBeLastAction") && allActions[lastActionID]["cantBeLastAction"]):
	#	pass
	
	var _i = 0
	for actionID in sequence:
		if(actionID == "FAIL"):
			return false
		doAction(actionID)
		if(shouldSafeWord || shouldEndUnconscious):
			return false
		_i += 1
		if(shouldEndSuccess && _i != sequence.size()):
			return false
		
	return true

func hasEffect(effectID):
	return currentEffects.has(effectID) && currentEffects[effectID] > 0

func doAction(actionID):	
	var action = allActions[actionID]
	lastText = RNG.pick(action["messages"])
	
	if(!isBot && action.has("animation")):
		lastAnimation = action["animation"]
	
	var noturnuse = (action.has("noturnusage") && action["noturnusage"])
	
	if(action.has("changestate")):
		state = action["changestate"]
	
	if(action.has("air")):
		var addAir = action["air"]
		
		air += addAir
		if(air >= 5):
			#shouldSafeWord = true
			shouldEndUnconscious = true
			return
	elif(air > 0 && (!action.has("noturnusage") || !action["noturnusage"])):
		air -= 1
	
	if(action.has("pain")):
		var addPain = action["pain"]
		#if(addPain > 0):
		for effectID in currentEffects:
			addPain = statusEffectHandleAddPain(effectID, addPain)
			#if(hasEffect("shock")):
			#	addPain *= 0.5
		
		pain += addPain
		if(addPain > 0 && pain > targetPain && !isBot):
			if(!hasEffect("highpain")):
				currentEffects["highpain"] = 2
			else:
				shouldSafeWord = true
				return
	if(pain < 0):
		pain = 0
	
	doSpecialEffect(actionID)
	
	if(hasEffect("highpain") && pain > targetPain):
		currentEffects["highpain"] = 2
	
	if(!noturnuse):
		for effectID in currentEffects.keys():
			currentEffects[effectID] -= 1
			if(currentEffects[effectID] <= 0):
				currentEffects.erase(effectID)
	
	if(action.has("effects")):
		for effect in action["effects"]:
			if(currentEffects.has(effect[0]) && currentEffects[effect[0]] > effect[1]):
				continue
			currentEffects[effect[0]] = effect[1]

	if(!noturnuse):
		actionsLeft -= 1

	if(abs(pain-targetPain) <= 0.1 && !isBot):
		shouldEndSuccess = true
		return
	
	if(!noturnuse):
		if(!isBot):
			if(actionsLeft <= 0):
				shouldEndFail = true
				return
		
func getAnimation():
	var result = lastAnimation.duplicate(true)
	var npcData = result[2]
	if(!npcData.has("npcBodyState")):
		npcData["npcBodyState"] = {}
	npcData["npcBodyState"]["naked"] = currentDifficulty["isNaked"]
	return result

func getLastText():
	return lastText

func getAllDifficulties():
	return {
		0: {
			name = "Легкие шлепки",
			actions = ["wait", "lightspank"],
			amountOfActions = 3,
			winID = "firstspanks",
			introText = "Вы готовитесь слегка отшлепать Тави.",
			isNaked = false,
			defaultAnimation = [StageScene.Duo, "stand", {npc="tavi"}],
			avoidTargets = [],
		},
		1: {
			name = "Злобные шлепки",
			actions = ["wait", "lightspank", "heavyspank"],
			amountOfActions = 5,
			winID = "firmspanks",
			introText = "Вы говорите Тави, что хотите поэкспериментировать и шлепать её сильнее.",
			isNaked = false,
			defaultAnimation = [StageScene.Duo, "stand", {npc="tavi"}],
			avoidTargets = [3, 5, 10, 15, 20, 6, 9, 14],
		},
		2: {
			name = "Удушение",
			actions = ["wait", "heavyspank", "startchoke"],
			amountOfActions = 4,
			winID = "afterchoking",
			introText = "Вы говорите Тави, что хотите попробовать игры с дыханием. Главное — не дать ей отключиться.",
			isNaked = true,
			defaultAnimation = [StageScene.Duo, "stand", {npc="tavi"}],
			avoidTargets = [3, 6, 9, 12, 15, 10, 15, 20, 22, 14],
		},
		3: {
			name = "Температурные игры",
			actions = ["wait", "lightspank", "pourvax", "ice"],
			amountOfActions = 5,
			winID = "afterwax",
			introText = "Вы находите восковые свечи и кубики льда, а затем говорите Тави, что хотите поэкспериментировать с температурными играми. Она кивает и раздевается для вас.",
			isNaked = true,
			defaultAnimation = [StageScene.Duo, "stand", {npc="tavi"}],
			avoidTargets = [3, 6, 9, 12, 5, 15, 25, 35],
		},
		4: {
			name = "Всё",
			actions = ["wait", "lightspank", "heavyspank", "startchoke", "pourvax", "ice"],
			amountOfActions = 4,
			winID = "finalcum",
			introText = "Вы говорите Тави, что пришло время для финального испытания. Вы задействуете против неё весь свой арсенал.",
			isNaked = true,
			defaultAnimation = [StageScene.Duo, "stand", {npc="tavi"}],
			avoidTargets = [3, 6, 9, 12, 5, 10, 20, 30, 15, 25, 35, 40, 50, 45, 55, 23],
		},
	}

func getDifficultyAmount():
	return getAllDifficulties().keys().size()

func getAllActions():
	return {
		"wait": {
			name = "Подождать",
			desc = "Дать Тави отдохнуть один ход. Убирает 1 единицу боли",
			shortdesc = "-1 Pain",
			pain = -1,
			cantBeFirstAction = true,
			cantBeLastAction = true,
			animation = [StageScene.Spanking, "tease", {npc="tavi"}],
			messages = [
				"Вы даете Тави секунду передохнуть. Она немного приходит в себя.",
			],
		},
		"lightspank": {
			name = "Шлепать слегка",
			#desc = "Deliver a soft spank on Tavi's rear, adding 7 pain",
			shortdesc = "+3 Pain",
			pain = 3,
			animation = [StageScene.Spanking, "spank", {npc="tavi"}],
			messages = [
				"У Тави перехватывает дыхание, когда ваша ладонь встречается с её задницей.",
				"Вы нежно шлепаете Тави, отчего её ягодицы слегка розовеют.",
				"Ваша рука мягко хлопает Тави по заднице, заставляя её ягодицы колыхаться.",
				"Тави тихонько мяукает, когда твоя ладонь опускается на её пушистую попку и отвешивает шлепок.",
			],
		},
		"heavyspank": {
			name = "Шлепать ощутимо",
			#desc = "Deliver a firm spank on Tavi's rear, adding 10 pain",
			shortdesc = "+10 Pain",
			pain = 10,
			effects = [
				["numb", 2],
			],
			animation = [StageScene.Spanking, "fast", {npc="tavi"}],
			messages = [
				"Тави ахает от прикосновения твоей руки; жжение резкое, но следующий удар будет уже не таким чувствительным.",
				"Твердый шлепок по заднице Тави заставляет её судорожно вздохнуть; за жжением следует мимолетный прилив стойкости к этому ощущению.",
				"Твоя ладонь легко хлопает Тави по заду, и это ощущение смешивается с едва заметным ростом её болевого порога.",
				"Тави ахает, когда твоя рука касается её попы, отчего её ягодицы становятся похожи на два зеленых яблока.",
			],
		},
		"startchoke": {
			name = "Начать душить",
			desc = "Начать душить Тави, нанося 3 единицы боли каждый ход, пока вы не остановитесь или она не потеряет сознание",
			shortdesc = "+3-12 Pain",
			pain = 3,
			air = 1,
			changestate = "choking",
			previousCantBe = ["stopchoking"],
			animation = [StageScene.Choking, "idle", {npc="tavi"}],
			noturnusage = true,
			messages = [
				"Тави ахает, когда ты обхватываешь её горло и начинаешь слегка душить.",
			],
		},
		"choke": {
			name = "Сжимай сильнее",
			desc = "Продолжать душить Тави",
			shortdesc = "+3 Pain",
			pain = 3,
			air = 1,
			state = "choking",
			animation = [StageScene.Choking, "choke", {npc="tavi"}],
			noturnusage = true,
			messages = [
				"Тави извивается и издает беззвучные вздохи, пока ты продолжаешь её душить.",
				"Чем сильнее ты её душишь, тем больше Тави теряет силы... но при этом она кажется всё более возбужденной.",
				"Тави ерзает и прижимает свои лапки к твоим рукам... но это не мешает тебе душить её.",
				"Кошечка держит рот открытым, высунув язык и пуская слюни, пока ты душишь её.",
			],
		},
		"stopchoking": {
			air = 0,
			name = "Стой",
			desc = "Дать Тави вздохнуть",
			shortdesc = "Перестать душить",
			changestate = "",
			state = "choking",
			animation = [StageScene.Choking, "idle", {npc="tavi"}],
			previousCantBe = ["startchoke"],
			messages = [
				"Когда ты перестаешь душить Тави, она жадно хватает ртом воздух.",
			],
		},
		"pourvax": {
			name = "Лить воск",
			#desc = "Deliver a firm spank on Tavi's rear, adding 10 pain",
			shortdesc = "+5 Pain",
			pain = 5,
			effects = [
				["wax", 2],
			],
			animation = [StageScene.SexStart, "start", {npc="tavi"}],
			messages = [
				"От ощущения теплого воска, стекающего по телу Тави, она начинает активно ерзать и стонать.",
				"Тави издает тихий звук, когда воск касается ее внутренней стороны бедра — это ощущение вызывает у нее смесь любопытства и беспокойства.",
				"Тави издает милый стон, когда ты наклоняешь свечу так, чтобы воск капнул ей на промежность.",
				"Тихий всхлип срывается с губ Тави, когда тепло воска касается ее киски; это ощущение — смесь дискомфорта и интриги.",
			],
		},
		"ice": {
			name = "Лед",
			#desc = "Deliver a firm spank on Tavi's rear, adding 10 pain",
			shortdesc = "Уменьшает текущую боль вдвое",
			pain = 0,
			effects = [
			],
			animation = [StageScene.SexStart, "start", {npc="tavi"}],
			cantBeFirstAction = true,
			messages = [
				"Кубик льда, упавший на спину Тави, заставляет ее ахнуть и активно заерзать.",
				"Ты дразняще прижимаешь кубик льда к соску Тави и держишь его, пока тот не начинает таять. Тави закусывает губы и стонет.",
				"Тави издает долгий стон, когда ты на секунду прижимаешь лед к ее чувствительному клитору, прогоняя волну прохлады по всему ее телу.",
				"Твои руки кладут несколько кубиков льда на бедра Тави, и ты удерживаешь ее неподвижно, пока она пытается стряхнуть их, извиваясь.",
			],
		}
	}

func doSpecialEffect(_actionID):
	if(_actionID == "ice"):
		pain = pain * 0.5
	if(_actionID == "pourvax"):
		if(isPlaying):
			GlobalRegistry.getCharacter("tavi").coverBodyWithFluid("HotWax", 0.2)

func getAllStatusEffects():
	return {
		"numb": {
			name = "Онемение",
			desc = "[color=#00CC00]-50% боли при следующих ударах[/color]", #Tavi got caught off-guard but her body quickly prepares for the next strike. 
		},
		"highpain": {
			name = "Сильная боль",
			desc = "Тави переступила порог боли. Еще один удар заставит её произнести [color=red]стоп-слово[/color].",
		},
		"wax": {
			name = "Горячий воск",
			desc = "[color=red]+100% к боли[/color]",
		},
	}

func statusEffectHandleAddPain(statusID, addPain):
	if(statusID == "numb"):
		if(addPain > 0):
			addPain *= 0.5
	if(statusID == "wax"):
		if(addPain > 0):
			addPain *= 2.0
	
	return addPain

func saveData():
	return {
		pain = pain,
		air = air,
		targetPain = targetPain,
		currentEffects = currentEffects,
		avaiableActions = avaiableActions,
		state = state,
		actionsLeft = actionsLeft,
		shouldPlayStateOnWin = shouldPlayStateOnWin,
		currentDifficulty = currentDifficulty,
		lastAnimation = lastAnimation,
		lastText = lastText,
		amountOfTurns = amountOfTurns,
	}

func loadData(_data):
	pain = SAVE.loadVar(_data, "pain", 0)
	air = SAVE.loadVar(_data, "air", 0)
	targetPain = SAVE.loadVar(_data, "targetPain", 0)
	currentEffects = SAVE.loadVar(_data, "currentEffects", {})
	avaiableActions = SAVE.loadVar(_data, "avaiableActions", [])
	state = SAVE.loadVar(_data, "state", "")
	actionsLeft = SAVE.loadVar(_data, "actionsLeft", 0)
	shouldPlayStateOnWin = SAVE.loadVar(_data, "shouldPlayStateOnWin", "")
	currentDifficulty = SAVE.loadVar(_data, "currentDifficulty", {})
	lastAnimation = SAVE.loadVar(_data, "lastAnimation", [])
	lastText = SAVE.loadVar(_data, "lastText", "")
	amountOfTurns = SAVE.loadVar(_data, "amountOfTurns", 5)
