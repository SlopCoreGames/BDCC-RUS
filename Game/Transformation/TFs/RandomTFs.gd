extends TFBase

var lastStep:String = ""
var howOftenTime:int = -1

func _init():
	id = "RandomTFs"
	
	pointsOnUnlock = 50

func getName() -> String:
	return "???"

func getPillName() -> String:
	return "Нестабильный мутаген"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интерес-.. погодите.. Что это за чертовщина? Ого. Ого! Оно меняется! Прямо на глазах.. молекулярная структура этого препарата меняется прямо сейчас. Честно, я без понятия, безопасно ли это вообще принимать.. последствия могут быть любыми. В этот момент это уже даже не лекарство, а просто концентрированная доза «Нестабильного мутагена».",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат вызовет случайный эффект. Список возможных эффектов:\n- Случайные волосы.\n- Случайная трансформация части тела в другую часть тела.\n- Увеличение или уменьшение размера груди.\n- Увеличение или уменьшение длины пениса.\n- Увеличение или уменьшение женственности.\n- Увеличение или уменьшение объемов тела.\n- Случайные цвета и кожа.\n\nПервая стадия наступит примерно через 15 минут. После этого последующие будут происходить примерно каждые 25 часов. Процесс можно ускорить, используя препарат QuickShift.\n\nУ этого препарата нет фиксированного количества стадий. Он будет постепенно менять ваше тело вечно, и остановить процесс можно только препаратами MorphIn или MorphOut. С помощью продвинутого лабораторного оборудования можно изменять частоту мутаций."

func getTFCheckTags() -> Dictionary:
	return {
		"gender": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Cum": 2000.0,
		"Milk": 5000.0,
		"WhiteGoo": 50.0,
	}

#func getSexGoalWeightModifier(_sexGoalID:String) -> float:
#	if(_sexGoalID == SexGoal.FuckAnal):
#		return 100000.0
#	if(_sexGoalID == SexGoal.StraponAnal):
#		return 100000.0
#	return 0.0

func isPossibleFor(_char) -> bool:
	if(getPossibleSteps(_char).empty()):
		return false
	return true

func start(_args:Dictionary):
	if(_args.has("howOftenTime")):
		howOftenTime = _args["howOftenTime"]

func getPillOptions() -> Dictionary:
	return {
		"howOftenTime": {
			name = "Частота",
			desc = "Как часто должны происходить изменения",
			value = 60*60*25,
			values = [
				[60*10, "10 minutes"],
				[60*30, "30 minutes"],
				[60*60, "1 hour"],
				[60*60*2, "2 hours"],
				[60*60*6, "6 hours"],
				[60*60*12, "12 hours"],
				[60*60*25, "25 hours"],
				[60*60*50, "50 hours"],
				[60*60*100, "100 hours"],
			],
		},
	}

func getPossibleSteps(_char:BaseCharacter) -> Array:
	var result:Array = [
		"hair",
		"bodypart",
		"bodypart",
		"breastsize",
		"thick",
		"fem",
		"skin",
	]
	if(_char.hasPenis()):
		result.append("penlen")
	
	if(result.has(lastStep)):
		result.erase(lastStep)
	
	return result

func canTransformFurther() -> bool:
	if(!getPossibleSteps(getChar()).empty()):
		return true
	return false
	
func canBeTested() -> bool:
	return stage >= 5
	
func getTimerForStage(_theStage:int) -> int:
	if(howOftenTime > 0):
		return howOftenTime
	if(_theStage == 0):
		return 900
	return 60*60*25
	
func doProgress(_context:Dictionary) -> Dictionary:
	var allSteps:Array = getPossibleSteps(getChar())
	if(allSteps.empty()):
		return {}
	var nextStep:String = RNG.pick(allSteps)
	lastStep = nextStep
	
	if(nextStep == "fem"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [RNG.randi_range(10, 20) if RNG.chance(50) else -RNG.randi_range(10, 20)]),
			]
		}
	if(nextStep == "thick"):
		return {
			step = nextStep,
			effects = [
				charEffect("thi", "AddThickness", [RNG.randi_range(7, 20) if RNG.chance(50) && getChar().getThickness() < 130 else -RNG.randi_range(7, 20)]),
			]
		}
	if(nextStep == "hair"):
		var theChar = getChar()
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Hair, theChar, theChar.getSpecies(), theChar.calculateNpcGender(), true)
		if(theChar.hasBodypart(BodypartSlot.Hair)):
			var currentPart:String = theChar.getBodypart(BodypartSlot.Hair).id
			if(possiblePartIDs.has(currentPart)):
				possiblePartIDs.erase(currentPart)
		if(possiblePartIDs.empty()):
			return {}

		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				partEffect("newpart", BodypartSlot.Hair, "SwitchPart", [newPartID]),
			]
		}
		
	if(nextStep == "bodypart"):
		var theChar = getChar()
		var bodypartSlots:Array = BodypartSlot.getAll()
		bodypartSlots.erase(BodypartSlot.Body)
		
		var slot = RNG.pick(bodypartSlots)
		var possiblePartIDs:Array = GlobalRegistry.getBodypartsIdsBySlotForTF(slot)#Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Penis, theChar, theChar.getSpecies(), NpcGender.Male)
		if(possiblePartIDs.has("")):
			possiblePartIDs.erase("")
		if(slot in [BodypartSlot.Penis, BodypartSlot.Vagina, BodypartSlot.Horns, BodypartSlot.Tail]):
			if(theChar.hasBodypart(slot)):
				possiblePartIDs.append("")
		if(theChar.hasBodypart(slot)):
			var currPenis:String = theChar.getBodypart(slot).id
			if(possiblePartIDs.has(currPenis)):
				possiblePartIDs.erase(currPenis)
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pick(possiblePartIDs)
		
		return {
			step = nextStep,
			bodypartSlot = slot,
			effects = [
				partEffect("newpart", slot, "SwitchPart", [newPartID]),
				charEffect("speciescalc", "SpeciesCalculate", []),
			]
		}
	if(nextStep == "breastsize"):
		var canDecrease:bool = getChar().hasNonFlatBreasts()
		return {
			step = nextStep,
			effects = [
				partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [RNG.randi_range(1, 3) if (RNG.chance(50) || !canDecrease) else -RNG.randi_range(1, 3)]),
			]
		}
	if(nextStep == "penlen"):
		var canDecrease:bool = getChar().getPenisSize() > 10
		return {
			step = nextStep,
			effects = [
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [RNG.randi_range(1, 4) if (RNG.chance(50) || !canDecrease) else -RNG.randi_range(1, 4)]),
			]
		}
	if(nextStep == "skin"):
		var theChar = getChar()
		var pickedColors = TFUtil.getRandomColorsForSpecies(theChar.getSpecies())
		var pickedSkin = TFUtil.getRandomSkinForSpecies(theChar.getSpecies())
		return {
			step = nextStep,
			effects = [
				charEffect("skin", "SkinSet", [pickedSkin, pickedColors]),
			]
		}
	
	return {
	}

func reactProgressShort(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts(" ", false))
	var step:String = _result.getField("step", "")
	if(step == "skin"):
		addText("Цвета {npc.YourHis} начинают стремительно меняться... из-за чего {npc.youHim} выглядит совсем иначе.")
	
func reactProgress(_context:Dictionary, _result:TFResult):
	var step:String = _result.getField("step", "")
	
	#var stage:int = getStage()
	
	if(isFirstTime()):
		addText("Внезапный прилив энергии пронзает ваше тело, заставляя вас задыхаться. Смятение и страх охватывают вас, когда вы осознаете, что с вашим телом происходит нечто помимо вашей воли.")
	
	addText(_result.getAllTFTexts())
	if(step == "skin"):
		addText("Цвета {npc.YourHis} начинают стремительно меняться... из-за чего {npc.youHim} выглядит совсем иначе.")
	
	if(isFirstTime()):
		addText("Что происходит с вашим телом...")
	elif(getStage() % 5 == 0):
		addText("У этих трансформаций нет никакой закономерности... они кажутся совершенно случайными...")
	
	if(step in ["hair"]):
		playAnim(StageScene.TFLook, "head")
	elif(step in ["breastsize"]):
		playAnim(StageScene.TFLook, "breasts", {bodyState={exposedChest=true}})
	elif(step in ["bodypart"]):
		var bodypartSlot:String = _result.getField("bodypartSlot", "")
		if(bodypartSlot in [BodypartSlot.Head, BodypartSlot.Hair, BodypartSlot.Ears, BodypartSlot.Horns]):
			playAnim(StageScene.TFLook, "head")
		elif(bodypartSlot in [BodypartSlot.Vagina, BodypartSlot.Penis, BodypartSlot.Tail]):
			playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})
		elif(bodypartSlot in [BodypartSlot.Anus, BodypartSlot.Legs]):
			playAnim(StageScene.GivingBirth, "birth", {bodyState={exposedCrotch=true, hard=true}})
		elif(bodypartSlot in [BodypartSlot.Breasts]):
			playAnim(StageScene.TFLook, "breasts", {bodyState={exposedChest=true}})
		else:
			playAnim(StageScene.TFLook, "hands")
	elif(step in ["skin"]):
		playAnim(StageScene.TFLook, "hands", {bodyState={naked=true}})
	else:
		playAnim(StageScene.TFLook, "hands")
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["ls"] = lastStep
	data["hot"] = howOftenTime
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	lastStep = SAVE.loadVar(_data, "ls", "")
	howOftenTime = SAVE.loadVar(_data, "hot", -1)
