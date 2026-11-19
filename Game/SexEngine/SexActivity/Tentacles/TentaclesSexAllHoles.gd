extends SexActivityBase

var currentPose:String = ""
var isStuffing:bool = false

const POSE_ALLHOLES = "allholes"

const POSES = {
	POSE_ALLHOLES: {
		name = "Все отверстия",
		anim = StageScene.TentaclesSex,
		anims = ["tease", "inside", "sex", "fast"],
	},
}

func getAvaiablePoses() -> Array:
	return [POSE_ALLHOLES]

func _init():
	id = "TentaclesSexAllHoles"
	
	activityName = "Все отверстия"
	activityDesc = "Трахать кишку, задницу и рот сабмиссивной."
	activityCategory = ["Fuck"]


func getGoals():
	return {
		SexGoal.FuckVaginal: 1.0,
		SexGoal.FuckAnal: 1.0,
		SexGoal.FuckOral: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.TentaclesSex: true,
	}

func isActivityImpossibleShouldStop() -> bool:
	#if(!getSub().hasReachableVagina() || !getSub().hasReachableAnus() || getSub().isOralBlocked()):
	#	return true
	return false

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var sub:BaseCharacter = _subInfo.getChar()
	#if(!sub.hasReachableVagina()):
	#	return false
	if(!sub.hasReachableAnus()):
		return false
	if(sub.isOralBlocked()):
		return false
	
	#var dom:BaseCharacter = _domInfo.getChar()
	#if(!dom.hasReachablePenis() && !dom.isWearingStrapon()):
	#	return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.PenisUsed, SexActivityTag.PenisInside]
		return [SexActivityTag.HavingSex, SexActivityTag.PenisUsed]
	if(_indx == SUB_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.AnusUsed, SexActivityTag.AnusPenetrated, SexActivityTag.VaginaUsed, SexActivityTag.VaginaPenetrated, SexActivityTag.MouthUsed]
		return [SexActivityTag.HavingSex, SexActivityTag.AnusUsed, SexActivityTag.VaginaUsed]
	return []

func startActivity(_args):
	currentPose = RNG.pick(getAvaiablePoses())
	
	addText("{dom.You} {dom.youVerb('grab')} {sub.you} и {dom.youVerb('raise')} {sub.youHim} над полом, {dom.yourHis} щупальца вжаты во все {sub.yourHis} отверстия одновременно!")

func onSwitchFrom(_otherActivity, _args):
	currentPose = RNG.pick(getAvaiablePoses())

func processTurn():
	if(state == ""):
		isStuffing = false
	return

func inside_processTurn():
	addTextPick([
		"{sub.You} {sub.youAre} — настоящая щупальцевая шлюха, все {sub.yourHis} дырки забиты ими до отказа.",
		"Все {sub.Your} отверстия плотно забиты щупальцами.",
		"{sub.Your} отверстия согревают щупальца.",
	])
	if(getSub().hasReachableVagina()):
		stimulateSex(DOM_0, SUB_0, S_VAGINA, I_TEASE, SPEED_VERYSLOW)
		stimulateSex(DOM_0, SUB_0, S_ANUS, I_TEASE, SPEED_VERYSLOW)
	else:
		stimulateSex(DOM_0, SUB_0, S_ANUS, I_TEASE, SPEED_SLOW)

func sex_processTurn():
	if(getSub().hasReachableVagina()):
		stimulateSex(DOM_0, SUB_0, S_VAGINA, I_NORMAL, SPEED_VERYSLOW)
		stimulateSex(DOM_0, SUB_0, S_ANUS, I_NORMAL, SPEED_VERYSLOW)
	else:
		stimulateSex(DOM_0, SUB_0, S_ANUS, I_NORMAL, SPEED_SLOW)
	stimulateSex(DOM_0, SUB_0, S_MOUTH, I_NORMAL, SPEED_VERYSLOW)
	
	var possible:Array = [
		"Скользкие щупальца удерживают {sub.you} над полом, беспомощно трахая {sub.yourHis} во все отверстия.",
		"Стекающие со слизью щупальца без остановки вбиваются в жаждущие дырочки {sub.your}.",
		"Поднятая в воздух, {sub.you} {sub.youAre} трахают во все отверстия одни и те же неумолимые влажные отростки.",
		"Три влажных щупальца одновременно вбиваются во все отверстия {sub.your}.",
	]
	
	if(getSub().hasReachableVagina()):
		possible.append_array([
			"Три скользких щупальца в размеренном ритме трахают рот, киску и задницу {sub.your}.",
			"Множество щупалец одновременно забивают рот, киску и задницу {sub.your}.",
			"Скользкие отростки высоко держат {sub.you}, одновременно трахая {sub.yourHis} в рот, киску и задницу.",
		])
	else:
		possible.append_array([
			"Три скользких щупальца трахают рот {sub.your} и двойным ударом забивают {sub.yourHis} задницу.",
			"Множество щупалец одновременно забивают рот и задницу {sub.your}.",
			"Скользкие отростки высоко держат {sub.you}, одновременно трахая {sub.yourHis} в рот и задницу.",
			
		])
	addTextPick(possible)
	
	if(isStuffing):
		stuffTentacleEggRandomHole(SUB_0)
	
	var possibleExtra:Array = []
	if(getSubInfo().isCloseToCumming()):
		possibleExtra.append_array([
			"{sub.YourHis} влажные внутренние стенки сильно сжимаются вокруг неумолимых щупалец.",
			"{sub.YourHis} тело содрогается от нарастающей глубоко внутри волны удовольствия.",
			"{sub.You} {sub.youVerb('try', 'tries')} хочется застонать, но щупальце во {sub.yourHis} рту превращает звук в глухое бульканье.",
			"{sub.YourHis} задница спазматически сжимается, непроизвольно обхватывая скользкий отросток, вбивающийся в неё.",
			"{sub.YourHis} глаза закатываются, когда {sub.youHe} {sub.youHeVerb('feel')} {sub.yourself} подбирается опасно близко.",
		])
		if(getSub().hasReachableVagina()):
			possibleExtra.append_array([
				"Поток {sub.yourHis} собственной смазки обволакивает щупальце, поршнеобразно входящее и выходящее из {sub.yourHis} киски.",
				"Предоргазмические сокращения сжимают {sub.yourHis} киску вокруг вторгающегося отростка.",
			])
	else:
		possibleExtra.append_array([
			"{sub.YourHis} внутренние стенки сжимаются вокруг неумолимых щупалец.",
			"Слезы текут по {sub.yourHis} щекам от интенсивных, глубоких толчков в {sub.yourHis} горло.",
			"Беспомощные всхлипы прорываются сквозь толстое щупальце, трахающее {sub.yourHis} горло.",
		])
		
	if(RNG.chance(possibleExtra.size()*10)):
		addTextPick(possibleExtra)

func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Прекратить секс", "Остановить секс")
		
		if(state == "inside" && !checkActiveDomPC(_indx)):
			var continueScoreFinal:float = 0.0
			if(getSub().hasReachableVagina()):
				continueScoreFinal = min(getContinueSexScore(_indx, SUB_0, S_ANUS), getContinueSexScore(_indx, SUB_0, S_VAGINA))
			else:
				continueScoreFinal = getContinueSexScore(_indx, SUB_0, S_ANUS)
			
			addAction("fuckMore", continueScoreFinal-getStopScore(), "Продолжать трахаться", "Снова начать трахать их")
			addAction("pullOut", getStopScore(), "Вытащить", "Вытащить свой член")
		
		if(state == ""):
			addAction("rub", 1.0 if !isReadyToPenetrate(_indx) else 0.4, "Тереть", "Потри свой член об них", {A_PRIORITY: 4})
			if(hasBodypartUncovered(SUB_0, S_VAGINA) && hasBodypartUncovered(SUB_0, S_ANUS) && !getSub().isOralBlocked() && !checkActiveDomPC(_indx)):
				addAction("penetrate", 1.0, "Проникнуть", "Попробовать снова начать трахать их!", {A_PRIORITY: 5})
		if(state == "sex" && !checkActiveDomPC(_indx)):
			var pauseScoreFinal:float = 0.0
			if(getSub().hasReachableVagina()):
				pauseScoreFinal = max(getPauseSexScore(_indx, SUB_0, S_ANUS), getPauseSexScore(_indx, SUB_0, S_VAGINA))
			else:
				pauseScoreFinal = getPauseSexScore(_indx, SUB_0, S_ANUS)
			addAction("pause", pauseScoreFinal, "Замедлиться", "Притормози, блядь,", {A_PRIORITY: 1})
			
			if(isStuffing):
				addAction("stopStuff", 0.0, "Хватит запихивать яйца", "Довольно пихать яйца в сабку!")
			else:
				var theStartScore:float = getDomInfo().getArousal()*fetish(DOM_0, Fetish.Breeding)
				if(theStartScore < 0.4):
					theStartScore = 0.0
				addAction("startStuff", theStartScore, "Начать запихивать яйца", "Начни заталкивать яйца в дырки сабмиссивной!")
			
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
			addAction("switchpose", 0.0, poseName, "Сменить позу", {A_CATEGORY: ["Сменить позу"], A_ARGS: [pose]})
		
		
	if(_indx == SUB_0):
		addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0), A_PRIORITY: 2})
		if(state == "sex"):
			if(isReadyToCumHandled(SUB_0)):
				addAction("subcum", 1.0, "Кончай!", "Ты сейчас кончишь!", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "startStuff"):
		isStuffing = true
		addText("Щупальца начали заталкивать яйца в {sub.your} отверстия!")
	if(_id == "stopStuff"):
		isStuffing = false
		addText("Щупальца перестали заталкивать яйца в {sub.your} отверстия.")
	
	
	if(_id == "cum"):
		isStuffing = false
		if(getSub().hasReachableVagina()):
			stimulate(DOM_0, S_PENIS, SUB_0, S_VAGINA, I_NORMAL, Fetish.VaginalSexGiving)
		stimulate(DOM_0, S_PENIS, SUB_0, S_ANUS, I_NORMAL, Fetish.AnalSexGiving)
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
			var hasEggs:bool = theSub.hasEggsIn(BodypartSlot.Vagina, true) || theSub.hasEggsIn(BodypartSlot.Anus, true) || theSub.hasEggsIn(BodypartSlot.Head, true)
			if(getSub().hasReachableVagina()):
				getDom().fillBalls(RNG.randf_range(0.9, 1.0))
				cumInsideNoText(DOM_0, SUB_0, S_VAGINA)
				possible.append_array([
					"Скользкие кончики раздуваются внутри рта, киски и задницы {sub.your}, а затем начинают пульсировать, впрыскивая густую {dom.cum} глубоко во все отверстия {sub.yourHis} одновременно"+(", [b]оплодотворяя икринки[/b]" if hasEggs else "")+".",
					"Щупальца дергаются и пульсируют, а затем извергаются. Поток липкой {dom.cum} бьет в глотку {sub.your}. Еще одна порция заливает киску {sub.yourHis}, теплую и густую. Третья забивает задницу {sub.yourHis}, наполняя ее до краев."+(" [b]Нектар помогает оплодотворить яйца[/b]." if hasEggs else "")+"",
					"Все щупальца извергаются разом. Горячая {dom.cum} стекает по глотке {sub.your}, впрыскивается в матку {sub.yourHis} и заливает {sub.yourHis} {sub.analStretch} задницу."+(" [b]Нектар помогает оплодотворить яйца[/b]." if hasEggs else "")+"",
				])
			else:
				possible.append_array([
					"Скользкие кончики раздуваются внутри рта и задницы {sub.your}, а затем начинают пульсировать, впрыскивая густую {dom.cum} глубоко во все отверстия {sub.yourHis} одновременно"+(", [b]оплодотворяя икринки[/b]" if hasEggs else "")+".",
					"Щупальца дергаются и пульсируют, а затем извергаются. Поток липкой {dom.cum} бьет в глотку {sub.your}, в то время как другая порция заливает задницу {sub.yourHis}, наполняя ее до краев."+(" [b]Нектар помогает оплодотворить яйца[/b]." if hasEggs else "")+"",
					"Все щупальца извергаются разом. Горячая {dom.cum} стекает по глотке {sub.your} и впрыскивается в {sub.yourHis} {sub.analStretch} задницу, набивая ее до отказа."+(" [b]Нектар помогает оплодотворить яйца[/b]." if hasEggs else "")+"",
				])
			getDom().fillBalls(RNG.randf_range(0.9, 1.0))
			cumInsideNoText(DOM_0, SUB_0, S_ANUS)
			getDom().fillBalls(RNG.randf_range(0.9, 1.0))
			cumInsideNoText(DOM_0, SUB_0, S_MOUTH)
			getDom().fillBalls(RNG.randf_range(0.9, 1.0))
			getSub().cummedOnBy(getDomID(), FluidSource.Penis)
			
			addTextPick(possible)
		satisfyGoals()
		state = "inside"
		return
	if(_id == "fuckMore"):
		addText("Щупальца снова начинают трахать {sub.you}!")
		state = "sex"
		return
	if(_id == "pause"):
		addTextTopBottom("{<TOP>.You} {<TOP>.youVerb('pause')} процесс.", _indx, SUB_0)
		state = "inside"
		return
	if(_id == "pullOut"):
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourHis} щупальца снаружи.")
		state = ""
		return
	if(_id == "rub"):
		addText("{dom.You} {dom.youVerb('rub')} {dom.yourHis} щупальца прижаты к {sub.your} отверстиям.")
		if(getSub().hasReachableVagina()):
			stimulateSex(DOM_0, SUB_0, S_VAGINA, I_TEASE, SPEED_VERYSLOW)
		stimulateSex(DOM_0, SUB_0, S_ANUS, I_TEASE, SPEED_VERYSLOW)
		stimulateSex(DOM_0, SUB_0, S_MOUTH, I_TEASE, SPEED_VERYSLOW)
		return
	if(_id == "penetrate"):
		var didPenetrate:bool = RNG.chance(40)
		
		if(getSub().hasReachableVagina()):
			penetration(didPenetrate, DOM_0, SUB_0, S_VAGINA)
		penetration(didPenetrate, DOM_0, SUB_0, S_ANUS)
		
		if(didPenetrate):
			var possible:Array = [
			]
			if(getSub().hasReachableVagina()):
				possible.append_array([
					"Толстый щупалец глубоко врывается в рот {sub.your}. Еще одно заполняет {sub.yourHis} киску. Еще одно вонзается в зад {sub.yourHis}. Все они начинают двигаться.",
					"Три скользких кончика прижимаются к отверстиям {sub.your}. Они входят одновременно, набивая {sub.youHim} до отказа.",
				])
			else:
				possible.append_array([
					"Толстый щупалец глубоко врывается в рот {sub.your}. Еще два заполняют зад {sub.yourHis}. Все они начинают двигаться.",
					"Три скользких кончика прижимаются к отверстиям {sub.your}. Они входят одновременно, набивая {sub.youHim} до отказа.",
				])
			addTextPick(possible)
			state = "sex"
		else:
			var possible:Array = [
				"Щупальца пытаются растянуть отверстия {sub.yourHis} еще шире.",
				"Скользкие кончики щупалец тычутся в узкие отверстия {sub.yourHis}, пытаясь медленно проскользнуть внутрь.",
				"Кончики щупалец кружат вокруг отверстий {sub.your}, прежде чем начать тыкаться, пытаясь протиснуться внутрь.",
			]
			addTextPick(possible)
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('pull')} подается прочь от {sub.you}.")
		return 
	if(_id == "switchpose"):
		#switchedPoseOnce = true
		var newPose:String = _action["args"][0]
		#var isInside:bool = true
		#if(state in [""]):
		#	isInside = false
		
		#if(isInside):
		#	addText(getSwitchPoseTextForPose(newPose))
		#else:
		#	addText(getStartTextForPose(newPose))
		addText("{dom.You} {dom.youVerb('switch', 'switches')} поза!")
		currentPose = newPose
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
	var theSexAnim:String = StageScene.TentaclesSex
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
