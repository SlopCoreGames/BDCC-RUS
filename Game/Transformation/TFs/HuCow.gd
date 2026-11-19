extends TFBase

var switchedbreasts:bool = false
var addedhorns:bool = false
var nipsStage:int = 0

func _init():
	id = "HuCow"
	
	pointsOnUnlock = 25

func getName() -> String:
	return "Трансформация в Человека-Корову"

func getPillName() -> String:
	return "MegaMilkMAX"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Wow.. This pill packs a lot.. Very interesting.. I think it will affect your breasts in some way.. but it will also do something else. I think I’ll call it.. 'MegaMilkMAX.' For no reason in particular.",
		tryOptions = [
			{
				name = "Заставить Элизу сожрать это",
				desc = "Спросить, хватит ли ей смелости попробовать собственный продукт. Вероятно, она станет очень молочной.",
				sceneID = "ElizaDrugTestHuCowScene",
			},
		],
	}

func getPillDatabaseDesc() -> String:
	return "This drug will turn you into a walking milky cow. It will achieve that by doing the following:\n- Increase the thickness of your body until it reaches 100%.\n- Morph your pecs into round breasts.\n- Gradually increase the size of your breasts until they become ‘M-cup’ or bigger. Moo.\n- Grow a set of horns if you don’t have any.\n- Increase the sensitivity of your nipples.\n- Cause you to lactate.\n\nThe first stage will happen after a few minutes. Stage 2 will happen after about 20 minutes. Stage 3 will happen after about 30 minutes. Next stages will happen roughly every 20 hours. This could be accelerated only by using the QuickShift drug or by stimulating the breasts.\n\nThis drug doesn’t have a set amount of stages. It will reach its final stage when there is nothing left to transform.\n\nBeing under the effects of this transformation will make others more likely to want to stimulate your breasts and have vaginal sex."

func getTFCheckTags() -> Dictionary:
	return {
		"breasts": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 10000.0,
	}

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.GropeBreasts):
		return 3.0
	if(_sexGoalID == SexGoal.BreastFeedOnSub):
		return 3.0
	if(_sexGoalID == SexGoal.MilkWithBreastPump):
		return 3.0
	if(_sexGoalID == SexGoal.FuckVaginal):
		return 3.0
	return 0.0

func isPossibleFor(_char) -> bool:
	#if(!_char.hasPenis() || _char.getPenisSize() < 10):
	#	return false
	if(getPossibleSteps(_char).empty()):
		return false
	return true

func start(_args:Dictionary):
	pass

func charHasMaleBreasts(theChar) -> bool:
	return theChar.bodypartHasTrait(BodypartSlot.Breasts, PartTrait.BreastsMale)

func getPossibleSteps(_char:BaseCharacter) -> Array:
	var result:Array = []
	
	var thick:int = _char.getThickness()
	
	if(thick < 100):
		result.append("thick")
	
	if(thick > 30):
		if(thick > 70 && charHasMaleBreasts(_char) && !switchedbreasts):
			result.append("switchbreasts")
		var goodBreastSize:int = BreastsSize.M
		var currentBreastSize:int = _char.getBreastsBaseSize()
		
		if(currentBreastSize < goodBreastSize):
			result.append("incbreasts")
	
	if(thick > 50 && !addedhorns && !_char.hasHorns()):
		result.append("addhorns")
	
	if(thick > 30 && nipsStage < 3):
		result.append("nipSen")
	
	return result

func canTransformFurther() -> bool:
	if(!getPossibleSteps(getChar()).empty()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 600
	if(_theStage == 1):
		return 1000
	if(_theStage == 2):
		return 2000
	return 60*60*20
	
func doProgress(_context:Dictionary) -> Dictionary:
	var allSteps:Array = getPossibleSteps(getChar())
	if(allSteps.empty()):
		return {}
	var nextStep:String = RNG.pick(allSteps)
	
	var theChar = getChar()
	
	if(nextStep == "thick"):
		return {
			step = nextStep,
			effects = [
				charEffect("thi", "AddThickness", [RNG.randi_range(7, 13)]),
			],
		}
	
	if(nextStep == "switchbreasts"):
		var nipStageInc:bool = false
		if(nipsStage < 3 && RNG.chance(100)):
			nipsStage += 1
			nipStageInc = true
			theChar.increaseBodypartSensitivity(BodypartSlot.Breasts, 0.2*nipsStage)
		switchedbreasts = true
		return {
			step = nextStep,
			nipStageInc = nipStageInc,
			effects = [
				charEffect("fem", "AddFemininity", [5]),
				partEffect("breasts", BodypartSlot.Breasts, "SwitchPart", ["humanbreasts"]),
			]
		}
	if(nextStep == "incbreasts"):
		var nipStageInc:bool = false
		if(nipsStage < 3 && RNG.chance(100)):
			nipsStage += 1
			nipStageInc = true
			theChar.increaseBodypartSensitivity(BodypartSlot.Breasts, 0.2*nipsStage)
		
		var breastSize:int = getChar().getBreastsBaseSize()
		
		var sizesToAdd:int = 1
		if(breastSize < BreastsSize.C):
			sizesToAdd = RNG.randi_range(2, 4)
		elif(breastSize < BreastsSize.K):
			sizesToAdd = RNG.randi_range(1, 3)
		
		return {
			step = nextStep,
			nipStageInc = nipStageInc,
			effects = [
				partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [sizesToAdd]),
			]
		}
	if(nextStep == "addhorns"):
		addedhorns = true
		
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Horns, theChar, [Species.Demon], NpcGender.Female, true)
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				partEffect("newpart", BodypartSlot.Horns, "SwitchPart", [newPartID]),
			]
		}

	if(nextStep == "nipSen"):
		nipsStage += 1
		theChar.increaseBodypartSensitivity(BodypartSlot.Breasts, 0.2*nipsStage)
		return {
			step = nextStep,
			nipStageInc = true,
			effects = [
			]
		}
	
	return {
	}

func reactProgressShort(_context:Dictionary, _result:TFResult):
	.reactProgressShort(_context, _result)
	
	if(_result.getField("nipStageInc", false)):
		addText("{npc.YourHis} соски теперь стали чувствительнее!")

func reactProgress(_context:Dictionary, _result:TFResult):
	var step:String = _result.getField("step", "")
	
	#var stage:int = getStage()
	
	if(isFirstTime()):
		addText("Внезапный прилив энергии пронзает ваше тело, заставляя вас задыхаться. Смятение и страх охватывают вас, когда вы осознаете, что с вашим телом происходит нечто помимо вашей воли.")
	
	addText(_result.getAllTFTexts())
	
	if(_result.getField("nipStageInc", false)):
		if(nipsStage == 1):
			addText(RNG.pick([
				"{npc.youHim} пробирает дрожь, когда теплая волна ощущений разливается по {npc.yourHis} груди. В {npc.yourHis} чувствительных сосках начинает нарастать восхитительное покалывание, заставляя их жаждать внимания и дразнящих прикосновений.",
			]))
		elif(nipsStage == 2):
			addText(RNG.pick([
				"{npc.youHim} пробирает дрожь, когда волнующее тепло окутывает {npc.yourHis} грудь. Она набухает, становясь всё больше и тяжелее, и буквально зудит от желания, чтобы её подоили. Внезапно {npc.yourHis} соски начинают лактировать, и теплые струйки {npc.milk} текут вниз, словно умоляя кого-нибудь воспользоваться этим новым, восхитительным изобилием. С {npc.yourHis} губ срывается мычание — первобытный звук наслаждения.",
			]))
		else:
			addText(RNG.pick([
				"{npc.youHim} пробирает дрожь, когда непреодолимая волна экстаза захлестывает {npc.yourHis} грудь. Теперь она невероятно чувствительна, практически умоляя о ласках и дойке. Сладкие, кремовые {npc.milk} текут рекой, а разум {npc.yourHis} наполняет желание замычать, полностью принимая похотливую, покорную натуру истинной Челокоровы!"
			]))

	if(isFirstTime()):
		addText("Что происходит с вашим телом...")
	else:
		if(getPossibleSteps(getChar()).empty()):
			addText("После всего этого {npc.youHim} накрывает внезапная волна осознания. {npc.YouHe} {npc.youAreHeIs} теперь идеальная Челококорова! {npc.YouHe} нужно лишь принять немного Морфина, чтобы закрепить эти изменения навсегда..")
	
	if(step in ["switchbreasts", "incbreasts", "nipSen"]):
		playAnim(StageScene.TFLook, "breasts", {bodyState={exposedChest=true}})
	elif(step in ["addhorns"]):
		playAnim(StageScene.TFLook, "head")
	else:
		playAnim(StageScene.TFLook, "hands")
		
func getBuffs() -> Array:
	var result:Array = []
	
	if(nipsStage >= 1):
		result.append_array([
			buff(Buff.SensitivityGainBuff, [BodypartSlot.Breasts, 20*nipsStage]),
			buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Breasts, 10*nipsStage*nipsStage]),
		])
	if(nipsStage >= 2):
		result.append_array([
			buff(Buff.BreastsForcedLactationBuff),
		])
	if(nipsStage >= 3):
		result.append_array([
			buff(Buff.FetishSpecificGainBuff, [Fetish.Lactation, 100.0]),
		])
			
	return result
	
func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.BreastFeeding, SexEvent.BreastsGroped, SexEvent.BreastsPumpMilked]):
		if(_event.getTargetChar() == _npc):
			accelerateTimer(0.4)
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["sb"] = switchedbreasts
	data["ah"] = addedhorns
	data["ns"] = nipsStage
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	switchedbreasts = SAVE.loadVar(_data, "sb", false)
	addedhorns = SAVE.loadVar(_data, "ah", false)
	nipsStage = SAVE.loadVar(_data, "ns", 0)
