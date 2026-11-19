extends SexActivityBase

var teasingTimes:int = 0
var didTeasing:bool = false
var waitTimer:int = 0

func _init():
	id = "SexFeetplay"
	
	activityName = "Футплей"
	activityDesc = "Используй свои ступни, чтобы доставить им удовольствие"
	activityCategory = ["Humiliate"]

func getGoals():
	return {
		SexGoal.DoFeetplay: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.BitchsuitSex: true,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.PreventsSubTeasing, SexActivityTag.PreventsSubViolence, SexActivityTag.HavingSex, SexActivityTag.MouthUsed]
	return []

func startActivity(_args):
	pass

func init_processTurn():
	addText("{dom.You} {dom.youVerb('hold')} {sub.you} прижаты к полу {dom.yourHis} {dom.foot}.")

func onhead_processTurn():
	if(RNG.chance(50)):
		teasingTimes += 1
	stimulate(DOM_0, S_LEGS, SUB_0, S_MOUTH, I_TEASE, Fetish.FeetplayGiving, SPEED_SLOW)
	#affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.0, 0.02, -0.01, -0.005)
	addText("{dom.You} {dom.youVerb('hold')} {dom.yourHis} {dom.foot} на {sub.your} голове.")

func kissingfeet_processTurn():
	addTextPick([
		"{sub.You} {sub.youAre} сосет {dom.your} {dom.foot}!",
		"{sub.You} {sub.youAre} licking {dom.your} {dom.foot}.",
		"{sub.You} {sub.youAre} лижет {dom.your} {dom.foot}, пока тот во рту у {sub.yourHis}.",
		"{sub.You} {sub.youAre} лениво посасывает {dom.your} {dom.toes}, пока они во рту у {sub.yourHis}.",
		"{sub.You} {sub.youAre} просовывает {sub.yourHis} язык между {dom.your} {dom.toes}."
	])
	stimulate(DOM_0, S_LEGS, SUB_0, S_MOUTH, I_TEASE, Fetish.FeetplayGiving)
	#affectDom(getDomInfo().fetishScore({Fetish.FeetplayGiving: 1.0})+0.3, 0.05, -0.01)
	#affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.0, 0.05, -0.05, -0.02)
	#getDomInfo().addArousalForeplay(0.05)
	teasingTimes += 1
	react(SexReaction.FeetplayKissingFeet, [20, 10])

func rubpussy_processTurn():
	stimulateRubWithFoot(DOM_0, SUB_0, S_VAGINA, I_NORMAL, SPEED_SLOW)
	affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.3, 0.1, -0.005, -0.002)
	rubWithFeet(DOM_0, SUB_0, S_VAGINA)
	
	if(isReadyToCum(SUB_0) && !getSubInfo().canDoActions()):
		satisfyGoals()
		getSub().cummedOnBy(getSubID(), FluidSource.Vagina, 0.7)
		addText("У {sub.Your} киснет со всех ног на {sub.yourHis} бедрах, пока {sub.youHe} {sub.youHeVerb('orgasm')} таким унизительным образом!")
		cumOnSelf(SUB_0, DOM_0, UniqueOrgasm.Feet, "", SexReaction.FeetplayCumPussy)
		state = ""
	else:
		react(SexReaction.FeetplayRubbingPussy, [20, 10])

func rubpenis_processTurn():
	stimulateRubWithFoot(DOM_0, SUB_0, S_PENIS, I_NORMAL, SPEED_SLOW)
	affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.3, 0.1, -0.005, -0.002)
	rubWithFeet(DOM_0, SUB_0, S_PENIS)
	
	if(getSubInfo().isReadyToCum() && !getSubInfo().canDoActions()):
		satisfyGoals()
		cumOnSelf(SUB_0, DOM_0, UniqueOrgasm.Feet, " таким унизительным образом", SexReaction.FeetplayCumPenis)
		state = ""
	else:
		react(SexReaction.FeetplayRubbingPenis, [20, 10])

func onheadwaitingforanswer_processTurn():
	var text:String = "{dom.You} {dom.youVerb('hold')} {sub.you} прижаты к полу {dom.yourHis} {dom.foot} в ожидании {sub.youHim}."
	waitTimer += 1
	if(waitTimer > 4):
		state = "onhead"
		text += " {dom.You} перестал ждать."
	elif(waitTimer > 2):
		text += " {dom.You} {dom.youAre} теряет терпение."
		getDomInfo().addAnger(0.1)
	
	if(RNG.chance(50)):
		teasingTimes += 1
	addText(text)

func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state in [""]):
			addAction("stompchest", getDomInfo().getSadisticActionStore(), "Топать", "Топай им по груди!")
		if(state in [""]):
			if(getSexType() == SexType.DefaultSex):
				addAction("pinhead", 1.0 - (float(didTeasing) * 1.0), "Прижать головой", "Прижать их голову ногами")
		if(state in [""]):
			if(getSub().hasReachableVagina()):
				addAction("rubpussy", 0.5, "Тереть киску", "Начни тереть их киску ногами")
		if(state in [""]):
			if(getSub().hasReachablePenis() || getSub().isWearingChastityCage() || getSub().isWearingPenisPump()):
				addAction("rubpenis", 0.5, "Тереть член", "Начни тереть их член ногами")
		if(state in ["", "onhead", "kissingfeet", "rubpussy", "rubpenis", "onheadwaitingforanswer"]):
			addAction("stop", getStopScore(), "Прекратить игры ногами", "Хватит унижений")
		if(state in ["onhead", "kissingfeet", "rubpussy", "rubpenis", "onheadwaitingforanswer"]):
			var pinchestScore:float = (1.0 if (state in ["onhead", "kissingfeet"] && teasingTimes > 5) else 0.0)
			addAction("pinchest", pinchestScore, "Прижать грудь", "Снова прижать грудь")
		if(state in ["onhead"]):
			if(!getSub().isOralBlocked()):
				addAction("asktolick", 0.3, "Приказать лизать", "Приказать им начать сосать твои ступни")
		if(state in ["rubpussy"]):
			addAction("stomppussy", getDomInfo().getSadisticActionStore(), "Втаптывать в киску", "Втаптывать в эту мокрую киску")
		if(state in ["rubpenis"]):
			addAction("stompcock", getDomInfo().getSadisticActionStore(), "Втаптывать в член", "Сделай это по-настоящему больно!")

	if(_indx == SUB_0):
		if(state in ["", "onhead", "kissingfeet", "rubpussy", "rubpenis", "onheadwaitingforanswer"]):
			addAction("breakfree", getResistScore(SUB_0), "Вырваться", "Тебе не захочется оказаться у них под ногами", {A_CHANCE: getSubResistChance(30.0, 25.0)})
		if(state in ["onhead"]):
			if((!getSub().isOralBlocked())):
				addAction("licksoles", getComplyScore(SUB_0)/3.0, "Лизать подошвы", "Лизать их подошвы")
		if(state in ["kissingfeet"]):
			if((!getSub().isBitingBlocked())):
				addAction("bitefeet", getResistScore(SUB_0), "Кусать стопу", "Кусать стопу, которая у тебя во рту", {A_CHANCE: getSubResistChance(50.0, 25.0)})
		if(state in ["rubpussy"]):
			if(isReadyToCumHandled(SUB_0)):
				addAction("cumpussy", 1.0, "Кончай!", "Ты вот-вот кончишь", {A_PRIORITY: 1001})
		if(state in ["rubpenis"]):
			if(isReadyToCumHandled(SUB_0)):
				addAction("cumpenis", 1.0, "Кончай!", "Ты вот-вот кончишь", {A_PRIORITY: 1001})
		if(state in ["onheadwaitingforanswer"]):
			addAction("startsuck", getComplyScore(SUB_0), "Сосать ступни", "Позволить им запихивать свои ноги тебе в рот")

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stompchest"):
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})-0.5, 0.1, -0.05, 0.0)
		affectDom(getDomInfo().fetishScore({Fetish.Sadism: 1.0})+0.5, 0.2, 0.0)
		var howMuchAddPain = RNG.randi_range(10, 20)
		getSubInfo().addPain(howMuchAddPain)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=howMuchAddPain,isDefense=false,intentional=true})
		getDomInfo().addAnger(-0.1)
		getSubInfo().addFear(0.2)
		addTextPick([
			"{dom.You} {dom.youVerb('stomp')} по груди {sub.yourHis} [b]очень сильно[/b].",
			"{dom.You} {dom.youVerb('kick')} по бокам {sub.yourHis} [b]очень сильно[/b]."
		])
		react(SexReaction.FeetplayStompChest, [100.0, 40.0])
		if(RNG.chance(20)):
			doWound(DOM_0, SUB_0)
		return
	if(_id == "pinhead"):
		state = "onhead"
		addText("{dom.You} {dom.youVerb('move')} {dom.yourHis} {dom.foot} к {sub.you} голове!")
		affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})-0.1, 0.03, -0.05, -0.02)
		getDomInfo().addArousalForeplay(0.1)
		affectDom(getDomInfo().fetishScore({Fetish.FeetplayGiving: 1.0})+0.5, 0.1, 0.0)
		didTeasing = true
		return
	if(_id == "pinchest"):
		state = ""
		addText("{dom.You} {dom.youVerb('pin')} {sub.your} груди!")
		return
	if(_id == "rubpussy"):
		state = "rubpussy"
		addText("{dom.You} {dom.youVerb('move')} {dom.yourHis} {dom.foot} к {sub.your} промежности и {dom.youVerb('begin')} трет(ет) {sub.yourHis} киску!")
		getSubInfo().addArousalForeplay(0.05)
		affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.3, 0.1, -0.02, -0.01)
		return
	if(_id == "rubpenis"):
		state = "rubpenis"
		addText("{dom.You} {dom.youVerb('move')} {dom.yourHis} {dom.foot} вниз к {sub.your} промежности и {dom.youVerb('start')} трет(ет) {sub.yourHis} член!")
		getSubInfo().addArousalForeplay(0.05)
		affectSub(getSubInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.3, 0.1, -0.02, -0.01)
		return
	if(_id == "asktolick"):
		addTextPick([
			"{dom.You} {dom.youVerb('order')} {sub.you}, чтобы начать лизать {dom.yourHis} {dom.foot}!",
			"{dom.You} {dom.youVerb('order')} {sub.you}, чтобы начать сосать {dom.yourHis} {dom.foot}!",
			"{dom.You} {dom.youVerb('order')} {sub.you}, чтобы начать воспевать {dom.yourHis} {dom.foot}!"
		])
		state = "onheadwaitingforanswer"
		react(SexReaction.FeetplayAskToKiss, [100.0, 40.0])
		return
	if(_id == "stomppussy"):
		affectDom(getDomInfo().fetishScore({Fetish.Sadism: 1.0})+0.0, 0.1, 0.0)
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})-0.5, 0.1, -0.01, 0.0)
		var howMuchAddPain = RNG.randi_range(13, 25)
		getSubInfo().addPain(howMuchAddPain)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=howMuchAddPain,isDefense=false,intentional=true})
		getDomInfo().addAnger(-0.1)
		getSubInfo().addFear(0.3)
		addTextPick([
			"{dom.You} {dom.youVerb('stomp')} на {sub.yourHis} киску, крепко!",
			"{dom.You} {dom.youVerb('kick')} {sub.yourHis} киску садистски!",
			"{dom.You} {dom.youVerb('stomp')} на {sub.yourHis} киску, крепко, причиняя невыносимую боль!"
		])
		react(SexReaction.FeetplayStompPussy, [100.0, 40.0])
		if(RNG.chance(20)):
			doWound(DOM_0, SUB_0)
		return
	if(_id == "stompcock"):
		affectDom(getDomInfo().fetishScore({Fetish.Sadism: 1.0})+0.0, 0.1, 0.0)
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})-0.5, 0.1, -0.01, 0.0)
		var howMuchAddPain = RNG.randi_range(13, 25)
		getSubInfo().addPain(howMuchAddPain)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=howMuchAddPain,isDefense=false,intentional=true})
		getDomInfo().addAnger(-0.1)
		getSubInfo().addFear(0.3)
		addTextPick([
			"{dom.You} {dom.youVerb('stomp')} на {sub.yourHis} член, крепко сжимая его!",
			"{dom.You} {dom.youVerb('kick')} {sub.yourHis} член с садистским удовольствием!",
			"{dom.You} {dom.youVerb('stomp')} по {sub.yourHis} яйцам, причиняя невыносимую боль!"
		])
		react(SexReaction.FeetplayStompPenis, [100.0, 40.0])
		if(RNG.chance(20)):
			doWound(DOM_0, SUB_0)
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('stop')} прижимает {sub.you} с помощью {dom.yourHis} {dom.foot}.")
		return

	if(_id == "startsuck"):
		addText("{sub.You} {sub.youVerb('open')} {sub.yourHis} рот и начинает сосать {dom.your} {dom.foot}!")
		state = "kissingfeet"
		affectDom(getDomInfo().fetishScore({Fetish.FeetplayReceiving: 1.0})+0.1, 0.1, -0.05)
		reactSub(SexReaction.AgreeGeneric)
		return
	if(_id == "breakfree"):
		var text:String = ""
		if(RNG.chance(getSubResistChance(30.0, 25.0))):
			text += RNG.pick([
				"{sub.You} {sub.youVerb('escape')}, чтобы сбросить захват {dom.your}!",
				"{sub.You} {sub.youVerb('manage')}, чтобы вырваться из захвата {dom.your}!",
				"{sub.You} {sub.youVerb('manage')}, чтобы освободиться от захвата {dom.your}!"
			])
			getDomInfo().addAnger(0.3)
			if(state != ""):
				state = ""
			else:
				endActivity()
		else:
			text += "{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}."
			getDomInfo().addAnger(0.1)
		addText(text)
		reactSub(SexReaction.ActivelyResisting, [50])
		return
	if(_id == "bitefeet"):
		var text:String = ""
		if(RNG.chance(getSubResistChance(50.0, 25.0))):
			state = ""
			text += "{sub.You} {sub.youVerb('manage')}, чтобы больно укусить {dom.your} за {dom.foot}!"
			getDomInfo().addPain(5)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=5,isDefense=true,intentional=true})
			getDomInfo().addAnger(0.3)
			react(SexReaction.PainGeneric)
		else:
			text += "{sub.You} {sub.youVerb('try', 'tries')}, чтобы укусить {dom.yourHis} за {dom.foot}."
			getDomInfo().addAnger(0.1)
		addText(text)
		reactSub(SexReaction.ActivelyResisting, [50])
		return
	if(_id == "licksoles"):
		addTextPick([
			"{sub.You} {sub.youVerb('lick')} {dom.yourHis} подошвы!",
			"{sub.You} {sub.youVerb('drag')} {sub.yourHis} язык скользит по подошвам {dom.yourHis}!",
			"{sub.You} {sub.youVerb('use')} {sub.yourHis} языком боготворит подошвы {dom.yourHis}!"
		])
		affectDom(getDomInfo().fetishScore({Fetish.FeetplayGiving: 1.0})+0.3, 0.1, -0.03)
		getDomInfo().addArousalForeplay(0.04)
		return
	if(_id == "cumpussy"):
		satisfyGoals()
		getSub().cummedOnBy(getSubID(), FluidSource.Vagina, 0.7)
		addText("У {sub.Your} киснет со всех ног на {sub.yourHis} бедрах, пока {sub.youHe} {sub.youHeVerb('orgasm')} таким унизительным образом!")
		cumOnSelf(SUB_0, DOM_0, UniqueOrgasm.Feet, "", SexReaction.FeetplayCumPussy)
		state = ""
		return
	if(_id == "cumpenis"):
		satisfyGoals()
		cumOnSelf(SUB_0, DOM_0, UniqueOrgasm.Feet, " таким унизительным образом", SexReaction.FeetplayCumPenis)
		state = ""
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
	
func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		if(state in ["rubpussy", "rubpenis"]):
			return 10
	return -1

func saveData():
	var data = .saveData()

	data["teasingTimes"] = teasingTimes
	data["didTeasing"] = didTeasing
	data["waitTimer"] = waitTimer

	return data

func loadData(_data):
	.loadData(_data)

	teasingTimes = SAVE.loadVar(_data, "teasingTimes", 0)
	didTeasing = SAVE.loadVar(_data, "didTeasing", false)
	waitTimer = SAVE.loadVar(_data, "waitTimer", 0)

func getAnimation():
	if(getSexType() == SexType.BitchsuitSex):
		if(state in ["rubpussy", "rubpenis"]):
			return [StageScene.PuppyFeetCrotch, "crotch", {pc=DOM_0, npc=SUB_0}]
		return [StageScene.PuppyPinned, "pinned", {pc=DOM_0, npc=SUB_0}]
	
	if(state == ""):
		return [StageScene.SexFeetPlay, "pin", {pc=DOM_0, npc=SUB_0}]
	if(state == "onhead"):
		return [StageScene.SexFeetPlay, "head", {pc=DOM_0, npc=SUB_0}]
	if(state == "kissingfeet"):
		return [StageScene.SexFeetPlay, "head", {pc=DOM_0, npc=SUB_0}]
	if(state == "rubpussy"):
		return [StageScene.SexFeetPlay, "crotch", {pc=DOM_0, npc=SUB_0}]
	if(state == "rubpenis"):
		return [StageScene.SexFeetPlay, "crotch", {pc=DOM_0, npc=SUB_0}]
	if(state == "onheadwaitingforanswer"):
		return [StageScene.SexFeetPlay, "head", {pc=DOM_0, npc=SUB_0}]

func isActivityImpossibleShouldStop() -> bool:
	if(state == "rubpussy"):
		if(!getSub().hasReachableVagina()):
			return true
	if(state == "rubpenis"):
		if(!getSub().hasReachablePenis() && !getSub().isWearingChastityCage() && !getSub().isWearingPenisPump()):
			return true
	return false
