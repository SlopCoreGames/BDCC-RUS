extends TFBase

var addedVag:bool = false
var removedPenis:bool = false
var switchedbreasts:bool = false
var switchedhair:bool = false

func _init():
	id = "Feminization"
	
	pointsOnUnlock = 15

func getName() -> String:
	return "Феминизация"

func getPillName() -> String:
	return "EstroGPlus"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интригующе! Похоже, эта таблетка содержит смесь фитоэстрогенов и блокаторов андрогенов, которые могут способствовать феминизации за счет изменения гормонального баланса. При приеме она, скорее всего, запустит процесс трансформации первичных и вторичных половых признаков в женские. Думаю, я назову её... «ЭстроГПлюс». Звучит неплохо, не находишь?",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат превратит тебя в девчонку. Он действует следующим образом:\n- Повышает твою общую женственность.\n- Меняет форму твоей груди, превращая грудные мышцы в более округлые женские молочные железы.\n- Увеличивает размер груди. Итоговый размер зависит от твоей полноты.\n- Постепенно уменьшает размер твоего пениса, а затем полностью его растворяет.\n- Выращивает вагину, если её еще нет.\n- Меняет твою прическу на более женственную.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 10 часов. Этот процесс можно ускорить с помощью препарата QuickShift или если подопытный испытает [b]оргазм[/b].\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет уже нечего. С помощью продвинутого лабораторного оборудования можно отключить некоторые эффекты этого препарата."

func getTFCheckTags() -> Dictionary:
	return {
		"gender": true,
		"breasts": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Cum": 1000.0,
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
	if(_args.has("addVag")):
		addedVag = !_args["addVag"]
	if(_args.has("removePenis")):
		removedPenis = !_args["removePenis"]
	if(_args.has("switchBreasts")):
		switchedbreasts = !_args["switchBreasts"]
	if(_args.has("switchHair")):
		switchedhair = !_args["switchHair"]

func getPillOptions() -> Dictionary:
	return {
		"addVag": {
			name = "Рост киски",
			desc = "Должен ли препарат вырастить полноценную вагину",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"removePenis": {
			name = "Удаление пениса",
			desc = "Должен ли препарат удалить пенис",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"switchBreasts": {
			name = "Женская грудь",
			desc = "Должен ли препарат превратить мужские грудные мышцы в женскую грудь",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"switchHair": {
			name = "Смена прически",
			desc = "Должен ли препарат вырастить женские волосы (только если они еще не женские)",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
	}

func charHasMaleBreasts(theChar) -> bool:
	return theChar.bodypartHasTrait(BodypartSlot.Breasts, PartTrait.BreastsMale)

func getPossibleSteps(_char:BaseCharacter) -> Array:
	var result:Array = []
	
	if(_char.getFemininity() > 70 && _char.getGender() != Gender.Female):
		result.append("gender")
		
	if(_char.getFemininity() > 10):
		if(_char.hasPenis() && !removedPenis):
			var penisLen = _char.getPenisSize()
			
			if(penisLen > 8):
				result.append("shrinkpenis")
	
	if(_char.getFemininity() > 40):
		if(charHasMaleBreasts(_char) && !switchedbreasts):
			result.append("switchbreasts")
		var goodBreastSize:int = BreastsSize.B
		if(_char.getThickness() >= 50):
			goodBreastSize = BreastsSize.C
		if(_char.getThickness() >= 80):
			goodBreastSize = BreastsSize.D
		var currentBreastSize:int = _char.getBreastsBaseSize()
		
		if(currentBreastSize < goodBreastSize):
			result.append("incbreasts")
	
	if(!switchedhair && _char.getFemininity() > 50):
		var hairPart:Bodypart = _char.getBodypart(BodypartSlot.Hair)
		if(hairPart != null && hairPart.femaleWeight < 0.6):
			result.append("switchhair")
	
	if(_char.getFemininity() > 60):
		if(_char.hasPenis() && !removedPenis):
			var penisLen = _char.getPenisSize()
			if(!addedVag && penisLen <= 8):
				if(_char.hasVagina()):
					result.append("rempenis")
				else:
					result.append("penistovag")
		elif(!_char.hasVagina() && !addedVag):
			result.append("growvag")
	
	if(result.empty() && _char.getFemininity() < 100):
		if(_char.getFemininity() < 45):
			result.append("femincmale")
		else:
			result.append("feminc")
	
	return result

func canTransformFurther() -> bool:
	if(!getPossibleSteps(getChar()).empty()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*60*10
	
func doProgress(_context:Dictionary) -> Dictionary:
	var allSteps:Array = getPossibleSteps(getChar())
	if(allSteps.empty()):
		return {}
	var nextStep:String = RNG.pick(allSteps)
	
	if(nextStep == "feminc"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [10]),
			]
		}
	
	if(nextStep == "femincmale"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [RNG.randi_range(15, 25)]),
			]
		}
		
	if(nextStep == "gender"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [5]),
				charEffect("gender", "GenderChange", [Gender.Female]),
			]
		}
	if(nextStep == "switchbreasts"):
		switchedbreasts = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [5]),
				partEffect("breasts", BodypartSlot.Breasts, "SwitchPart", ["humanbreasts"]),
			]
		}
	if(nextStep == "incbreasts"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [5]),
				partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [1]),
			]
		}
	if(nextStep == "switchhair"):
		switchedhair = true
		
		var theChar = getChar()
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Hair, theChar, theChar.getSpecies(), NpcGender.Female, true)
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [5]),
				partEffect("newpart", BodypartSlot.Hair, "SwitchPart", [newPartID]),
			]
		}
	if(nextStep == "shrinkpenis"):
		var currentPenLen = getChar().getPenisSize()
		var mod:float = 1.0
		if(currentPenLen >= 20):
			mod = 2.0
		if(currentPenLen >= 30):
			mod = 3.0
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [10]),
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [-RNG.randi_range(2,4)*mod]),
			]
		}
	if(nextStep == "rempenis"):
		addedVag = true
		removedPenis = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [10]),
				partEffect("rempenis", BodypartSlot.Penis, "SwitchPart", [""]),
			]
		}
	if(nextStep == "penistovag"):
		removedPenis = true
		addedVag = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [10]),
				partEffect("rempenis", BodypartSlot.Penis, "SwitchPart", [""]),
				partEffect("addvag", BodypartSlot.Vagina, "SwitchPart", ["vagina"]),
			]
		}
	if(nextStep == "growvag"):
		removedPenis = true
		addedVag = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [10]),
				partEffect("addvag", BodypartSlot.Vagina, "SwitchPart", ["vagina"]),
			]
		}
	
	return {
	}


func reactProgress(_context:Dictionary, _result:TFResult):
	var step:String = _result.getField("step", "")
	
	#var stage:int = getStage()
	
	if(isFirstTime()):
		addText("Внезапный прилив энергии пронзает ваше тело, заставляя вас задыхаться. Смятение и страх охватывают вас, когда вы осознаете, что с вашим телом происходит нечто помимо вашей воли.")
	
	addText(_result.getAllTFTexts())
	
	if(isFirstTime()):
		addText("Что происходит с вашим телом...")
	
	
	if(step in ["gender", "femincmale", "feminc"]):
		playAnim(StageScene.TFLook, "hands")
	elif(step in ["shrinkpenis", "rempenis", "penistovag", "growvag"]):
		playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})
	elif(step in ["switchbreasts", "incbreasts"]):
		playAnim(StageScene.TFLook, "breasts", {bodyState={exposedChest=true}})
	elif(step in ["switchhair"]):
		playAnim(StageScene.TFLook, "head")
	else:
		playAnim(StageScene.TFLook, "hands")
	
func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.Orgasmed]):
		if(_event.getTargetChar() == _npc):
			accelerateTimer(1.0)
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["av"] = addedVag
	data["rp"] = removedPenis
	data["sb"] = switchedbreasts
	data["sh"] = switchedhair
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	addedVag = SAVE.loadVar(_data, "av", false)
	removedPenis = SAVE.loadVar(_data, "rp", false)
	switchedbreasts = SAVE.loadVar(_data, "sb", false)
	switchedhair = SAVE.loadVar(_data, "sh", false)
