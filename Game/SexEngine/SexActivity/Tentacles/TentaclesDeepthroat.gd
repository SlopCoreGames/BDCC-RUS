extends SexActivityBase

var currentPose:String = ""
var isStuffing:bool = false

const POSE_DEEPTHROAT = "deepthroat"
const POSE_GANGBANG = "gangbang"

var fuckHole:String = S_MOUTH
var fuckFetish:String = Fetish.OralSexReceiving
var fuckHoleNames:Array = [
	"throat",
]

const POSES = {
	POSE_DEEPTHROAT: {
		name = "Глубокий минет",
		anim = StageScene.TentaclesDeepthroat,
		anims = ["tease", "inside", "sex", "fast"],
		startText = "{dom.You} {dom.youVerb('bring')} {sub.you} down to {sub.yourHis} knees. One of the tentacles reaches towards {sub.yourHis} lips!",
	},
	POSE_GANGBANG: {
		name = "Гангбанг",
		anim = StageScene.TentaclesGangbang,
		anims = ["tease", "inside", "stroke", "fast"],
		startText = "Many tentacles surround {sub.you}. One of the tentacles reaches towards {sub.yourHis} [b]lips[/b]!",
	},
}

func getAvaiablePoses() -> Array:
	return [POSE_DEEPTHROAT, POSE_GANGBANG]

func _init():
	id = "TentaclesDeepthroat"
	
	activityName = "Глубокий минет"
	activityDesc = "Трахать подчиненную в глотку."
	activityCategory = ["Fuck"]


func getGoals():
	return {
		SexGoal.FuckOral: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.TentaclesSex: true,
	}

func isActivityImpossibleShouldStop() -> bool:
	if(getSub().isOralBlocked()):
		return true
	return false

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var sub:BaseCharacter = _subInfo.getChar()
	if(sub.isOralBlocked()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.PenisUsed, SexActivityTag.PenisInside]
		return [SexActivityTag.HavingSex, SexActivityTag.PenisUsed]
	if(_indx == SUB_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed]
		return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed]
	return []

func startActivity(_args):
	currentPose = RNG.pick(getAvaiablePoses())
	
	var theEntry:Dictionary = POSES[currentPose]
	addText(theEntry["startText"].replace("<HOLE>", RNG.pick(fuckHoleNames)))

func onSwitchFrom(_otherActivity, _args):
	if(_args != null && _args.size() > 0):
		currentPose = _args[0]
		return
	currentPose = RNG.pick(getAvaiablePoses())

func processTurn():
	if(state == ""):
		isStuffing = false
	return

func inside_processTurn():
	addTextPick([
		"{sub.You} {sub.youAre} — настоящая щупальцевая шлюха, {sub.yourHis} "+RNG.pick(fuckHoleNames)+" служит подогревом для щупалец.",
		"{sub.Your} "+RNG.pick(fuckHoleNames)+" разогревает одно из щупалец.",
		"{sub.Your} "+RNG.pick(fuckHoleNames)+" согревает одно из щупалец.",
	])
	stimulateSex(DOM_0, SUB_0, fuckHole, I_TEASE, SPEED_VERYSLOW)

func sex_processTurn():
	stimulateSex(DOM_0, SUB_0, fuckHole, I_NORMAL, SPEED_MEDIUM)
	
	var possible:Array = [
		"{sub.You} {sub.youAre} being held still while a thick, slick tentacle fucks {sub.yourHis} "+RNG.pick(fuckHoleNames)+".",
		"Dripping tentacle pumps into {sub.your} "+RNG.pick(fuckHoleNames)+", again and again.",
		"While forced to sit still, {sub.you} {sub.youAre} being throat-fucked by the same relentless, wet tendril.",
		"A slick, wet tendril pumps into {sub.your} "+RNG.pick(fuckHoleNames)+", again and again.",
		"A slick tendril fucks {sub.your} "+RNG.pick(fuckHoleNames)+", deep and steady.",
		"A slick tendril slides in and out of {sub.your} "+RNG.pick(fuckHoleNames)+", fucking {sub.yourHis} face.",
		"While being held, {sub.your} throat is being fucked deep by a wet, pulsing tentacle.",
	]
	
	addTextPick(possible)
	
	if(isStuffing):
		stuffTentacleEgg(SUB_0, fuckHole)
	
	var possibleExtra:Array = []
	possibleExtra.append_array([
		"{sub.YourHis} eyes get teary.",
		"{sub.YourHis} body shudders and squirms.",
		"The wet inner walls of {sub.yourHis} throat squeeze hard around the relentless tentacles.",
		"{sub.YourHis} "+RNG.pick(fuckHoleNames)+" clenches, involuntarily gripping the slick tendril pumping into it.",
		"{sub.YourHis} throat squeezes around the relentless tentacle.",
		"Every deep penetration makes {sub.yourHis} body squirm and tremble.",
		"Wet sounds fill the air with each swift withdrawal.",
		"Gooey ropes of precum-like secret ooze from the tendril fucking {sub.your} "+RNG.pick(fuckHoleNames)+".",
	])
		
	if(RNG.chance(possibleExtra.size()*10)):
		addTextPick(possibleExtra)

func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Прекратить секс", "Остановить секс")
		
		if(state == "inside" && !checkActiveDomPC(_indx)):
			addAction("fuckMore", getContinueSexScore(_indx, SUB_0, fuckHole)-getStopScore(), "Продолжать трахаться", "Снова начать трахать их")
			addAction("pullOut", getStopScore(), "Вытащить", "Вытащить свой член")
		
		if(state == ""):
			#addAction("rub", 1.0 if !isReadyToPenetrate(_indx) else 0.4, "Rub", "Rub your cock against them", {A_PRIORITY: 4})
			if(hasBodypartUncovered(SUB_0, fuckHole) && !checkActiveDomPC(_indx)):
				addAction("penetrate", 1.0, "Проникнуть", "Попробовать снова начать трахать их!", {A_PRIORITY: 5})
		if(state == "sex" && !checkActiveDomPC(_indx)):
			addAction("pause", getPauseSexScore(_indx, SUB_0, fuckHole), "Замедлиться", "Притормози, блядь,", {A_PRIORITY: 1})
			
			if(isStuffing):
				addAction("stopStuff", 0.0, "Хватит запихивать яйца", "Довольно пихать яйца в сабку!")
			else:
				var theStartScore:float = getDomInfo().getArousal()*fetish(DOM_0, Fetish.Breeding)
				if(theStartScore < 0.4):
					theStartScore = 0.0
				addAction("startStuff", theStartScore, "Начать запихивать яйца", "Начни заталкивать яйца в дырочку сабки!")
			
		if(state == "sex" && isReadyToCumHandled(DOM_0)):
			addAction("cum", 1.0, "Кончить внутрь", "Кончи в них!", {A_PRIORITY: 1001})
			if(isStuffing):
				addAction("donothing", 1.0, "Продолжай пихать", "Продолжай заталкивать яйца в сабку!", {A_PRIORITY: 1001})
		elif(state == "sex" && isReadyToCumHandled(SUB_0) && !canDoActions(SUB_0) && !checkActiveDomPC(_indx)):
			addAction("subcum", 1.0, "Оргазм сабки!", "Они сейчас кончат!", {A_PRIORITY: 1001})
		
		for pose in getAvaiablePoses():
			if(pose == currentPose):
				continue
			if(!POSES.has(pose)):
				continue
			var poseName:String = POSES[pose]["name"]
			addAction("switchpose", 0.0, poseName, "Сменить позу", {A_CATEGORY: ["Switch pose"], A_ARGS: [pose]})
		
		
	if(_indx == SUB_0):
		addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0), A_PRIORITY: 2})
		if(state == ""):
			if(!getSub().isOralBlocked()):
				addAction("openmouth", 0.0, "Открыть рот", "Дай щупальцу войти!", {A_CHANCE: getSubResistChance(30.0, 25.0), A_PRIORITY: 5})
		if(state == "sex"):
			if(isReadyToCumHandled(SUB_0)):
				addAction("subcum", 1.0, "Кончай!", "Ты сейчас кончишь!", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "startStuff"):
		isStuffing = true
		addText("Тентакли начали заталкивать яйца в {sub.your} "+RNG.pick(fuckHoleNames)+"!")
	if(_id == "stopStuff"):
		isStuffing = false
		addText("Тентакли перестали заталкивать яйца в {sub.your} "+RNG.pick(fuckHoleNames)+".")
	
	
	if(_id == "cum"):
		isStuffing = false
		stimulate(DOM_0, S_PENIS, SUB_0, fuckHole, I_NORMAL, fuckFetish)
		var orgAmount:int = 0
		if(isReadyToCumHandled(DOM_0)):
			orgAmount += 1
		if(isReadyToCumHandled(SUB_0)):
			orgAmount += 1
			
		if(orgAmount == 2):
			addText("[b]Двойной оргазм![/b]")
		elif(orgAmount == 3):
			addText("[b]Тройной оргазм![/b]")
		elif(orgAmount == 4):
			addText("[b]Четверной оргазм![/b]")
		if(isReadyToCumHandled(SUB_0)):
			cumGeneric(SUB_0, DOM_0)
		if(isReadyToCumHandled(DOM_0)):
			addText("[b]Тентакли кончают![/b]")
			var possible:Array = [
			]
			var theSub:BaseCharacter = getSub()
			var hasEggs:bool = theSub.hasEggsIn(fuckHole, true)
			getDom().fillBalls(RNG.randf_range(0.9, 1.0))
			cumInsideNoText(DOM_0, SUB_0, fuckHole)
			if(currentPose == POSE_GANGBANG):
				getDom().fillBalls(RNG.randf_range(0.9, 1.0))
				getSub().cummedOnBy(getDomID(), FluidSource.Penis)
			possible.append_array([
				"Slick tip of a tentacle swell inside {sub.your} "+RNG.pick(fuckHoleNames)+", then begin to pulse, pumping thick {dom.cum} deep into {sub.yourHis} belly"+(", [b]fertilizing the eggs[/b]" if hasEggs else "")+"!",
				"The slick tip lodged inside {sub.your} "+RNG.pick(fuckHoleNames)+" swells to a fat knot, then pulses hard. A thick, hot load of {dom.cum} begins to get pumped deep into {sub.yourHis} belly"+(", [b]fertilizing the eggs inside[/b]" if hasEggs else "")+".",
				"The tentacle rams in deep and swells. Thick, gooey {dom.cum} erupts from the tip in a hot wave. Another thick load follows fast, pumping deep into {sub.your} "+RNG.pick(fuckHoleNames)+". The tentacles keep stuffing {sub.youHim} until {sub.youHe} {sub.youAreHeIs} full"+(", [b]fertilizing the eggs inside {sub.yourHis} belly[/b]" if hasEggs else "")+".",
			])
			
			addTextPick(possible)
			if(currentPose == POSE_GANGBANG):
				addTextPick([
					"Остальные тентакли заливают {sub.youHim} своей {dom.cum}!",
				])
			
		satisfyGoals()
		state = "inside"
		return
	if(_id == "fuckMore"):
		addText("Тентакли снова начинают трахать горло {sub.your}!")
		state = "sex"
		return
	if(_id == "pause"):
		addTextTopBottom("{<TOP>.You} {<TOP>.youVerb('pause')} процесс.", _indx, SUB_0)
		state = "inside"
		return
	if(_id == "pullOut"):
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourHis} тентакль наружу.")
		state = ""
		return
	if(_id == "rub"):
		addText("{dom.You} {dom.youVerb('rub')} {dom.yourHis} щупальца прижаты к {sub.your} "+RNG.pick(fuckHoleNames)+".")
		stimulateSex(DOM_0, SUB_0, fuckHole, I_TEASE, SPEED_SLOW)
		return
	if(_id == "openmouth"):
		penetration(true, DOM_0, SUB_0, fuckHole)
		var possible:Array = [
		]
		possible.append_array([
			"{sub.You} {sub.youVerb('open')} {sub.yourHis} mouth, allowing the tentacle to slide deep inside.",
		])
		addTextPick(possible)
		state = "sex"
		getDomInfo().addAnger(-0.1)
		return
	if(_id == "penetrate"):
		var didPenetrate:bool = RNG.chance(60)
		
		penetration(didPenetrate, DOM_0, SUB_0, fuckHole)
		
		if(didPenetrate):
			var possible:Array = [
			]
			possible.append_array([
				"A thick tentacle slips past {sub.your} lips and slides down {sub.yourHis} throat!",
				"A slick tip of a tentacle presses against {sub.your} lips. It finds way past them and proceeds to fill {sub.yourHis} mouth and go down {sub.yourHis} throat.",
			])
			addTextPick(possible)
			state = "sex"
		else:
			var possible:Array = [
				"The tentacle tries to slide into {sub.yourHis} mouth, brushing against {sub.yourHis} lips.",
				"Slick tentacle tip kisses {sub.yourHis} lips, trying to slip past them.",
				"Tentacle tip hovers near {sub.yourHis} mouth, waiting for {sub.youHim} to open {sub.yourHis} mouth.",
			]
			addTextPick(possible)
			getDomInfo().addAnger(0.1)
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('pull')} подается прочь от {sub.you}.")
		return 
	if(_id == "switchpose"):
		var newPose:String = _action["args"][0]
		addText("{dom.You} {dom.youVerb('switch', 'switches')} поза!")
		currentPose = newPose
		var theEntry:Dictionary = POSES[currentPose]
		addText(theEntry["startText"].replace("<HOLE>", RNG.pick(fuckHoleNames)))
		return

	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getSubResistChance(30.0, 25.0)
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
			return
	if(_id == "subcum"):
		cumGeneric(SUB_0, DOM_0)
		return
			
func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.5
	if(getSub().hasBoundArms()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	
	return max(theChance, 5.0)

func getAnimation():
	var theSexAnim:String = StageScene.TentaclesDeepthroat
	var theSexAnims:Array = ["tease", "inside", "sex", "fast"]
	if(POSES.has(currentPose)):
		var thePose:Dictionary = POSES[currentPose]
		theSexAnim = thePose.get("anim", theSexAnim)
		theSexAnims = thePose.get("anims", theSexAnims)
	
	if(state == "inside"):
		return [theSexAnim, theSexAnims[1], {pc=SUB_0}]
	if(state == "sex"):
		if(isCloseToCumming(DOM_0)):
			return [theSexAnim, theSexAnims[3], {pc=SUB_0}]
		return [theSexAnim, theSexAnims[2], {pc=SUB_0}]
	return [theSexAnim, theSexAnims[0], {pc=SUB_0}]
	#return [StageScene.Duo, "stand", {pc=SUB_0, npc=DOM_0, npcAction="stand"}]

func getAnimationPriority():
	return 10

func getOrgasmHandlePriority(_indx:int) -> int:
	return 10

func saveData():
	var data = .saveData()
	
	data["currentPose"] = currentPose
	data["isStuffing"] = isStuffing

	return data
	
func loadData(data):
	.loadData(data)
	
	currentPose = SAVE.loadVar(data, "currentPose", "")
	if(currentPose == ""):
		currentPose = RNG.pick(getAvaiablePoses())
	isStuffing = SAVE.loadVar(data, "isStuffing", false)
