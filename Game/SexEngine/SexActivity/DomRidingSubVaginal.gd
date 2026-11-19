extends SexActivityBase
var waitTimer:int = 0

var usedBodypart:String = BodypartSlot.Vagina
var usedTag:int = SexActivityTag.VaginaUsed
var usedTagInside:int = SexActivityTag.VaginaPenetrated
var fetishGiving:String = Fetish.VaginalSexGiving
var fetishReceiving:String = Fetish.VaginalSexReceiving
var aboutToRideReaction:int = SexReaction.AboutToRidePussy
var usedBodypartNames:Array = ["pussy", "pussy", "slit", "cunt", "kitty"]
var switchHoleActivity:String = "DomRidingSubAnal"
var otherHoleNames:Array = ["anus"]
var otherHoleBodypart:String = BodypartSlot.Anus
var otherHoleTag:int = SexActivityTag.AnusUsed
var otherHoleFetishGiving:String = Fetish.AnalSexGiving
var otherHoleFetishReceiving:String = Fetish.AnalSexReceiving
var otherGoal:String = SexGoal.ReceiveAnal
var currentPose:String = ""
var isVag:bool = true
var isMakingOut:bool = false

func _init():
	id = "DomRidingSubVaginal"
	
	activityName = "Наездница (вагинально)"
	activityDesc = "Начни скакать на них своей киской!"
	activityCategory = ["Fuck"]

func getGoals():
	if(currentPose == POSE_COWGIRLCHOKE):
		return {
			SexGoal.ChokeReceiveVaginal: 1.0,
			SexGoal.ReceiveVaginal: 1.0,
			SexGoal.ReceiveStraponVaginal: 1.0,
		}
	
	return {
		SexGoal.ReceiveVaginal: 1.0,
		SexGoal.ReceiveStraponVaginal: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.SlutwallSex: true,
		SexType.BitchsuitSex: true,
	}

const POSE_DEFAULT = "POSE_DEFAULT"
const POSE_COWGIRL = "POSE_COWGIRL"
const POSE_REVERSECOWGIRL = "POSE_REVERSECOWGIRL"
const POSE_COWGIRLALT = "POSE_COWGIRLALT"
const POSE_LOTUS = "POSE_LOTUS"
const POSE_COWGIRLAMAZON = "POSE_COWGIRLAMAZON"
const POSE_STANDRIDE = "POSE_STANDRIDE"
const POSE_COWGIRLCHOKE = "POSE_COWGIRLCHOKE"
const POSE_STRADDLE = "POSE_STRADDLE"

const PoseToName = {
	POSE_DEFAULT: "Default",
	POSE_COWGIRL: "Cowgirl",
	POSE_REVERSECOWGIRL: "Reverse Cowgirl",
	POSE_COWGIRLALT: "Cowgirl Alternative",
	POSE_COWGIRLCHOKE: "Cowgirl Choking",
	POSE_LOTUS: "Lotus",
	POSE_STANDRIDE: "Standing",
	POSE_COWGIRLAMAZON: "Cowgirl amazon",
	POSE_STRADDLE: "Straddle",
}
const PoseToAnimName = {
	POSE_DEFAULT: StageScene.SexCowgirl,
	POSE_COWGIRL: StageScene.SexCowgirl,
	POSE_REVERSECOWGIRL: StageScene.SexReverseCowgirl,
	POSE_COWGIRLALT: StageScene.SexCowgirlAlt,
	POSE_COWGIRLCHOKE: StageScene.SexCowgirlChoke,
	POSE_LOTUS: StageScene.SexLotus,
	POSE_STANDRIDE: StageScene.SexStandRide,
	POSE_COWGIRLAMAZON: StageScene.SexCowgirlAmazon,
	POSE_STRADDLE: StageScene.SexCowgirlStraddle,
}
func getAvaiablePoses() -> Array:
	if(currentPose == POSE_COWGIRLCHOKE):
		return [POSE_COWGIRLCHOKE]
	
	if(getSexType() == SexType.DefaultSex):
		var possible:= [POSE_COWGIRL, POSE_REVERSECOWGIRL, POSE_COWGIRLALT, POSE_LOTUS, POSE_COWGIRLAMAZON, POSE_STRADDLE]
		if(getSexEngine() != null && getSexEngine().hasWallsNearby()):
			possible.append(POSE_STANDRIDE)
		
		return possible
	
	return [POSE_DEFAULT]

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(!_subInfo.getChar().hasReachablePenis() && !_subInfo.getChar().isWearingStrapon()):
		return false
	if(usedBodypart == BodypartSlot.Vagina && !_domInfo.getChar().hasReachableVagina()):
		return false
	if(usedBodypart == BodypartSlot.Anus && !_domInfo.getChar().hasReachableAnus()):
		return false
	
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func isActivityImpossibleShouldStop() -> bool:
	if(!getSub().hasReachablePenis() && !getSub().isWearingStrapon()):
		return true
	if(usedBodypart == BodypartSlot.Vagina && !getDom().hasReachableVagina()):
		return true
	if(usedBodypart == BodypartSlot.Anus && !getDom().hasReachableAnus()):
		return true
		
	return false

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		var thetags:Array = [usedTag, SexActivityTag.HavingSex]
		if(getState() in ["fucking", "aftercumminginside", "knotting", "inside"]):
			thetags.append(usedTagInside)
		return thetags
	if(_indx == SUB_0):
		if(getState() in ["fucking", "aftercumminginside", "knotting", "inside"]):
			return [SexActivityTag.PenisUsed, SexActivityTag.PenisInside, SexActivityTag.HavingSex, SexActivityTag.PreventsSubViolence, SexActivityTag.PreventsSubTeasing]
		return [SexActivityTag.PenisUsed, SexActivityTag.HavingSex, SexActivityTag.PreventsSubViolence, SexActivityTag.PreventsSubTeasing]
	return []

func getCheckTagsDom() -> Array:
	return [SexActivityTag.OrderedToDoSomething, usedTag, SexActivityTag.HavingSex]

func getCheckTagsSub() -> Array:
	return [SexActivityTag.OrderedToDoSomething, SexActivityTag.PenisUsed, SexActivityTag.HavingSex]

func isStraponSex() -> bool:
	return getSub().isWearingStrapon()

#func subSensetivity() -> float:
#	var strapon = getSub().getWornStrapon()
#	if(strapon == null):
#		return 1.0
#
#	return strapon.getStraponPleasureForDom()

func getDickName(dickName = null) -> String:
	if(isStraponSex()):
		return "strapon"
	if(dickName == null):
		return RNG.pick(["cock", "dick", "member"])
	return dickName

func getUsedBodypartName() -> String:
	var theName = RNG.pick(usedBodypartNames)
	if(usedBodypart == BodypartSlot.Vagina):
		theName = "{dom.pussyStretch} "+theName
	if(usedBodypart == BodypartSlot.Anus):
		theName = "{dom.anusStretch} "+theName
	
	var _isNeedy:bool = getDom().getLustLevel() > 0.6
	var _isDry:bool = getDom().getLustLevel() < 0.1
	var _isLubedUp:bool = getDom().hasEffect(StatusEffect.LubedUp)
	var _hasCumInHole:bool = false
	if(usedBodypart == BodypartSlot.Vagina):
		_hasCumInHole = getDom().hasEffect(StatusEffect.HasCumInsideVagina)
	if(usedBodypart == BodypartSlot.Anus):
		_hasCumInHole = getDom().hasEffect(StatusEffect.HasCumInsideAnus)
	
	if(_hasCumInHole && RNG.chance(30)):
		theName = RNG.pick(["creamed", "stuffed"])+" "+theName
	elif(_isNeedy):
		if(usedBodypart == BodypartSlot.Vagina):
			theName = RNG.pick(["needy", "awaiting", "inviting"])+" "+theName
		if(usedBodypart == BodypartSlot.Anus):
			theName = RNG.pick(["needy", "awaiting", "drippy", "inviting", "wet", "slick", "aroused"])+" "+theName
	elif(_isLubedUp):
		theName = RNG.pick(["смазанная"])+" "+theName
	elif(_isDry && RNG.chance(50)):
		if(usedBodypart == BodypartSlot.Vagina):
			theName = RNG.pick(["dry"])+" "+theName
		if(usedBodypart == BodypartSlot.Anus):
			theName = RNG.pick(["dry"])+" "+theName
	return theName

func getStartTextForPose(thePose:String) -> String:
	var throughClothing = "."
	if(!hasBodypartUncovered(DOM_0, usedBodypart)):
		throughClothing = " сквозь одежду {dom.yourHis}"
	
	var text:String = ""
	if(thePose == POSE_COWGIRL):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} and {dom.youVerb('rub')} {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	elif(thePose == POSE_STRADDLE):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} and {dom.youVerb('rub')} {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	elif(thePose == POSE_REVERSECOWGIRL):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе обратной наездницы и {dom.youVerb('rub')} {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	elif(thePose == POSE_COWGIRLAMAZON):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе полуамазонки и {dom.youVerb('rub')} {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	elif(thePose == POSE_COWGIRLALT):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} и {dom.youVerb('tilt')} {dom.yourHis} тело назад, потирая {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	elif(thePose == POSE_LOTUS):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('sink')} на {sub.your} колени, обхватив {dom.yourHis} ногами {sub.yourHis} талию и придерживаясь за {sub.yourHis} плечи для опоры. {dom.YourHis} "+getUsedBodypartName()+" {dom.youVerb('press', 'presses')} плотно к {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+" в тесных, интимных объятиях.",
		])
	elif(thePose == POSE_STANDRIDE):
		text = RNG.pick([
				"{dom.You} {dom.youVerb('raise')} одну ногу высоко и {dom.youVerb('pin')} {sub.you} у ближайшей стены, {dom.yourHis} {dom.foot} задевая {sub.yourHis} плечо. {dom.YourHis} "+getUsedBodypartName()+" {dom.youVerb('press', 'presses')} against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock"]))+throughClothing+".",
			])
	else:
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} and {dom.youVerb('rub')} {dom.yourHis} "+getUsedBodypartName()+" against {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+throughClothing+".",
		])
	return text
	
func getSwitchPoseTextForPose(thePose:String) -> String:
	var text:String = ""
	if(thePose == POSE_COWGIRL):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе наездницы, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_STRADDLE):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в доминирующей позиции, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_REVERSECOWGIRL):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе обратной наездницы, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_COWGIRLAMAZON):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе полуамазонки, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_COWGIRLALT):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} и {dom.youVerb('tilt')} {dom.yourHis} откинула тело назад, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_LOTUS):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you} в позе лотоса, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	elif(thePose == POSE_STANDRIDE):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('pin')} {sub.you}, прижавшись к стене с вертикальным разрезом, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	else:
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stradle')} {sub.you}, {sub.your} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+" все еще внутри {dom.yourHis} "+getUsedBodypartName()+"!",
		])
	return text

func startActivity(_args):
	currentPose = RNG.pick(getAvaiablePoses())
	
	var text:String = getStartTextForPose(currentPose)
	if(getSexType() == SexType.SlutwallSex):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('stand')} на цепях и {dom.youVerb('stradle')} {sub.you}, {dom.yourHis} "+RNG.pick(usedBodypartNames)+" тёрся(лась) об {sub.yourHis} "+getDickName(RNG.pick(["dick", "penis", "cock", "member"]))+".",
		])
	addText(text)
	react(aboutToRideReaction)

func onSwitchFrom(_otherActivity, _args):
	if(_args != null && _args == ["choke"]):
		currentPose = POSE_COWGIRLCHOKE
		return
	currentPose = RNG.pick(getAvaiablePoses())

func processExtra():
	if(!isMakingOut):
		return
	
	var hasPC:bool = (getSubID() == "pc" || getDomID() == "pc")
	var text:String = ("Вы " if hasPC else "Они ")+RNG.pick([
		"страстно целуются.",
		"всё еще глубоко целуются.",
		"всё еще целуются.",
	])
	
	if(RNG.chance(30)):
		text += RNG.pick([
			" Из горла {sub.yourHis} вырывается тихий стон.",
			" {dom.YourHis} слегка прикусывает нижнюю губу {sub.yourHis}, вызывая мягкий вздох.",
			" Их языки обмениваются слюной.",
			" Языки танцуют и переплетаются друг с другом.",
			" Оба издают тихие вздохи и стоны.",
		])
	
	if(OPTIONS.isContentEnabled(ContentType.CumStealing)):
		if(RNG.chance(20) && getDom().bodypartShareFluidsWith(BodypartSlot.Head, getSubID(), BodypartSlot.Head, 0.2)):
			text += RNG.pick([
				" {dom.You} и {sub.you} [b]делятся спермой[/b], при этом "+RNG.pick(["страстно целуясь", "kissing", "глубоко целуясь"])+"!",
				" [b]Они делятся спермой[/b] друг с другом "+RNG.pick(["mouths", "tongues", "lovers"])+"!",
				" [b]Происходит «снежный ком»: они по очереди делятся спермой[/b].",
			])
	sendSexEvent(SexEvent.Kissing, DOM_0, SUB_0, {})
	
	addText(text)

func processTurn():
	if(currentPose == POSE_COWGIRLCHOKE):
		choke(DOM_0, SUB_0, CHOKE_GENTLE)
	
	if(isMakingOut && currentPose != POSE_LOTUS):
		isMakingOut = false
	
	if(getState() == "knotting" || getState() == "inside"):
		cockWarmer(DOM_0, SUB_0, usedBodypart, getState() == "knotting")
		processExtra()
		return
	
func fucking_processTurn():
	stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_NORMAL)
#	affectSub(getSubInfo().fetishScore({fetishGiving: 1.0})+0.5, 0.1 * subSensetivity(), -0.1, -0.01)
#	affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0})+0.3, 0.1, 0.0)
#	getSubInfo().stimulateArousalZone(0.2, BodypartSlot.Penis, 1.0)
#	getDomInfo().stimulateArousalZone(0.2, usedBodypart, 1.0)
	
	doProcessRide(DOM_0, SUB_0, usedBodypart)
	
	doProcessRideExtra(DOM_0, SUB_0, usedBodypart)

	processExtra()


func getActions(_indx:int):
	if(_indx == DOM_0):
		if(currentPose == POSE_LOTUS):
			if(!isMakingOut && !getDom().isMuzzled() && !getSub().isMuzzled()):
				var makeoutScore:float = getDomInfo().personalityScore({PersonalityStat.Mean:-0.1})
				addAction("makeout", makeoutScore, "Начать целоваться", "Начать страстно целоваться (эта поза позволяет делать это одновременно)")
			if(isMakingOut):
				addAction("stopmakeout", 0.01, "Перестать целоваться", "Хватит смешивать жидкости!")
		
		if(state == "" || state == "inside"):
			addAction("rub", 1.0 - getStopScore(), "Тереть", "Потереть свою "+RNG.pick(usedBodypartNames)+" об их "+getDickName(), {A_PRIORITY: 4})
		if(state == ""):
			if(getDom().getFirstItemThatCoversBodypart(usedBodypart) == null && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null && getSubInfo().isReadyToPenetrate()):
				addAction("envelop", 1.0, "Окутать "+getDickName("cock"), "Попытаться засунуть это "+getDickName("cock")+" в тебя", {A_PRIORITY: 5})
					
			if(getDomInfo().getChar().hasBodypart(otherHoleBodypart) && !getSexEngine().hasTag(getDomID(), otherHoleTag)):
				var switchholeScore:float = 5.0 * (-getDomInfo().goalsScore(getGoals(), getSubID()) + getDomInfo().goalsScore({otherGoal: 1.0}, getSubID()))
				addAction("switchhole", switchholeScore, "Сменить отверстие", "Перейти на езду на "+RNG.pick(otherHoleNames))

		if(state in ["fucking", "knotting"]):
			if(isReadyToCumHandled(DOM_0)):
				addAction("domcum", 1.0, "Кончай!", "Ты сейчас кончишь!", {A_PRIORITY: 1001})
		
		if(state in ["fucking", "knotting", "inside"]):
			addEggStuffReceiveButton(DOM_0, SUB_0, usedBodypart)
		
		if(state in ["fucking"]):
			var moanScore:float = max(0.1, getDomInfo().fetishScore({fetishReceiving: 1.0}) + getDomInfo().personalityScore({PersonalityStat.Subby: 1.0}))
			addAction("moan", moanScore, "Стон", "Покажи, как тебе это нравится", {A_PRIORITY: 4})

			addAction("slowdown", getPauseSexScore(DOM_0, SUB_0, S_PENIS, usedBodypart), "Замедлиться", "Прекрати трахаться на секунду...")
			
			if(isStraponSex() && getSub().bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)):
				var domArousal:float = getDomInfo().getArousal()
				var straponForceKnotScore:float = 0.01
				if(domArousal > 0.8):
					straponForceKnotScore = 0.5
				addAction("straponForceKnot", straponForceKnotScore, "Втиснуть узел", "Попробуй затолкнуть их узел в себя!", {A_PRIORITY: 3})
				
		if(getState() in ["subabouttocum"] || (getState() == "fucking" && getSubInfo().isReadyToCum() && !getSubInfo().canDoActions())):
			var scoreToCumInside:float = 1.0
			var scoreToPullOut:float = 1.0
			
			if(getSexEngine().domNoPullingOut):
				scoreToPullOut = 0.0
			
			var hasKnot:bool = getSub().bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
			if(hasKnot):
				scoreToCumInside *= 0.5
				
				addAction("letsubknotinside", scoreToCumInside, "Узел!", "Попробуй затолкнуть узел в свои "+RNG.pick(usedBodypartNames), {A_PRIORITY: 1001})
			
			addAction("letsubcuminside", scoreToCumInside, "Кончить внутрь", "Дай сабмиссиву кончить в тебя", {A_PRIORITY: 1001})
			addAction("makesubcumoutside", scoreToPullOut, "Вытащить", "Перестань скакать на сабмиссиве", {A_PRIORITY: 1001})
		
		if(!(state in ["knotting"])):
			addAction("stop", getStopScore(), "Перестань скакать", "Прекратить секс")
		if(state in ["knotting"]):
			addAction("pullknotout", 1.0, "Вытащить", "Попробуй вырвать их узел")
		for pose in getAvaiablePoses():
			if(pose == currentPose):
				continue
			var poseName = "error"
			if(PoseToName.has(pose)):
				poseName = PoseToName[pose]
			addAction("switchpose", 0.0, poseName, "Сменить позу", {A_CATEGORY: ["Сменить позу"], A_ARGS: [pose]})
		
		if(state == "inside"):
			if(getDom().getFirstItemThatCoversBodypart(usedBodypart) == null && getSub().getFirstItemThatCoversBodypart(BodypartSlot.Penis) == null):
				addAction("ridemore", getContinueSexScore(DOM_0, SUB_0, S_PENIS, usedBodypart)-getStopScore(), "Скачи активнее", "Продолжать скакать на этом "+getDickName("cock")+".")
			
			
	if(_indx == SUB_0):
		if(state in [""]):
			addAction("rubSub", getSubInfo().getComplyScore()/2.0, "Подразнить", "Тереться членом об их "+RNG.pick(usedBodypartNames), {A_PRIORITY: 4})

		if(state in ["fucking"]):
			if(isReadyToCumHandled(SUB_0) && isStraponSex()):
				addAction("subcumstrapon", 1.0, "Кончай!", "Ты вот-вот кончишь", {A_PRIORITY: 1001})
			
			if(isReadyToCumHandled(SUB_0) && !isStraponSex()):
				addAction("warndom", 1.0, "Предупредить их", "Дать понять, что ты на грани", {A_PRIORITY: 1001})
				var cuminsideScore:float = getResistScore(SUB_0) + fetish(SUB_0, Fetish.Breeding)*0.5
				addAction("cuminside", cuminsideScore, "Кончить внутрь", "Кончить внутрь их "+RNG.pick(usedBodypartNames), {A_PRIORITY: 1001})
			var moanSubScore:float = max(0.1, getSubInfo().fetishScore({fetishGiving: 0.5}) + getSubInfo().personalityScore({PersonalityStat.Subby: 0.5}))
			addAction("moanSub", moanSubScore, "Стон", "Покажи, как тебе это нравится", {A_PRIORITY: 2})
			
		if(state in ["fucking", "", "inside"]):
			addAction("throwoff", getResistScore(SUB_0), "Сбросить их с себя", "Сопротивляться их попыткам оседлать тебя", {A_CHANCE: getSubResistChance(30.0, 25.0)})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stuffegg"):
		doReceiveEggFrom(DOM_0, SUB_0, usedBodypart)
	if(_id == "straponForceKnot"):
		# Need a tryKnot func?
		#if(tryPenetrate())
		stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_NORMAL, SPEED_SLOW)
		#var subArousal:float = getSubInfo().getArousal()
		if(RNG.chance(getDom().getKnottingChanceBy(usedBodypart, getSubID()) * 0.25)):
			getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.2)
			addTextTopBottom(RNG.pick([
				#"{dom.You} {dom.youVerb('manage')} to knot {sub.you}!",
				"{<BOTTOM>.You} {<BOTTOM>.youVerb('ride')} {<TOP>.your} {<TOP>.penisShort} изо всех сил, пока {<TOP>.yourHis} узел внезапно не проскользнет внутрь, растягивая {<BOTTOM>.yourHis} "+getNameHole(DOM_0, usedBodypart)+" до предела!",
			]), SUB_0, DOM_0)
			state = "knotting"
			cumInside(SUB_0, DOM_0, usedBodypart)
			#satisfyGoals()
		else:
			getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.1)
			addTextPick([
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы затолкнуть {sub.your} узел внутрь!",
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы растянуть {dom.yourHis} "+getNameHole(DOM_0, usedBodypart)+" на {sub.your} узле, так что он вот-вот проскользнет внутрь!",
				"{dom.You} {dom.youVerb('try', 'tries')}, чтобы завязать узел на {sub.your} {sub.penisShort} {dom.yourself}!",
			])
		return
	if(_id == "makeout"):
		isMakingOut = true
		if(!getSubInfo().isResistingSlightly()):
			addText("{dom.You} {dom.youVerb('lean')} ближе, {dom.yourHis} губы сплетаются с {sub.yourHis} в глубоком, жарком поцелуе. Поцелуе, который не прекращается. {sub.YouHe} {sub.youHeVerb('respond')}, приоткрывая {sub.yourHis} рот, чтобы встретить {dom.yourHis} язык.")
		else:
			addText("{dom.You} {dom.youVerb('lean')} ближе и {dom.youVerb('force')} глубоко целует, несмотря на приглушенные протесты {sub.your}. {dom.YourHis} язык проникает в этот рот, заявляя права на него как на {sub.youHe} {sub.youHeVerb('squirm')} снизу.")
		return
	if(_id == "stopmakeout"):
		isMakingOut = false
		addText("{dom.You} {dom.youVerb('decide')} перестать целоваться.")
		return
	if(_id == "switchpose"):
		#switchedPoseOnce = true
		var newPose:String = _action["args"][0]
		var isInside:bool = true
		if(state in [""]):
			isInside = false
		
		if(isInside):
			addText(getSwitchPoseTextForPose(newPose))
		else:
			addText(getStartTextForPose(newPose))
		currentPose = newPose
		return
	if(_id == "switchhole"):
		switchCurrentActivityTo(switchHoleActivity)
		addText("{dom.You} {dom.youVerb('switch', 'switches')} отверстия, теперь потирая {dom.yourHis} "+RNG.pick(otherHoleNames)+" against {sub.yourHis} "+getDickName()+".")
		return
	if(_id == "stop"):
		endActivity()
		addText("{dom.You} {dom.youVerb('pull')} {dom.yourself} подальше от {sub.your} "+getDickName()+" и {dom.youVerb('get')} вверх.")
		return
	if(_id == "domcum"):
		getDom().cumOnFloor()
		getDomInfo().cum()
		var straponText:String = ""
		if(isStraponSex()):
			satisfyGoals()
			var strapon = getSub().getWornStrapon()
			if(strapon.getFluids() != null && !strapon.getFluids().isEmpty()):
				getDom().cummedInBodypartByAdvanced(usedBodypart, getSubID())
				straponText = "{dom.your} сжимает {sub.Your} страпон "+RNG.pick(usedBodypartNames)+" так, что он внезапно [b]извергает содержимое внутрь {dom.youHim}[/b]!"
		getSubInfo().stimulateArousalZone(0.2, BodypartSlot.Penis, 1.0)
		addGenericOrgasmText(DOM_0)
		if(straponText != ""):
			addText(straponText)
		return
	if(_id in ["letsubcuminside", "letsubknotinside"]):
		var wombText:String = RNG.pick([
			"womb", "womb",
			"babymaker",
		])
		if(usedBodypart == BodypartSlot.Anus):
			wombText = RNG.pick([
				"ass",
				"butt",
			])
		var text:String = ""
		
		var condomBroke:bool = false
		var knotSuccess:bool = false
		#var isTryingToKnot = false
		if(_id == "letsubknotinside"):
			#isTryingToKnot = true
			getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.5)
			if(RNG.chance(getDom().getKnottingChanceBy(usedBodypart, getSubID()))):
				knotSuccess = true
			else:
				text += RNG.pick([
					"{dom.You} {dom.youVerb('try', 'tries')} to "+RNG.pick(["силой втиснуть {sub.yourHis} узел внутрь {dom.youHim}", "получить узел от {dom.you}"])+" но дырка {dom.yourHis} слишком узкая. "
				])
		
		if(knotSuccess):
			text = RNG.pick([
				"{dom.You} "+RNG.pick(["{dom.youVerb('nod')} and", "just"])+" {dom.youVerb('keep')} riding {sub.your} "+RNG.pick(["cock", "dick", "member"])+" жестко, пока узел {sub.yourHis} внезапно не проскальзывает внутрь! [b]{sub.You} {sub.youVerb('moan')}, пока {sub.youHe} {sub.youHeVerb('cum')} внутри {dom.yourHis} "+RNG.pick(usedBodypartNames)+"[/b]!",
			])
		else:
			text = RNG.pick([
				"{dom.You} "+RNG.pick(["{dom.youVerb('nod')} and", "just"])+" {dom.youVerb('keep')} riding {sub.your} "+RNG.pick(["cock", "dick", "member"])+" пока [b]{sub.youHe} {sub.youHeVerb('cum')} внутри {dom.yourHis} "+RNG.pick(usedBodypartNames)+"[/b]!",
			])
		text += RNG.pick([
			" Волна за волной липкой "+RNG.pick(["cum", "seed", "jizz", "semen"])+" втекает в {dom.yourHis} "+wombText+".",
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
				if(knotSuccess):
					text = RNG.pick([
						"{dom.You} "+RNG.pick(["{dom.youVerb('nod')} and", "just"])+" {dom.youVerb('keep')} riding {sub.your} "+RNG.pick(["cock", "dick", "member"])+" жестко, пока узел {sub.yourHis} внезапно не проскальзывает внутрь!",
					])
				else:
					text = RNG.pick([
						"{dom.You} "+RNG.pick(["{dom.youVerb('nod')} and", "just"])+" {dom.youVerb('keep')} riding {sub.your} "+RNG.pick(["cock", "dick", "member"])+".",
					])
				text += RNG.pick([
					" {sub.You} {sub.youVerb('moan')}, пока {sub.youHe} {sub.youHeVerb('fill')} презерватив внутри {dom.your} "+RNG.pick(usedBodypartNames)+"!",
					" {sub.You} {sub.youVerb('moan')}, пока {sub.youHe} {sub.youHeVerb('stuff')} презерватив в {dom.your} "+RNG.pick(usedBodypartNames)+" полная {sub.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+"!",
				])
				var loadSize = getSub().cumInItem(condom)
				getSubInfo().cum()
				getDomInfo().addArousalSex(0.02)
				sendSexEvent(SexEvent.FilledCondomInside, SUB_0, DOM_0, {hole=usedBodypart,loadSize=loadSize,knotted=knotSuccess,engulfed=true})
				satisfyGoals()
				if(knotSuccess):
					state = "knotting"
				else:
					state = "inside"
				
				addText(text)
				return
		
		getDom().cummedInBodypartByAdvanced(usedBodypart, getSubID(), {knotted=knotSuccess,condomBroke=condomBroke,engulfed=true})
		getSubInfo().cum()
		
		satisfyGoals()
		if(knotSuccess):
			state = "knotting"
			getDomInfo().addArousalSex(0.05)
		else:
			state = "inside"
			getDomInfo().addArousalSex(0.02)
		
		addText(text)
		return
	if(_id == "makesubcumoutside"):
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('ride')} {sub.yourHis} "+RNG.pick(["dick", "cock", "member"])+" пока {sub.youHe} {sub.youAreHeIs} не готов кончить. Но {dom.you} {dom.youVerb('stop')} верхом на {sub.youHim} как раз вовремя!",
		])
		state = ""
		
		var condom:ItemBase = getSub().getWornCondom()
		if(condom != null):
			var breakChance = condom.getCondomBreakChance()
			
			if(RNG.chance(breakChance)):
				text = "[b]Презерватив порвался![/b] "+text
				condom.destroyMe()
				fetishUp(SUB_0, Fetish.Condoms, -15.0)
				fetishUp(DOM_0, Fetish.Condoms, -20.0)
			else:
				fetishAffect(SUB_0, Fetish.Condoms, 3.0)
				fetishAffect(DOM_0, Fetish.Condoms, 3.0)
				text += RNG.pick([
					" {sub.You} "+RNG.pick(["{sub.youVerb('fill')}", "{sub.youVerb('stuff')}"])+" {sub.yourHis} презерватив!",
				])
				getSub().cumInItem(condom)
				getSubInfo().cum()
				satisfyGoals()
				
				addText(text)
				return
		
		text += RNG.pick([
			" {sub.You} [b]{sub.youVerb('cum')} размазаны по всему {sub.yourself}[/b]! Тягучие нити {sub.yourHis} собственной "+RNG.pick(["cum", "seed", "semen"])+" падают на грудь {sub.yourHis}, оставляя после себя месиво.",
		])
		
		getSub().cummedOnBy(getSubID(), FluidSource.Penis)
		getSubInfo().cum()
		satisfyGoals()

		addText(text)
		return
	if(_id == "pullknotout"):
		if(RNG.chance(30)):
			state = ""
			var text = RNG.pick([
				"{dom.You} {dom.youVerb('manage')}, чтобы поднять {dom.yourself}. Узел "+RNG.pick(["выходит наружу,", "вытягивается,"])+" с приятным члюпающим звуком.",
			])
			
			if((getDom().hasEffect(StatusEffect.HasCumInsideVagina) && usedBodypart == BodypartSlot.Vagina) || (getDom().hasEffect(StatusEffect.HasCumInsideAnus) && usedBodypart == BodypartSlot.Anus)):
				if((getDom().getBuffsHolder().hasBuff(Buff.BlocksVaginaLeakingBuff) && usedBodypart == BodypartSlot.Vagina) || (getDom().getBuffsHolder().hasBuff(Buff.BlocksAnusLeakingBuff) && usedBodypart == BodypartSlot.Anus)):
					text += RNG.pick([
						" Немного "+RNG.pick(["cum", "seed", "semen"])+" пытается вытечь, но {dom.you} быстро {dom.youVerb('plug')} {dom.yourHis} "+RNG.pick(usedBodypartNames)+" back.",
					])
				else:	
					text += RNG.pick([
						" Немного "+RNG.pick(["cum", "seed", "semen"])+" вытекает из использованной {dom.yourHis} "+RNG.pick(usedBodypartNames)+".",
					])
			stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_NORMAL, SPEED_VERYSLOW)
			addText(text)
			return
		else:
			var text = RNG.pick([
				"{dom.You} {dom.youVerb('try', 'tries')} to "+RNG.pick(["pull", "yank"])+" {sub.yourHis} "+RNG.pick(["cock", "dick"])+" выходит, но {dom.youVerb('fail')}. Узел внутри {dom.youHim} медленно спадает.",
			])
			getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.1)
			affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.1, -0.3, 0.0)
			affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0}), 0.1, -0.05)
			getSubInfo().addArousalForeplay(0.1)
			getDomInfo().addArousalForeplay(0.1)
			addText(text)
			return
	if(_id == "rub"):
		stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_TEASE)
		#affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.1 * subSensetivity(), 0.0, 0.0)
		#affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0}), 0.1, -0.01)
		#getSubInfo().addArousalForeplay(0.05 * subSensetivity())
		#getDomInfo().addArousalForeplay(0.05)
		
		addText("{dom.You} {dom.youVerb('rub')} {dom.yourHis} "+RNG.pick(usedBodypartNames)+" against {sub.yourHis} "+getDickName()+".")
		return
	if(_id == "envelop"):
		if(!RNG.chance(getDom().getPenetrateChanceBy(usedBodypart, getSubID()))):
			getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.1)
			#affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.1 * subSensetivity(), 0.0, 0.0)
			#affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0}), 0.2, -0.01)
			stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_TEASE)
			addText("{dom.You} {dom.youVerb('try', 'tries')}, чтобы окутать {sub.yourHis} "+getDickName()+" но он слишком большой!")
			return
		
		sendSexEvent(SexEvent.HolePenetrated, SUB_0, DOM_0, {hole=usedBodypart,engulfed=true,strapon=isStraponSex()})
		#affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.1 * subSensetivity(), 0.0, 0.0)
		#affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0}), 0.1, -0.01)
		#getSubInfo().stimulateArousalZone(0.1, BodypartSlot.Penis, 0.5)
		#getDomInfo().stimulateArousalZone(0.1, usedBodypart, 0.5)
		stimulateSexRide(DOM_0, SUB_0, usedBodypart, I_LOW)
		
		#getSub().gotFuckedBy(usedBodypart, getDomID())
		getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.2)
		#gonnaCumOutside = false
		state = "fucking"
		addText("{dom.You} {dom.youVerb('envelop')} {sub.youHis} "+getDickName()+", позволяя ему проникать в {dom.yourHis} "+RNG.pick(usedBodypartNames)+".")
		return
	if(_id == "slowdown"):
		state = "inside"
		addText("{dom.You} {dom.youVerb('stop')}, оседлавшая это "+getDickName()+" и просто {dom.youVerb('let')}, чтобы он оставался внутри.")
		return
	if(_id == "moan"):
		var moanText:String = RNG.pick([
			"{dom.youVerb('moan')}"
		])
		if(getDom().isGagged()):
			moanText = RNG.pick([
				"{dom.youVerb('let')} издает приглушенные стоны",
			])
		addTextPick([
			"{dom.You} "+moanText+" пока её трахают!",
			"{dom.You} "+moanText+" пока она скачет на {sub.youHim} с {dom.yourHis} "+RNG.pick(usedBodypartNames)+"!",
			"{dom.You} "+moanText+" с жадностью!",
		])
		moan(DOM_0)
		#affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.03 * subSensetivity(), -0.01, -0.0)
		#affectDom(getDomInfo().fetishScore({fetishReceiving: 1.0}), 0.05, -0.03)
		return
	if(_id == "ridemore"):
		getDom().gotOrificeStretchedBy(usedBodypart, getSubID(), true, 0.2)
		#gonnaCumOutside = false
		state = "fucking"
		addText("{dom.You} {dom.youVerb('continue')}, чтобы оседлать {sub.youHis} "+getDickName()+" with {dom.yourHis} "+RNG.pick(usedBodypartNames)+".")
		return

	if(_id == "subcumstrapon"):
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		addGenericOrgasmText(SUB_0)
		return
	if(_id == "moanSub"):
		var moanText:String = RNG.pick([
			"{sub.youVerb('moan')}"
		])
		if(getSub().isGagged()):
			moanText = RNG.pick([
				"{sub.youVerb('let')} издает приглушенные стоны",
				"{sub.youVerb('let')} издает приглушенный стон",
				"{sub.youVerb('let')} издает приглушенный звук удовольствия",
			])
		
		addTextPick([
			"{sub.You} "+moanText+" while {dom.you} {dom.youVerb('ride')} {sub.youHim}!",
			"{sub.You} "+moanText+" while {sub.yourHis} "+getDickName()+" используется {dom.you}!",
			"{sub.You} "+moanText+" с жадностью!",
		])
		moan(SUB_0)
		return
	if(_id == "throwoff"):
		if(RNG.chance(getSubResistChance(30.0, 25.0))):
			if(state != ""):
				state = ""
				isMakingOut = false
			else:
				endActivity()
			
			addText("{sub.You} {sub.youVerb('manage')}, чтобы отшвырнуть {dom.youHim} от {sub.yourHis} "+getDickName()+".")
			reactSub(SexReaction.ActivelyResisting, [50])
			getDomInfo().addAnger(0.3)
			return
		else:
			addText("{sub.You} {sub.youVerb('try', 'tries')}, чтобы сопротивляться и "+RNG.pick(["shove", "push", "throw"])+" {dom.you}, но {sub.youVerb('fail')}.")
			getDomInfo().addAnger(0.1)
			reactSub(SexReaction.ActivelyResisting, [50])
			return
	if(_id == "rubSub"):
		stimulateSex(SUB_0, DOM_0, usedBodypart, I_TEASE)
		#affectSub(getSubInfo().fetishScore({fetishGiving: 1.0}), 0.05 * subSensetivity(), -0.1, 0.0)
		#affectDom(max(0.1, getDomInfo().fetishScore({fetishReceiving: 1.0})+1.0), 0.05, 0.0)
		
		addText("{sub.You} {sub.youVerb('rub')} {sub.yourHis} "+getDickName()+" against {dom.your} "+RNG.pick(usedBodypartNames)+".")
		return
	if(_id == "warndom"):
		state = "subabouttocum"
		getDomInfo().addAnger(-0.05)
		addText("{sub.You} {sub.youVerb('warn')} {dom.youHim} that {sub.youHe} {sub.youAreHeIs} "+RNG.pick(["вот-вот кончит", "close", "совсем близко"])+".")
		reactSub(SexReaction.WarnAboutToCum)
		return
	if(_id == "cuminside"):
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('grunt')} as {sub.yourHis} "+RNG.pick(["cock", "dick", "member"])+" пульсирует и [b]"+RNG.pick(["кончает внутрь {dom.yourHis} "+RNG.pick(usedBodypartNames), "stuffs {dom.yourHis} "+RNG.pick(usedBodypartNames)])+" не спрашивая разрешения[/b]!",
		])
		if(usedBodypart == BodypartSlot.Vagina):
			text += RNG.pick([
				" Волна за волной липкой "+RNG.pick(["cum", "seed", "jizz", "semen"])+" втекает в {dom.yourHis} "+RNG.pick(["womb", "babymaker", "womb"])+".",
			])
		else:
			text += RNG.pick([
				" Волна за волной липкой "+RNG.pick(["cum", "seed", "jizz", "semen"])+" запихивают в {dom.yourHis} "+RNG.pick(["ass", "butt"])+".",
			])
		
		var condomBroke = false
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
					"{sub.You} {sub.youVerb('fill')} презерватив внутрь {dom.your} "+RNG.pick(usedBodypartNames)+" [b]не спрашивая разрешения[/b]!",
					"{sub.You} {sub.youVerb('stuff')} презерватив в {dom.your} "+RNG.pick(usedBodypartNames)+" полная {sub.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+" [b]не спрашивая разрешения[/b]!",
				])
				var loadSize = getSub().cumInItem(condom)
				getSubInfo().cum()
				getDomInfo().addArousalSex(0.02)
				sendSexEvent(SexEvent.FilledCondomInside, SUB_0, DOM_0, {hole=usedBodypart,loadSize=loadSize,knotted=false})
				satisfyGoals()
				state = "inside"
				
				addText(text)
				return
		
		var beingBredScore = getDomInfo().fetishScore({Fetish.BeingBred: 1.0})
		if(beingBredScore < 0.0):
			getDomInfo().addAnger(1.0)
			text += RNG.pick([
				" {dom.You} {dom.youAre} в ярости!",
			])
			getDomInfo().addFrustration(1.0)
		else:
			getDomInfo().addAnger(0.3)
		getDom().cummedInBodypartByAdvanced(usedBodypart, getSubID(), {condomBroke=condomBroke})
		getSubInfo().cum()
		getDomInfo().addArousalSex(0.02)
		satisfyGoals()
		state = "inside"

		addText(text)
		return

func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.6
	if(getSub().hasBoundArms()):
		theChance *= 0.6
	if(getSub().hasBoundLegs()):
		theChance *= 0.5
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	if(getSexType() == SexType.SlutwallSex):
		theChance *= 0.5
	
	return max(theChance, 5.0)

func getAnimation():
	var shouldUncon = getSubInfo().isUnconscious()
	
	if(getSexType() == SexType.BitchsuitSex):
		if(state in [""]):
			return [StageScene.PuppySexCowgirl, "tease", {npc=SUB_0, pc=DOM_0}]
		if(state in ["knotting", "inside"]):
			return [StageScene.PuppySexCowgirl, "inside", {npc=SUB_0, pc=DOM_0, bodyState={hard=true}}]
		if(getSubInfo().isCloseToCumming() || (isStraponSex() && getDomInfo().isCloseToCumming())):
			return [StageScene.PuppySexCowgirl, "fast", {npc=SUB_0, pc=DOM_0, bodyState={hard=true}}]
		return [StageScene.PuppySexCowgirl, "sex", {npc=SUB_0, pc=DOM_0, bodyState={hard=true}}]
	
	if(getSexType() == SexType.SlutwallSex):
		if(state in [""]):
			return [StageScene.SlutwallRide, "tease", {pc=SUB_0, npc=DOM_0}]
		if(state in ["knotting", "inside"]):
			return [StageScene.SlutwallRide, "inside", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
		if(getSubInfo().isCloseToCumming() || (isStraponSex() && getDomInfo().isCloseToCumming())):
			return [StageScene.SlutwallRide, "fast", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
		return [StageScene.SlutwallRide, "sex", {pc=SUB_0, npc=DOM_0, bodyState={hard=true}}]
	
	var animToPlay = StageScene.SexCowgirl
	if(PoseToAnimName.has(currentPose)):
		animToPlay = PoseToAnimName[currentPose]
	var pcPoseID:int=SUB_0
	var npcPoseID:int=DOM_0
	var pcState:Dictionary = {hard=true}
	var npcState:Dictionary = {}
	if(currentPose == POSE_LOTUS):
		pcPoseID = DOM_0
		npcPoseID = SUB_0
		pcState = {}
		npcState = {hard=true}
	
	if(state in [""]):
		return [animToPlay, "tease", {pc=pcPoseID, npc=npcPoseID, uncon=shouldUncon}]
	if(state in ["knotting", "inside"]):
		return [animToPlay, "inside", {pc=pcPoseID, npc=npcPoseID, uncon=shouldUncon, bodyState=pcState, npcBodyState=npcState}]
	if(getSubInfo().isCloseToCumming() || (isStraponSex() && getDomInfo().isCloseToCumming())):
		if(currentPose == POSE_REVERSECOWGIRL):
			shouldUncon = false
		return [animToPlay, "fast", {pc=pcPoseID, npc=npcPoseID, uncon=shouldUncon, bodyState=pcState, npcBodyState=npcState}]
	return [animToPlay, "sex", {pc=pcPoseID, npc=npcPoseID, uncon=shouldUncon, bodyState=pcState, npcBodyState=npcState}]

func getDomSwitchHoleChance() -> float:
	if(getDomInfo().hasMemory("switchedHoles")):
		return 0.0
	
	var domLikesOtherHoleScore = getDomInfo().fetishScore({otherHoleFetishGiving:1.0, fetishGiving: -0.5})
	
	return max(5.0, domLikesOtherHoleScore * 100.0 * (1.0 - getDomInfo().getAngerScore()))

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == DOM_0):
		if(isStraponSex()):
			return 10
		return 5
	if(_indx == SUB_0):
		if(isStraponSex()):
			return 5
		return 10
	return -1

func getJoinActions(_sexInfo:SexInfoBase):
	if(!(_sexInfo is SexDomInfo)):
		return
	#var theChar:BaseCharacter = _sexInfo.getChar()
	
	if(canSwitchTo("ThreeDDS_Train", [_sexInfo, DOM_0], [SUB_0], [S_VAGINA, usedBodypart])):
		addJoinAction(["trainVag"], "+Train (vag)", "Присоединяйся и трахай киску сабмиссива одновременно!", getJoinActivityScore("ThreeDDS_Train", DOM_0, _sexInfo, getSubInfo(), [S_VAGINA]), {A_CATEGORY: ["Блядь"]})
	if(canSwitchTo("ThreeDDS_Train", [_sexInfo, DOM_0], [SUB_0], [S_ANUS, usedBodypart])):
		addJoinAction(["trainAnal"], "+Train (anal)", "Присоединяйся и трахай задницу сабмиссива одновременно!", getJoinActivityScore("ThreeDDS_Train", DOM_0, _sexInfo, getSubInfo(), [S_ANUS]), {A_CATEGORY: ["Блядь"]})
		
	if(canSwitchTo("ThreeDDS_RideGrind", [DOM_0, _sexInfo], [SUB_0], [usedBodypart])):
		addJoinAction(["rideAndGrind"], "+Тереться лицом", "Присоединяйся и одновременно трусь лицом о сабмиссива!", getJoinActivityScore("ThreeDDS_RideGrind", DOM_1, _sexInfo, getSubInfo()), {A_CATEGORY: ["Блядь"]})
		
		
func doJoinAction(_sexInfo:SexInfoBase, _args):
	if(_args[0] == "trainVag"):
		switchCurrentActivityTo("ThreeDDS_Train", [S_VAGINA, usedBodypart, _sexInfo.getCharID(), true])
	if(_args[0] == "trainAnal"):
		switchCurrentActivityTo("ThreeDDS_Train", [S_ANUS, usedBodypart, _sexInfo.getCharID(), true])
	
	if(_args[0] == "rideAndGrind"):
		switchCurrentActivityTo("ThreeDDS_RideGrind", [usedBodypart, _sexInfo.getCharID()])
	

func saveData():
	var data = .saveData()
	
	data["waitTimer"] = waitTimer
	data["currentPose"] = currentPose
	data["isMakingOut"] = isMakingOut

	return data
	
func loadData(data):
	.loadData(data)
	
	waitTimer = SAVE.loadVar(data, "waitTimer", 0)
	currentPose = SAVE.loadVar(data, "currentPose", "")
	isMakingOut = SAVE.loadVar(data, "isMakingOut", false)
	if(currentPose == ""):
		currentPose = RNG.pick(getAvaiablePoses())
