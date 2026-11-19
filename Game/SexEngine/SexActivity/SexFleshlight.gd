extends SexActivityBase

var targetID:String = ""
var targetHole:String = S_ANUS
var npcsWithPortalPanties:Array = []
var shouldCalculateNpcsWithPortalPanties:bool = true

func _init():
	id = "SexFleshlight"
	
	activityName = "Портальный мастурбатор"
	activityDesc = "Используй мастурбатор, чтобы доставить удовольствие сабке!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		#SexGoal.SubUndressSub: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		#SexType.StocksSex: true,
		#SexType.SlutwallSex: true,
	}

func isActivityImpossibleShouldStop() -> bool:
	if(!getSub().hasReachablePenis()):
		return true
	if(targetID != ""):
		var theChar:BaseCharacter = GlobalRegistry.getCharacter(targetID)
		if(!theChar):
			return true
		if(!theChar.hasBodypart(targetHole)):
			return true
	if(getSubInfo().isUnconscious()):
		return true
	return false

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_domInfo.getChar().isPlayer()):
		return false
	
	if(!_domInfo.getChar().getInventory().hasItemID("PortalPantiesFleshlight")):
		return false
	if(!_subInfo.getChar().hasReachablePenis()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.HandsUsed]
		return [SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		if(state != ""):
			return [SexActivityTag.HavingSex, SexActivityTag.PenisUsed, SexActivityTag.PenisInside, SexActivityTag.PreventsSubTeasing]
		return [SexActivityTag.HavingSex]
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.HavingSex]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.HavingSex]

func startActivity(_args):
	addText("{dom.You} {dom.youVerb('whip')} достает портальный мастурбатор и подносит его к {sub.your} {sub.penisShort}!")

func processTurn():
	return

func addTextTarget(_text:String):
	addText(_text.replace("<TARGET>", targetID))

func init_processTurn():
	if(targetID != ""):
		var theChar:BaseCharacter = GlobalRegistry.getCharacter(targetID)
		if(!theChar):
			return
		if(!theChar.hasBodypart(targetHole)):
			return
		addTextTarget("Объект для мастурбации: {<TARGET>.Your} "+getNameHoleGeneric(targetHole)+".")
		getSubInfo().addArousalForeplay(0.1)
		
func sex_processTurn():
	addTextPick([
		"{dom.You} {dom.youAre} ласкает {sub.your} {sub.penisShort} мастурбатором.",
		"{dom.You} {dom.youVerb('slide')} водит мастурбатором по {sub.your} {sub.penisShort}.",
		"{dom.You} {dom.youVerb('pleasure')} {sub.your} {sub.penisShort} мастурбатором.",
	])
	stimulateSex(SUB_0, getTargetIndx(), targetHole, I_NORMAL)
	doProcessFuck(SUB_0, getTargetIndx(), targetHole, " через трусики-порталы")
	doProcessFuckExtra(SUB_0, getTargetIndx(), targetHole)
	if(isReadyToCumHandled(getTargetIndx()) && getTargetIndx() != SUB_0):
		cumGeneric(getTargetIndx(), getTargetIndx(), UniqueOrgasm.PortalSex)
	
	if(RNG.chance(20) && getSexEngine().isInvolved(targetID)):
		var theTargetInfo:= getSexEngine().getCharInfo(targetID)
		if(!theTargetInfo.isUnconscious()):
			addTextTarget(RNG.pick([
				"{<TARGET>.You} {<TARGET>.youVerb('moan')}, пока её трахают дистанционно!",
				"{<TARGET>.You} {<TARGET>.youVerb('squirm')}, пока её трахают дистанционно!",
			]))
			moan(getTargetIndx())
	
	clearTargetIndx()

func inside_processTurn():
	cockWarmer(getTargetIndx(), SUB_0, targetHole)
	clearTargetIndx()

const HOLES_CAN_PORTAL_FUCK = [S_VAGINA, S_ANUS]

func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Прекратить использование мастурбатора", "Убрать мастурбатор")
		
		if(state == ""):
			var theNpcs:Array = getNpcsWithPortalPanties()
			for portalNPC in theNpcs:
				var charName:String = portalNPC.getName()
				for slot in HOLES_CAN_PORTAL_FUCK:
					if(charCanUse(portalNPC, slot)):
						var theHoleName:String = getNameHoleGeneric(slot)
						addAction("setTarget", 0.0, theHoleName, "Цель "+charName+"'s "+theHoleName, {
							A_CATEGORY: ["Объект для мастурбации", charName], A_ARGS: [portalNPC.getID(), slot], A_PRIORITY: 5,
						})
		
			if(isReadyToFuck(SUB_0)):
				addAction("penetrate", 1.0, "Проникнуть", "Попытаться войти членом саба в это отверстие.")
		if(state == "inside"):
			addAction("pullout", getStopScore(), "Вытащить", "Вытащить член саба из этой мастурбатора")
			addAction("fuckmore", 0.5, "Драть сильнее", "Снова начни двигать рукой!")
		if(state == "sex"):
			addAction("pause", 0.0, "Прекратить движения", "Дай сабу немного отдохнуть.")
		
		if(state == "inside" || state == "sex"):
			if(canStuffEggIntoRaw(getSub(), GlobalRegistry.getCharacter(targetID), targetHole)):
				addAction("stuffegg", 0.0, "Засунуть яйцо", "Заставить саба засунуть яйцо в себя..", {A_PRIORITY: 2})
		
	if(_indx == SUB_0):
		addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0)})
		if(isReadyToCumHandled(SUB_0)):
			addAction("subcum", 1.0, "Оргазм!", "Ты сейчас кончишь!", {A_PRIORITY: 1001})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stuffegg"):
		doStuffEggInto(SUB_0, getTargetIndx(), targetHole)
		clearTargetIndx()
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} отстранилась.")
		return 
	if(_id == "pullout"):
		state = ""
		addText("{dom.You} {dom.youVerb('pull')} срывает фаллоимитатор с {sub.your} {sub.penisShort}.")
		return
	if(_id == "fuckmore"):
		state = "sex"
		addText("{dom.You} {dom.youVerb('begin')} снова двигает рукой {dom.yourHis}, скользя фаллоимитатором по {sub.your} {sub.penisShort}.")
		return
	if(_id == "pause"):
		state = "inside"
		addText("{dom.You} {dom.youVerb('pause')} прекращает ласки, давая {sub.you} немного отдохнуть.")
		return
	if(_id == "setTarget"):
		targetID = _action["args"][0]
		targetHole = _action["args"][1]
		
		addTextTarget("{dom.You} {dom.youVerb('pick')} цель! На флешлайте открывается портал, открывающий вид на {<TARGET>.your} "+getNameHoleGeneric(targetHole)+".")
		if(targetID == getDomOrSubID(DOM_0)):
			talkText(DOM_0, RNG.pick([
				"Надеюсь, этот тебе понравится.",
				"Видишь? Это мой "+getNameHole(DOM_0, targetHole)+".",
				"Хочешь меня оттрахать? Теперь можешь.",
				"Тебе нравится этот? Он мой.",
				"Это, "+getNameHole(DOM_0, targetHole)+" кстати, мой.",
			]))
		elif(targetID == getDomOrSubID(SUB_0)):
			talkText(DOM_0, RNG.pick([
				"Выглядит знакомо? Так и должно быть.",
				"Думаешь, справишься?",
				"Я вижу твой "+getNameHole(SUB_0, targetHole)+" clench.",
				"Нравится этот? Вообще-то, он твой.",
				"Это, "+getNameHole(SUB_0, targetHole)+" кстати, твой.",
			]))
		else:
			talkText(DOM_0, RNG.pick([
				"Интересно, узнаешь ли ты их.",
				"Сможешь узнать кого-то только по дыркам?",
				"Готов почувствовать их на своем члене?",
				"Готов трахнуть кого-нибудь другого?",
			]))
		return
	if(_id == "penetrate"):
		if(tryPenetrate(SUB_0, getTargetIndx(), targetHole)):
			state = "sex"
		clearTargetIndx()
		return
	
	if(_id == "subcum"):
		cumInside(SUB_0, getTargetIndx(), targetHole)
		clearTargetIndx()
		state = "inside"
		return
		
	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		#if(pullAway(SUB_0, DOM_0, chance)):
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
	if(state == "inside"):
		return [StageScene.SexFleshlight, "inside", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
	if(state == "sex"):
		if(isCloseToCumming(SUB_0) || isCloseToCumming(DOM_0)):
			return [StageScene.SexFleshlight, "fast", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
		return [StageScene.SexFleshlight, "sex", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
	return [StageScene.SexFleshlight, "tease", {pc=SUB_0, npc=DOM_0}]

func getAnimationPriority():
	return 10

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 10
	if(_indx == SUB_1):
		return 10
	if(_indx == DOM_0 && targetID == getDomID()):
		return 10
	return -1

func calculateNpcsWithPortalPanties() -> Array:
	return GM.main.calculateNpcsWithPortalPanties()

func getNpcsWithPortalPanties() -> Array:
	if(!shouldCalculateNpcsWithPortalPanties):
		return npcsWithPortalPanties
	shouldCalculateNpcsWithPortalPanties = false
	npcsWithPortalPanties = calculateNpcsWithPortalPanties()
	return npcsWithPortalPanties

func charCanUseVagina(character) -> bool:
	return character.canUseVaginaThroughPortal()

func charCanUseAnus(character) -> bool:
	return character.canUseAnusThroughPortal()

func charCanUse(character, slot:String) -> bool:
	if(slot == S_VAGINA):
		return charCanUseVagina(character)
	if(slot == S_ANUS):
		return charCanUseAnus(character)
	return false

func getExtraInvolvedCharIDs() -> Array:
	if(targetID != ""):
		return [targetID]
	return []

# Temporarily adds the target as SUB_1 if they aren't participating. Huge hack.
func getTargetIndx() -> int:
	if(targetID == ""):
		assert(false, "Target ID is Empty!")
		return SUB_0
	if(subs.size() > 1):
		return SUB_1
	if(isDom(targetID)):
		return DOM_0
	if(isSub(targetID)):
		return SUB_0
	var tempInfo:SexSubInfo = SexSubInfo.new()
	tempInfo.initInfo(targetID, getSexEngine())
	subs.append(tempInfo)
	return SUB_1

func clearTargetIndx():
	if(subs.size() > 1):
		subs.remove(1)

func saveData():
	var data = .saveData()
	
	data["targetID"] = targetID
	data["targetHole"] = targetHole

	return data
	
func loadData(data):
	.loadData(data)
	
	targetID = SAVE.loadVar(data, "targetID", "")
	targetHole = SAVE.loadVar(data, "targetHole", S_ANUS)
	
	shouldCalculateNpcsWithPortalPanties = true
