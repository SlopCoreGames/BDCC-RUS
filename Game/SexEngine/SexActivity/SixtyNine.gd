extends SexActivityBase
var cumAmount:int = 0
var domFocus:String = BodypartSlot.Vagina
var subFocus:String = BodypartSlot.Vagina

func _init():
	id = "SixtyNine"
	
	activityName = "69"
	activityDesc = "Доставляйте друг другу удовольствие одновременно!"
	activityCategory = ["Fuck"]

func getGoals():
	return {
		SexGoal.Fuck69: 1.0,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_domInfo.getChar().hasReachableVagina() && !_domInfo.getChar().hasReachablePenis()):
		return false
	if(!_subInfo.getChar().hasReachableVagina() && !_subInfo.getChar().hasReachablePenis()):
		return false
	if(_domInfo.getChar().isOralBlocked()):
		return false
	if(_subInfo.getChar().isOralBlocked()):
		return false
		
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func isActivityImpossibleShouldStop() -> bool:
	if(domFocus == BodypartSlot.Vagina && !getSub().hasReachableVagina()):
		return true
	if(domFocus == BodypartSlot.Penis && !getSub().hasReachablePenis()):
		return true
	if(subFocus == BodypartSlot.Vagina && !getDom().hasReachableVagina()):
		return true
	if(subFocus == BodypartSlot.Penis && !getDom().hasReachablePenis()):
		return true
	return false

func getTags(_indx:int) -> Array:
	if(state == "sex"):
		if(_indx == DOM_0):
			if(subFocus == BodypartSlot.Vagina):
				return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed, SexActivityTag.VaginaUsed]
			if(subFocus == BodypartSlot.Penis):
				return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed, SexActivityTag.PenisUsed, SexActivityTag.PenisInside]
		if(_indx == SUB_0):
			if(domFocus == BodypartSlot.Vagina):
				return [SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing, SexActivityTag.MouthUsed, SexActivityTag.VaginaUsed]
			if(domFocus == BodypartSlot.Penis):
				return [SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing, SexActivityTag.MouthUsed, SexActivityTag.PenisUsed, SexActivityTag.PenisInside]
	
	if(_indx == DOM_0):
		if(subFocus == BodypartSlot.Penis):
			return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed, SexActivityTag.PenisUsed]
		return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed]
	if(_indx == SUB_0):
		if(domFocus == BodypartSlot.Penis):
			return [SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing, SexActivityTag.MouthUsed, SexActivityTag.PenisUsed]
		return [SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing, SexActivityTag.MouthUsed]
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.HavingSex, SexActivityTag.MouthUsed]

func domCanSwitchFocus() -> bool:
	if(getSub().hasReachablePenis() && getSub().hasReachableVagina()):
		return true
	return false

func subCanSwitchFocus() -> bool:
	if(getDom().hasReachablePenis() && getDom().hasReachableVagina()):
		return true
	return false

func startActivity(_args):
	var possibleDomFocus:Array = []
	if(getSub().hasReachablePenis()):
		possibleDomFocus.append(BodypartSlot.Penis)
	if(getSub().hasReachableVagina()):
		possibleDomFocus.append(BodypartSlot.Vagina)
	domFocus = RNG.pick(possibleDomFocus)
	
	var possibleSubFocus:Array = []
	if(getDom().hasReachablePenis()):
		possibleSubFocus.append(BodypartSlot.Penis)
	if(getDom().hasReachableVagina()):
		possibleSubFocus.append(BodypartSlot.Vagina)
	subFocus = RNG.pick(possibleSubFocus)
	
	var domPartNameStr:String = "{dom.pussyStretch} pussy" if subFocus == BodypartSlot.Vagina else "{dom.penis}"
	if(getDom().getFirstItemThatCoversBodypart(subFocus) != null):
		domPartNameStr = "прикрыты "+domPartNameStr
	
	var subPartNameStr:String = "{sub.pussyStretch} pussy" if domFocus == BodypartSlot.Vagina else "{sub.penis}"
	if(getSub().getFirstItemThatCoversBodypart(domFocus) != null):
		subPartNameStr = "clothed "+subPartNameStr
		
	affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.2, -0.01)
	affectDom(getDomInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.1, -0.03)
	
	addText("{dom.You} {dom.youVerb('position')} {dom.yourself} above {sub.you}, {dom.yourHis} "+domPartNameStr+" соблазнительно зависает над губами {sub.yourHis}, пока рот {dom.yourHis} идеально совпадает с {sub.yourHis} "+subPartNameStr+".")
	return

func onSwitchFrom(_otherActivity, _args):
	return

func order_processTurn():
	if(getSubInfo().isUnconscious()):
		state = ""

func sex_processTurn():
	if(domFocus == BodypartSlot.Vagina && !getSub().hasReachableVagina()):
		state = ""
		satisfyGoals()
		addText("киска {sub.Your} стала недосягаемой, поэтому {dom.you} {dom.youVerb('stop')} лижет её.")
		return
	if(domFocus == BodypartSlot.Penis && !getSub().hasReachablePenis()):
		state = ""
		satisfyGoals()
		addText("член {sub.Your} стал недосягаемым, поэтому {dom.you} {dom.youVerb('stop')} сосет его.")
		return
	if(subFocus == BodypartSlot.Vagina && !getDom().hasReachableVagina()):
		state = ""
		satisfyGoals()
		addText("киска {dom.Your} стала недосягаемой, поэтому {sub.you} {sub.youAre} не может продолжать лизать её.")
		return
	if(subFocus == BodypartSlot.Penis && !getDom().hasReachablePenis()):
		state = ""
		satisfyGoals()
		addText("член {dom.Your} стал недосягаемым, поэтому {sub.you} {sub.youAre} не может продолжать сосать его.")
		return
		
	if(RNG.chance(50)):
		if(subFocus == BodypartSlot.Penis):
			doBlowjobTurnDom()
		else:
			doPussyLickingTurnDom()
			react(SexReaction.DomsPussyGetsLicked, [10.0, 10.0])
		if(domFocus == BodypartSlot.Penis):
			doBlowjobTurnSub()
		else:
			doPussyLickingTurnSub()
		return
	
	if(domFocus == BodypartSlot.Penis):
		doBlowjobTurnSub()
	else:
		doPussyLickingTurnSub()
	if(subFocus == BodypartSlot.Penis):
		doBlowjobTurnDom()
	else:
		doPussyLickingTurnDom()
		react(SexReaction.DomsPussyGetsLicked, [10.0, 10.0])


func getActions(_indx:int):
	if(_indx == DOM_0):
		if(domCanSwitchFocus()):
			addAction("switch", 0.05, "Сменить фокус", "Переключиться на другие части тела")
		addAction("stop", getStopScore(), "Прекратить 69", "Хватит лизать и сосать")
	if(_indx == SUB_0):
		addAction("pullaway", getSubInfo().getResistScore(), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(30.0, 25.0)})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "switch"):
		if(domFocus == BodypartSlot.Penis):
			domFocus = BodypartSlot.Vagina
		else:
			domFocus = BodypartSlot.Penis
		addText("{dom.You} {dom.youVerb('switch', 'switches')} {dom.yourHis} сосредоточились на {sub.your} "+("{sub.penis}" if domFocus == BodypartSlot.Penis else "{sub.pussyStretch} pussy")+".")
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourHis} отстранили пах от лица {sub.your}, прекращая веселье.")
		return

	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var successChance:float = getSubResistChance(30.0, 25.0)
		if(RNG.chance(successChance)):
			getDomInfo().addAnger(0.3)
			if(state != ""):
				state = ""
			else:
				failGoals()
				endActivity()
			addText("{sub.You} {sub.youVerb('pull')} от {dom.you}.")
			return
		else:
			getDomInfo().addAnger(0.1)
			addText("{sub.You} {sub.youVerb('try', 'tries')} попытаться отстраниться от {dom.you}, но {sub.youVerb('fail')}.")
			reactSub(SexReaction.ActivelyResisting, [50])
			return

	
func init_getActions(_indx:int):
	if(_indx == DOM_0):
		var isSubUncon:bool = getSubInfo().isUnconscious()
		
		if(getSub().getFirstItemThatCoversBodypart(domFocus) == null):
			if(getDom().hasReachableVagina() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null):
				if(!isSubUncon):
					addAction("orderlick", 1.0 - getDomInfo().getAngerScore(), "Приказать лизать", "Приказать им начать лизать твою киску!")
				var forcelickScore:float = getDomInfo().getAngerScore() if !isSubUncon else 1.0
				addAction("forcelick", forcelickScore, "Заставить лизать", "Заставить подчиненную начать отсасывать тебе!", {A_CHANCE: getDomForceChance()})

			if(getDom().hasReachablePenis() && getDom().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
				if(!isSubUncon):
					addAction("ordersuck", 1.0 - getDomInfo().getAngerScore(), "Приказать сосать", "Приказать им начать сосать твой член!")
				var forcesuckScore:float = getDomInfo().getAngerScore() if !isSubUncon else 1.0
				addAction("forcesuck", forcesuckScore, "Заставить сосать", "Заставить подчиненную начать отсасывать тебе!", {A_CHANCE: getDomForceChance()})

func init_doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "orderlick"):
		state = "order"
		subFocus = BodypartSlot.Vagina
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.4, 0.0)
		addText("{dom.You} {dom.youVerb('order')} {sub.youHim} to "+RNG.pick(["начать лизать {dom.yourHis} киску", "высунуть {sub.yourHis} язык и приняться за {dom.yourHis} киску"])+".")
		react(SexReaction.OrderLickPussy)
		return
	if(_id == "ordersuck"):
		state = "order"
		subFocus = BodypartSlot.Penis
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.4, 0.0)
		addText("{dom.You} {dom.youVerb('order')} {sub.youHim} to "+RNG.pick(["открыть {sub.yourHis} рот", "раздвинуть {sub.yourHis} губы"])+".")
		react(SexReaction.OrderBlowjob)
		return
	if(_id in ["forcelick", "forcesuck"]):
		var succChance:float = getDomForceChance()
		if(_id == "forcelick"):
			subFocus = BodypartSlot.Vagina
		if(_id == "forcesuck"):
			subFocus = BodypartSlot.Penis
		
		if(!RNG.chance(succChance)):
			getDomInfo().addAnger(0.05)
			affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.2, 0.0)
			addText("{dom.You} {dom.youVerb('try', 'tries')} заставляет {sub.you} "+("начать лизать {dom.yourHis} киску" if subFocus == BodypartSlot.Vagina else "начать сосать {dom.yourHis} член")+" but {dom.youVerb('fail')}.")
			if(domFocus == BodypartSlot.Penis):
				react(SexReaction.TryForceSuckPenis, [40.0, 20.0])
			else:
				react(SexReaction.TryForceLickPussy, [40.0, 20.0])
			return
		
		state = "sex"
		var text:String = ""
		
		if(domFocus == BodypartSlot.Penis):
			sendSexEvent(SexEvent.HolePenetrated, SUB_0, DOM_0, {hole=BodypartSlot.Head,engulfed=true,strapon=isWearingStrapon(SUB_0)})
			
			text += RNG.pick([
				"{dom.You} {dom.youVerb('take')} {sub.yourHis} {penis} в {dom.yourHis} рот, {dom.yourHis} губы скользят вдоль его длины.",
				"{dom.You} {dom.youVerb('wrap')} {dom.yourHis} губами вокруг {sub.yourHis} {penis}, {dom.yourHis} язык дразнит чувствительный кончик, пока {dom.youHe} {dom.youHeVerb('bob')} {dom.yourHis} голову вверх и вниз.",
			])
		else:
			text += RNG.pick([
				"{dom.You} {dom.youVerb('lean')} вниз, прижимая {dom.yourHis} язык к {sub.yourHis} {pussy} медленными, размеренными движениями.",
				"{dom.You} {dom.youVerb('bury', 'buries')} {dom.yourHis} лицом между {sub.yourHis} ног, исследуя языком каждый дюйм {sub.yourHis} киски.",
			])
		
		text += " "
		if(subFocus == BodypartSlot.Penis):
			sendSexEvent(SexEvent.HolePenetrated, DOM_0, SUB_0, {hole=BodypartSlot.Head,engulfed=false,strapon=isWearingStrapon(DOM_0)})
			
			text += RNG.pick([
				"Без предупреждения, {dom.you} {dom.youVerb('shift')} {dom.yourHis} бедра, совмещая {dom.yourHis} {dom.penis} со {sub.yourHis} губами. Резким толчком {dom.youHe} {dom.youHeVerb('part')} {sub.yourHis} рот, заставляя {sub.youHim} ответить тем же и взять {dom.youHim}.",
				"{dom.You} {dom.youVerb('move')} {dom.yourHis} бедра вперед, направляя {dom.yourHis} {dom.penis} к {sub.yourHis} губам. {dom.YouHe} {dom.youHeVerb('push', 'pushes')} настойчиво, не оставляя {sub.youHim} выбора, кроме как принять {dom.youHim} в ответ.",
			])
		else:
			text += RNG.pick([
				"Без малейших колебаний, {dom.you} {dom.youVerb('shift')} {dom.yourHis} весом и {dom.youVerb('lower')} {dom.yourself} на {sub.yourHis} лицо, заглушая любые протесты {dom.yourHis} {dom.pussyStretch} киской и заставляя {sub.youHim} начать лизать.",
				"В то же время, {dom.you} {dom.youVerb('lower')} {dom.yourself}, плотно прижимая {dom.yourHis} {dom.pussyStretch} киску к {sub.yourHis} рту, заставляя {sub.youHim} начать отвечать взаимностью.",
			])
		getDomInfo().addAnger(-0.1)
		affectSub(getSubInfo().fetishScore({Fetish.OralSexGiving: 1.0}), 0.05, -0.2, 0.0)
		
		addText(text)
		return

func order_getActions(_indx:int):
	if(_indx == SUB_0):
		addAction("obey", getSubInfo().getComplyScore(), "Повиноваться", "Начать "+("sucking" if subFocus == BodypartSlot.Penis else "licking"), {A_PRIORITY: 1001})
		var refuseScore:float = getSubInfo().getResistScore()*((1.0+getSubInfo().personalityScore({PersonalityStat.Mean:-1.0})) if !getSub().isBitingBlocked() else 1.0)
		addAction("refuse", refuseScore, "Отказаться", "Отказаться это делать", {A_PRIORITY: 1001})
		if(!getSub().isBitingBlocked()):
			var biteScore:float = getSubInfo().getResistScore()/2.0*(1.0+getSubInfo().personalityScore({PersonalityStat.Mean:1.0}))
			addAction("bite", biteScore, "Кусь!", "Отказаться это делать", {A_PRIORITY: 1001, A_CHANCE: getSubBiteChance(50.0, 30.0)})

func order_doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "obey"):
		state = "sex"
		var text:String = ""
		if(subFocus == BodypartSlot.Penis):
			sendSexEvent(SexEvent.HolePenetrated, DOM_0, SUB_0, {hole=BodypartSlot.Head,engulfed=true,strapon=isWearingStrapon(DOM_0)})
			
			text += RNG.pick([
				"Послушно, {sub.you} {sub.youVerb('part')} {sub.yourHis} губами и {sub.youVerb('take')} {dom.yourHis} {dom.penis} в {sub.yourHis} рот, жадно посасывая.",
				"{sub.You} {sub.youVerb('open')} {sub.yourHis} широко открывает рот, позволяя {dom.yourHis} {dom.penis} скользнуть мимо {sub.yourHis} губ. С жадным языком и медленными, намеренными движениями, {sub.youHe} {sub.youHeVerb('begin')} сосет {dom.youHim}.",
			])
		else:
			text += RNG.pick([
				"Послушно, {sub.you} {sub.youVerb('extend')} {sub.yourHis} языком и {sub.youVerb('begin')} лижет {dom.yourHis} {dom.pussyStretch} киску.",
				"{sub.You} {sub.youVerb('press', 'presses')} {sub.yourHis} языком к {dom.yourHis} {dom.pussyStretch} киске, жадно слизывая всё, без колебаний повинуясь приказу {dom.youHis}.",
			])
		text += " "
		if(domFocus == BodypartSlot.Penis):
			sendSexEvent(SexEvent.HolePenetrated, SUB_0, DOM_0, {hole=BodypartSlot.Head,engulfed=true,strapon=isWearingStrapon(SUB_0)})
			
			text += RNG.pick([
				"В ответ {dom.You} {dom.youVerb('take')} {sub.yourHis} {penis} прямо в {dom.yourHis} рот, а {dom.yourHis} губы скользят вдоль него.",
				"Ощущая это, {dom.You} {dom.youVerb('wrap')} {dom.yourHis} губами вокруг {sub.yourHis} {penis}, а {dom.yourHis} язык дразнит чувствительный кончик, пока {dom.youHe} {dom.youHeVerb('bob')} {dom.yourHis} двигает головой вверх-вниз.",
			])
		else:
			text += RNG.pick([
				"В ответ {dom.You} {dom.youVerb('lean')} вниз, прижимая {dom.yourHis} язык к {sub.yourHis} {pussy} медленными, размеренными движениями.",
				"Ощущая это, {dom.You} {dom.youVerb('bury', 'buries')} {dom.yourHis} лицом между {sub.yourHis} ног, исследуя языком каждый дюйм {sub.yourHis} киски.",
			])
		
		addText(text)
		reactSub(SexReaction.AgreeGeneric)
		return
	if(_id == "refuse"):
		state = ""
		getDomInfo().addAnger(0.3)
		addText("{sub.You} {sub.youVerb('refuse')}.")
		reactSub(SexReaction.RefuseGeneric)
		return
	if(_id == "bite"):
		var successChance:float = getSubBiteChance(50.0, 30.0)
		if(RNG.chance(successChance)):
			getDomInfo().addPain(10)
			sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=10,isDefense=true,intentional=true})
			getDomInfo().addAnger(1.0 - getDomInfo().fetishScore({Fetish.Masochism: 0.5}))
			getDomInfo().addLust(-5 + 10 * getDomInfo().fetishScore({Fetish.Masochism: 1.0}))
			if(RNG.chance(50)):
				failGoals()
			endActivity()
			addText("{sub.You} {sub.youVerb('bite')} хватает {dom.your} за гениталии! {dom.YouHe} {dom.youHeVerb('cry', 'cries')} от боли и {dom.youHeVerb('pull')} прочь.")
			react(SexReaction.PainGeneric)
			return
		else:
			getDomInfo().addAnger(0.4)
			state = ""
			addText("{sub.You} {sub.youVerb('try', 'tries')} пытается укусить {dom.you}, но {dom.youHe} {dom.youHeVerb('avoid')} это!")
			return

func sex_getActions(_indx:int):
	if(_indx == DOM_0):
		if(domFocus == BodypartSlot.Vagina && getDom().hasEffect(StatusEffect.HasCumInsideMouth) && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina) == null && !getDom().isOralBlocked() && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			var spitcumintosubspussyScore:float = 0.01 + getDomInfo().fetishScore({Fetish.Breeding: 0.1})
			addAction("spitcumintosubspussy", spitcumintosubspussyScore, "Плюнуть спермой в киску", "Запихнуть сперму в щель")
		
		if(isReadyToCumHandled(DOM_0)):
			if(isReadyToCumHandled(SUB_0)):
				addAction("cum", 1.0, "Двойной конч!", "Вы оба сейчас кончите!", {A_PRIORITY: 1001})
			else:
				addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})
	if(_indx == SUB_0):
		if(isReadyToCumHandled(SUB_0)):
			addAction("cumSub", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})

func sex_doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "spitcumintosubspussy"):
		doSpitCumIntoHoleDom(BodypartSlot.Vagina)
		return
	if(_id == "cum"):
		getSubInfo().stimulateArousalZone(0.05, domFocus, 0.5)
		if(isReadyToCumHandled(SUB_0)):
			satisfyGoals()
			addText("[b]Двойной оргазм[/b]!")
			var _ok =doCumBJDom() if subFocus == BodypartSlot.Penis else doCumPussyLickDom()
			var _ok2 =doCumBJSub(false) if domFocus == BodypartSlot.Penis else doCumPussyLickSub(false)
			return
		else:
			cumAmount += 1
			if(cumAmount >= 2):
				satisfyGoals()
		var _ok =doCumBJDom() if subFocus == BodypartSlot.Penis else doCumPussyLickDom()
		return
	if(_id == "cumSub"):
		getDomInfo().stimulateArousalZone(0.05, subFocus, 0.5)
		
		if(isReadyToCumHandled(DOM_0)):
			satisfyGoals()
			addText("[b]Двойной оргазм[/b]!")
			var _ok =doCumBJDom() if subFocus == BodypartSlot.Penis else doCumPussyLickDom()
			var _ok2 =doCumBJSub(false) if domFocus == BodypartSlot.Penis else doCumPussyLickSub(false)
			return
		else:
			cumAmount += 1
			if(cumAmount >= 2):
				satisfyGoals()
		var _ok =doCumBJSub(false) if domFocus == BodypartSlot.Penis else doCumPussyLickSub(false)
		return

func getAnimation():
	if(state in ["sex"]):
		var aName:String = ""
		if(subFocus == BodypartSlot.Penis):
			aName += "M"
		else:
			aName += "F"
		if(domFocus == BodypartSlot.Penis):
			aName += "M"
		else:
			aName += "F"
		if(getDomInfo().isCloseToCumming() || getSubInfo().isCloseToCumming()):
			aName += "fast"
		
		return [StageScene.Sex69, aName, {npc=DOM_0, pc=SUB_0, bodyState={hard=true}, npcBodyState={hard=true}}]
	return [StageScene.Sex69, "tease", {npc=DOM_0, pc=SUB_0}]
	
func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == DOM_0):
		return 10
	if(_indx == SUB_0):
		return 10
	return -1

func getDomForceChance() -> float:
	if(getSub().isBitingBlocked() || getSubInfo().isUnconscious()):
		return 100.0
	if(getSubInfo().resistance <= 0.01):
		return 100.0
	var theChance:float= 50.0 - getSubInfo().getResistScoreSmooth()*30.0
	if(getSub().hasBlockedHands()):
		theChance *= 1.2
	if(getSub().hasBoundArms()):
		theChance *= 1.2
	
	return clamp(theChance, 5.0, 100.0)

func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.7
	if(getSub().hasBoundArms()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.9
	if(getSub().hasBoundLegs()):
		theChance *= 0.8
	
	return max(theChance, 5.0)

func getSubBiteChance(baseChance:float, domAngerRemoval:float) -> float:
	#if(state in ["blowjob", "licking"]):
	#	return 100.0
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.9
	if(getSub().hasBoundArms()):
		theChance *= 0.9
	if(getSub().isBlindfolded()):
		theChance *= 0.5
	
	return max(theChance, 5.0)

func saveData():
	var data = .saveData()
	
	data["cumAmount"] = cumAmount
	data["domFocus"] = domFocus
	data["subFocus"] = subFocus

	return data
	
func loadData(data):
	.loadData(data)
	
	cumAmount = SAVE.loadVar(data, "cumAmount", 0)
	domFocus = SAVE.loadVar(data, "domFocus", BodypartSlot.Vagina)
	subFocus = SAVE.loadVar(data, "subFocus", BodypartSlot.Vagina)
