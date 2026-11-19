extends Reference
class_name SexActivityBase

var id:String = "error"
var uniqueID:int = 0
var sexEngineRef: WeakRef
var hasEnded:bool = false

var subs:Array = []
var doms:Array = []

var startedByDom:bool = true # Can be started by dom?
var startedBySub:bool = false # Can be started by sub?

var state:String = ""

# Here is hope this won't bite me
const DOM_0 = 0
const DOM_1 = 1
const DOM_2 = 2

const SUB_0 = -1
const SUB_1 = -2
const SUB_2 = -3

const S_VAGINA = BodypartSlot.Vagina
const S_ANUS = BodypartSlot.Anus
const S_PENIS = BodypartSlot.Penis
const S_MOUTH = BodypartSlot.Head
const S_HANDS = BodypartSlot.Arms
const S_LEGS = BodypartSlot.Legs
const S_BREASTS = BodypartSlot.Breasts

const I_TEASE = SexActIntensity.Tease
const I_LOW = SexActIntensity.Low
const I_NORMAL = SexActIntensity.Normal
const I_HIGH = SexActIntensity.High

const SPEED_VERYSLOW = 0
const SPEED_SLOW = 1
const SPEED_MEDIUM = 2
const SPEED_FAST = 3

const A_PRIORITY = "priority"
const A_CHANCE = "chance"
const A_ARGS = "args"
const A_CATEGORY = "category"
const A_SCORE = "score"

# Don't save these
var activityName:String = "НОВОЕ ДЕЙСТВИЕ"
var activityDesc:String = "Начать новое действие."
var activityCategory:Array = []

func getDomOrSubInfo(_indx:int) -> SexInfoBase:
	if(_indx >= 0):
		return getDomInfo(_indx)
	return getSubInfo(-_indx-1)
func getDomOrSub(_indx:int) -> BaseCharacter:
	if(_indx >= 0):
		return getDom(_indx)
	return getSub(-_indx-1)
func getDomOrSubID(_indx:int) -> String:
	if(_indx >= 0):
		return getDomID(_indx)
	return getSubID(-_indx-1)

# avoids near-zero values basically
# unClampValue(0.2, 0.1) = 0.2
# unClampValue(0.02, 0.1) = 0.1
# unClampValue(-0.02, 0.1) = -0.1
# 0.0 treated as positive
func unClampValue(_theVal:float, _theBorder:float) -> float:
	if(_theVal >= 0.0 && _theVal <= _theBorder):
		_theVal = _theBorder
	if(_theVal < 0.0 && _theVal > -_theBorder):
		_theVal = -_theBorder
	return _theVal

func addResistanceIfPlayer(_index:int, _am:float = 0.3):
	if(getDomOrSubID(_index) != "pc"):
		return
	var theInfo:SexInfoBase = getDomOrSubInfo(_index)
	if(!theInfo):
		return
	if(theInfo is SexSubInfo):
		theInfo.addResistance(_am)

func exposeToFetish(_indxTarget:int, _fetishID:String, _intensity:int, _indxExposer:int):
	var info1:SexInfoBase = getDomOrSubInfo(_indxTarget)
	
	var fetishScore:float = info1.fetishScore({_fetishID:1.0}) if _fetishID != "" else 1.0
	fetishScore = unClampValue(fetishScore, 0.2)
	
	if(info1 is SexSubInfo):
		info1.addLust(10.0*fetishScore)
		info1.addResistance(-0.1*fetishScore)
		info1.addFear(-0.01*fetishScore)
	
	elif(info1 is SexDomInfo):
		info1.addLust(10.0*fetishScore)
		info1.addAnger(-0.05*fetishScore)
	
#	var theFetish:FetishBase = GlobalRegistry.getFetish(_fetishID)
#	if(theFetish):
#		var fetishMod:float = theFetish.getExposeMod(info1)
#		if(_intensity == I_TEASE):
#			fetishAffect(_indxTarget, _fetishID, 0.1*fetishMod)
#		elif(_intensity == I_LOW):
#			fetishAffect(_indxTarget, _fetishID, 0.25*fetishMod)
#		elif(_intensity == I_NORMAL):
#			fetishAffect(_indxTarget, _fetishID, 1.0*fetishMod)
#		elif(_intensity == I_HIGH):
#			fetishAffect(_indxTarget, _fetishID, 1.5*fetishMod)

func intensityToFetishUpMod(_intensity:int) -> float:
	if(_intensity == I_TEASE):
		return 0.25
	elif(_intensity == I_LOW):
		return 0.5
	elif(_intensity == I_NORMAL):
		return 1.0
	elif(_intensity == I_HIGH):
		return 1.5
	return 1.0
#
#func intensityZone(_intensity:int, _zone:String) -> float:
#	var intensityMod:float = intensityToFetishUpMod(_intensity)
#
#	return 1.0

# Actor grinds target's face with their pussy
func stimulateGrindFace(_indxActor:int, _indxTarget:int, _intensity:int, speedSex:int = SPEED_MEDIUM):
	stimulateLick(_indxTarget, _indxActor, S_VAGINA, _intensity, speedSex)

# Actor licks target's hole (or penis) with their tongue
func stimulateLick(_indxActor:int, _indxTarget:int, _hole:String, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var _fetishID:String = ""
	
	if(_hole in [S_VAGINA, S_PENIS]):
		_fetishID = Fetish.OralSexGiving
	if(_hole == S_ANUS):
		_fetishID = Fetish.RimmingGiving
	
	if(_fetishID == ""):
		return
	
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, S_MOUTH) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, _hole) else -0.5)
	fetishAffect(_indxActor, _fetishID, intensityMod*stimModTarget)
	fetishAffect(_indxTarget, Fetish.getOppositeFetish(_fetishID), intensityMod*stimModTarget)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod)
	
	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, S_MOUTH, _indxTarget, _hole, _intensity, _fetishID, speedSex)

# Actors fucks Target's hole with their penis
func stimulateSex(_indxActor:int, _indxTarget:int, _hole:String, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var _fetishID:String = ""
	
	if(_hole == S_VAGINA):
		_fetishID = Fetish.VaginalSexGiving
	if(_hole == S_ANUS):
		_fetishID = Fetish.AnalSexGiving
	if(_hole == S_MOUTH):
		_fetishID = Fetish.OralSexReceiving
	
	if(_fetishID == ""):
		return
	
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, S_PENIS) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, _hole) else -0.5)
	fetishAffect(_indxActor, _fetishID, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.getOppositeFetish(_fetishID), intensityMod*stimModTarget)
	
	if(isWearingStrapon(_indxActor)):
		if(_hole == S_VAGINA):
			fetishAffect(_indxActor, Fetish.StraponSexVaginal, intensityMod*stimModActor)
		if(_hole == S_ANUS):
			fetishAffect(_indxActor, Fetish.StraponSexAnal, intensityMod*stimModActor)
	
	if(isWearingCondom(_indxActor)):
		fetishAffect(_indxActor, Fetish.Condoms, intensityMod)
		fetishAffect(_indxTarget, Fetish.Condoms, intensityMod)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod*stimModActor)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod*stimModTarget)
	
	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, S_PENIS, _indxTarget, _hole, _intensity, _fetishID, speedSex)

# Actor rides Target's penis with their hole
func stimulateSexRide(_indxActor:int, _indxTarget:int, _hole:String, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var _fetishID:String = ""
	
	if(_hole == S_VAGINA):
		_fetishID = Fetish.VaginalSexReceiving
	if(_hole == S_ANUS):
		_fetishID = Fetish.AnalSexReceiving
	if(_hole == S_MOUTH):
		_fetishID = Fetish.OralSexGiving
	
	if(_fetishID == ""):
		return
	
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, _hole) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, S_PENIS) else -0.5)
	fetishAffect(_indxActor, _fetishID, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.getOppositeFetish(_fetishID), intensityMod*stimModTarget)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod)
	
	if(isWearingCondom(_indxTarget)):
		fetishAffect(_indxActor, Fetish.Condoms, intensityMod)
		fetishAffect(_indxTarget, Fetish.Condoms, intensityMod)
	
	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, _hole, _indxTarget, S_PENIS, _intensity, _fetishID, speedSex)

func stimulateTribadism(_indxActor:int, _indxTarget:int, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, S_VAGINA) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, S_VAGINA) else -0.5)
	fetishAffect(_indxActor, Fetish.Tribadism, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.Tribadism, intensityMod*stimModTarget)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod)

	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, S_VAGINA, _indxTarget, S_VAGINA, _intensity, Fetish.Tribadism, speedSex)

# Actor uses their foot to rub Target's hole (or penis)
func stimulateRubWithFoot(_indxActor:int, _indxTarget:int, _hole:String, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, S_LEGS) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, _hole) else -0.5)
	fetishAffect(_indxActor, Fetish.FeetplayGiving, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.FeetplayReceiving, intensityMod*stimModTarget)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod)

	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, S_LEGS, _indxTarget, _hole, _intensity, Fetish.FeetplayGiving, speedSex)

# Actors uses their _actorPart (mouth or arms) to stimulate Target's breasts
func stimulateBreasts(_indxActor:int, _indxTarget:int, _actorPart:String, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, _actorPart) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, S_BREASTS) else -0.5)
	fetishAffect(_indxActor, Fetish.Lactation, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.Lactation, intensityMod*stimModTarget)
	
	var restraintsAmount:int = getRemovableRestraintsAmount(_indxTarget)
	if(restraintsAmount > 0):
		fetishAffect(_indxActor, Fetish.Rigging, intensityMod*0.2*restraintsAmount*stimModActor)
		fetishAffect(_indxTarget, Fetish.Bondage, intensityMod*0.2*restraintsAmount*stimModTarget)
	
	stimulate(_indxActor, _actorPart, _indxTarget, S_BREASTS, _intensity, Fetish.Lactation, speedSex)

func stimulateStrokePenis(_indxActor:int, _indxTarget:int, _intensity:int, speedSex:int = SPEED_MEDIUM):
	var intensityMod:float = intensityToFetishUpMod(_intensity)
	var stimModActor:float = (1.0 if !isZoneOverstimulated(_indxActor, S_HANDS) else -0.5)
	var stimModTarget:float = (1.0 if !isZoneOverstimulated(_indxTarget, S_PENIS) else -0.5)
	
	fetishAffect(_indxActor, Fetish.SeedMilking, intensityMod*stimModActor)
	fetishAffect(_indxTarget, Fetish.SeedMilking, intensityMod*stimModTarget)
	
	if(isUnconscious(_indxTarget)):
		fetishUp(_indxActor, Fetish.UnconsciousSex, intensityMod)
		fetishUp(_indxTarget, Fetish.UnconsciousSex, intensityMod)

	stimulate(_indxActor, S_HANDS, _indxTarget, S_PENIS, _intensity, Fetish.SeedMilking, speedSex)

func stimulate(_indxActor:int, _slotActor:String, _indxTarget:int, _slotTarget:String, _intensity:int, _fetishID:String, speedSex:int = SPEED_MEDIUM):
	var infoActor:SexInfoBase = getDomOrSubInfo(_indxActor)
	var infoTarget:SexInfoBase = getDomOrSubInfo(_indxTarget)
	
	var targetFetishID:String = Fetish.getOppositeFetish(_fetishID)
	
	exposeToFetish(_indxTarget, targetFetishID, _intensity, _indxActor)
	exposeToFetish(_indxActor, _fetishID, _intensity, _indxTarget)
	
	var fetishScoreActor:float = infoActor.fetishScore({_fetishID:1.0}) if _fetishID != "" else 1.0
	fetishScoreActor = unClampValue(fetishScoreActor, 0.2)
	var fetishScoreTarget:float = infoTarget.fetishScore({targetFetishID:1.0}) if targetFetishID != "" else 1.0
	fetishScoreTarget = unClampValue(fetishScoreTarget, 0.2)
	
	var arousalAdd:float = 0.1
	if(speedSex == SPEED_VERYSLOW):
		arousalAdd = 0.05
	elif(speedSex == SPEED_SLOW):
		arousalAdd = 0.1
	elif(speedSex == SPEED_MEDIUM):
		arousalAdd = 0.2
	elif(speedSex == SPEED_FAST):
		arousalAdd = 0.3
	
	if(_intensity == I_TEASE):
		infoActor.addArousalForeplay(arousalAdd*0.25 + max(fetishScoreActor, -0.5)*0.05)
		infoTarget.addArousalForeplay(arousalAdd*0.25 + max(fetishScoreTarget, -0.5)*0.05)
	elif(_intensity == I_LOW):
		infoActor.stimulateArousalZone(arousalAdd*0.5, _slotActor, 0.5)
		infoTarget.stimulateArousalZone(arousalAdd*0.5, _slotTarget, 0.5)
	elif(_intensity == I_NORMAL):
		infoActor.stimulateArousalZone(arousalAdd, _slotActor, 1.0)
		infoTarget.stimulateArousalZone(arousalAdd, _slotTarget, 1.0)
	elif(_intensity == I_HIGH):
		infoActor.stimulateArousalZone(arousalAdd, _slotActor, 1.5)
		infoTarget.stimulateArousalZone(arousalAdd, _slotTarget, 1.5)

const CHOKE_GENTLE = 0
const CHOKE_NORMAL = 1
const CHOKE_HARD = 2
const CHOKE_VERYHARD = 3

func chokeStrengthFetishMod(_chokeStrength:int) -> float:
	if(_chokeStrength == CHOKE_GENTLE):
		return 0.5
	if(_chokeStrength == CHOKE_NORMAL):
		return 1.0
	if(_chokeStrength == CHOKE_HARD):
		return 1.5
	if(_chokeStrength == CHOKE_VERYHARD):
		return 2.5
	return 1.0

func choke(_indxActor:int, _indxTarget:int, _chokeStrength:int = CHOKE_NORMAL):
	if(_indxActor < 0):
		assert(false, "Subs can't choke")
		return
	if(_indxTarget >= 0):
		assert(false, "Doms can't be choked")
		return
	var actorInfo:SexDomInfo = getDomOrSubInfo(_indxActor)
	var targetInfo:SexSubInfo = getDomOrSubInfo(_indxTarget)
	
	var wasConscious:bool = !targetInfo.isUnconscious()
	
	if(_chokeStrength == CHOKE_VERYHARD):
		targetInfo.addFear(0.3)
		actorInfo.addAnger(-0.05)
	elif(_chokeStrength == CHOKE_HARD):
		targetInfo.addFear(0.1)
		actorInfo.addAnger(-0.05)
	else:
		targetInfo.addFear(0.05)
		actorInfo.addAnger(-0.05)
	
	var targetMasochism:float = fetish(_indxTarget, Fetish.Masochism, -0.5)
	targetInfo.addLust(0.1 * targetMasochism)
	targetInfo.addResistance(-0.2 * targetMasochism)
	
	var actorSadism:float = fetish(_indxActor, Fetish.Sadism, 0.5)
	actorInfo.addLust(0.1 * actorSadism)
	
	if(_chokeStrength == CHOKE_GENTLE):
		targetInfo.addConsciousness(-0.01)
	elif(_chokeStrength == CHOKE_NORMAL):
		targetInfo.addConsciousness(-RNG.randf_range(0.01, 0.05))
	elif(_chokeStrength == CHOKE_HARD):
		targetInfo.addConsciousness(-RNG.randf_range(0.05, 0.2))
	elif(_chokeStrength == CHOKE_VERYHARD):
		targetInfo.addConsciousness(-RNG.randf_range(0.1, 0.25))
	
	var isConsciousNow:bool = !targetInfo.isUnconscious()
	
	if(isConsciousNow):
		fetishAffect(_indxTarget, Fetish.Choking, chokeStrengthFetishMod(_chokeStrength))
	elif(wasConscious): # Got chocked unconscious
		GM.main.RS.sendSocialEvent(actorInfo.getCharID(), targetInfo.getCharID(), SocialEventType.ForcedUnconscious)
	#	fetishUp(_indxTarget, Fetish.Choking, -30.0)
	
	sendSexEvent(SexEvent.Choking, _indxActor, _indxTarget, {strongChoke=(_chokeStrength == CHOKE_HARD)})

const STRIKE_NORMAL = 0
const STRIKE_FULLFORCE = 1

func strike(_indxActor:int, _indxTarget:int, _strikeStrength:int = STRIKE_NORMAL, _isDefense:bool = false, _isIntentional:bool = true):
	if(_indxActor >= 0 && _indxTarget >= 0):
		assert(false, "Doms can't hit doms")
		return
	if(_indxActor < 0 && _indxTarget < 0):
		assert(false, "Subs can't hit subs")
		return
	
	# Dom hits a sub
	if(_indxActor >= 0 && _indxTarget < 0):
		var actorInfo:SexDomInfo = getDomOrSubInfo(_indxActor)
		var targetInfo:SexSubInfo = getDomOrSubInfo(_indxTarget)
		var wasConscious:bool = !targetInfo.isUnconscious()
		
		var targetMasochism:float = fetish(_indxTarget, Fetish.Masochism, -0.5)
		if(_strikeStrength == STRIKE_FULLFORCE):
			targetInfo.addFear(0.3)
			targetInfo.addLust(0.2 * targetMasochism)
			targetInfo.addResistance(-0.05 * targetMasochism)
		else:
			targetInfo.addFear(0.05)
			targetInfo.addLust(0.1 * targetMasochism)
			targetInfo.addResistance(-0.2 * targetMasochism)
		
		var actorSadism:float = fetish(_indxActor, Fetish.Sadism, 0.5)
		var howMuchAddPain:int = 0
		if(_strikeStrength == STRIKE_FULLFORCE):
			howMuchAddPain = RNG.randi_range(15, 25)
			actorInfo.addLust(0.2 * actorSadism)
			actorInfo.addAnger(-0.2)
			fetishAffect(_indxActor, Fetish.Sadism, 3.0)
		else:
			howMuchAddPain = RNG.randi_range(4, 8)
			actorInfo.addLust(0.1 * actorSadism)
			actorInfo.addAnger(-0.1)
			fetishAffect(_indxActor, Fetish.Sadism)
		
		targetInfo.addPain(howMuchAddPain)
		var isConsciousNow:bool = !targetInfo.isUnconscious()
		
		if(isConsciousNow):
			if(_strikeStrength == STRIKE_FULLFORCE):
				fetishAffect(_indxTarget, Fetish.Masochism, 3.0)
			else:
				fetishAffect(_indxTarget, Fetish.Masochism)
		elif(wasConscious): # Got beaten unconscious
			GM.main.RS.sendSocialEvent(actorInfo.getCharID(), targetInfo.getCharID(), SocialEventType.ForcedUnconscious)
			#if(_strikeStrength == STRIKE_FULLFORCE):
			#	fetishUp(_indxTarget, Fetish.Masochism, -50.0)
			#else:
			#	fetishUp(_indxTarget, Fetish.Masochism, -40.0)
			pass
		elif(!isConsciousNow): # Getting beaten while unconscious makes us like uncon sex less
			fetishUp(_indxTarget, Fetish.UnconsciousSex, -3.0)
		
		sendSexEvent(SexEvent.PainInflicted, _indxActor, _indxTarget, {pain=howMuchAddPain,isDefense=_isDefense,intentional=_isIntentional})
	# Sub hits a dom
	if(_indxActor < 0 && _indxTarget >= 0):
		assert(false, "IMPLEMENT ME")

func doStretch(_indxActor:int, _indxTarget:int, _hole:String, showText:bool = true) -> bool:
	if(getDomOrSub(_indxTarget).doPainfullyStretchHole(_hole, getDomOrSubID(_indxActor))):
		if(showText):
			addTextTopBottom("{<BOTTOM>.Your} "+getNameHole(_indxTarget, _hole)+" [b]болезненно растягивается[/b]!", _indxActor, _indxTarget)
			react(SexReaction.PainStrongGeneric, [100.0], [_indxTarget])
		return true
	return false

func doWound(_indxActor:int, _indxTarget:int, showText:bool = true) -> bool:
	if(getDomOrSub(_indxTarget).doWound(getDomOrSubID(_indxActor))):
		if(showText):
			addTextTopBottom("{<BOTTOM>.You} [b]{<BOTTOM>.youVerb('get')} wounded[/b]!", _indxActor, _indxTarget)
			react(SexReaction.PainStrongGeneric, [100.0], [_indxTarget])
		GM.main.RS.sendSocialEvent(getDomOrSubID(_indxActor), getDomOrSubID(_indxTarget), SocialEventType.GotWounded, [getDomOrSub(_indxTarget).getWoundedAmount()])
		return true
	return false

func moan(_indx:int, _theReaction:int = SexReaction.MoanGeneric):
	var theInfo:SexInfoBase = getDomOrSubInfo(_indx)
	if(theInfo.isUnconscious()):
		return
	theInfo.addArousalForeplay(0.02)
	for theSubInfo in subs:
		theSubInfo.addLust(5)
		theSubInfo.addFear(-0.02)
	for theDomInfo in doms:
		theDomInfo.addLust(5)
		theDomInfo.addAnger(-0.02)
	if(_theReaction >= 0):
		react(_theReaction, [100.0], [_indx])
	
func fetish(_indx:int, _fetishID:String, _add:float = 0.0, _unclampVal:float = 0.1) -> float:
	var theInfo:SexInfoBase = getDomOrSubInfo(_indx)
	if(!theInfo):
		return 0.0
	var theVal:float = clamp(theInfo.fetishScore({_fetishID:1.0})+_add, -1.0, 1.0)
	return unClampValue(theVal, _unclampVal)

func personality(_indx:int, _persStatID:String, _add:float = 0.0, _unclampVal:float = 0.1) -> float:
	var theInfo:SexInfoBase = getDomOrSubInfo(_indx)
	if(!theInfo):
		return 0.0
	var theVal:float = clamp(theInfo.personalityScore({_persStatID:1.0})+_add, -1.0, 1.0)
	return unClampValue(theVal, _unclampVal)

func fetishUp(_indx:int, _fetishID:String, _amount:float = 1.0):
	var theInfo = getDomOrSubInfo(_indx)
	if(!theInfo):
		return
	theInfo.fetishUp(_fetishID, _amount)

func fetishAffect(_indx:int, _fetishID:String, _amount:float = 1.0):
	var theInfo = getDomOrSubInfo(_indx)
	if(!theInfo):
		return
	theInfo.fetishAffect(_fetishID, _amount)

const RESIST_BREASTS_FOCUS = 0
const RESIST_NECK_FOCUS = 1
const RESIST_LEGS_FOCUS = 2
const RESIST_HANDS_FOCUS = 3
const RESIST_ORAL_FOCUS = 4
func getResistChance(_indxSub:int, _indxDom:int, resistType:int, baseChance:float, domAngerRemoval:float) -> float:
	#var theSubInfo:SexSubInfo = getDomOrSubInfo(_indxSub)
	var theSub:BaseCharacter = getDomOrSub(_indxSub)
	var theDomInfo:SexDomInfo = getDomOrSubInfo(_indxDom)
	
	var theChance:float = baseChance - theDomInfo.getAngerScore()*domAngerRemoval
	if(resistType == RESIST_BREASTS_FOCUS):
		if(theSub.hasBlockedHands()):
			theChance *= 0.5
		if(theSub.hasBoundArms()):
			theChance *= 0.5
		if(theSub.isBlindfolded()):
			theChance *= 0.8
		if(theSub.hasBoundLegs()):
			theChance *= 0.5
	if(resistType == RESIST_NECK_FOCUS):
		if(theSub.hasBoundArms()):
			theChance *= 0.5
		if(theSub.hasBlockedHands()):
			theChance *= 0.5
		if(theSub.isBlindfolded()):
			theChance *= 0.8
		if(theSub.hasBoundLegs()):
			theChance *= 0.8
		#if(getState() == ""):
		#	theChance *= 0.5
		if(getSexType() in [SexType.SlutwallSex, SexType.StocksSex]):
			theChance *= 0.5
	if(resistType == RESIST_LEGS_FOCUS):
		if(theSub.hasBlockedHands()):
			theChance *= 0.8
		if(theSub.hasBoundArms()):
			theChance *= 0.8
		if(theSub.isBlindfolded()):
			theChance *= 0.8
		if(theSub.hasBoundLegs()):
			theChance *= 0.5
	if(resistType == RESIST_HANDS_FOCUS):
		if(theSub.hasBlockedHands()):
			theChance *= 0.5
		if(theSub.hasBoundArms()):
			theChance *= 0.5
		if(theSub.isBlindfolded()):
			theChance *= 0.8
	if(resistType == RESIST_ORAL_FOCUS):
		if(theSub.hasBlockedHands()):
			theChance *= 0.5
		if(theSub.hasBoundArms()):
			theChance *= 0.5
		if(theSub.isBlindfolded()):
			theChance *= 0.8
		if(getSexType() == SexType.SlutwallSex):
			theChance *= 0.5
	
	return max(theChance, 5.0)

func addOutputRaw(_rawEntry:Array):
	getSexEngine().addOutputRaw(_rawEntry)

func talkText(_indx1:int, _text:String):
	if(_text.empty()):
		return
	var theInfo := getDomOrSubInfo(_indx1)
	if(theInfo.isUnconscious()):
		return
	if(_indx1 >= 0 && getSexEngine().domsNoTalking):
		return
	addOutputRaw([SexEngine.OUTPUT_SAY, theInfo.getCharID(), processText(_text)])

func react(_reactionID:int, _chances:Array = [100.0, 100.0], _actors:Array = [DOM_0, SUB_0], _args:Array = []):
	var allHandlers:Array = GlobalRegistry.getSexReactionHandlersFor(_reactionID)
	if(allHandlers.empty()):
		return
	var handlersWeights:Array = []
	for handler in allHandlers:
		handlersWeights.append(handler.handlerWeight)
	
	var pickedHandler = RNG.pickWeighted(allHandlers, handlersWeights)
	pickedHandler.doReactFinal(_reactionID, _actors, _chances, self, getSexEngine(), _args)


func reactSub(_reactionID:int, _chances:Array = [100.0, 100.0], _actors:Array = [SUB_0, DOM_0], _args:Array = []):
	react(_reactionID, _chances, _actors, _args)
	
func addText(_text:String):
	if(_text.empty()):
		return
	addOutputRaw([SexEngine.OUTPUT_TEXT, processText(_text)])

func addTextPick(_texts:Array):
	if(_texts.empty()):
		return
	addText(RNG.pick(_texts))

func addTextRaw(_text:String):
	if(_text.empty()):
		return
	addOutputRaw([SexEngine.OUTPUT_TEXT, (_text)])

func addTextRawPick(_texts:Array):
	if(_texts.empty()):
		return
	addTextRaw(RNG.pick(_texts))

func indxToTextID(_indx:int) -> String:
	if(_indx == 0):
		return "dom"
	if(_indx == -1):
		return "sub"
	if(_indx > 0):
		return "dom"+str(_indx)
	return "sub"+str(-_indx-1)

func processText(_text:String) -> String:
	var theOverrides:Dictionary = {}
	var _i:int = 0
	for theSubInfo in subs:
		if(_i == 0):
			theOverrides["sub"] = theSubInfo.getCharID()
		else:
			theOverrides["sub"+str(_i)] = theSubInfo.getCharID()
		_i += 1
	_i = 0
	for theDomInfo in doms:
		if(_i == 0):
			theOverrides["dom"] = theDomInfo.getCharID()
		else:
			theOverrides["dom"+str(_i)] = theDomInfo.getCharID()
		_i += 1
	return GM.ui.processString(_text, theOverrides)

func hasBodypartUncovered(_indx:int, bodypartSlot:String) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return (theChar.getFirstItemThatCoversBodypart(bodypartSlot) == null)

const INDX_NOT_FOUND = -9999

func convertCharIDToIndx(_charID:String) -> int:
	for _i in range(doms.size()):
		if(doms[_i].getCharID() == _charID):
			return _i
	for _i in range(subs.size()):
		if(subs[_i].getCharID() == _charID):
			return -_i-1
	return INDX_NOT_FOUND

func doActionForCharID(_charID:String, _action:Dictionary):
	var _indx:int = convertCharIDToIndx(_charID)
	if(_indx <= INDX_NOT_FOUND):
		return
	
	if(has_method(getStatePrefix()+"_doAction")):
		call(getStatePrefix()+"_doAction", _indx, _action["id"], _action)
	doAction(_indx, _action["id"], _action)

func getJoinActions(_sexInfo:SexInfoBase):
	pass

func getJoinActionsFinal(_sexInfo:SexInfoBase) -> Array:
	actionsResult = []
	getJoinActions(_sexInfo)
	return actionsResult

func doJoinAction(_sexInfo:SexInfoBase, _args):
	pass

func addJoinAction(_aArgs:Array, _aName:String, _aDesc:String, _aScore:float, _aExtra:Dictionary = {}):
	var theCategory:Array = getCategory() if !_aExtra.has(A_CATEGORY) else []
	var theEntry:Dictionary = {
		score = _aScore,
		name = _aName,
		desc = _aDesc,
		category = theCategory,
		args = _aArgs,
	}
	for field in _aExtra:
		theEntry[field] = _aExtra[field]
	
	actionsResult.append(theEntry)

var actionsResult:Array
func getActionsForCharID(_charID:String) -> Array:
	actionsResult = []
	
	var _indx:int = convertCharIDToIndx(_charID)
	if(_indx <= -9999):
		return []
	
	if(has_method(getStatePrefix()+"_getActions")):
		call(getStatePrefix()+"_getActions", _indx)
	getActions(_indx)
	
	return actionsResult

func getActions(_indx:int):
	pass
	
func doAction(_indx:int, _id:String, _action:Dictionary):
	pass

func addAction(_aID:String, _aScore:float, _aName:String, _aDesc:String, _aExtra:Dictionary = {}):
	var theEntry:Dictionary = {
		id = _aID,
		score = _aScore,
		name = _aName,
		desc = _aDesc,
	}
	for field in _aExtra:
		theEntry[field] = _aExtra[field]
	
	actionsResult.append(theEntry)

func addStartAction(_aArgs:Array, _aName:String, _aDesc:String, _aScore:float, _aExtra:Dictionary = {}):
	var theCategory:Array = getCategory() if !_aExtra.has(A_CATEGORY) else []
	var theEntry:Dictionary = {
		score = _aScore,
		name = _aName,
		desc = _aDesc,
		category = theCategory,
		args = _aArgs,
	}
	for field in _aExtra:
		theEntry[field] = _aExtra[field]
	
	actionsResult.append(theEntry)

func getSubInfo(_indx:int = 0) -> SexSubInfo:
	if(_indx < 0 || _indx >= subs.size()):
		Log.printerr("Sex activity with ID "+str(id)+" tries to access non-existant sub info with index "+str(_indx))
		return null
	return subs[_indx]
	
func getDomInfo(_indx:int = 0) -> SexDomInfo:
	if(_indx < 0 || _indx >= doms.size()):
		Log.printerr("Sex activity with ID "+str(id)+" tries to access non-existant dom info with index "+str(_indx))
		return null
	return doms[_indx]

func getSubID(_indx:int = 0) -> String:
	if(_indx < 0 || _indx >= subs.size()):
		Log.printerr("Sex activity with ID "+str(id)+" tries to access non-existant sub with index "+str(_indx))
		return ""
	return subs[_indx].charID

func getDomID(_indx:int = 0) -> String:
	if(_indx < 0 || _indx >= doms.size()):
		Log.printerr("Sex activity with ID "+str(id)+" tries to access non-existant dom with index "+str(_indx))
		return ""
	return doms[_indx].charID

func getSub(_indx:int = 0) -> BaseCharacter:
	var theSubInfo := getSubInfo(_indx)
	if(!theSubInfo):
		return null
	return theSubInfo.getChar()

func getDom(_indx:int = 0) -> BaseCharacter:
	var theDomInfo := getDomInfo(_indx)
	if(!theDomInfo):
		return null
	return theDomInfo.getChar()

func switchSubs(_indx1:int=0, _indx2:int=1):
	var subInfo1:SexSubInfo = subs[_indx1]
	subs[_indx1] = subs[_indx2]
	subs[_indx2] = subInfo1

func switchDoms(_indx1:int=0, _indx2:int=1):
	var domInfo1:SexDomInfo = doms[_indx1]
	doms[_indx1] = doms[_indx2]
	doms[_indx2] = domInfo1

func indxToOverrideName(_indx:int) -> String:
	if(_indx == SUB_0):
		return "sub"
	if(_indx == DOM_0):
		return "dom"
	if(_indx == SUB_1):
		return "sub1"
	if(_indx == DOM_1):
		return "dom1"
	if(_indx > 0):
		return "dom"+str(_indx)
	if(_indx < 0):
		return "sub"+str(-_indx-1)
	
	return "ERROR"

func getThroughClothingText(_indx:int, _slot:String) -> String:
	var theChar := getDomOrSub(_indx)
	var clothingItem = theChar.getFirstItemThatCoversBodypart(_slot)
	var throughTheClothing:String = ""
	if(clothingItem != null):
		throughTheClothing = " through {"+getDomOrSubID(_indx)+".yourHis} "+clothingItem.getCasualName()
	return throughTheClothing

func getThroughClothingTextCustom(_indx:int, _slot:String, _customText:String) -> String:
	var theChar := getDomOrSub(_indx)
	var clothingItem = theChar.getFirstItemThatCoversBodypart(_slot)
	var throughTheClothing:String = ""
	if(clothingItem != null):
		throughTheClothing = _customText
	return throughTheClothing

func isCloseToCumming(_indx:int) -> bool:
	return getDomOrSubInfo(_indx).isCloseToCumming()
	
func isReadyToCum(_indx:int) -> bool:
	return getDomOrSubInfo(_indx).isReadyToCum()

func isReadyToCumHandled(_indx:int) -> bool:
	return isReadyToCum(_indx) && isHandlingOrgasms(_indx)

func canDoActions(_indx:int) -> bool:
	return getDomOrSubInfo(_indx).canDoActions()

func isUnconscious(_indx:int) -> bool:
	return getDomOrSubInfo(_indx).isUnconscious()

func getRemovableRestraintsAmount(_indx:int) -> int:
	return getDomOrSub(_indx).getInventory().getRemovableRestraintsAmount()

func isZoneOverstimulated(_indx:int, _slot:String) -> bool:
	return getDomOrSub(_indx).isZoneOverstimulated(_slot)

func getVisibleName() -> String:
	return activityName

func getVisibleDesc() -> String:
	return activityDesc

func getCategory() -> Array:
	return activityCategory

func getSexEngine() -> SexEngine:
	if(sexEngineRef == null):
		return null
	return sexEngineRef.get_ref()

func initParticipants(theDoms, theSubs):
	if(theDoms is String):
		theDoms = [theDoms]
	if(theSubs is String):
		theSubs = [theSubs]
	
	doms.clear()
	subs.clear()
	
	for theDomID in theDoms:
		doms.append(getSexEngine().getDomInfo(theDomID))
	for theSubID in theSubs:
		subs.append(getSexEngine().getSubInfo(theSubID))

# Will automatically end the activity if this returns true
func isActivityImpossibleShouldStop() -> bool:
	return false

func endActivity():
	if(!hasEnded):
		hasEnded = true
		onActivityEnd()
		if(getSexEngine()):
			getSexEngine().reconsiderPCTarget()
	
	hasEnded = true

func onActivityEnd():
	pass

func getGoals():
	return {}

func getGoalsFor(_indx:int, _args:Array) -> Dictionary:
	return getGoals()

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
	}

func getSexType():
	return getSexEngine().getSexTypeID()

func isTentaclesSex() -> bool:
	return getSexType() == SexType.TentaclesSex

func satisfyGoals():
	var goalData = getGoals()
	var sexEngine = getSexEngine()
	
	for theDomInfo in doms:
		for theSubInfo in subs:
			for goalID in goalData:
				sexEngine.satisfyGoal(theDomInfo, goalID, theSubInfo)

func satisfyGoal(goalID):
	var sexEngine = getSexEngine()
	for theDomInfo in doms:
		for theSubInfo in subs:
			sexEngine.satisfyGoal(theDomInfo, goalID, theSubInfo)

func failGoals():
	var goalData = getGoals()
	var sexEngine = getSexEngine()
	
	for theDomInfo in doms:
		for theSubInfo in subs:
			for goalID in goalData:
				sexEngine.failGoal(theDomInfo, goalID, theSubInfo)

func failGoal(goalID):
	var sexEngine = getSexEngine()
	for theDomInfo in doms:
		for theSubInfo in subs:
			sexEngine.failGoal(theDomInfo, goalID, theSubInfo)

func replaceGoalsTo(newgoalID, replaceAll = true):
	var goalData = getGoals()
	var sexEngine = getSexEngine()
	
	for theDomInfo in doms:
		for theSubInfo in subs:
			for goalID in goalData:
				sexEngine.replaceGoal(theDomInfo, goalID, theSubInfo, newgoalID, replaceAll)

func progressGoal(goalid, args = []):
	for theDomInfo in doms:
		for theSubInfo in subs:
			getSexEngine().progressGoal(theDomInfo, goalid, theSubInfo, args)

func progressGoalFailed(goalid, args = []):
	for theDomInfo in doms:
		for theSubInfo in subs:
			getSexEngine().progressGoalFailed(theDomInfo, goalid, theSubInfo, args)

func replaceRandomGoalSmart(_domIndx:int, _subIndx:int, _goalID:String) -> bool:
	var theInfo = getDomOrSubInfo(_domIndx)
	var theInfo2 = getDomOrSubInfo(_subIndx)
	var theEngine := getSexEngine()
	var theGoal:SexGoalBase = GlobalRegistry.getSexGoal(_goalID)
	if(!theInfo || !theGoal || !(theInfo is SexDomInfo) || !theInfo2 || !(theInfo2 is SexSubInfo)):
		return false
	var theDomInfo:SexDomInfo = theInfo
	var theSubInfo:SexSubInfo = theInfo2
	
	var domGoalsGoalToIndx:Dictionary = {}
	var _i:int = 0
	for goalEntry in theDomInfo.goals:
		if(goalEntry[1] != theSubInfo.getCharID() || goalEntry[0] == _goalID):
			_i += 1
			continue
		domGoalsGoalToIndx[goalEntry[0]] = _i
		#domGoalsList.append(goalEntry[0])
		_i += 1
	
	if(domGoalsGoalToIndx.empty()):
		var theGoalData = theGoal.generateData(getSexEngine(), theDomInfo, theSubInfo)
		theDomInfo.goals.append([_goalID, theSubInfo.getCharID(), theGoalData])
		print("NO GOALS FOUND TO REPLACE. JUST ADDED A NEW GOAL.")
		return true
	
	# We go through each activity that involves the two chars
	# We get the goals of those activities
	# We go through dom goals. If one of those goals is satisfied by the activity, we replace that goal specifically
	
	for theActivity in theEngine.activities:
		if(!theActivity.doms.has(theDomInfo) || !theActivity.subs.has(theSubInfo)):
			continue
		
		var theGoals:Dictionary = theActivity.getGoals()
		for theActivityGoalID in theGoals:
			if(domGoalsGoalToIndx.has(theActivityGoalID)):
				var goalIndxToRemove:int = domGoalsGoalToIndx[theActivityGoalID]
				theDomInfo.goals.remove(goalIndxToRemove)
				var theGoalData = theGoal.generateData(getSexEngine(), theDomInfo, theSubInfo)
				theDomInfo.goals.append([_goalID, theSubInfo.getCharID(), theGoalData])
				print("REPLACED THE CURRENT GOAL AND ADDED A NEW ONE.")
				return true
	
	#Remove random goal
	var goalIndxToRemove:int = RNG.pick(domGoalsGoalToIndx.values())
	theDomInfo.goals.remove(goalIndxToRemove)
	
	var theGoalData = theGoal.generateData(getSexEngine(), theDomInfo, theSubInfo)
	theDomInfo.goals.append([_goalID, theSubInfo.getCharID(), theGoalData])
	print("REMOVED RANDOM GOAL AND ADDED A NEW ONE.")
	return true

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return tagsNotBusy(_sexEngine, _domInfo, _subInfo) && !hasActivity(_sexEngine, id, _domInfo, _subInfo)

func getStartActions(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	addStartAction([], getVisibleName(), getVisibleDesc(), getActivityScore(_sexEngine, _domInfo, _subInfo))

func getStartActionsFinal(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo) -> Array:
	actionsResult = []
	getStartActions(_sexEngine, _domInfo, _subInfo)
	return actionsResult

func canBeStartedByDom() -> bool:
	return startedByDom
	
func canBeStartedBySub() -> bool:
	return startedBySub

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 0.0

func getActivityScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	#print(id," ",getActivityScoreCustomGoals(getGoals(), _sexEngine, _domInfo, _subInfo))
	return getActivityScoreCustomGoals(getGoals(), _sexEngine, _domInfo, _subInfo)

func getActivityScoreCustomGoals(goalData, _sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var resultScore = getActivityBaseScore(_sexEngine, _domInfo, _subInfo)
	var addToScore = 0.0
	
	for goalID in goalData:
		#if(_sexEngine.hasGoal(_domInfo, goalID, _subInfo)):
		addToScore = max(addToScore, goalData[goalID] * _sexEngine.hasGoalScore(_domInfo, goalID, _subInfo))

	return (resultScore + addToScore) * getActivityScoreMult(_sexEngine, _domInfo, _subInfo)

func getActivityScoreMult(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 1.0

func getStopSexScore(_indx:int) -> float:
	if(_indx < 0):
		return 0.0
	var theInfo = getDomOrSubInfo(_indx)
	if(!theInfo):
		return 0.0
	if(theInfo.hasGoals()):
		return 0.0
	return 1.0

func canStopSexWithThisActivity() -> bool:
	return false

func getStopScore() -> float:
	var sexEngine := getSexEngine()
	
	var activityScore:float = 0.0
	for theDomInfo in doms:
		# If one of the doms in this activity is player, never automatically stop
		if(theDomInfo.getCharID() == "pc"):
			return 0.0
		for theSubInfo in subs:
			activityScore += max(getActivityScore(sexEngine, theDomInfo, theSubInfo), 0.0)
		
	if(activityScore > 0.0):
		return 0.0
	return 2.0

func getPauseSexScore(_indxTop:int, _indxBottom:int, _slotBottom:String, _slotTop:String = BodypartSlot.Penis) -> float:
	var topChar:BaseCharacter = getDomOrSub(_indxTop)
	var bottomChar:BaseCharacter = getDomOrSub(_indxBottom)
	
	var topOverStim:float = topChar.getZoneOverstimulation(_slotTop)
	if(topOverStim < 0.8):
		topOverStim = 0.0
	if(topChar.isZoneOverstimulated(_slotTop)):
		topOverStim = 1.0
	
	var bottomOverStim:float = bottomChar.getZoneOverstimulation(_slotBottom)
	if(bottomOverStim < 0.8):
		bottomOverStim = 0.0
	if(bottomChar.isZoneOverstimulated(_slotBottom)):
		bottomOverStim = 1.0
	
	var slowdownScore:float = topOverStim * (1.0 - (personality(_indxTop, PersonalityStat.Impatient)+1.0)/2.0)
	
	slowdownScore = max(slowdownScore, bottomOverStim * (1.0 - (personality(_indxTop, PersonalityStat.Mean)+1.0)/2.0))
	
	return slowdownScore

func getContinueSexScore(_indxTop:int, _indxBottom:int, _hole:String, _slotTop:String = BodypartSlot.Penis) -> float:
	var thePauseScore:float = getPauseSexScore(_indxTop, _indxBottom, _hole, _slotTop)
	if(thePauseScore > 0.1):
		return 0.0
	return 1.0


func hasActivity(_sexEngine: SexEngine, theid:String, _domInfo: SexDomInfo, _subInfo: SexSubInfo) -> bool:
	return _sexEngine.hasActivity(theid, _domInfo.charID, _subInfo.charID)

func tagsNotBusy(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var domTags:Array = getCheckTagsDom()
	for tag in domTags:
		if(_sexEngine.hasTag(_domInfo.charID, tag)):
			return false
			
	var subTags:Array = getCheckTagsSub()
	for tag in subTags:
		if(_sexEngine.hasTag(_subInfo.charID, tag)):
			return false
	
	return true

func startActivity(_args):
	pass

func onSwitchFrom(_otherActivity, _args):
	pass

func switchCurrentActivityTo(newactivityID, _args = []):
	getSexEngine().switchActivity(self, newactivityID, _args)

func getTags(_indx:int) -> Array:
	return []

func getCheckTagsDom() -> Array:
	return getTags(DOM_0)

func getCheckTagsSub() -> Array:
	return getTags(SUB_0)

func isAllowedAsRoleFinal(_sexEngine, _indx:int, _sexInfo:SexInfoBase, skipTagsCheck:bool, _args:Array) -> bool:
	if(!_sexInfo):
		return false
	if(!_sexEngine.areSexTypesSupportedForActivity(self)):
		return false
	if(_indx >= 0 && !(_sexInfo is SexDomInfo)):
		return false
	if(_indx < 0 && !(_sexInfo is SexSubInfo)):
		return false
	#return tagsNotBusy(_sexEngine, _domInfo, _subInfo) && !hasActivity(_sexEngine, id, _domInfo, _subInfo)
	if(_sexEngine.hasActivityWithInfo(id, _sexInfo)):
		return false
	return isAllowedAsRole(_sexEngine, _indx, _sexInfo, skipTagsCheck, _args)

func isAllowedAsRole(_sexEngine, _indx:int, _sexInfo:SexInfoBase, _skipTagsCheck:bool, _args:Array) -> bool:
	return true

func getLeashes() -> Dictionary:
	return {}

func hasAnyTag(_sexEngine, _sexInfo:SexInfoBase, _tags:Array) -> bool:
	for tag in _tags:
		if(_sexEngine.hasTag(_sexInfo.charID, tag)):
			return true
	return false

func canSwitchTo(_activityID:String, theDoms:Array, theSubs:Array, _args:Array = []) -> bool:
	var newDoms:Array = []
	var newSubs:Array = []
	for domEntry in theDoms:
		if(domEntry is int):
			newDoms.append([getDomOrSubInfo(domEntry), true])
		else:
			newDoms.append([domEntry, false])
	for subEntry in theSubs:
		if(subEntry is int):
			newSubs.append([getDomOrSubInfo(subEntry), true])
		else:
			newSubs.append([subEntry, false])
	var theEngine:=getSexEngine()
	
	if(!theEngine.isAllowedAsRoles(_activityID, newDoms, newSubs, _args)):
		return false
	return true

func getJoinActivityScore(_activityID:String, _charIndx:int, _domInfo:SexDomInfo, _subInfo:SexSubInfo, _args:Array = []) -> float:
	var theActivity = GlobalRegistry.getSexActivityReference(_activityID)
	if(!theActivity):
		return 0.0
	var theEngine:=getSexEngine()
	var addToScore:float = 0.0
	
	var goalData:Dictionary = theActivity.getGoalsFor(_charIndx, _args)
	for goalID in goalData:
		addToScore = max(addToScore, goalData[goalID] * theEngine.hasGoalScore(_domInfo, goalID, _subInfo))
	
	return addToScore

func processTurnFinal():
	if(has_method(getStatePrefix()+"_processTurn")):
		call(getStatePrefix()+"_processTurn")
	processTurn()

func processTurn():
	pass

func reactActivityEnd(_otheractivity):
	pass
	
func getAnimationPriority():
	return 10

func getAnimation():
	return null

func isAnimOptional() -> bool:
	return false

func getAnimationFinal():
	var theAnim = getAnimation()
	if(theAnim == null):
		return null
	if(theAnim.size() <= 2):
		theAnim.append({})
		return theAnim
	var theDict:Dictionary = theAnim[2]
	for field in ["pc", "npc", "npc2", "npc3"]:
		if(theDict.has(field)):
			if(theDict[field] is int):
				theDict[field] = getDomOrSubID(theDict[field])
	return theAnim

func hasAnimsToPlay() -> bool:
	return getAnimationFinal() != null

func isSub(_charID:String) -> bool:
	for theSubInfo in subs:
		if(theSubInfo.getCharID() == _charID):
			return true
	return false

func isDom(_charID:String) -> bool:
	for theDomInfo in doms:
		if(theDomInfo.getCharID() == _charID):
			return true
	return false

func isInvolved(_charID:String) -> bool:
	if(isSub(_charID) || isDom(_charID)):
		return true
	return false

func checkActiveDomPC(_indx:int) -> bool:
	var _i:int = 0
	for theDomInfo in doms:
		if(theDomInfo.getCharID() == "pc" && theDomInfo.canDoActions()):
			if(_indx != _i):
				return true
		_i += 1
	return false

func checkActiveDomPCUnlessStrapon(_indx:int) -> bool:
	if(GM.pc.isWearingStrapon()): # Hack-ish but it should work fine
		return false
	return checkActiveDomPC(_indx)

func affectSub(howmuch:float, lustMod, resistanceMod, fearMod):
	if(lustMod != 0.0):
		getSub().addLust(int(round(howmuch * lustMod * 100.0)))
	if(resistanceMod != 0.0):
		getSubInfo(0).addResistance(howmuch * resistanceMod)
	if(fearMod != 0.0):
		getSubInfo(0).addFear(max(howmuch * fearMod, 0.01))

func affectDom(howmuch:float, lustMod, angerMod):
	if(lustMod != 0.0):
		getDom().addLust(int(round(howmuch * lustMod * 100.0)))
	if(angerMod != 0.0):
		getDomInfo(0).addAnger(howmuch * angerMod)

func getOrgasmHandlePriority(_indx:int) -> int:
	return -1

func isHandlingOrgasms(_indx:int) -> bool:
	return getOrgasmHandlePriority(_indx) >= getSexEngine().getMaxOrgasmHandlePriority(getDomOrSubID(_indx))

func getResistScore(_indx:int) -> float:
	if(_indx >= 0):
		assert(false, "getResistScore function can only be called for subs!")
		return 0.0
	var theInfo := getDomOrSubInfo(_indx)
	if(!theInfo):
		Log.printerr("getResistScore: No character with id "+str(_indx)+" found in the sex activity")
		return 0.0
	return theInfo.getResistScore()

func getComplyScore(_indx:int) -> float:
	if(_indx >= 0):
		assert(false, "getComplyScore function can only be called for subs!")
		return 0.0
	var theInfo := getDomOrSubInfo(_indx)
	if(!theInfo):
		Log.printerr("getComplyScore: No character with id "+str(_indx)+" found in the sex activity")
		return 0.0
	return theInfo.getComplyScore()

func getGenericOrgasmData(_indx:int, extraText = ""):
	var theCharID:String = getDomOrSubID(_indx)
	if(theCharID == ""):
		return ""
	var character:BaseCharacter = getDomOrSub(_indx)
	if(!character):
		return ""
	var text = RNG.pick([
		"[b]Мощный оргазм[/b] захлестывает тело {<ORGASMER>.your}"+str(extraText)+".",
		"[b]{<ORGASMER>.You} {<ORGASMER>.youVerb('cum')}[/b] hard"+str(extraText)+"!",
	])
	
	if(character.hasPenis()):
		if(character.isWearingChastityCage()):
			text += RNG.pick([
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" разбрызгивая свой заряд сквозь тесную девственную клетку!",
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" выстреливает слабой порцией сквозь отверстие в клетке!",
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" пульсирует внутри запертой клетки, растрачивая свое семя!",
			])
		else:
			text += RNG.pick([
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" разбрызгивает свой заряд!",
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" выстреливает порцией!",
				" {<ORGASMER>.YourHis} "+RNG.pick(["cock", "dick", "member"])+" пульсирует, извергая свое семя!",
			])
	if(character.hasVagina()):
		text += RNG.pick([
			" {<ORGASMER>.YourHis} "+RNG.pick(["pussy", "slit"])+" сжимается!",
			" {<ORGASMER>.YourHis} "+RNG.pick(["pussy", "slit"])+" сжимается и дергается!",
			" {<ORGASMER>.YourHis} "+RNG.pick(["pussy", "slit"])+" пульсирует неритмично!",
			" {<ORGASMER>.YourHis} "+RNG.pick(["pussy", "slit"])+" брызжет!",
		])
	if(character.getWornPenisPump() != null):
		var penisPump:ItemBase = character.getWornPenisPump()
		var howMuchFluids = penisPump.getFluids().getFluidAmount()
		var isFull = penisPump.getFluids().isFull()
		text += RNG.pick([
			" насос для {<ORGASMER>.YourHis} собрал всю порцию и теперь удерживает "+str(Util.roundF(howMuchFluids, 1))+" мл {<ORGASMER>.cum}!"
		])
		if(isFull):
			text += RNG.pick([
				" Насос полон!"
			])
	
	text = text.replace("<ORGASMER>", theCharID)
	
	return text

func addGenericOrgasmText(_indx:int, extraText:String = ""):
	addText(getGenericOrgasmData(_indx, extraText))

func applyTallymarkIfNeeded(bodypartSlot:String):
	#if(getDom().isPlayer()):
	#	return null
	
	if(getSub().isPlayer() && GM.main.getEncounterSettings().isGoalDisabledForSubPC(SexGoal.AddTallymarks)):
		return

	var chanceToAdd:float = 0.0
	var domBodywritingsScale: float = (getDomInfo(0).fetishScore({Fetish.Bodywritings: 1.0}) + 1.0)/2.0 # makes it a [0.0-1.0] value
	
	if(getSub().hasTallymarks() || getSexType() in [SexType.SlutwallSex, SexType.StocksSex]):
		chanceToAdd = 200.0
	else:
		chanceToAdd = (max(0.0, getDomInfo(0).fetishScore({Fetish.Bodywritings: 1.0})) + getDomInfo(0).personalityScore({PersonalityStat.Mean: 0.3})) * 100.0
		if(!getDomInfo(0).isAngry()):
			chanceToAdd *= 0.5
	chanceToAdd *= domBodywritingsScale
	
	if(!RNG.chance(chanceToAdd)):
		return
	
	var theZone = null
	if(bodypartSlot == BodypartSlot.Head):
		theZone = getSub().addTallymarkFace()
	elif(bodypartSlot == BodypartSlot.Vagina):
		theZone = getSub().addTallymarkCrotch()
	else:
		theZone = getSub().addTallymarkButt()
	var zoneText = "body"
	if(theZone != null && theZone is int):
		zoneText = BodyWritingsZone.getZoneVisibleName(theZone)
	
	addTextPick([
		"{dom.You} "+RNG.pick(["{dom.youVerb('draw')}"])+" [b]tallymark[/b] на {sub.your} "+zoneText+".",
		"{dom.You} "+RNG.pick(["{dom.youVerb('add')}"])+" [b]tallymark[/b] к {sub.your} "+zoneText+".",
	])
	
	var tallymarkCount:int = getSub().getTallymarkCount()
	fetishAffect(SUB_0, Fetish.Bodywritings, sqrt(tallymarkCount))

func sendSexEvent(type, sourceIndx:int = DOM_0, targetIndx:int = SUB_0, data = {}):
	var source:String = getDomOrSubID(sourceIndx)
	var target:String = getDomOrSubID(targetIndx)
	if(source == ""):
		source = getDomID(0)
	if(target == ""):
		target = getSubID(0)
	
	var newSexEvent:SexEvent = SexEvent.new()
	newSexEvent.type = type
	newSexEvent.sourceCharID = source
	newSexEvent.targetCharID = target
	newSexEvent.data = data
	newSexEvent.isSexEngine = true
	newSexEvent.sexEngine = getSexEngine()
	
	getDom().sendSexEvent(newSexEvent)
	if(getSub() != getDom()):
		getSub().sendSexEvent(newSexEvent)
	
func damageClothes(_indx:int) -> String:
	var damageClothesResult = getDomOrSub(_indx).damageClothes()
	if(damageClothesResult[0]):
		return "[b]"+damageClothesResult[2].getVisibleName()+" получил повреждения![/b] "+damageClothesResult[1]
	return ""
	
func getState() -> String:
	return state

func getStatePrefix() -> String:
	if(state == ""):
		return "init"
	return state

func setState(_newState:String):
	state = _newState
	
func saveData():
	var subsData:Array = []
	for theSubInfo in subs:
		subsData.append(theSubInfo.getCharID())
	var domsData:Array = []
	for theDomInfo in doms:
		domsData.append(theDomInfo.getCharID())
	
	var data = {
		"uniqueID": uniqueID,
		"subs": subsData,
		"doms": domsData,
		"hasEnded": hasEnded,
		"state": state,
	}

	return data
	
func loadData(data):
	uniqueID = SAVE.loadVar(data, "uniqueID", 0)
	hasEnded = SAVE.loadVar(data, "hasEnded", false)
	state = SAVE.loadVar(data, "state", "")
	
	var theSexEngine := getSexEngine()
	
	var subsData:Array = SAVE.loadVar(data, "subs", [])
	subs.clear()
	for theSubID in subsData:
		subs.append(theSexEngine.getSubInfo(theSubID))
	
	var domsData:Array = SAVE.loadVar(data, "doms", [])
	doms.clear()
	for theDomID in domsData:
		doms.append(theSexEngine.getDomInfo(theDomID))

# Condition stuff below
enum {
	COND_HasReachablePenisOrStrapon,
	COND_AllowUnconsciousOrDowned,
	COND_HasReachableAnus,
}

func doesCharSatisfyCondition(_sexEngine, _charInfo:SexInfoBase, condEntry) -> bool:
	var _char:BaseCharacter = _charInfo.getChar()
	if(condEntry == COND_HasReachablePenisOrStrapon):
		if(!_char.hasReachablePenis() && !_char.isWearingStrapon()):
			return false
	if(condEntry == COND_HasReachableAnus):
		if(!_char.hasReachableAnus()):
			return false
	
	return true

func getDomIDsThatSatisfyConditions(_sexEngine, _condList:Array, _amount:int, _ignoreList:Array) -> Array:
	var result:Array = []
	
	var allowUncon:bool = (COND_AllowUnconsciousOrDowned in _condList)
	
	var theChars:Array = _sexEngine.doms.keys()
	theChars.shuffle()
	for theDomID in theChars:
		if(result.size() >= _amount):
			break
		if(theDomID in _ignoreList):
			continue
		var domInfo:SexDomInfo = _sexEngine.doms[theDomID]
		#var dom:BaseCharacter = domInfo.getChar()
		
		if(!allowUncon && domInfo.getIsDown()):
			continue
		
		var nopeCondition:bool = false
		for condEntry in _condList:
			if(!doesCharSatisfyCondition(_sexEngine, domInfo, condEntry)):
				nopeCondition = true
				break
		if(nopeCondition):
			continue
		result.append(theDomID)
	
	return result

func hasDomIDsThatSatisfyConditions(_sexEngine, _condList:Array, _amount:int, _ignoreList:Array) -> bool:
	if((_sexEngine.doms.size()-_ignoreList.size()) < _amount):
		return false
	return getDomIDsThatSatisfyConditions(_sexEngine, _condList, _amount, _ignoreList).size() == _amount

func getSubIDsThatSatisfyConditions(_sexEngine, _condList:Array, _amount:int, _ignoreList:Array) -> Array:
	var result:Array = []
	
	var allowUncon:bool = (COND_AllowUnconsciousOrDowned in _condList)
	
	var theChars:Array = _sexEngine.subs.keys()
	theChars.shuffle()
	for theSubID in theChars:
		if(result.size() >= _amount):
			break
		if(theSubID in _ignoreList):
			continue
		var subInfo:SexSubInfo = _sexEngine.subs[theSubID]
		
		if(!allowUncon && subInfo.isUnconscious()):
			continue
		
		for condEntry in _condList:
			if(!doesCharSatisfyCondition(_sexEngine, subInfo, condEntry)):
				continue
		result.append(theSubID)
	
	return result

func hasSubIDsThatSatisfyConditions(_sexEngine, _condList:Array, _amount:int, _ignoreList:Array) -> bool:
	if((_sexEngine.subs.size()-_ignoreList.size()) < _amount):
		return false
	return getSubIDsThatSatisfyConditions(_sexEngine, _condList, _amount, _ignoreList).size() == _amount

func pullInDom(_otherDomID:String, stopTheirActivities:bool = true):
	if(isDom(_otherDomID)):
		return
	var theSexEngine := getSexEngine()
	if(stopTheirActivities):
		theSexEngine.stopActivitiesThatInvolveCharID(_otherDomID)
	doms.append(theSexEngine.getDomInfo(_otherDomID))

func pullInSub(_otherSubID:String, stopTheirActivities:bool = true):
	if(isSub(_otherSubID)):
		return
	var theSexEngine := getSexEngine()
	if(stopTheirActivities):
		theSexEngine.stopActivitiesThatInvolveCharID(_otherSubID)
	subs.append(theSexEngine.getSubInfo(_otherSubID))

func getExtraInvolvedCharIDs() -> Array:
	return []

# Building blocks below


func doCumPussyLickDom():
	var text:String = RNG.pick([
		"{dom.You} {dom.youVerb('shake')} и {dom.youVerb('shiver')}, пока {dom.yourHis} "+RNG.pick(["pulsating", "twitching"])+" "+RNG.pick(["pussy", "pussy", "slit", "kitty"])+" [b]"+RNG.pick(["cums", "squirts", "orgasms", "climaxes"])+" по всему лицу {sub.your}[/b]!",
	])
	if(getDom().getFirstItemThatCoversBodypart(InventorySlot.Vagina) != null):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('shake')} и {dom.youVerb('shiver')}, пока {dom.yourHis} "+RNG.pick(["pulsating", "twitching"])+" "+RNG.pick(["pussy", "pussy", "slit", "kitty"])+" [b]"+RNG.pick(["makes", "creates"])+" мокрое пятно на одежде {dom.yourHis}[/b]!",
		])
	else:
		if(getSub().isOralBlocked()):
			getSub().cummedOnBy(getDomID(0), FluidSource.Vagina)
		else:
			getSub().cummedInMouthBy(getDomID(0), FluidSource.Vagina, 0.5)
			getSub().cummedOnBy(getDomID(0), FluidSource.Vagina, 0.5)
	
	if(getDom().hasReachablePenis()):
		getDom().cumOnFloor()
		text += RNG.pick([
			" {dom.YourHis} "+RNG.pick(["cock", "dick"])+" пульсирует, извергая струи "+RNG.pick(["cum", "seed", "semen"])+"!",
		])
	
	getDomInfo(0).cum()

	addText(text)

func doCumBJDom(isDeepthroat:bool = false):
	var text:String = RNG.pick([
		"{dom.You} {dom.youVerb('grunt')} while {dom.yourHis} "+RNG.pick(["cock", "dick", "member"])+" пульсирует и [b]кончает прямо в рот {sub.your}[/b].",
	])
	if(isDeepthroat):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('ram')} {dom.yourHis} "+RNG.pick(["cock", "dick"])+" "+RNG.pick(["по самую прошивку", "настолько глубоко, насколько позволяет горло {sub.yourHis}", "глубоко в глотку {sub.yourHis}"])+" прежде чем [b]зальет кучу спермы в живот {sub.yourHis}[/b]!",
		])
	
	var condomBroke:bool = false
	var condom:ItemBase = getDom().getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		condomBroke = getDom().shouldCondomBreakWhenFucking(getSub(), breakChance)
		if(condomBroke):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(DOM_0, Fetish.Condoms, -20.0)
			fetishUp(SUB_0, Fetish.Condoms, -30.0)
		else:
			fetishAffect(DOM_0, Fetish.Condoms, 5.0)
			fetishAffect(SUB_0, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{dom.You} наполнил(а) презерватив внутри {sub.your} "+RNG.pick(["mouth"])+"!",
				"{dom.You} запихал(а) презерватив в {sub.your} "+RNG.pick(["mouth"])+" полный {dom.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+"!",
			])
			getDom().cumInItem(condom)
			getDomInfo(0).cum()
			
			addText(text)
			return
	var beingBredScore:float = getSubInfo(0).fetishScore({Fetish.OralSexGiving: 1.0})
	if(beingBredScore < 0.0):
		getSubInfo(0).addResistance(1.0)
		getSubInfo(0).addFear(0.1)
	getSub().cummedInBodypartByAdvanced(BodypartSlot.Head, getDomID(0), {condomBroke=condomBroke})
	getDomInfo(0).cum()
	
	#return getSexEngine().combineData({text=text}, applyTallymarkIfNeededData(BodypartSlot.Head))
	addText(text)


func doCumBJFacialsDom():
	var text:String = RNG.pick([
		"{dom.You} {dom.youVerb('pull')} {dom.yourHis} вытащил свой член и [b]кончил прямо на лицо {sub.your}[/b]!",
		"{dom.You} {dom.youVerb('pull')} высунул, [b]заливая спермой всё лицо {sub.your}[/b]!",
	])
	
	var condom:ItemBase = getDom().getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		
		if(RNG.chance(breakChance)):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(DOM_0, Fetish.Condoms, -20.0)
			fetishUp(SUB_0, Fetish.Condoms, -30.0)
		else:
			fetishAffect(DOM_0, Fetish.Condoms, 5.0)
			fetishAffect(SUB_0, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{dom.You} {dom.youVerb('pull')} вытащил {dom.yourHis} член и {dom.youVerb('fill')} надел {dom.yourHis} презерватив!",
				"{dom.You} {dom.youVerb('pull')} высунул, натягивая на {dom.yourHis} презерватив!",
			])
			getDom().cumInItem(condom)
			getDomInfo(0).cum()
			#satisfyGoals()
			#state = ""
			addText(text)
			return
	
	getSub().cummedOnBy(getDomID(0), FluidSource.Penis)
	getDom().cumOnFloor()
	getDomInfo(0).cum()
	#satisfyGoals()
	#state = ""

	addText(text)


func doCumPussyLickSub(supposedToBeAngry:bool = true):
	#satisfyGoals()
	
	var noPermissionText:String = " {sub.YouHe} [b]кончил без разрешения {dom.yourHis}[/b]!" if supposedToBeAngry else ""
	if(getSexType() == SexType.SlutwallSex):
		noPermissionText = ""
		supposedToBeAngry = false
	
	var text:String = ""
	text = RNG.pick([
		"{sub.You} {sub.youVerb('arch', 'arches')} {sub.yourHis} откинулся назад, пока {sub.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty"])+" дергается и заливает всё лицо {dom.your}!"+noPermissionText,
	])
	getDom().cummedOnBy(getSubID(0), FluidSource.Vagina)
	getSubInfo(0).cum()
	if(getSub().isWearingChastityCage()):
		text += RNG.pick([
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "penis"])+" выстреливает слабой порцией через девственную клетку, но этого было легко избежать.",
		])
	elif(getSub().hasReachablePenis()):
		text += RNG.pick([
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "penis"])+" выстреливает порцией, но, по крайней мере, {dom.you} {dom.youVerb('avoid')} это удалось.",
		])
	
	#endActivity()
	if(supposedToBeAngry):
		getDomInfo(0).addAnger(0.5)
		text += RNG.pick([
			" Это очень разозлило {dom.you}.",
		])
	addText(text)
	
func doCumBJSub(supposedToBeAngry:bool = true):
	#satisfyGoals()
	
	var noPermissionText:String = " {sub.YouHe} [b]кончил без разрешения {dom.yourHis}[/b]!" if supposedToBeAngry else ""
	if(getSexType() == SexType.SlutwallSex):
		noPermissionText = ""
		supposedToBeAngry = false
	
	var text:String = ""

	text = RNG.pick([
		"{sub.You} {sub.youVerb('grunt')} while {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" пульсирует и внезапно выбрасывает струи "+RNG.pick(["cum", "seed", "semen"])+" прямо в рот {dom.your}!"+noPermissionText,
	])
	
	var condomBroke = false
	var condom:ItemBase = getSub().getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		condomBroke = getSub().shouldCondomBreakWhenFucking(getDom(), breakChance)
		if(condomBroke):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(SUB_0, Fetish.Condoms, -20.0)
			fetishUp(DOM_0, Fetish.Condoms, -30.0)
		else:
			fetishAffect(SUB_0, Fetish.Condoms, 5.0)
			fetishAffect(DOM_0, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{sub.You} {sub.youVerb('grunt')} while {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" пульсирует и внезапно начинает наполнять презерватив {sub.yourHis} "+RNG.pick(["cum", "seed", "semen"])+"!"+noPermissionText,
			])
			getSub().cumInItem(condom)
			getSubInfo(0).cum()
			#endActivity()
			if(supposedToBeAngry):
				getDomInfo(0).addAnger(0.5)
				text += RNG.pick([
					" Это очень разозлило {dom.you}.",
				])
			
			addText(text)
			return
	
	getDom().cummedInMouthByAdvanced(getSubID(0), {condomBroke=condomBroke})
	getSubInfo(0).cum()
	
	#endActivity()
	if(supposedToBeAngry):
		getDomInfo(0).addAnger(0.5)
		text += RNG.pick([
			" Это очень разозлило {dom.you}.",
		])
	addText(text)


func doCumBJFacialsSub(supposedToBeAngry:bool = true):
	#satisfyGoals()
	
	var noPermissionText:String = " {sub.YouHe} [b]кончил без разрешения {dom.yourHis}[/b]!" if supposedToBeAngry else ""
	if(getSexType() == SexType.SlutwallSex):
		noPermissionText = ""
		supposedToBeAngry = false
	
	var text:String = ""

	text = RNG.pick([
		"{sub.You} {sub.youVerb('grunt')} while {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" пульсирует и внезапно выбрасывает струи "+RNG.pick(["cum", "seed", "semen"])+" которые попадают прямо на лицо {dom.your}!"+noPermissionText,
	])
	if(getSub().isWearingChastityCage()):
		text = RNG.pick([
			"{sub.You} {sub.youVerb('grunt')}, пока {sub.yourHis} заперт(а) "+RNG.pick(["cock", "dick", "shaft"])+" пульсирует в своей тесной оболочке и внезапно выпускает несколько слабых струек "+RNG.pick(["cum", "seed", "semen"])+" сквозь девственную клетку прямо на лицо {dom.your}!"+noPermissionText,
		])
		
	var condom:ItemBase = getSub().getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		
		if(RNG.chance(breakChance)):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(SUB_0, Fetish.Condoms, -20.0)
			fetishUp(DOM_0, Fetish.Condoms, -30.0)
		else:
			fetishAffect(SUB_0, Fetish.Condoms, 5.0)
			fetishAffect(DOM_0, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{sub.You} {sub.youVerb('grunt')} while {sub.yourHis} "+RNG.pick(["cock", "dick", "shaft"])+" пульсирует и внезапно начинает наполнять презерватив {sub.yourHis} "+RNG.pick(["cum", "seed", "semen"])+"!"+noPermissionText,
			])
			getSub().cumInItem(condom)
			getSubInfo(0).cum()
			#endActivity()
			if(supposedToBeAngry):
				getDomInfo(0).addAnger(0.5)
				text += RNG.pick([
					" Это очень разозлило {dom.you}.",
				])
			
			addText(text)
			return
		
	getDom().cummedOnBy(getSubID(0), FluidSource.Penis)
	getSubInfo(0).cum()

	#endActivity()
	if(supposedToBeAngry):
		getDomInfo(0).addAnger(0.5)
		text += RNG.pick([
			" Это очень разозлило {dom.you}.",
		])
	addText(text)



func doSpitCumIntoHoleDom(bodypartSlot = BodypartSlot.Vagina):
	var mixtureText:String = getDom().getBodypartContentsStringList(BodypartSlot.Head)
	var locationName:String = ("{sub.pussyStretch} "+RNG.pick(["pussy", "slit"]) if bodypartSlot == BodypartSlot.Vagina else ("{sub.anusStretch} "+RNG.pick(["anus"])))
	var text:String = RNG.pick([
		"{dom.You} {dom.youVerb('press', 'presses')} {dom.yourHis} губы прижаты к {sub.yourHis} "+locationName+" and [b]{dom.youVerb('spit')} "+mixtureText+" в деле[/b]!",
	])
	var howMuch = getDom().bodypartTransferFluidsToAmount(BodypartSlot.Head, getSubID(0), bodypartSlot, 0.2, 20.0)
	if(getSub().hasWombIn(bodypartSlot)):
		affectSub(getSubInfo(0).fetishScore({Fetish.BeingBred:1.0}), 0.1, -0.1, -0.05)
	elif(bodypartSlot == BodypartSlot.Vagina):
		affectSub(getSubInfo(0).fetishScore({Fetish.OralSexReceiving:1.0}), 0.1, -0.1, -0.05)
	elif(bodypartSlot == BodypartSlot.Anus):
		affectSub(getSubInfo(0).fetishScore({Fetish.RimmingReceiving:1.0}), 0.1, -0.1, -0.05)
	sendSexEvent(SexEvent.HoleSpitted, DOM_0, SUB_0, {hole=bodypartSlot, loadSize=howMuch})
	addText(text)
	if(getSub().hasWombIn(bodypartSlot) && getSub().getFertility() > 0.1 && getDom().hasVirileFluidsIn(S_MOUTH)):
		fetishAffect(DOM_0, Fetish.Breeding, 10.0)
		fetishAffect(SUB_0, Fetish.BeingBred, 10.0)

func doSpitCumIntoHoleSub(bodypartSlot = BodypartSlot.Vagina):
	var mixtureText = getSub().getBodypartContentsStringList(BodypartSlot.Head)
	var locationName:String = ("{dom.pussyStretch} "+RNG.pick(["pussy", "slit"]) if bodypartSlot == BodypartSlot.Vagina else ("{dom.anusStretch} "+RNG.pick(["anus"])))
	var text = RNG.pick([
		"{sub.You} {sub.youVerb('press', 'presses')} губы {sub.yourHis} о {dom.yourHis} "+locationName+" and [b]{sub.youVerb('spit')} "+mixtureText+" в деле[/b]!",
	])
	var howMuch = getSub().bodypartTransferFluidsToAmount(BodypartSlot.Head, getDomID(0), bodypartSlot, 0.2, 20.0)
	if(getDom().hasWombIn(bodypartSlot)):
		affectDom(getDomInfo(0).fetishScore({Fetish.BeingBred:1.0}), 0.1, -0.1)
	elif(bodypartSlot == BodypartSlot.Vagina):
		affectDom(getDomInfo(0).fetishScore({Fetish.OralSexReceiving:1.0}), 0.1, -0.1)
	elif(bodypartSlot == BodypartSlot.Anus):
		affectDom(getDomInfo(0).fetishScore({Fetish.RimmingReceiving:1.0}), 0.1, -0.1)
	sendSexEvent(SexEvent.HoleSpitted, SUB_0, DOM_0, {hole=bodypartSlot, loadSize=howMuch})
	addText(text)
	if(getDom().hasWombIn(bodypartSlot) && getDom().getFertility() > 0.1 && getSub().hasVirileFluidsIn(S_MOUTH)):
		fetishAffect(SUB_0, Fetish.Breeding, 3.0)
		fetishAffect(DOM_0, Fetish.BeingBred, 3.0)

func hasOvipositorPenis(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(theChar):
		return false
	var theStrapon = theChar.getWornStrapon()
	if(theStrapon):
		if(theStrapon.has_method("getStraponTraits")):
			return theStrapon.getStraponTraits().get(PartTrait.Ovipositor, false)
		return false
	if(!theChar.hasPenis()):
		return false
	return theChar.getBodypart(BodypartSlot.Penis).hasTrait(PartTrait.Ovipositor)
	

func isWearingStrapon(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return theChar.isWearingStrapon()
	
func isWearingCondom(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return theChar.isWearingCondom()

# Just shorter func name
func isStrapon(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return theChar.isWearingStrapon()

func getPenisSensitivity(_indx:int) -> float:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return 1.0
	var strapon = theChar.getWornStrapon()
	if(strapon == null):
		return 1.0
	return strapon.getStraponPleasureForDom()
	
func doBlowjobTurnDom():
	stimulateLick(SUB_0, DOM_0, S_PENIS, I_NORMAL)
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexGiving: 1.0})+0.1, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexReceiving: 0.5})+0.6, 0.1*getDomPenisSensetivity(), 0.0)
	#getSubInfo(0).addArousalForeplay(0.03)
	#getDomInfo(0).stimulateArousalZone(0.2, BodypartSlot.Penis, 1.0)
	getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(0), true, 0.05)
	
	var text = RNG.pick([
		"{sub.youHim} сосет {dom.Your} {dom.penisShort}.",
		"{sub.You} {sub.youAre} "+RNG.pick(["sucking", "blowing"])+" {dom.yourHis} {dom.penisShort}.",
		"{sub.You} {sub.youAre} плотно обхватывает {dom.your} {dom.penisShort} губами {sub.yourHis}.",  
		"{sub.You} {sub.youAre} дразнит кончик {dom.penisShort} {sub.yourHis} языком {dom.your}.",  
		"{sub.You} {sub.youVerb('bob')} заглатывает {sub.yourHis} {dom.your} {dom.penisShort} всё глубже.",  
		"{sub.You} {sub.youAre} проводит языком {sub.yourHis} по нижней стороне {dom.your} {dom.penisShort}.",  
		"{sub.You} {sub.youAre} жадно сосет {dom.your} {dom.penisShort}, заставляя {dom.youHim} стонать.",  
		"{sub.You} {sub.youVerb('swirl')} водит языком {sub.yourHis} вокруг головки {dom.your} {dom.penisShort}.",  
		"{sub.You} {sub.youVerb('take')} заталкивает {dom.your} {dom.penisShort} еще глубже в рот {sub.yourHis}, сильно посасывая.",  
		"{sub.You} {sub.youVerb('press', 'presses')} плотно прижимает язык {sub.yourHis} к {dom.your} {dom.penisShort}, медленно проводя им по всей длине.",  
	])
	
	if(!getSubInfo(0).isUnconscious()):
		if(RNG.chance(30)):
			text += RNG.pick([
				" От {sub.you} слышны влажные хлюпающие звуки.",
				" {sub.You} {sub.youAre} издает влажные звуки ртом {sub.yourHis}.",
				" {sub.You} {sub.youVerb('try', 'tries')} заставь этот язычок поработать.",
			])
	else:
		text = RNG.pick([
			"{dom.You} {dom.youVerb('use')} {sub.yourHis} "+RNG.pick(["mouth", "lips", "tongue"])+" ради {dom.yourHis} удовольствия.",
			"{dom.You} "+RNG.pick(["forcefully {dom.youVerb('move')}", "{dom.youVerb('move')}"])+" {sub.yourHis} двигает головой вперед-назад над {dom.yourHis} {dom.penisShort}."
		])
		
		if(RNG.chance(30)):
			text += RNG.pick([
				" От {sub.you} слышны влажные хлюпающие звуки.",
				" {sub.You} {sub.youAre} издает влажные звуки ртом {sub.yourHis}.",
			])
	
	if(isWearingStrapon(DOM_0)):
		if(getDomInfo(0).isReadyToCum()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
				" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
				" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
			])
		elif(getDomInfo(0).isCloseToCumming()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
			])
	else:
		if(getDomInfo(0).isReadyToCum()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
				" {dom.YourHis} "+RNG.pick(["cock", "dick", "member"])+" сильно дергается.",
				" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
				" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
			])
		elif(getDomInfo(0).isCloseToCumming()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} leaking "+RNG.pick(["pre", "precum"])+" прямо в этот рот.",
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YourHis} "+RNG.pick(["cock", "dick", "member"])+" слегка подергивается.",
			])
	addText(text)


func doDeepthroatTurnDom():
	getSub().gotOrificeStretchedBy(BodypartSlot.Head, getDomID(0), true, 0.1)
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexGiving: 1.0})-0.3, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexReceiving: 0.5})+0.6, 0.1*getDomPenisSensetivity(), 0.0)
	#getSubInfo(0).addArousalForeplay(0.06)
	#getDomInfo(0).stimulateArousalZone(0.25, BodypartSlot.Penis, 1.0)
	stimulateLick(SUB_0, DOM_0, S_PENIS, I_HIGH)
	
	var text = RNG.pick([
		"{sub.You} {sub.youVerb('deepthroat')} that {dom.penisShort}.",
	])
	if(getSubInfo(0).isUnconscious()):
		text = RNG.pick([
			"{sub.You} {sub.youAre} заставляют глубоко заглатывать этот {dom.penisShort}.",
			"{dom.You} {dom.youAre} силой вгоняет голову {sub.yourHis} глубоко в {dom.yourHis} {dom.penisShort}.",
		])
	
	var freeRoom = getSub().getPenetrationFreeRoomBy(BodypartSlot.Head, getDomID(0))
	if(freeRoom > 3.0):
		text += RNG.pick([
			" горло {sub.Your} достаточно глубокое, чтобы {sub.youHim} не задохнулась.",
			" {sub.You} {sub.youVerb('allow')} позволяет {dom.youHim} легко трахать {sub.yourHis} в горло.",
			" горло {sub.Your} легко растягивается, чтобы вместить такую длину.",
			" Там есть небольшая "+RNG.pick(["bulge", "bump"])+" на горле {sub.yourHis}.",
		])
	else:
		getSubInfo(0).addConsciousness(-RNG.randf_range(0.05, 0.15))
		text += RNG.pick([
			" {sub.You} {sub.youVerb('choke')} и {sub.youVerb('gag')}, потому что "+RNG.pick(["он слишком велик,", "в длину", "в размере", "горло {sub.yourHis} недостаточно растянуто"])+".",
			" {sub.You} "+RNG.pick(["{sub.youVerb('choke')}", "{sub.youVerb('suffocate')}", "не хватает воздуха"])+"!",
			" "+RNG.pick(["Несколько слезинок катятся", "Одинокая слеза катится"])+" по щекам {sub.yourHis}, пока горло {sub.yourHis} "+RNG.pick(["fucked", "used", "stretched"])+".",
			" Заметно, как "+RNG.pick(["bulge", "bump"])+" на горле {sub.yourHis}.",
		])
	
	if(isWearingStrapon(DOM_0)):
		if(getDomInfo(0).isReadyToCum()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
				" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
				" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
			])
		elif(getDomInfo(0).isCloseToCumming()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
			])
	else:
		if(getDomInfo(0).isReadyToCum()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
				" {dom.YourHis} "+RNG.pick(["cock", "dick", "member"])+" сильно дергается.",
				" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
				" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
			])
		elif(getDomInfo(0).isCloseToCumming()):
			text += RNG.pick([
				" {dom.YouHe} {dom.youAreHeIs} leaking "+RNG.pick(["pre", "precum"])+" прямо в этот рот.",
				" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
				" {dom.YourHis} "+RNG.pick(["cock", "dick", "member"])+" слегка подергивается.",
			])
	
	if(isWearingStrapon(DOM_0)):
		var strapon = getDom().getWornStrapon()
		if(strapon.getFluids() != null && RNG.chance(33) && !strapon.getFluids().isEmpty()):
			var extraMessages = []
			var fluidByAmount = strapon.getFluids().getFluidAmountByType()
			for fluidID in fluidByAmount:
				var swallowData:Dictionary = getSub().doSwallow(fluidID, fluidByAmount[fluidID], false)
				if(swallowData.has("text") && swallowData["text"] != ""):
					extraMessages.append(swallowData["text"])
			
			getSub().cummedInBodypartByAdvanced(BodypartSlot.Head, getDomID(0))
			text += " {sub.your} сжимает страпон {dom.Your} "+RNG.pick(["throat"])+" так, что он внезапно [b]извергает содержимое прямо в рот {sub.yourHis}[/b]!"
			if(extraMessages.size() > 0):
				text += " "+Util.join(extraMessages, " ")
	
	addText(text)

func doPussyLickingTurnDom():
	stimulateLick(SUB_0, DOM_0, S_VAGINA, I_NORMAL)
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexGiving: 1.0})+0.1, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexReceiving: 0.5})+0.6, 0.1, 0.0)
	#getDomInfo(0).stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
	
	var clothingItem = getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina)
	var throughTheClothing = ""
	if(clothingItem != null):
		throughTheClothing = " через "+clothingItem.getCasualName()
	var text = RNG.pick([
		"{sub.You} {sub.youAre} licking {dom.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty", "petals", "slit", "folds"])+ throughTheClothing +".",
		"{sub.You} {sub.youAre} водит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["половым губам", "kitty", "slit", "petals", "folds", "клитору и киске"])+ throughTheClothing +".",
		"{sub.You} {sub.youAre} licking {dom.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty", "petals", "slit", "folds"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} водит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["половым губам", "kitty", "slit", "petals", "folds", "клитору и киске"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} exploring {dom.yourHis} "+RNG.pick(["pussy", "folds", "slit", "нежным лепесткам", "heat", "sweetness"])+" медленно и дразняще облизывая"+throughTheClothing+".",  
		"{sub.You} {sub.youAre} прижимает {sub.yourHis} язык к {dom.yourHis} "+RNG.pick(["pussy", "folds", "petals", "чувствительной щели", "wetness", "нежные губы"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} крутит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["клитор и щель", "мягкие складки", "половым губам", "petals", "чувствительные зоны"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} смакует вкус {dom.yourHis} "+RNG.pick(["pussy", "сладкие лепестки", "интимные складки", "slit", "wetness", "чувствительный клитор и губы"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} teasing {dom.yourHis} "+RNG.pick(["pussy", "нежные складки", "petals", "клитор и губы", "slit", "мягкая влажность"])+" с нарочитыми, чувственными облизываниями"+throughTheClothing+".",  
		"{sub.You} {sub.youAre} водит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["folds", "клитору и киске", "половым губам", "slit", "heat", "нежным лепесткам"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} медленно и дразняще водит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["pussy", "мягкие складки", "slit", "интимные губы", "petals", "нежная кожа"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} нежно водит кончиком {sub.yourHis} языка по {dom.yourHis} "+RNG.pick(["половым губам", "мягкая щелочка", "folds", "petals", "clit", "интимный жар"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} уверенно ведет {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["влажным губам", "folds", "pussy", "slit", "petals", "клитору и складкам"])+ throughTheClothing+".",  
		"{sub.You} {sub.youAre} spreading {dom.yourHis} "+RNG.pick(["folds", "мягким губам", "pussy", "нежным лепесткам", "slit", "wetness"])+" языком {sub.yourHis}"+throughTheClothing+".",  

	])
	if(getSubInfo(0).isUnconscious()):
		text = RNG.pick([
			"{dom.You} {dom.youVerb('rub')} {dom.yourHis} "+RNG.pick(["pussy", "slit", "kitty"])+" поверх языка {sub.yourHis}"+throughTheClothing+".",
			"{dom.You} {dom.youVerb('use')} водит {sub.yourHis} языком по {dom.yourHis} "+RNG.pick(["pussy", "slit", "kitty"])+" ради {dom.yourHis} удовольствия.",
		])
	
	if(clothingItem == null):
		if(getDom().hasEffect(StatusEffect.HasCumInsideVagina)):
			if(RNG.chance(30) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
				var _howMuch = getDom().bodypartTransferFluidsToAmount(BodypartSlot.Vagina, getSubID(0), BodypartSlot.Head, 0.2, 20.0)
				text += RNG.pick([ 
					" "+Util.capitalizeFirstLetter(getDom().getBodypartContentsStringList(BodypartSlot.Vagina))+" [b]"+RNG.pick(["oozes", "leaks"])+" из {dom.yourHis}[/b] "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+".",
				])
	
	if(getDomInfo(0).isReadyToCum()):
		text += RNG.pick([
			" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
			" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
			" {dom.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно дергается.",
			" {dom.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно течет от возбуждения.",
			" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
			" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
		])
	elif(getDomInfo(0).isCloseToCumming()):
		text += RNG.pick([
			" {dom.You} "+RNG.pick(["{dom.youVerb('let')} издает стоны", "{dom.youVerb('let')} издать стон", "{dom.youVerb('bite')} {dom.yourHis} lip", "{dom.youVerb('breathe')} deeply"])+" пока {dom.yourHis} течет "+RNG.pick(["становится всё более влажной", "течет от возбуждения", "возбуждается сильнее", "течет от возбуждения", "издает возбуждающий аромат"])+"."
		])
	
	addText(text)

func doPussyGrindingTurnDom():
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexGiving: 1.0})-0.1, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexReceiving: 0.5})+0.6, 0.1, 0.0)
	#getDomInfo(0).stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
	stimulateGrindFace(DOM_0, SUB_0, I_HIGH)
	
	var clothingItem = getDom().getFirstItemThatCoversBodypart(BodypartSlot.Vagina)
	var throughTheClothing = ""
	if(clothingItem != null):
		throughTheClothing = " через "+clothingItem.getCasualName()
	var text:String = RNG.pick([
		"{dom.You} {dom.youAre} grinding {dom.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty", "petals", "slit", "folds"])+" на лице {sub.yourHis}"+ throughTheClothing +".",
		"{dom.You} {dom.youVerb('use')} {sub.yourHis} лицо {dom.yourHis}, доставляя удовольствие трением!",
	])
	
	if(clothingItem == null):
		if(getDom().hasEffect(StatusEffect.HasCumInsideVagina)):
			if(RNG.chance(30)):
				text += RNG.pick([ 
					" "+Util.capitalizeFirstLetter(getDom().getBodypartContentsStringList(BodypartSlot.Vagina))+" размазывается по лицу {sub.yourHis}.",
				])
	
	if(getDomInfo(0).isReadyToCum()):
		text += RNG.pick([
			" {dom.YouHe} {dom.youAreHeIs} сейчас кончит!",
			" {dom.YouHe} {dom.youAreHeIs} edging {dom.yourself}.",
			" {dom.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно дергается.",
			" {dom.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно течет от возбуждения.",
			" {dom.YouHe} {dom.youAreHeIs} едва сдерживает {dom.yourself} от оргазма.",
			" {dom.YouHe} достиг(ла) {dom.yourHis} пика!",
		])
	elif(getDomInfo(0).isCloseToCumming()):
		text += RNG.pick([
			" {dom.You} "+RNG.pick(["{dom.youVerb('let')} издает стоны", "{dom.youVerb('let')} издать стон", "{dom.youVerb('bite')} {dom.yourHis} lip", "{dom.youVerb('breathe')} deeply"])+" пока {dom.yourHis} течет "+RNG.pick(["становится всё более влажной", "течет от возбуждения", "возбуждается сильнее", "течет от возбуждения", "издает возбуждающий аромат"])+"."
		])
	
	addText(text)

		
func doBlowjobTurn(_indxActor:int, _indxTarget:int):
	if(_indxActor == SUB_0 && _indxTarget == DOM_0):
		doBlowjobTurnDom()
	elif(_indxActor == DOM_0 && _indxTarget == SUB_0):
		doBlowjobTurnSub()
	else:
		assert(false, "Unimplemented")

func doBlowjobTurnSub():
	stimulateLick(DOM_0, SUB_0, S_PENIS, I_NORMAL)
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexReceiving: 1.0})+0.6, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexGiving: 0.5})+0.1, 0.1, 0.0)
	#getDomInfo(0).addArousalForeplay(0.03)
	#getSubInfo(0).stimulateArousalZone(0.2, BodypartSlot.Penis, 1.0)
	getDom().gotOrificeStretchedBy(BodypartSlot.Head, getSubID(0), true, 0.05)
	
	var text:String = RNG.pick([
		"{dom.You} {dom.youAre} sucking {sub.your} "+RNG.pick(["cock", "dick", "member"])+".",
		"{dom.You} {dom.youVerb('drag')} {dom.yourHis} губы на {sub.your} "+RNG.pick(["cock", "dick", "member", "length"])+", посасывая его.",
		"{dom.You} {dom.youAre} плотно обхватывает {sub.your} своими {dom.yourHis} губами "+RNG.pick(["cock", "dick", "member"])+".",  
		"{dom.You} {dom.youAre} дразнит кончик {sub.your} "+RNG.pick(["cock", "dick", "length", "shaft"])+ " языком {dom.yourHis}.",  
		"{dom.You} {dom.youVerb('bob')} водит головкой {dom.yourHis} по {sub.your} "+RNG.pick(["dick", "cock", "shaft", "member"])+", заглатывая её всё глубже.",  
		"{dom.You} {dom.youAre} проводит {dom.yourHis} языком по нижней стороне {sub.your} "+RNG.pick(["cock", "length", "member"])+".",  
		"{dom.You} {dom.youAre} жадно посасывает {sub.your} "+RNG.pick(["dick", "member", "shaft"])+", заставляя {sub.youHim} застонать.",  
		"{dom.You} {dom.youVerb('swirl')} обводит {dom.yourHis} языком вокруг головки {sub.your} "+RNG.pick(["cock", "dick", "member"])+".",  
		"{dom.You} {dom.youVerb('take')} {sub.your} "+RNG.pick(["length", "shaft", "cock"])+ " глубже во рту {dom.yourHis}, сильно посасывая.",  
		"{dom.You} {dom.youVerb('press', 'presses')} плотно прижимает {dom.yourHis} язык к {sub.your} "+RNG.pick(["cock", "dick", "member"])+", медленно ведя им вдоль всей длины.",  
	])
	
	if(RNG.chance(30)):
		text += RNG.pick([
			" Из {dom.you} доносятся влажные хлюпающие звуки.",
			" {dom.You} {dom.youAre} издает влажные звуки {dom.yourHis} ртом.",
			" {dom.You} {dom.youVerb('work')} водит языком вдоль всей длины, чтобы добавить стимуляции.",
		])
	
	if(getSubInfo(0).isReadyToCum()):
		text += RNG.pick([
			" {sub.YouHe} {sub.youAreHeIs} вот-вот кончит!",
			" {sub.YouHe} {sub.youAreHeIs}, когда {dom.youHim} доводит его до эджинга.",
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "member"])+" сильно дергается.",
			" {sub.YouHe} {sub.youAreHeIs} едва сдерживает {sub.yourself} от оргазма.",
			" {sub.YouHe} достиг(ла) {sub.yourHis} пика!",
		])
	elif(getSubInfo(0).isCloseToCumming()):
		text += RNG.pick([
			" {sub.YouHe} {sub.youAreHeIs} leaking "+RNG.pick(["pre", "precum"])+" прямо в рот {dom.yourHis}.",
			" {sub.YouHe} {sub.youAreHeIs} скоро кончит!",
			" {sub.YourHis} "+RNG.pick(["cock", "dick", "member"])+" слегка подергивается.",
		])
	addText(text)

func doPussyLickingTurn(_indxActor:int, _indxTarget:int):
	if(_indxActor == SUB_0 && _indxTarget == DOM_0):
		doPussyLickingTurnDom()
	elif(_indxActor == DOM_0 && _indxTarget == SUB_0):
		doPussyLickingTurnSub()
	else:
		assert(false, "Unimplemented")

func doPussyLickingTurnSub():
	stimulateLick(DOM_0, SUB_0, S_VAGINA, I_NORMAL)
	#affectSub(getSubInfo(0).fetishScore({Fetish.OralSexReceiving: 1.0})+0.3, 0.1, -0.1, -0.01)
	#affectDom(getDomInfo(0).fetishScore({Fetish.OralSexGiving: 0.5})+0.6, 0.1, 0.0)
	#getSubInfo(0).stimulateArousalZone(0.1, BodypartSlot.Vagina, 0.5)
	
	var clothingItem = getSub().getFirstItemThatCoversBodypart(BodypartSlot.Vagina)
	var throughTheClothing = ""
	if(clothingItem != null):
		throughTheClothing = " через "+clothingItem.getCasualName()
	var text:String = RNG.pick([
		"{dom.You} {dom.youAre} licking {sub.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty", "petals", "slit", "folds"])+ throughTheClothing +".",
		"{dom.You} {dom.youAre} проводит {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["половым губам", "kitty", "slit", "petals", "folds", "клитору и киске"])+ throughTheClothing +".",
		"{dom.You} {dom.youAre} exploring {sub.yourHis} "+RNG.pick(["pussy", "folds", "slit", "нежным лепесткам", "heat", "sweetness"])+" медленно и дразняще облизывая"+throughTheClothing+".",  
		"{dom.You} {dom.youAre} прижимает {dom.yourHis} язык к {sub.yourHis} "+RNG.pick(["pussy", "folds", "petals", "чувствительной щели", "wetness", "нежные губы"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} кружащийся {dom.yourHis} язык над {sub.yourHis} "+RNG.pick(["клитор и щель", "мягкие складки", "половым губам", "petals", "чувствительные зоны"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} смакует вкус {sub.yourHis} "+RNG.pick(["pussy", "сладкие лепестки", "интимные складки", "slit", "wetness", "чувствительный клитор и губы"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} teasing {sub.yourHis} "+RNG.pick(["pussy", "нежные складки", "petals", "клитор и губы", "slit", "мягкая влажность"])+" с нарочитыми, чувственными облизываниями"+throughTheClothing+".",  
		"{dom.You} {dom.youAre} проводит {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["folds", "клитору и киске", "половым губам", "slit", "heat", "нежным лепесткам"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} медленно и дразняще выводит круги {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["pussy", "мягкие складки", "slit", "интимные губы", "petals", "нежная кожа"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} нежно водит {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["половым губам", "мягкая щелочка", "folds", "petals", "clit", "интимный жар"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} уверенно проводит {dom.yourHis} языком по {sub.yourHis} "+RNG.pick(["влажным губам", "folds", "pussy", "slit", "petals", "клитору и складкам"])+ throughTheClothing+".",  
		"{dom.You} {dom.youAre} spreading {sub.yourHis} "+RNG.pick(["folds", "мягким губам", "pussy", "нежным лепесткам", "slit", "wetness"])+" {dom.yourHis} языком"+throughTheClothing+".",  
	])
	
	if(clothingItem == null):
		if(getSub().hasEffect(StatusEffect.HasCumInsideVagina)):
			if(RNG.chance(30)):
				text += RNG.pick([ 
					" "+Util.capitalizeFirstLetter(getSub().getBodypartContentsStringList(BodypartSlot.Vagina))+" "+RNG.pick(["oozes", "leaks"])+" из {sub.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+".",
				])
	
	if(getSubInfo(0).isReadyToCum()):
		text += RNG.pick([
			" {sub.YouHe} {sub.youAreHeIs} вот-вот кончит!",
			" {sub.YouHe} {sub.youAreHeIs} изводит {dom.youHim}, держа её на грани.",
			" {sub.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно дергается.",
			" {sub.YourHis} "+RNG.pick(["pussy", "щель киски"])+" сильно течет от возбуждения.",
			" {sub.YouHe} {sub.youAreHeIs} едва сдерживает {sub.yourself} от оргазма.",
			" {sub.YouHe} достиг(ла) {sub.yourHis} пика!",
		])
	elif(getSubInfo(0).isCloseToCumming()):
		text += RNG.pick([
			" {sub.You} "+RNG.pick(["{sub.youVerb('let')} издает стоны", "{sub.youVerb('let')} стонет", "{sub.youVerb('breathe')} deeply"])+" в то время как киска {sub.yourHis} "+RNG.pick(["становится всё более влажной", "течет от возбуждения", "возбуждается сильнее", "течет от возбуждения", "издает возбуждающий аромат"])+"."
		])
	
	addText(text)


# New-new building blocks

func isReadyToPenetrate(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return theChar.isReadyToPenetrate()

func isReadyToFuck(_indx:int) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	return hasBodypartUncovered(_indx, S_PENIS) && theChar.isReadyToPenetrate()

func getNamePenis(_indx:int) -> String:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return "[color=red]error[/color]"
	if(theChar.isWearingStrapon()):
		return RNG.pick(["strapon", "резиновый член", "резинового члена", "резиновая игрушка"])
	return "{penis}"

func getNameHole(_indx:int, _hole:String) -> String:
	if(_hole == S_VAGINA):
		return RNG.pick(["pussy", "pussy", "slit", "cunt", "kitty"])
	if(_hole == S_ANUS):
		return RNG.pick(["anus", "tailhole", "backdoor", "star", "анальное кольцо"])
	if(_hole == S_MOUTH):
		return RNG.pick(["mouth", "throat"])
	return "[color=red]error[/color]"

func getNameHoleGeneric(_hole:String) -> String:
	if(_hole == S_VAGINA):
		return RNG.pick(["pussy", "pussy", "slit", "cunt", "kitty"])
	if(_hole == S_ANUS):
		return RNG.pick(["anus", "tailhole", "backdoor", "star", "анальное кольцо"])
	if(_hole == S_MOUTH):
		return RNG.pick(["mouth", "throat"])
	return "[color=red]error[/color]"

func doProcessFuck(_indxTop:int, _indxBottom:int, _hole:String, _poseDescriptor:String = ""):
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()
	
	var usedBodypartName:String = getNameHole(_indxBottom, _hole)
	
	var text:String = RNG.pick([
		"{<TOP>.You} {<TOP>.youAre} fucking {<BOTTOM>.youHim}"+_poseDescriptor+".",
		"{<TOP>.You} {<TOP>.youVerb('pound')} {<BOTTOM>.your} "+usedBodypartName+".",
		"{<TOP>.You} {<TOP>.youVerb('fuck')} {<BOTTOM>.your} "+usedBodypartName+".",
	])

	if(RNG.chance(20)):
		var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topInfo.getCharID())
		
		bottomChar.gotOrificeStretchedBy(_hole, topInfo.getCharID(), true, 0.1)
		
		if(_hole == BodypartSlot.Vagina):
			if(freeRoom <= 5.0):
				text += RNG.pick([
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" easily "+RNG.pick(["hits", "smashes", "reaches", "finds"])+" {<BOTTOM>.yourHis} "+RNG.pick(["cervix", "естественная преграда"])+".",
				])
			elif(freeRoom >= 10):
				text += RNG.pick([
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" едва ли может проникнуть глубоко.",
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" изо всех сил пытается достать до {<BOTTOM>.yourHis} "+RNG.pick(["cervix", "естественная преграда"])+".",
				])
		if(_hole == BodypartSlot.Anus):
			if(freeRoom <= 5.0):
				text += RNG.pick([
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" easily "+RNG.pick(["hits", "smashes", "reaches", "finds"])+" {<BOTTOM>.yourHis} "+RNG.pick(["точка удовольствия"])+".",
				])
			elif(freeRoom >= 10):
				text += RNG.pick([
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" едва ли может проникнуть глубоко.",
					" Кончик {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" тщетно пытается достичь {<BOTTOM>.yourHis} "+RNG.pick(["точка удовольствия"])+".",
				])

	addTextRaw(text.replace("<TOP>", topInfo.getCharID()).replace("<BOTTOM>", bottomInfo.getCharID()))
	
func doProcessFuckExtra(_indxTop:int, _indxBottom:int, _hole:String):
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	var topStrapon:bool = topChar.isWearingStrapon()
	
	if(RNG.chance(20) && topChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisBarbs)):
		addTextRaw(RNG.pick([
			"Шипики на {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" дают дополнительную стимуляцию.",
			"Шипы на {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" "+RNG.pick(["царапают", "scratch"])+" the "+RNG.pick(["нежные внутренности", "мягкие внутренние стенки"])+".",
		]).replace("<TOP>", topInfo.getCharID()))
	if(RNG.chance(20) && topChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisRidges)):
		addTextRaw(RNG.pick([
			" Ребра на {<TOP>.yourHis} "+("{penis}" if !topStrapon else "strapon")+" дают дополнительную стимуляцию.",
		]).replace("<TOP>", topInfo.getCharID()))
	
	if(topInfo.getChar().isWearingStrapon()):
		if(topInfo.isReadyToCum()):
			addTextRaw(RNG.pick([
				"{<TOP>.You} {<TOP>.youAre} дрожит на самом краю, изнывая в сбруе.",
				"{<TOP>.You} {<TOP>.youAre} вся в дрожи, {<TOP>.yourHis} тело буквально молит о разрядке.",
				"{<TOP>.You} {<TOP>.youVerb('quiver')} неконтролируемо, всего в паре дюймов от оргазма.",
				"{<TOP>.You} {<TOP>.youAre} edging {<TOP>.yourself}.",
				"{<TOP>.You} {<TOP>.youAre} вот-вот кончит!",
				"{<TOP>.You} {<TOP>.youAre} держит {<TOP>.yourself} на пределе.",
			]).replace("<TOP>", topInfo.getCharID()))
		elif(topInfo.isCloseToCumming()):
			addTextRaw(RNG.pick([
				"{<TOP>.You} {<TOP>.youVerb('pant')} жарко, сбруя натягивается на {<TOP>.yourHis} теле.",
				"{<TOP>.You} {<TOP>.youVerb('pant')} eagerly.",
				"{<TOP>.You} {<TOP>.youVerb('close')} на грани {<TOP>.yourHis} оргазма.",
				"{<TOP>.You} {<TOP>.youAre} скоро кончит.",
			]).replace("<TOP>", topInfo.getCharID()))
	else:
		if(topInfo.isReadyToCum()):
			addTextRaw(RNG.pick([
				"{<TOP>.You} {<TOP>.youAre} трясется на краю, {<TOP>.yourHis} {penis} неистово пульсирует.",
				"{<TOP>.You} {<TOP>.youAre} edging {<TOP>.yourself}.",
				"{<TOP>.You} {<TOP>.youAre} вот-вот кончит!",
				"{<TOP>.You} {<TOP>.youAre} держит {<TOP>.yourself} на пределе.",
				"{<TOP>.Your} {penis} вот-вот кончит.",
				"{<TOP>.Your} {penis} достиг пика."
			]).replace("<TOP>", topInfo.getCharID()))
		elif(topInfo.isCloseToCumming()):
			addTextRaw(RNG.pick([
				"{<TOP>.You} {<TOP>.youVerb('pant')} жадно, бедра дергаются при каждом пульсе.",
				"{<TOP>.Your} член пульсирует, тяжелый и готовый к разрядке.",
				"{<TOP>.Your} член яростно дергается, скользкий от предвкушения.",
				"{<TOP>.Your} тяжелый член пульсирует, требуя извержения.",
				"Дергающийся член {<TOP>.Your} весь залит смазкой.",
				"{<TOP>.You} {<TOP>.youVerb('pant')} eagerly.",
				"{<TOP>.You} {<TOP>.youVerb('close')} на грани {<TOP>.yourHis} оргазма.",
				"{<TOP>.You} {<TOP>.youAre} скоро кончит.",
				"{<TOP>.Your} "+RNG.pick(["cock", "dick", "member"])+" пульсирует.",
				"{<TOP>.Your} "+RNG.pick(["cock", "dick", "member"])+" дергается и сильно течет."
			]).replace("<TOP>", topInfo.getCharID()))

func doProcessRide(_indxRider:int, _indxTarget:int, _hole:String, _poseDescriptor:String = ""):
	var riderInfo:SexInfoBase = getDomOrSubInfo(_indxRider)
	var riderChar:BaseCharacter = riderInfo.getChar()
	#var riderStrapon:bool = riderChar.isWearingStrapon()
	var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	#var targetChar:BaseCharacter = targetInfo.getChar()
	
	var usedBodypartName:String = getNameHole(_indxRider, _hole)
	var usedPenisName:String = getNamePenis(_indxTarget)

	var text:String = RNG.pick([
		"{<RIDER>.You} {<RIDER>.youAre} riding {<TARGET>.yourHis} "+usedPenisName+".",
		"{<RIDER>.You} {<RIDER>.youAre} скачет на {<TARGET>.yourHis} "+usedPenisName+" with {<RIDER>.yourHis} "+usedBodypartName+".",
		"{<RIDER>.You} {<RIDER>.youAre} двигается вверх-вниз на {<TARGET>.yourHis} "+usedPenisName+" with {<RIDER>.yourHis} "+usedBodypartName+".",
		"{<RIDER>.You} {<RIDER>.youAre} fucking {<TARGET>.yourHis} "+usedPenisName+" with {<RIDER>.yourHis} "+usedBodypartName+".",
	])

	if(RNG.chance(20)):
		var freeRoom:float = riderChar.getPenetrationFreeRoomBy(_hole, targetInfo.getCharID())
		
		riderChar.gotOrificeStretchedBy(_hole, targetInfo.getCharID(), true, 0.1)
		
		if(_hole == BodypartSlot.Vagina):
			if(freeRoom <= 5.0):
				text += RNG.pick([
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" easily "+RNG.pick(["hits", "smashes", "reaches", "finds"])+" {<RIDER>.yourHis} "+RNG.pick(["cervix", "естественная преграда"])+".",
				])
			elif(freeRoom >= 10):
				text += RNG.pick([
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" едва ли может проникнуть глубоко.",
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" изо всех сил пытается достать до {<RIDER>.yourHis} "+RNG.pick(["cervix", "естественная преграда"])+".",
				])
		if(_hole == BodypartSlot.Anus):
			if(freeRoom <= 5.0):
				text += RNG.pick([
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" easily "+RNG.pick(["hits", "smashes", "reaches", "finds"])+" {<RIDER>.yourHis} "+RNG.pick(["точка удовольствия"])+".",
				])
			elif(freeRoom >= 10):
				text += RNG.pick([
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" едва ли может проникнуть глубоко.",
					" Кончик {<TARGET>.yourHis} "+usedPenisName+" едва дотягивается до {<RIDER>.yourHis} "+RNG.pick(["точка удовольствия"])+".",
				])

	addTextRaw(text.replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))

func doProcessRideExtra(_indxRider:int, _indxTarget:int, _hole:String):
	var riderInfo:SexInfoBase = getDomOrSubInfo(_indxRider)
	#var riderChar:BaseCharacter = riderInfo.getChar()
	var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var targetChar:BaseCharacter = targetInfo.getChar()
	var targetStrapon:bool = targetChar.isWearingStrapon()

	#var usedBodypartName:String = getNameHole(_indxRider, _hole)
	var usedPenisName:String = getNamePenis(_indxTarget)
	
	if(RNG.chance(20) && targetChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisBarbs)):
		addTextRaw(RNG.pick([
			"Зазубрины на {<TARGET>.yourHis} "+usedPenisName+" дают дополнительную стимуляцию.",
			"Зазубрины на {<TARGET>.yourHis} "+usedPenisName+" "+RNG.pick(["царапают", "scratch"])+" the "+RNG.pick(["нежные внутренности", "мягкие внутренние стенки"])+".",
		]).replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))
	
	if(targetStrapon):
		if(targetInfo.isReadyToCum()):
			addTextRaw(RNG.pick([
				"{<TARGET>.You} {<TARGET>.youAre} доводит до изнеможения через эджинг, используя {<RIDER>.you}.",
				"{<TARGET>.You} {<TARGET>.youAre} вот-вот кончит!",
				"{<TARGET>.You} {<TARGET>.youAre} держит {<TARGET>.yourself} на грани.",
			]).replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))
		elif(targetInfo.isCloseToCumming()):
			addTextRaw(RNG.pick([
				"{<TARGET>.You} {<TARGET>.youVerb('pant')} eagerly.",
				"{<TARGET>.You} {<TARGET>.youVerb('close')} наслаждается оргазмом {<TARGET>.yourHis}.",
				"{<TARGET>.You} {<TARGET>.youAre} скоро кончит.",
			]).replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))
	else:
		if(targetInfo.isReadyToCum()):
			addTextRaw(RNG.pick([
				"{<TARGET>.You} {<TARGET>.youAre} доводит до изнеможения через эджинг, используя {<RIDER>.you}.",
				"{<TARGET>.You} {<TARGET>.youAre} вот-вот кончит!",
				"{<TARGET>.You} {<TARGET>.youAre} держит {<TARGET>.yourself} на грани.",
				"{<TARGET>.Your} "+usedPenisName+" всего в паре мгновений от оргазма.",
				"{<TARGET>.Your} "+usedPenisName+" достигло пика."
			]).replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))
		elif(targetInfo.isCloseToCumming()):
			addTextRaw(RNG.pick([
				"{<TARGET>.You} {<TARGET>.youVerb('pant')} eagerly.",
				"{<TARGET>.You} {<TARGET>.youVerb('close')} наслаждается оргазмом {<TARGET>.yourHis}.",
				"{<TARGET>.You} {<TARGET>.youAre} скоро кончит.",
				"{<TARGET>.Your} "+usedPenisName+" пульсирует.",
				"{<TARGET>.Your} "+usedPenisName+" дергается и сильно течет."
			]).replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))

func doProcessPussyGrind(_indxRider:int, _indxTarget:int):
	var riderInfo:SexInfoBase = getDomOrSubInfo(_indxRider)
	var riderChar:BaseCharacter = riderInfo.getChar()
	var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	#var targetChar:BaseCharacter = targetInfo.getChar()
	
	var text:String = RNG.pick([
		"{<RIDER>.You} {<RIDER>.youAre} grinding {<RIDER>.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty", "petals", "slit", "folds", getNameHole(_indxRider, S_VAGINA)])+" на {<TARGET>.yourHis} лице.",
		"{<RIDER>.You} {<RIDER>.youVerb('use')} {<TARGET>.yourHis} выгибает лицо от {<RIDER>.yourHis} удовольствия, вжимаясь в него всем телом!",
	])
	
	if(hasBodypartUncovered(_indxRider, S_VAGINA) && riderChar.hasEffect(StatusEffect.HasCumInsideVagina)):
		if(RNG.chance(30)):
			text += RNG.pick([ 
				" "+Util.capitalizeFirstLetter(riderChar.getBodypartContentsStringList(BodypartSlot.Vagina))+" размазывается по всему лицу {<TARGET>.yourHis}.",
			])
	
	if(riderInfo.isReadyToCum()):
		text += RNG.pick([
			" {<RIDER>.YouHe} {<RIDER>.youAreHeIs} сейчас кончит!",
			" {<RIDER>.YouHe} {<RIDER>.youAreHeIs} edging {<RIDER>.yourself}.",
			" {<RIDER>.YourHis} "+getNameHole(_indxRider, S_VAGINA)+" сильно дергается.",
			" {<RIDER>.YourHis} "+getNameHole(_indxRider, S_VAGINA)+" сильно течет от возбуждения.",
			" {<RIDER>.YouHe} {<RIDER>.youAreHeIs} едва сдерживает {<RIDER>.yourself} от кончмента.",
			" {<RIDER>.YouHe} достиг(ла) {<RIDER>.yourHis} пика!",
		])
	elif(riderInfo.isCloseToCumming()):
		text += RNG.pick([
			" {<RIDER>.You} "+RNG.pick(["{<RIDER>.youVerb('let')} издает стоны", "{<RIDER>.youVerb('let')} стонет", "{<RIDER>.youVerb('bite')} {<RIDER>.yourHis} lip", "{<RIDER>.youVerb('breathe')} deeply"])+" пока {<RIDER>.yourHis} киска "+RNG.pick(["становится всё более влажной", "течет от возбуждения", "возбуждается сильнее", "течет от возбуждения", "издает возбуждающий аромат"])+"."
		])
	
	addTextRaw(text.replace("<RIDER>", riderInfo.getCharID()).replace("<TARGET>", targetInfo.getCharID()))

func doProcessCumInside(_indxTop:int, _indxBottom:int, _hole:String, tryKnot:bool = false, isRiding:bool = false) -> Dictionary:
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	#var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()

	var wombText:String = RNG.pick([
		"womb", "womb",
		"babymaker",
	])
	if(_hole == BodypartSlot.Anus):
		wombText = RNG.pick([
			"guts",
			"insides",
		])
	var text:String = ""
	var condomBroke:bool = false
	var knotSuccess:bool = false
	var didCumInside:bool = false
	var handledCum:bool = false
	var shouldStretchPainfully:bool = false

	if(_hole == S_VAGINA):
		fetishAffect(_indxTop, Fetish.VaginalSexGiving, 3.0)
		fetishAffect(_indxBottom, Fetish.VaginalSexReceiving, 3.0)
	if(_hole == S_ANUS):
		fetishAffect(_indxTop, Fetish.AnalSexGiving, 3.0)
		fetishAffect(_indxBottom, Fetish.AnalSexReceiving, 3.0)

	if(tryKnot):
		var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topChar.getID())
		var chanceToPain:float = -freeRoom * 5.0
		if(topInfo.isAngry()):
			chanceToPain *= 2.0
		if(RNG.chance(10)):
			chanceToPain *= 1.5
		if(RNG.chance(chanceToPain)):
			shouldStretchPainfully = true

		#isTryingToKnot = true
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.5)
		if(RNG.chance(bottomChar.getKnottingChanceBy(_hole, topChar.getID()))):
			knotSuccess = true
		else:
			if(!isRiding):
				text += RNG.pick([
					"{<TOP>.You} {<TOP>.youVerb('try', 'tries')} to "+RNG.pick(["принудительно вставить {<TOP>.yourHis}", "knot {<BOTTOM>.you}"])+" но дырка слишком узкая. "
				])
			else:
				text += RNG.pick([
					"{<BOTTOM>.You} {<BOTTOM>.youVerb('try', 'tries')} to "+RNG.pick(["силой впихнуть узел {<TOP>.your}", "получить узел от {<BOTTOM>.you}"])+" но дырка {<BOTTOM>.yourHis} слишком узкая. "
				])
	
	if(knotSuccess):
		if(!isRiding):
			text += RNG.pick([
				"{<TOP>.You} "+RNG.pick(["{<TOP>.youVerb('ram')}", "{<TOP>.youVerb('shove')}", "{<TOP>.youVerb('slide')}"])+" {<TOP>.yourHis} глубоко вставляет свой член в {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" и силой вгоняет узел, растягивая {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+" широкая перед [b]"+RNG.pick(["stuffing", "filling"])+" она полна семени {<TOP>.yourHis}[/b]!",
				"{<TOP>.You} заставляет {<TOP>.youVerb('manage')} принять узел {<TOP>.yourHis}, растягивая {<BOTTOM>.you}! {<TOP>.YouHe} {<TOP>.youHeVerb('grunt')}, когда член {<TOP>.yourHis} начинает извергать густые струи "+RNG.pick(["cum", "seed", "jizz", "semen"])+" глубокий [b] внутри {<BOTTOM>.yourHis} "+wombText+"[/b]!",
				"яйца {<TOP>.Your} напрягаются, когда {<TOP>.youHe} "+RNG.pick(["{<TOP>.youHeVerb('ram')}", "{<TOP>.youHeVerb('shove')}", "{<TOP>.youHeVerb('slide')}"])+" {<TOP>.yourHis} член глубоко. Узел входит, растягивая {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" пока [b]{<TOP>.youHe} {<TOP>.youAreHeIs} кончает внутрь[/b]!",
				"{<TOP>.You} "+RNG.pick(["{<TOP>.youVerb('ram')}", "{<TOP>.youVerb('shove')}", "{<TOP>.youVerb('slide')}"])+" {<TOP>.yourHis} член заходит по самые яйца. Узел растягивает {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" пока наконец не проскользнет внутрь. {<TOP>.You} {<TOP>.youVerb('grunt')}, пока [b] набивает {<BOTTOM>.yourHis} "+wombText+"[/b]!",
			])
		else:
			text += RNG.pick([
				"{<BOTTOM>.You} просто {<BOTTOM>.youVerb('keep')} скачет на {<TOP>.your} "+RNG.pick(["cock", "dick", "member"])+" жестко, пока узел {<TOP>.yourHis} внезапно не провалится внутрь! [b]{<TOP>.You} {<TOP>.youVerb('moan')}, пока {<TOP>.youHe} {<TOP>.youHeVerb('cum')} внутри {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+"[/b]!",
			])
	else:
		if(!isRiding):
			text += RNG.pick([
				"{<TOP>.You} "+RNG.pick(["{<TOP>.youVerb('ram')}", "{<TOP>.youVerb('shove')}", "{<TOP>.youVerb('slide')}"])+" {<TOP>.yourHis} глубоко вставляет свой член в {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" and [b]"+RNG.pick(["{<TOP>.youVerb('stuff')}", "{<TOP>.youVerb('fill')}"])+" она полна семени {<TOP>.yourHis}[/b]!",
				"{<TOP>.You} {<TOP>.youVerb('grunt')}, когда член {<TOP>.yourHis} начинает извергать густые струи "+RNG.pick(["cum", "seed", "jizz", "semen"])+" глубоко [b]внутри {<BOTTOM>.your} "+wombText+"[/b]!",
				"яйца {<TOP>.Your} напрягаются, когда {<TOP>.youHe} "+RNG.pick(["{<TOP>.youHeVerb('ram')}", "{<TOP>.youHeVerb('shove')}", "{<TOP>.youHeVerb('slide')}"])+" {<TOP>.yourHis} член глубоко, и [b]{<TOP>.youVerb('cum')} внутри {<BOTTOM>.you}[/b]!",
				"{<TOP>.You} "+RNG.pick(["{<TOP>.youVerb('ram')}", "{<TOP>.youVerb('shove')}", "{<TOP>.youVerb('slide')}"])+" {<TOP>.yourHis} член заходит по самые яйца, и {<TOP>.youVerb('grunt')}, пока [b] набивает {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"[/b]!",
			])
		else:
			text += RNG.pick([
				"{<BOTTOM>.You} просто {<BOTTOM>.youVerb('keep')} скачет на {<TOP>.your} "+RNG.pick(["cock", "dick", "member"])+" пока [b]{<TOP>.youHe} {<TOP>.youHeVerb('cum')} внутри {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+"[/b]!",
			])
	text += RNG.pick([
		" Волна за волной липкая {<TOP>.cum} вливается в {<BOTTOM>.yourHis} "+wombText+".",
	])
	
	var condom:ItemBase = topChar.getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		condomBroke = topChar.shouldCondomBreakWhenFucking(bottomChar, breakChance)
		if(condomBroke):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			didCumInside = true
			fetishUp(_indxTop, Fetish.Condoms, -20.0)
			fetishUp(_indxBottom, Fetish.Condoms, -30.0)
		else:
			fetishAffect(_indxTop, Fetish.Condoms, 5.0)
			fetishAffect(_indxBottom, Fetish.Condoms, 5.0)
			handledCum = true
			
			if(!isRiding):
				text = RNG.pick([
					"{<TOP>.You} заполнила презерватив внутри {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
					"{<TOP>.You} набила презерватив в {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" полный {<TOP>.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+"!",
				])
				if(knotSuccess):
					text = RNG.pick([
						"{<TOP>.You} {<TOP>.youVerb('manage')}, чтобы завязать {<BOTTOM>.youHim}! ",
						"{<TOP>.You} {<TOP>.youVerb('manage')}, чтобы засунуть узел {<TOP>.yourHis} в {<BOTTOM>.youHim}! ",
					]) + text
			else:
				if(knotSuccess):
					text = RNG.pick([
						"{<BOTTOM>.You} "+RNG.pick(["{<BOTTOM>.youVerb('nod')} and", "just"])+" {<BOTTOM>.youVerb('keep')} riding {<TOP>.your} "+RNG.pick(["cock", "dick", "member"])+" жестко, пока узел {<TOP>.yourHis} внезапно не соскользнет внутрь!",
					])
				else:
					text = RNG.pick([
						"{<BOTTOM>.You} "+RNG.pick(["{<BOTTOM>.youVerb('nod')} and", "just"])+" {<BOTTOM>.youVerb('keep')} riding {<TOP>.your} "+RNG.pick(["cock", "dick", "member"])+".",
					])
				text += RNG.pick([
					" {<TOP>.You} {<TOP>.youVerb('moan')}, пока {<TOP>.youHe} {<TOP>.youHeVerb('fill')} презерватив внутри {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
					" {<TOP>.You} {<TOP>.youVerb('moan')}, пока {<TOP>.youHe} {<TOP>.youHeVerb('stuff')} презерватив в {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" полный {<TOP>.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+"!",
				])
			
			var loadSize = topChar.cumInItem(condom)
			topInfo.cum()
			bottomInfo.addArousalSex(0.2)
			sendSexEvent(SexEvent.FilledCondomInside, _indxTop, _indxBottom, {hole=_hole,loadSize=loadSize,knotted=knotSuccess})
			#satisfyGoals()
			#if(knotSuccess):
			#	state = "knotting"
			#else:
			#	state = "aftercumminginside"
			
			#addText(text)
			#applyTallymarkIfNeeded(usedBodypart)
	
	if(!handledCum):
		didCumInside = true
		if(bottomChar.hasWombIn(_hole) && getDomOrSub(_indxTop).getFertility() > 0.1 && getDomOrSub(_indxBottom).getVirility() > 0.1):
			fetishAffect(_indxTop, Fetish.Breeding, 5.0)
			fetishAffect(_indxBottom, Fetish.BeingBred, 5.0)
			
			if(bottomInfo is SexSubInfo):
				var beingBredScore:float = bottomInfo.fetishScore({Fetish.BeingBred: 1.0})
				if(beingBredScore < 0.0):
					bottomInfo.addResistance(1.0)
					bottomInfo.addFear(0.1)
		bottomChar.cummedInBodypartByAdvanced(_hole, topInfo.getCharID(), {knotted=knotSuccess,condomBroke=condomBroke})
		topInfo.cum()
		bottomInfo.addArousalSex(0.2)
	#satisfyGoals()
	#if(knotSuccess):
	#	state = "knotting"
	#else:
	#	state = "aftercumminginside"
	
	#addText(text)
	#applyTallymarkIfNeeded(usedBodypart)
	addTextTopBottom(text, _indxTop, _indxBottom)
	
	if(shouldStretchPainfully):
		doStretch(_indxTop, _indxBottom, _hole)
	
	return {
		text=text,
		didCumInside=didCumInside,
		condomBroke=condomBroke,
		knotSuccess=knotSuccess
	}

func addTextTopBottom(_theText:String, _indxTop:int, _indxBottom:int):
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	_theText=_theText.replace("<TOP>", topInfo.getCharID()).replace("<BOTTOM>", bottomInfo.getCharID())
	addTextRaw(_theText)

func addTextTopBottomNotRaw(_theText:String, _indxTop:int, _indxBottom:int):
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	_theText=_theText.replace("<TOP>", topInfo.getCharID()).replace("<BOTTOM>", bottomInfo.getCharID())
	addText(_theText)

# Doesn't output any text
func cumOnSelf(_indxWho:int, _indxCauser:int, uniqueOrgasm:String = "", extraOrgasmText:String = " таким унизительным образом", orgasmReaction:int = SexReaction.OrgasmGeneric):
	var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var causerInfo:SexInfoBase = getDomOrSubInfo(_indxCauser)
	var theChar := theInfo.getChar()
	
	var theSpecialCase:Array = theChar.cumPenisSpecialCases(causerInfo.getCharID() if causerInfo != theInfo else "")

	#theChar.cumOnFloor(causerInfo.getCharID() if causerInfo != theInfo else "")
	theInfo.cum(causerInfo if causerInfo != theInfo else null)

	if(theChar.hasPenis()):
		var howCumText := "заливает {<SUB>.cum} по всему {<SUB>.yourHis} животу"
		if(theSpecialCase[0] == SexCumSpecialCase.CONDOM):
			howCumText = "наполняет {<SUB>.yourHis} презерватив до краев"
		if(theSpecialCase[0] == SexCumSpecialCase.PUMP):
			howCumText = "наполняет {<SUB>.yourHis} пенис-помпу до краев"
		var _theText := "{<SUB>.Your} cock "+howCumText+" as {<SUB>.youHe} {<SUB>.youHeVerb('orgasm')}"+extraOrgasmText+"!" # in such a humiliating way
		if(theSpecialCase[0] == SexCumSpecialCase.NOTHING):
			theChar.cummedOnBy(theChar.getID(), FluidSource.Penis)
		_theText =_theText.replace("<SUB>", theInfo.getCharID()).replace("<DOM>", causerInfo.getCharID())
		addTextRaw(_theText)

	if(theChar.hasReachableVagina()):
		theChar.cummedOnBy(theChar.getID(), FluidSource.Vagina, 0.3)

	if(uniqueOrgasm != ""):
		sendSexEvent(SexEvent.UniqueOrgasm, _indxCauser, _indxWho, {orgasmType=uniqueOrgasm})
	if(orgasmReaction >= 0):
		react(orgasmReaction, [100.0, 100.0] if causerInfo != theInfo else [100.0], [_indxCauser, _indxWho] if causerInfo != theInfo else [_indxWho], [uniqueOrgasm])
	
	if(theChar.getWornPenisPump() != null):
		fetishAffect(_indxWho, Fetish.SeedMilking, 3.0)

func cumGeneric(_indxWho:int, _indxCauser:int, uniqueOrgasm:String = "", extraOrgasmText:String = "", orgasmReaction:int = SexReaction.OrgasmGeneric):
	var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var causerInfo:SexInfoBase = getDomOrSubInfo(_indxCauser)
	var theChar := theInfo.getChar()
	theChar.cumOnFloor(causerInfo.getCharID() if causerInfo != theInfo else "")
	theInfo.cum(causerInfo if causerInfo != theInfo else null)
	addGenericOrgasmText(_indxWho, extraOrgasmText)
	if(uniqueOrgasm != ""):
		sendSexEvent(SexEvent.UniqueOrgasm, _indxCauser, _indxWho, {orgasmType=uniqueOrgasm})
	if(orgasmReaction >= 0):
		react(orgasmReaction, [100.0, 100.0] if causerInfo != theInfo else [100.0], [_indxWho, _indxCauser] if causerInfo != theInfo else [_indxWho], [uniqueOrgasm])
	
	if(theChar.getWornPenisPump() != null):
		fetishAffect(_indxWho, Fetish.SeedMilking, 3.0)
	
func cumInsideShare(_indxWho:int, _indxTarget1:int, _hole1:String, _indxTarget2:int, _hole2:String, _shareFirst:float = 0.5):
	#var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	var target1:BaseCharacter = getDomOrSub(_indxTarget1)
	#var target1Info:SexInfoBase = getDomOrSubInfo(_indxTarget1)
	var target2:BaseCharacter = getDomOrSub(_indxTarget2)
	#var target2Info:SexInfoBase = getDomOrSubInfo(_indxTarget2)
	
	var _hasCondom:bool = isWearingCondom(_indxWho)
	var _cumInfo1:Dictionary = cumInsideNoText(_indxWho, _indxTarget1, _hole1, {shareMode=true})
	var _cumInfo2:Dictionary = cumInsideNoText(_indxWho, _indxTarget2, _hole2, {})
	var _condomBrokeAfter1:bool = _hasCondom && _cumInfo1.get("condomBroke", false)
	var _condomBrokeAfter2:bool = _hasCondom && _cumInfo2.get("condomBroke", false)
	var _didCondomHeld:bool = _hasCondom && !_condomBrokeAfter1 && !_condomBrokeAfter2
	
	if(_didCondomHeld): # used a condom that held
		addTextRaw(("{<TOP>.You} {<TOP>.youVerb('stuff')} презерватив внутрь {<BOTTOM1>.your} "+getNameHole(_indxTarget1, _hole1)+" с первыми волнами {<TOP>.yourHis} {<TOP>.cum}. Пока оргазм еще продолжается, {<TOP>.youHe} быстро {<TOP>.youHeVerb('pull')} наружу и {<TOP>.youHeVerb('pump')} остатки в презерватив, пока он находится внутри {<BOTTOM2>.your} "+getNameHole(_indxTarget2, _hole2)+", [b]надежно удерживая всю порцию {<TOP>.your}[/b]!").replace("<TOP>", theChar.getID()).replace("<BOTTOM1>", target1.getID()).replace("<BOTTOM2>", target2.getID()))
	elif(_condomBrokeAfter1): # condom broke when the cock was inside the first sub, both subs received share of cum (same as if no condom)
		addTextRaw(("{<TOP>.You} {<TOP>.youVerb('stuff')} презерватив внутрь {<BOTTOM1>.your} "+getNameHole(_indxTarget1, _hole1)+" с первыми волнами {<TOP>.yourHis} {<TOP>.cum}. [b]Презерватив внезапно рвется![/b] Пока оргазм еще продолжается, {<TOP>.youHe} быстро {<TOP>.youHeVerb('pull')} наружу и {<TOP>.youHeVerb('pump')} остатки в {<BOTTOM2>.your} "+getNameHole(_indxTarget2, _hole2)+", [b]разделяя порцию {<TOP>.your} между ними[/b]!").replace("<TOP>", theChar.getID()).replace("<BOTTOM1>", target1.getID()).replace("<BOTTOM2>", target2.getID()))
	elif(_condomBrokeAfter2): # condom broke when the cock was inside the second sub, only the second sub got cream-pied
		addTextRaw(("{<TOP>.You} {<TOP>.youVerb('stuff')} презерватив внутрь {<BOTTOM1>.your} "+getNameHole(_indxTarget1, _hole1)+" с первыми волнами {<TOP>.yourHis} {<TOP>.cum}. Пока оргазм еще продолжается, {<TOP>.youHe} быстро {<TOP>.youHeVerb('pull')} наружу и {<TOP>.youHeVerb('pump')} остатки в презерватив, пока он находится внутри {<BOTTOM2>.your} "+getNameHole(_indxTarget2, _hole2)+". [b]Презерватив внезапно рвется! Вся порция оказывается внутри {<BOTTOM2>.you}[/b]!").replace("<TOP>", theChar.getID()).replace("<BOTTOM1>", target1.getID()).replace("<BOTTOM2>", target2.getID()))
	else: # Didn't use any condoms, just came inside both
		addTextRaw(("{<TOP>.You} {<TOP>.youVerb('stuff')} {<BOTTOM1>.your} "+getNameHole(_indxTarget1, _hole1)+" с первыми волнами {<TOP>.yourHis} {<TOP>.cum}. Пока оргазм еще продолжается, {<TOP>.youHe} быстро {<TOP>.youHeVerb('pull')} наружу и {<TOP>.youHeVerb('pump')} остальное в {<BOTTOM2>.your} "+getNameHole(_indxTarget2, _hole2)+", [b]разделяя порцию {<TOP>.your} между ними[/b]!").replace("<TOP>", theChar.getID()).replace("<BOTTOM1>", target1.getID()).replace("<BOTTOM2>", target2.getID()))


#	return {
#		text="",
#		didCumInside=didCumInside,
#		condomBroke=condomBroke,
#		knotSuccess=knotSuccess
#	}

func cumInsideNoText(_indxWho:int, _indxTarget:int, _hole:String, _extra:Dictionary = {}) -> Dictionary:
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	if(!theChar.hasPenis() && !theChar.isWearingStrapon()):
		return {}
	if(!target.hasBodypart(_hole)):
		return {}

	var tryKnot:bool = _extra["tryKnot"] if _extra.has("tryKnot") else false
	# Share mode means the target will only receive half of the cum and the dom also won't 'cum'
	var shareMode:bool = _extra["shareMode"] if _extra.has("shareMode") else false
	#var isRiding:bool = _extra["isRiding"] if _extra.has("isRiding") else false
	#var isDeepthroat:bool = _extra["isDeepthroat"] if _extra.has("isDeepthroat") else false

	if(theChar.isWearingStrapon()):
		if(_hole == S_VAGINA):
			fetishAffect(_indxWho, Fetish.StraponSexVaginal, 3.0)
			fetishAffect(_indxTarget, Fetish.VaginalSexReceiving, 3.0)
		if(_hole == S_ANUS):
			fetishAffect(_indxWho, Fetish.StraponSexAnal, 3.0)
			fetishAffect(_indxTarget, Fetish.AnalSexReceiving, 3.0)
		
		var strapon = theChar.getWornStrapon()
		if(strapon.getFluids() != null && !strapon.getFluids().isEmpty()):
			var straponHasCum:bool = strapon.getFluids().hasVirileFluids()
			target.cummedInBodypartByAdvanced(_hole, theChar.getID(), {}, null, 0.5 if shareMode else 1.0)
			
			if(straponHasCum && target.hasWombIn(_hole) && target.getFertility() > 0.1):
				fetishAffect(_indxWho, Fetish.Breeding, 5.0)
				fetishAffect(_indxTarget, Fetish.BeingBred, 5.0)
		return {}
	
	if(_hole in [S_VAGINA, S_ANUS]):
		var topInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
		var topChar:BaseCharacter = topInfo.getChar()
		#var topStrapon:bool = topChar.isWearingStrapon()
		var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
		var bottomChar:BaseCharacter = bottomInfo.getChar()

		var condomBroke:bool = false
		var knotSuccess:bool = false
		var didCumInside:bool = false
		var handledCum:bool = false
		var shouldStretchPainfully:bool = false

		if(_hole == S_VAGINA):
			fetishAffect(_indxWho, Fetish.VaginalSexGiving, 3.0)
			fetishAffect(_indxTarget, Fetish.VaginalSexReceiving, 3.0)
		if(_hole == S_ANUS):
			fetishAffect(_indxWho, Fetish.AnalSexGiving, 3.0)
			fetishAffect(_indxTarget, Fetish.AnalSexReceiving, 3.0)

		if(tryKnot):
			var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topChar.getID())
			var chanceToPain:float = -freeRoom * 5.0
			if(topInfo.isAngry()):
				chanceToPain *= 2.0
			if(RNG.chance(10)):
				chanceToPain *= 1.5
			if(RNG.chance(chanceToPain)):
				shouldStretchPainfully = true

			#isTryingToKnot = true
			bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.5)
			if(RNG.chance(bottomChar.getKnottingChanceBy(_hole, topChar.getID()))):
				knotSuccess = true
		
		var condom:ItemBase = topChar.getWornCondom()
		if(condom != null):
			var breakChance:float = condom.getCondomBreakChance()
			condomBroke = topChar.shouldCondomBreakWhenFucking(bottomChar, breakChance)
			if(condomBroke):
				condom.destroyMe()
				didCumInside = true
				fetishUp(_indxWho, Fetish.Condoms, -20.0)
				fetishUp(_indxTarget, Fetish.Condoms, -30.0)
			else:
				fetishAffect(_indxWho, Fetish.Condoms, 5.0)
				fetishAffect(_indxTarget, Fetish.Condoms, 5.0)
				handledCum = true
				
				var loadSize = topChar.cumInItem(condom, FluidSource.Penis, 0.5 if shareMode else 1.0)
				if(!shareMode):
					topInfo.cum()
				bottomInfo.addArousalSex(0.2)
				sendSexEvent(SexEvent.FilledCondomInside, _indxWho, _indxTarget, {hole=_hole,loadSize=loadSize,knotted=knotSuccess})
		
		if(!handledCum):
			didCumInside = true
			if(bottomChar.hasWombIn(_hole) && getDomOrSub(_indxWho).getFertility() > 0.1 && getDomOrSub(_indxTarget).getVirility() > 0.1):
				fetishAffect(_indxWho, Fetish.Breeding, 5.0)
				fetishAffect(_indxTarget, Fetish.BeingBred, 5.0)
				
				if(bottomInfo is SexSubInfo):
					var beingBredScore:float = bottomInfo.fetishScore({Fetish.BeingBred: 1.0})
					if(beingBredScore < 0.0):
						bottomInfo.addResistance(1.0)
						bottomInfo.addFear(0.1)
			bottomChar.cummedInBodypartByAdvanced(_hole, topInfo.getCharID(), {knotted=knotSuccess,condomBroke=condomBroke}, null, 0.5 if shareMode else 1.0)
			if(!shareMode):
				topInfo.cum()
			bottomInfo.addArousalSex(0.2)

		if(shouldStretchPainfully):
			doStretch(_indxWho, _indxTarget, _hole)
		
		return {
			text="",
			didCumInside=didCumInside,
			condomBroke=condomBroke,
			knotSuccess=knotSuccess
		}
	if(_hole == S_MOUTH):
		var topInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
		var topChar:BaseCharacter = topInfo.getChar()
		#var topStrapon:bool = topChar.isWearingStrapon()
		var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
		var bottomChar:BaseCharacter = bottomInfo.getChar()
		
		fetishAffect(_indxWho, Fetish.OralSexReceiving, 3.0)
		fetishAffect(_indxTarget, Fetish.OralSexGiving, 3.0)
		
		var condomBroke:bool = false
		var condom:ItemBase = topChar.getWornCondom()
		if(condom != null):
			var breakChance:float = condom.getCondomBreakChance()
			condomBroke = topChar.shouldCondomBreakWhenFucking(bottomChar, breakChance)
			if(condomBroke):
				condom.destroyMe()
				fetishUp(_indxWho, Fetish.Condoms, -20.0)
				fetishUp(_indxTarget, Fetish.Condoms, -30.0)
			else:
				fetishAffect(_indxWho, Fetish.Condoms, 5.0)
				fetishAffect(_indxTarget, Fetish.Condoms, 5.0)
				topChar.cumInItem(condom, FluidSource.Penis, 0.5 if shareMode else 1.0)
				if(!shareMode):
					topInfo.cum()
				return {}
		if(bottomInfo is SexSubInfo):
			var beingBredScore:float = bottomInfo.fetishScore({Fetish.OralSexGiving: 1.0})
			if(beingBredScore < 0.0):
				bottomInfo.addResistance(1.0)
				bottomInfo.addFear(0.1)
		bottomChar.cummedInBodypartByAdvanced(BodypartSlot.Head, topInfo.getCharID(), {condomBroke=condomBroke}, null, 0.5 if shareMode else 1.0)
		if(!shareMode):
			topInfo.cum()
		
		#return getSexEngine().combineData({text=text}, applyTallymarkIfNeededData(BodypartSlot.Head))
		return {}
	
	return {}

func cumInside(_indxWho:int, _indxTarget:int, _hole:String, _extra:Dictionary = {}) -> Dictionary:
	#var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	#var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	
	if(!theChar.hasPenis() && !theChar.isWearingStrapon()):
		return {}
	if(!target.hasBodypart(_hole)):
		return {}
	
	var tryKnot:bool = _extra["tryKnot"] if _extra.has("tryKnot") else false
	var isRiding:bool = _extra["isRiding"] if _extra.has("isRiding") else false
	var isDeepthroat:bool = _extra["isDeepthroat"] if _extra.has("isDeepthroat") else false
	
	if(theChar.isWearingStrapon()):
		if(_hole == S_VAGINA):
			fetishAffect(_indxWho, Fetish.StraponSexVaginal, 3.0)
			fetishAffect(_indxTarget, Fetish.VaginalSexReceiving, 3.0)
		if(_hole == S_ANUS):
			fetishAffect(_indxWho, Fetish.StraponSexAnal, 3.0)
			fetishAffect(_indxTarget, Fetish.AnalSexReceiving, 3.0)
		
		var strapon = theChar.getWornStrapon()
		if(strapon.getFluids() != null && !strapon.getFluids().isEmpty()):
			var straponHasCum:bool = strapon.getFluids().hasVirileFluids()
			target.cummedInBodypartByAdvanced(_hole, theChar.getID())
			var text:String = "{<TOP>.Your} сжимает страпон {<BOTTOM>.your} "+getNameHole(_indxTarget, _hole)+" достаточно, чтобы он внезапно [b]изверг свое содержимое внутрь {<BOTTOM>.youHim}[/b]!"
			addTextTopBottom(text, _indxWho, _indxTarget)
			
			if(straponHasCum && target.hasWombIn(_hole) && target.getFertility() > 0.1):
				fetishAffect(_indxWho, Fetish.Breeding, 5.0)
				fetishAffect(_indxTarget, Fetish.BeingBred, 5.0)
		return {}
	
	if(_hole in [S_VAGINA, S_ANUS]):
		return doProcessCumInside(_indxWho, _indxTarget, _hole, tryKnot, isRiding)
	if(_hole == S_MOUTH):
		return doProcessCumBJInside(_indxWho, _indxTarget, isDeepthroat)
	
	return {}




func doProcessCumBJInside(_indxTop:int, _indxBottom:int, isDeepthroat:bool = false) -> Dictionary:
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	#var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()
	
	var text:String = RNG.pick([
		"{<TOP>.You} {<TOP>.youVerb('grunt')} while {<TOP>.yourHis} "+RNG.pick(["cock", "dick", "member"])+" пульсирует и [b]выстреливает сперму прямо в рот {<BOTTOM>.your}[/b].",
	])
	if(isDeepthroat):
		text = RNG.pick([
			"{<TOP>.You} {<TOP>.youVerb('ram')} {<TOP>.yourHis} "+RNG.pick(["cock", "dick"])+" "+RNG.pick(["по самую прошивку", "так глубоко, как позволяет горло {<BOTTOM>.yourHis}", "глубоко в горло {<BOTTOM>.yourHis}"])+" прежде чем [b]забьет живот {<BOTTOM>.yourHis} кучей спермы[/b]!",
		])
	
	fetishAffect(_indxTop, Fetish.OralSexReceiving, 3.0)
	fetishAffect(_indxBottom, Fetish.OralSexGiving, 3.0)
	
	var condomBroke:bool = false
	var condom:ItemBase = topChar.getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		condomBroke = topChar.shouldCondomBreakWhenFucking(bottomChar, breakChance)
		if(condomBroke):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(_indxTop, Fetish.Condoms, -20.0)
			fetishUp(_indxBottom, Fetish.Condoms, -30.0)
		else:
			fetishAffect(_indxTop, Fetish.Condoms, 5.0)
			fetishAffect(_indxBottom, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{<TOP>.You} заполнила презерватив внутри {<BOTTOM>.your} "+RNG.pick(["mouth"])+"!",
				"{<TOP>.You} набила презерватив в {<BOTTOM>.your} "+RNG.pick(["mouth"])+" полный {<TOP>.yourHis} "+RNG.pick(["cum", "seed", "jizz", "semen"])+"!",
			])
			topChar.cumInItem(condom)
			topInfo.cum()
			
			addTextTopBottom(text, _indxTop, _indxBottom)
			return {}
	if(bottomInfo is SexSubInfo):
		var beingBredScore:float = bottomInfo.fetishScore({Fetish.OralSexGiving: 1.0})
		if(beingBredScore < 0.0):
			bottomInfo.addResistance(1.0)
			bottomInfo.addFear(0.1)
	bottomChar.cummedInBodypartByAdvanced(BodypartSlot.Head, topInfo.getCharID(), {condomBroke=condomBroke})
	topInfo.cum()
	
	#return getSexEngine().combineData({text=text}, applyTallymarkIfNeededData(BodypartSlot.Head))
	addTextTopBottom(text, _indxTop, _indxBottom)
	return {}




func squirtOnto(_indxWho:int, _indxTarget:int, _extra:Dictionary = {}):
	var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	#var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	
	if(!theChar.hasVagina()):
		return {}
	
	var uniqueOrgasm:String = _extra["uniqueOrgasm"] if _extra.has("uniqueOrgasm") else ""
	
	var text:String = ""
	text = RNG.pick([
		"{<TOP>.You} {<TOP>.youVerb('arch', 'arches')} {<TOP>.yourHis} назад, пока {<TOP>.yourHis} "+RNG.pick(["pussy", "щель киски", "kitty"])+" дергается и заливает всю поверхность тела и лица {<BOTTOM>.your}!",
	])
	target.cummedOnBy(theChar.getID(), FluidSource.Vagina)
	theInfo.cum()
	if(theChar.isWearingChastityCage()):
		text += RNG.pick([
			" {<TOP>.YourHis} "+RNG.pick(["cock", "dick", "penis"])+" выстреливает слабую порцию через девственную клетку.",
		])
	elif(theChar.hasReachablePenis()):
		text += RNG.pick([
			" {<TOP>.YourHis} "+RNG.pick(["cock", "dick", "penis"])+" выстреливает порцией {<TOP>.cum}, которая разлетается во все стороны.",
		])
	
	addTextTopBottom(text, _indxWho, _indxTarget)
	if(uniqueOrgasm != ""):
		sendSexEvent(SexEvent.UniqueOrgasm, _indxTarget, _indxWho, {orgasmType=uniqueOrgasm})

func cumOnto(_indxWho:int, _indxTarget:int, _extra:Dictionary = {}):
	var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	#var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	
	if(!theChar.hasPenis()):
		return {}
	
	var isGeneric:bool = _extra.has("generic") && _extra["generic"]
	var isSex:bool = _extra.has("sex") && _extra["sex"]
	var uniqueOrgasm:String = _extra["uniqueOrgasm"] if _extra.has("uniqueOrgasm") else ""
	
	if(!isSex && !isGeneric):
		fetishAffect(_indxWho, Fetish.OralSexReceiving, 3.0)
		fetishAffect(_indxTarget, Fetish.OralSexGiving, 3.0)
	
	var text:String = RNG.pick([
		"{<TOP>.You} {<TOP>.youVerb('pull')} {<TOP>.yourHis} {<TOP>.penisShort} наружу, и [b]{<TOP>.youVerb('cum')} заливает всё лицо {<BOTTOM>.your}[/b]!",
		"{<TOP>.You} {<TOP>.youVerb('pull')} наружу, [b]заливая всё лицо {<BOTTOM>.your}[/b]!",
	])
	if(_indxWho == _indxTarget):
		text = RNG.pick([
			"{<TOP>.You} {<TOP>.youVerb('pull')} {<TOP>.yourHis} {<TOP>.penisShort} наружу, и [b]{<TOP>.youVerb('cum')} заливает собственный живот {<TOP>.yourHis}[/b]!",
			"{<TOP>.You} {<TOP>.youVerb('pull')} наружу, [b]заливая собственный живот {<TOP>.yourHis}[/b]!",
		])
	if(isSex):
		text = RNG.pick([
			"{<TOP>.You} {<TOP>.youVerb('pull')} {<TOP>.yourHis} {<TOP>.penisShort} наружу, и [b]{<TOP>.youVerb('cum')} заливает задницу {<BOTTOM>.your}[/b]!",
			"{<TOP>.You} {<TOP>.youVerb('pull')} наружу, [b]заливая задницу {<BOTTOM>.your}[/b]!",
		])
		if(_indxWho == _indxTarget):
			text = RNG.pick([
				"{<TOP>.You} {<TOP>.youVerb('pull')} {<TOP>.yourHis} {<TOP>.penisShort} наружу, и [b]{<TOP>.youVerb('cum')} заливает собственный живот {<TOP>.yourHis}[/b]!",
				"{<TOP>.You} {<TOP>.youVerb('pull')} наружу, [b]заливая собственный живот {<TOP>.yourHis}[/b]!",
			])
	elif(isGeneric):
		text = RNG.pick([
			"{<TOP>.You} {<TOP>.youVerb('grunt')}, пока {<TOP>.youHe} [b]{<TOP>.youHeVerb('cum')} разлетается по всему телу и лицу {<BOTTOM>.your}[/b]!",
		])
		if(_indxWho == _indxTarget):
			text = RNG.pick([
				"{<TOP>.You} {<TOP>.youVerb('grunt')} размазывает {<TOP>.youHe} [b]{<TOP>.youHeVerb('cum')} по всему {<TOP>.yourHis} собственному животу[/b]!",
			])
	
	
	var condom:ItemBase = theChar.getWornCondom()
	if(condom != null):
		var breakChance:float = condom.getCondomBreakChance()
		
		if(RNG.chance(breakChance)):
			text = "[b]Презерватив порвался![/b] "+text
			condom.destroyMe()
			fetishUp(_indxWho, Fetish.Condoms, -20.0)
			fetishUp(_indxTarget, Fetish.Condoms, -30.0)
		else:
			fetishAffect(_indxWho, Fetish.Condoms, 5.0)
			fetishAffect(_indxTarget, Fetish.Condoms, 5.0)
			text = RNG.pick([
				"{<TOP>.You} {<TOP>.youVerb('pull')} {<TOP>.yourHis} вытащи член и {<TOP>.youVerb('fill')} {<TOP>.yourHis} презерватив!",
				"{<TOP>.You} {<TOP>.youVerb('pull')} вылетает наружу, {<TOP>.yourHis} член пульсирует, набивая {<TOP>.yourHis} презерватив!",
			])
			if(isGeneric):
				text = RNG.pick([
					"{<TOP>.You} {<TOP>.youVerb('grunt')}, словно {<TOP>.yourHis} {<TOP>.penisShort}, пульсирует и набивает презерватив до отказа!",
				])
			theChar.cumInItem(condom)
			theInfo.cum()
			#satisfyGoals()
			#state = ""
			addTextTopBottom(text, _indxWho, _indxTarget)
			if(uniqueOrgasm != ""):
				sendSexEvent(SexEvent.UniqueOrgasm, _indxTarget, _indxWho, {orgasmType=uniqueOrgasm})
			return
	
	target.cummedOnBy(theInfo.getCharID(), FluidSource.Penis)
	theChar.cumOnFloor()
	theInfo.cum()
	#satisfyGoals()
	#state = ""

	addTextTopBottom(text, _indxWho, _indxTarget)
	if(uniqueOrgasm != ""):
		sendSexEvent(SexEvent.UniqueOrgasm, _indxTarget, _indxWho, {orgasmType=uniqueOrgasm})




func tryPenetrate(_indxTop:int, _indxBottom:int, _hole:String, isEnveloping:bool = false, isForcePenetrate:bool = false) -> bool:
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()
	
	if(!(_hole in [S_VAGINA, S_ANUS])):
		return true
	#var fetishGiving:String = Fetish.VaginalSexGiving if _hole == S_VAGINA else Fetish.AnalSexGiving
	
	if(!isForcePenetrate && !RNG.chance(bottomChar.getPenetrateChanceBy(_hole, topChar.getID()))):
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.1)
		if(!isEnveloping):
			addTextTopBottom("{<TOP>.Your} {<TOP>.penisShort} stretches {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" наружу, пытаясь втиснуться внутрь.", _indxTop, _indxBottom)
		else:
			addTextTopBottom("{<BOTTOM>.You} {<BOTTOM>.youVerb('try', 'tries')} пытается обхватить {<TOP>.yourHis} {<TOP>.penisShort}, но он слишком велик!", _indxTop, _indxBottom)
		stimulateSex(_indxTop, _indxBottom, _hole, I_TEASE)
		
		return false
	else:
		sendSexEvent(SexEvent.HolePenetrated, _indxTop, _indxBottom, {hole=_hole,engulfed=isEnveloping,strapon=topStrapon})
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.2)
		stimulateSex(_indxTop, _indxBottom, _hole, I_LOW)
		var text:String = RNG.pick([
			"{<TOP>.You} {<TOP>.youVerb('manage','manages')} проникает в {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
			"{<TOP>.You} {<TOP>.youVerb('shove','shoves')} {<TOP>.yourHis} {<TOP>.penisShort} inside {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
		])
		if(isEnveloping):
			text = "{<BOTTOM>.You} {<BOTTOM>.youVerb('engulf')} {<TOP>.youHis} {<TOP>.penisShort}, позволяя ему войти в {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+"."
		if(_hole == BodypartSlot.Anus && bottomChar.getInventory().hasSlotEquipped(InventorySlot.Anal)):
			var item = bottomChar.getInventory().getEquippedItem(InventorySlot.Anal)
			if(!isEnveloping):
				text = "{<TOP>.You} на время {<TOP>.youVerb('retrieve')} "+str(item.getAStackName())+" из {<BOTTOM>.your} задницы. "+text
			else:
				text = "{<BOTTOM>.You} на время {<BOTTOM>.youVerb('retrieve')} "+str(item.getAStackName())+" из {<BOTTOM>.yourHis} задницы. "+text
		elif(_hole == BodypartSlot.Vagina && bottomChar.getInventory().hasSlotEquipped(InventorySlot.Vagina)):
			var item = bottomChar.getInventory().getEquippedItem(InventorySlot.Vagina)
			if(!isEnveloping):
				text = "{<TOP>.You} на время {<TOP>.youVerb('retrieve')} "+str(item.getAStackName())+" из {<BOTTOM>.your} киски. "+text
			else:
				text = "{<BOTTOM>.You} на время {<BOTTOM>.youVerb('retrieve')} "+str(item.getAStackName())+" из {<BOTTOM>.yourHis} киски. "+text
		
		addTextTopBottom(text, _indxTop, _indxBottom)
		
		var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topChar.getID())
		var chanceToPain = -freeRoom * 2.0
		if(RNG.chance(chanceToPain) || ((topInfo is SexDomInfo) && topInfo.isAngry() && RNG.chance(20))):
			doStretch(_indxTop, _indxBottom, _hole)
			#fetishUp(_indxBottom, Fetish.VaginalSexReceiving if _hole == S_VAGINA else Fetish.AnalSexReceiving, -20.0)
		return true

# Does a 'result' of a penetration
func penetration(didPenetrate:bool, _indxTop:int, _indxBottom:int, _hole:String, isEnveloping:bool = false) -> bool:
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()
	
	if(!(_hole in [S_VAGINA, S_ANUS])):
		return true
	#var fetishGiving:String = Fetish.VaginalSexGiving if _hole == S_VAGINA else Fetish.AnalSexGiving
	
	if(!didPenetrate):
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.1)
		#if(!isEnveloping):
		#	addTextTopBottom("{<TOP>.Your} {<TOP>.penisShort} stretches {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+" out while trying to fit inside.", _indxTop, _indxBottom)
		#else:
		#	addTextTopBottom("{<BOTTOM>.You} {<BOTTOM>.youVerb('try', 'tries')} to envelop {<TOP>.yourHis} {<TOP>.penisShort} but it's too big!", _indxTop, _indxBottom)
		stimulateSex(_indxTop, _indxBottom, _hole, I_TEASE)
		
		return false
	else:
		sendSexEvent(SexEvent.HolePenetrated, _indxTop, _indxBottom, {hole=_hole,engulfed=isEnveloping,strapon=topStrapon})
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.2)
		stimulateSex(_indxTop, _indxBottom, _hole, I_LOW)
		#var text:String = RNG.pick([
		#	"{<TOP>.You} {<TOP>.youVerb('manage','manages')} to penetrate {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
		#	"{<TOP>.You} {<TOP>.youVerb('shove','shoves')} {<TOP>.yourHis} {<TOP>.penisShort} inside {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+"!",
		#])
		#if(isEnveloping):
			#text = "{<BOTTOM>.You} {<BOTTOM>.youVerb('engulf')} {<TOP>.youHis} {<TOP>.penisShort}, letting it penetrate {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+"."
		#if(_hole == BodypartSlot.Anus && bottomChar.getInventory().hasSlotEquipped(InventorySlot.Anal)):
			#var item = bottomChar.getInventory().getEquippedItem(InventorySlot.Anal)
			#if(!isEnveloping):
				#text = "{<TOP>.You} temporarily {<TOP>.youVerb('retrieve')} "+str(item.getAStackName())+" out of {<BOTTOM>.your} ass. "+text
			#else:
				#text = "{<BOTTOM>.You} temporarily {<BOTTOM>.youVerb('retrieve')} "+str(item.getAStackName())+" out of {<BOTTOM>.yourHis} ass. "+text
		#elif(_hole == BodypartSlot.Vagina && bottomChar.getInventory().hasSlotEquipped(InventorySlot.Vagina)):
			#var item = bottomChar.getInventory().getEquippedItem(InventorySlot.Vagina)
			#if(!isEnveloping):
			#	text = "{<TOP>.You} temporarily {<TOP>.youVerb('retrieve')} "+str(item.getAStackName())+" out of {<BOTTOM>.your} pussy. "+text
			#else:
			#	text = "{<BOTTOM>.You} temporarily {<BOTTOM>.youVerb('retrieve')} "+str(item.getAStackName())+" out of {<BOTTOM>.yourHis} pussy. "+text
		
		var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topChar.getID())
		var chanceToPain = -freeRoom * 2.0
		if(RNG.chance(chanceToPain) || ((topInfo is SexDomInfo) && topInfo.isAngry() && RNG.chance(20))):
			doStretch(_indxTop, _indxBottom, _hole)
			#fetishUp(_indxBottom, Fetish.VaginalSexReceiving if _hole == S_VAGINA else Fetish.AnalSexReceiving, -20.0)

		#addTextTopBottom(text, _indxTop, _indxBottom)
		return true



func cockWarmer(_indxBottom:int, _indxTop:int, _hole:String, _isKnot:bool = false):
	var topInfo:SexInfoBase = getDomOrSubInfo(_indxTop)
	var topChar:BaseCharacter = topInfo.getChar()
	#var topStrapon:bool = topChar.isWearingStrapon()
	var bottomInfo:SexInfoBase = getDomOrSubInfo(_indxBottom)
	var bottomChar:BaseCharacter = bottomInfo.getChar()
	
	stimulateSex(_indxTop, _indxBottom, _hole, I_TEASE, SPEED_SLOW)
	
	var freeRoom:float = bottomChar.getPenetrationFreeRoomBy(_hole, topChar.getID())
	if(freeRoom > 0.0):
		addTextTopBottom("{<BOTTOM>.You} {<BOTTOM>.youAre} being a "+RNG.pick(["great", "good"])+" грелка для члена {<TOP>.you}. Внутри {<BOTTOM>.yourHis} достаточно места, "+getNameHole(_indxBottom, _hole)+" чтобы {<BOTTOM>.youHim} не чувствовала боли.", _indxTop, _indxBottom)
		return
	else:
		addTextTopBottom("{<BOTTOM>.You} {<BOTTOM>.youAre} пытается быть грелкой для {<TOP>.you}, но {<BOTTOM>.yourHis} "+getNameHole(_indxBottom, _hole)+" слишком узкая, это очень больно! Но для {<TOP>.you} это чертовски приятно.", _indxTop, _indxBottom)
		var howMuchPainAdd = RNG.randi_range(1, 2)
		bottomInfo.addPain(howMuchPainAdd)
		sendSexEvent(SexEvent.PainInflicted, SUB_0, DOM_0, {pain=howMuchPainAdd,isDefense=false,intentional=false})
		topInfo.addLust(10)
		topInfo.addArousalForeplay(0.1)
		bottomChar.gotOrificeStretchedBy(_hole, topChar.getID(), true, 0.1)
		return

func rubPenisAgainst(_indxTop:int, _indxBottom:int, _hole:String):
	if(!(_hole in [S_VAGINA, S_ANUS])):
		return
	addTextTopBottomNotRaw("{<TOP>.You} {<TOP>.youVerb('rub')} {<TOP>.yourHis} {<TOP>.penisShort} against {<BOTTOM>.your} "+getNameHole(_indxBottom, _hole)+getThroughClothingText(_indxTop, S_PENIS)+".", _indxTop, _indxBottom)
	stimulateSex(_indxTop, _indxBottom, _hole, I_TEASE)

func strokePenis(_indxActor:int, _indxTarget:int):
	var actorInfo:SexInfoBase = getDomOrSubInfo(_indxActor)
	var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	
	addTextRaw(RNG.pick([
		"{dom.You} {dom.youVerb('stroke')} {sub.yourHis} {sub.penisShort}.",
		"{dom.You} {dom.youVerb('slide')} водит рукой {dom.yourHis} вдоль {sub.yourHis} {sub.penisShort}.",
		"{dom.You} {dom.youVerb('slide')} водит рукой {dom.yourHis} вдоль {sub.yourHis} {sub.penisShort} туда-сюда.",
		"{dom.You} {dom.youVerb('rub')} головку {sub.yourHis} {sub.penisShort} круговыми движениями.",
		"{dom.You} {dom.youVerb('trace')} перебирает пальцами {dom.yourHis} по венам на {sub.yourHis} {sub.penisShort}.",
		"{dom.You} {dom.youVerb('keep')} ласкает {sub.yourHis} {sub.penisShort} в размеренном, дразнящем ритме.",
		
	]).replace("dom.", actorInfo.getCharID()+".").replace("sub.", targetInfo.getCharID()+"."))
	
	if(isCloseToCumming(_indxTarget) && !isStrapon(_indxTarget) && RNG.chance(30)):
		addTextRaw(RNG.pick([
			"{sub.YouHe} {sub.youAreHeIs} вот-вот кончит!",
			"{sub.YouHe} {sub.youAreHeIs} томится от возбуждения из-за {dom.youHim}.",
			"{sub.YourHis} {sub.penisShort} дергается и пульсирует.",
			"{sub.YourHis} {sub.penisShort} сильно течет.",
			"{sub.YouHe} {sub.youAreHeIs} едва сдерживает {sub.yourself} от кончания.",
			"{sub.YouHe} достиг(ла) {sub.yourHis} пика!",
		]).replace("dom.", actorInfo.getCharID()+".").replace("sub.", targetInfo.getCharID()+"."))
	elif(isReadyToFuck(_indxTarget) && !isStrapon(_indxTarget) && RNG.chance(20)):
		addTextRaw(RNG.pick([
			"{sub.Your} {sub.penisShort} уже сочится "+RNG.pick(["pre", "precum", "arousal"])+".",
			"{sub.Your} {sub.penisType} seems "+RNG.pick(["ready", "достаточно твердым"])+" для минета.",
			"головка {sub.YourHis} {sub.penisType} блестит от свежей смазки.",
			"{sub.Your} {sub.penisType} такой твердый и скользкий от возбуждения.",
			"{sub.Your} {sub.penisShort} пульсирует, умоляя о новых ласках.",
			"Ствол {sub.Your} пульсирует от жажды.",
		]).replace("dom.", actorInfo.getCharID()+".").replace("sub.", targetInfo.getCharID()+"."))

func cupballs(_indxWho:int, _indxTarget:int, poseDescription:String = ""):
	#var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	#var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	
	var penis:BodypartPenis = target.getBodypart(BodypartSlot.Penis)
	if(penis == null):
		return
	var cumProduction:FluidProduction = penis.getFluidProduction()
	if(cumProduction == null):
		return
	
	var level:float = cumProduction.getFluidLevel()
	var text:String
	if(level <= 0.3):
		text = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('grope')}", "{dom.youVerb('fondle')}", "{dom.youVerb('play')} with"])+" {sub.your} balls"+poseDescription+" и {dom.youVerb('feel')} их "+RNG.pick(["становятся тяжелее", "становятся всё тяжелее", "вырабатывает больше семени", "вырабатывает сперму"])+".",
		])
	elif(level <= 0.7):
		text = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('grope')}", "{dom.youVerb('fondle')}", "{dom.youVerb('play')} with"])+" {sub.your} balls"+poseDescription+" и {dom.youVerb('feel')} придают им немалый вес. Но они всё равно "+RNG.pick(["становятся ещё тяжелее", "производят ещё больше семени", "вырабатывают ещё больше кончи"])+" пока {dom.youHe} {dom.youHeVerb('tease')} их.",
		])
	else:
		text = RNG.pick([
			"{dom.You} "+RNG.pick(["{dom.youVerb('grope')}", "{dom.youVerb('fondle')}", "{dom.youVerb('play')} with"])+" {sub.your} balls"+poseDescription+" and {dom.youVerb('realize')} "+RNG.pick(["что они полны", "насколько они тяжёлые", "сколько кончи в них накопилось"])+". They "+RNG.pick(["слегка напрягаются"])+" пока {dom.youHe} {dom.youHeVerb('tease')} их.",
		])
	addTextRaw(text.replace("{доминант.", "{"+theChar.getID()+".").replace("{сабмиссив.", "{"+target.getID()+"."))
	cumProduction.fillPercent(0.2)

func rubWithFeet(_indxWho:int, _indxTarget:int, _hole:String):
	#var theInfo:SexInfoBase = getDomOrSubInfo(_indxWho)
	var theChar:BaseCharacter = getDomOrSub(_indxWho)
	var targetInfo:SexInfoBase = getDomOrSubInfo(_indxTarget)
	var target:BaseCharacter = getDomOrSub(_indxTarget)
	
	var text:String = ""
	
	if(_hole == S_PENIS):
		text += RNG.pick([
			"{dom.You} {dom.youVerb('use')} {dom.yourHis} {dom.toes}, чтобы доставить удовольствие {sub.your} {sub.penisShort}.",
			"{dom.You} {dom.youVerb('rub')} {dom.yourHis} {dom.foot} against {sub.your} {sub.penisShort}.",
			"{dom.You} {dom.youVerb('rub')} {sub.your} {sub.penisShort} with {dom.yourHis} {dom.foot}.",
			"{dom.You} {dom.youVerb('pleasure')} {sub.your} {sub.penisShort} with {dom.yourHis} {dom.toes}.",
			"{dom.You} {dom.youVerb('pleasure')} {sub.your} {sub.penisShort} with {dom.yourHis} {dom.feet}.",
			"{dom.You} {dom.youVerb('stroke')} {sub.your} {sub.penisShort} with {dom.yourHis} {dom.foot}.",
			"{dom.You} {dom.youVerb('stroke')} {sub.your} {sub.penisShort} with {dom.yourHis} {dom.feet}.",
		])
		if((targetInfo.isCloseToCumming() || RNG.chance(20)) && !isStrapon(_indxTarget)):
			text += RNG.pick([
				" {sub.YourHis} {sub.penisType} подергивается от удовольствия.",
				" {sub.YourHis} {sub.penisType} пульсирует от интенсивного ласкания.",
				" {sub.YourHis} {sub.penisType} течет от того, как сильно его/ее трут.",
				" {sub.YourHis} {sub.penisType} покрывает {dom.your} {dom.toes} своей смазкой."
			])
		if(targetInfo.isCloseToCumming() && RNG.chance(50)):
			text += RNG.pick([
				" {sub.You} {sub.youAre} сейчас кончит!",
				" {sub.You} больше не может сдерживаться!"
			])
	
	if(_hole in [S_VAGINA, S_ANUS]):
		text += RNG.pick([
			"{dom.You} {dom.youVerb('use')} {dom.yourHis} {dom.toes}, чтобы доставить удовольствие {sub.your} "+getNameHole(_indxTarget, _hole)+".",
			"{dom.You} {dom.youVerb('use')} {dom.yourHis} {dom.feet}, чтобы доставить удовольствие {sub.your} "+getNameHole(_indxTarget, _hole)+".",
			"{dom.You} {dom.youVerb('rub')} {dom.yourHis} {dom.foot} against {sub.your} "+getNameHole(_indxTarget, _hole)+".",
			"{dom.You} {dom.youVerb('rub')} {sub.yourHis} "+getNameHole(_indxTarget, _hole)+" with {dom.yourHis} {dom.foot}."
		])
	if(_hole == S_VAGINA):
		if(targetInfo.isCloseToCumming() || RNG.chance(20)):
			text += RNG.pick([
				" Щель {sub.YourHis} издает влажные звуки, пока ее ласкают.",
				" Влажная киска {sub.YourHis} подергивается от интенсивного трения.",
				" Щель {sub.YourHis} течет от того, как сильно ее трут.",
				" Щель {sub.YourHis} смазывает пальцы ног {dom.your} своим соком."
			])
		if(targetInfo.isCloseToCumming() && RNG.chance(50)):
			text += RNG.pick([
				" {sub.You} {sub.youAre} сейчас кончит!",
				" {sub.You} больше не может сдерживаться!"
			])
	addTextRaw(text.replace("{доминант.", "{"+theChar.getID()+".").replace("{сабмиссив.", "{"+target.getID()+"."))

func stuffTentacleEgg(_indx:int, _hole:String, _addMessage:bool = true, _tentacleIndx:int=DOM_0) -> bool:
	var theChar:BaseCharacter = getDomOrSub(_indx)
	if(!theChar):
		return false
	var theMenstrualCycle:MenstrualCycle = theChar.getMenstrualCycle()
	if(!theMenstrualCycle):
		return false
	var theSexType = getSexEngine().getSexType()
	if(theSexType.id != SexType.TentaclesSex):
		return false
	var theTentacleType:int = theSexType.tentacleType
	var theEggTime:int = theSexType.eggTime
	var theOrifice:int = OrificeType.fromBodypart(_hole)
	if(theOrifice < 0):
		return false
	var theResult:bool = theMenstrualCycle.addTentacleEgg(getDomOrSubID(_tentacleIndx), theTentacleType, theEggTime, theOrifice)
	
	if(theResult && _addMessage):
		var theHoleName:String = "somewhere"
		if(_hole == S_VAGINA):
			theHoleName = "в вагину {<TARGET>.your}"
		elif(_hole == S_ANUS):
			theHoleName = "down {<TARGET>.your} "+RNG.pick(["tailhole", "asshole"])
		elif(_hole == S_MOUTH):
			theHoleName = "в глотку {<TARGET>.your}"
		addTextRaw("[b]Запихнуть яйцо "+(theHoleName.replace("<TARGET>", theChar.getID()))+"![/b]")
	
	return theResult
	
func stuffTentacleEggRandomHole(_indx:int, _addMessage:bool = true, _tentacleIndx:int=DOM_0) -> bool:
	var possibleHoles:Array = [BodypartSlot.Anus, BodypartSlot.Anus, BodypartSlot.Head] # Anus is 2x as likely to be picked
	if(getDomOrSub(_indx).hasReachableVagina()):
		possibleHoles.append(BodypartSlot.Vagina) # Vagina is 4x time as likely to be picked
		possibleHoles.append(BodypartSlot.Vagina)
		possibleHoles.append(BodypartSlot.Vagina)
		possibleHoles.append(BodypartSlot.Vagina)
	
	var theHole:String = RNG.pick(possibleHoles)
	
	return stuffTentacleEgg(_indx, theHole, _addMessage, _tentacleIndx)

func addEggStuffButton(_roleMain:int, _roleTarget:int, _bodypart:String, _actionID:String = "stuffegg") -> bool:
	if(canStuffEggInto(_roleMain, _roleTarget, _bodypart)):
		var theMainInfo := getDomOrSubInfo(_roleMain)
		var theTargetInfo := getDomOrSubInfo(_roleTarget)
		var theArousal:float = theMainInfo.getArousal()
		var theTargetLust:float = theTargetInfo.getChar().getLustLevel()
		var theBreedFetish:float = fetish(_roleMain, Fetish.Breeding)
		var thePersMean:float = personality(_roleMain, PersonalityStat.Mean)
		
		var theEggScore:float = -0.2
		theEggScore += theTargetLust*0.2
		theEggScore += max((theBreedFetish+0.2)*0.5, 0.0)
		theEggScore += max(thePersMean*0.2, 0.0)
		if(theBreedFetish > -0.5):
			theEggScore = max(theEggScore, 0.1)
		
		theEggScore *= theArousal*2.0
		
		if(theArousal < 0.3):
			theArousal *= 0.1
		
		addAction(_actionID, theEggScore, "Засунуть яйцо", "Запихнуть им яйцо...", {A_PRIORITY: 2})
		return true
	return false

func addEggStuffReceiveButton(_roleMain:int, _roleTarget:int, _bodypart:String, _actionID:String = "stuffegg") -> bool:
	if(canStuffEggInto(_roleTarget, _roleMain, _bodypart)):
		var theMainInfo := getDomOrSubInfo(_roleMain)
		var theTargetInfo := getDomOrSubInfo(_roleTarget)
		var theArousal:float = theMainInfo.getArousal()
		var theTargetLust:float = theTargetInfo.getChar().getLustLevel()
		var theBreedFetish:float = fetish(_roleMain, Fetish.BeingBred)
		var thePersMean:float = personality(_roleMain, PersonalityStat.Mean)
		
		var theEggScore:float = -0.2
		theEggScore += theTargetLust*0.2
		theEggScore += max((theBreedFetish+0.2)*0.5, 0.0)
		theEggScore += max(thePersMean*0.2, 0.0)
		if(theBreedFetish > -0.5):
			theEggScore = max(theEggScore, 0.1)
		
		theEggScore *= theArousal*2.0
		
		if(theArousal < 0.3):
			theArousal *= 0.1

		addAction(_actionID, theEggScore, "Принять яйцо", "Заставить их запихнуть яйцо в тебя...", {A_PRIORITY: 2})
		return true
	return false

func canStuffEggInto(_roleMain:int, _roleTarget:int, _bodypart:String) -> bool:
	var _main := getDomOrSub(_roleMain)
	var _target := getDomOrSub(_roleTarget)
	return canStuffEggIntoRaw(_main, _target, _bodypart)

func canStuffEggIntoRaw(_main:BaseCharacter, _target:BaseCharacter, _bodypart:String) -> bool:
	if(!_main || !_target):
		return false
	if(!_target.isDynamicCharacter() && !_target.isPlayer()): # Static characters don't know how to handle it, sorry
		return false
	
	if(!_target.hasBodypart(_bodypart)):
		return false
	
	var theStrapon :ItemBase = _main.getWornStrapon()
	if(theStrapon):
		if(theStrapon.has_method("getStraponTraits") && theStrapon.has_method("canStuffEggInto")):
			if(theStrapon.getStraponTraits().get(PartTrait.Ovipositor, false)):
				return theStrapon.canStuffEggInto(_target, _bodypart)
		return false

	if(!_main.hasPenis()):
		return false
	var thePenis:BodypartPenis = _main.getBodypart(BodypartSlot.Penis)
	if(thePenis.hasTrait(PartTrait.Ovipositor) && thePenis.has_method("canStuffEggInto")):
		return thePenis.canStuffEggInto(_target, _bodypart)
	return false

func doReceiveEggFrom(_roleMain:int, _roleTarget:int, _bodypart:String, _showMessage:bool = true) -> Dictionary:
	return doStuffEggInto(_roleTarget, _roleMain, _bodypart, _showMessage)
	
func doStuffEggInto(_roleMain:int, _roleTarget:int, _bodypart:String, _showMessage:bool = true) -> Dictionary:
	var _main := getDomOrSub(_roleMain)
	var _target := getDomOrSub(_roleTarget)
	if(!_main || !_target):# || !_target.isDynamicCharacter()):
		return {success = false}
	
	var theStrapon :ItemBase = _main.getWornStrapon()
	if(theStrapon):
		if(theStrapon.has_method("getStraponTraits") && theStrapon.has_method("canStuffEggInto") && theStrapon.has_method("doStuffEggInto")):
			if(theStrapon.getStraponTraits().get(PartTrait.Ovipositor, false)):
				if(theStrapon.canStuffEggInto(_target, _bodypart)):
					var theResult:Dictionary = theStrapon.doStuffEggInto(_target, _bodypart)
					if(!theResult.get("success", false)):
						return {success = false}
					
					if(_showMessage && !theResult.get("text", "").empty()):
						addTextRaw(theResult["text"])
					
					return theResult
		return {success = false}
	
	if(!_main.hasPenis()):
		return {success = false}
	var thePenis:BodypartPenis = _main.getBodypart(BodypartSlot.Penis)
	if(thePenis.hasTrait(PartTrait.Ovipositor) && thePenis.has_method("canStuffEggInto") && thePenis.has_method("doStuffEggInto")):
		if(thePenis.canStuffEggInto(_target, _bodypart)):
			if(_main.isWearingCondom()): # I'm not making a condom-of-eggs mechanic, nuhhhhh
				var theCondom = _main.getWornCondom()
				theCondom.destroyMe()
				addTextRaw("[b]{"+_main.getID()+".Твой} презерватив рвется![/b]")
			
			var theResult:Dictionary = thePenis.doStuffEggInto(_target, _bodypart)
			if(!theResult.get("success", false)):
				return {success = false}
			
			if(_showMessage && !theResult.get("text", "").empty()):
				addTextRaw(theResult["text"])
	return {success = false}

func addTriggerStraponAction(_who:int, _score:float = 0.0, _actionID:String = "triggerStrapon") -> bool:
	if(isWearingStrapon(_who)):
		var strapon = getDomOrSub(_who).getWornStrapon()
		if(strapon.getFluids() != null && !strapon.getFluids().isEmpty()):
			addAction(_actionID, _score, "Использовать страпон", "Заставить страпон кончить!", {A_PRIORITY: 2})
			return true
	return false
			
func triggerStrapon(_who:int, _target:int, _bodypart:String, _showText:bool = true) -> bool:
	if(isWearingStrapon(_who)):
		var strapon = getDomOrSub(_who).getWornStrapon()
		if(strapon.getFluids() != null && !strapon.getFluids().isEmpty()):
			getDomOrSub(_target).cummedInBodypartByAdvanced(_bodypart, getDomOrSubID(_who), {}, FluidSource.Strapon)
			var theDom:String = indxToTextID(_who)
			var theSub:String = indxToTextID(_target)
			if(_showText):
				addText("{"+theDom+".You} {"+theDom+".youVerb('trigger')} {"+theDom+".yourHis} {"+theDom+".penisStrapon} кончает в [b]внутри {"+theSub+".you}[/b]!")
			return true
	return false
