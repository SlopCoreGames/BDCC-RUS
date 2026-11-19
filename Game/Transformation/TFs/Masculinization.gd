extends TFBase

var removedVag:bool = false
var addedPenis:bool = false
var switchedbreasts:bool = false
var switchedhair:bool = false

func _init():
	id = "Masculinization"
	
	pointsOnUnlock = 15

func getName() -> String:
	return "Мускулинизация"

func getPillName() -> String:
	return "TestosteGo"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интересно! Похоже, эта таблетка содержит мощную смесь бустеров тестостерона и андрогенных соединений, которые могут стимулировать маскулинизацию. При приеме она, вероятно, запустит процесс превращения женских черт в мужские... абсолютно всех черт. Думаю, назову её... «ТестостеГо». Да... она даст тебе яйца~.",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат превратит тебя в парня. Это произойдет благодаря следующему:\n- Повышению общего уровня маскулинности.\n- Изменению формы груди: округлые женские молочные железы превратятся в более мужественные грудные мышцы.\n- Постепенному уменьшению размера груди, пока она не станет полностью плоской.\n- Трансформации и исчезновению вагины, если она у тебя есть.\n- Росту пениса, длина которого будет постепенно увеличиваться, пока не достигнет как минимум 15 см.\n- Изменению прически на более мужскую.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 10 часов. Процесс можно ускорить с помощью препарата QuickShift или если подопытный испытает [b]оргазм[/b].\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет больше нечего. С помощью продвинутого лабораторного оборудования можно отключить некоторые эффекты этого препарата."

func getTFCheckTags() -> Dictionary:
	return {
		"gender": true,
		"breasts": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 2500.0,
	}

func isPossibleFor(_char) -> bool:
	if(getPossibleSteps(_char).empty()):
		return false
	return true

func start(_args:Dictionary):
	if(_args.has("addPenis")):
		addedPenis = !_args["addPenis"]
	if(_args.has("removeVag")):
		removedVag = !_args["removeVag"]
	if(_args.has("switchBreasts")):
		switchedbreasts = !_args["switchBreasts"]
	if(_args.has("switchHair")):
		switchedhair = !_args["switchHair"]

func getPillOptions() -> Dictionary:
	return {
		"addPenis": {
			name = "Рост пениса",
			desc = "Должен ли препарат вырастить полноценный пенис",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"removeVag": {
			name = "Удаление пизды",
			desc = "Должен ли препарат удалить влагалище",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"switchBreasts": {
			name = "Мужские груди",
			desc = "Должен ли препарат превратить женскую грудь в мужские грудные мышцы",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
		"switchHair": {
			name = "Смена прически",
			desc = "Должен ли препарат вырастить мужские волосы (только если персонаж еще не мужчина)",
			value = true,
			values = [[true, "Yes"], [false, "No"]],
		},
	}

func charHasMaleBreasts(theChar) -> bool:
	return theChar.bodypartHasTrait(BodypartSlot.Breasts, PartTrait.BreastsMale)

func charHasFemaleBreasts(theChar) -> bool:
	return !theChar.bodypartHasTrait(BodypartSlot.Breasts, PartTrait.BreastsMale)

func getPossibleSteps(_char:BaseCharacter) -> Array:
	var result:Array = []
	
	if(_char.getFemininity() < 30 && _char.getGender() != Gender.Male):
		result.append("gender")
		
	if(_char.getFemininity() < 90):
		if(_char.hasPenis() && addedPenis):
			var penisLen = _char.getPenisSize()
			
			if(penisLen < 15):
				result.append("extendpenis")
	
	if(_char.getFemininity() < 60):
		if(charHasFemaleBreasts(_char) && !switchedbreasts):
			result.append("switchbreasts")

		var currentBreastSize:int = _char.getBreastsBaseSize()
		
		if(currentBreastSize > BreastsSize.FLAT):
			result.append("decbreasts")
	
	if(!switchedhair && _char.getFemininity() < 50):
		var hairPart:Bodypart = _char.getBodypart(BodypartSlot.Hair)
		if(hairPart != null && hairPart.maleWeight < 0.6):
			result.append("switchhair")
	
	if(_char.getFemininity() < 40):
		if(_char.hasVagina() && !removedVag):
			if(!addedPenis):
				if(_char.hasPenis()):
					result.append("remvagina")
				else:
					result.append("vagtopenis")
		elif(!_char.hasPenis() && !addedPenis):
			result.append("growpenis")
	
	if(result.empty() && _char.getFemininity() > 0):
		if(_char.getFemininity() > 55):
			result.append("femdecfemale")
		else:
			result.append("femdec")
	
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
	
	if(nextStep == "femdec"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-10]),
			]
		}
	
	if(nextStep == "femdecfemale"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-RNG.randi_range(15, 25)]),
			]
		}
		
	if(nextStep == "gender"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-5]),
				charEffect("gender", "GenderChange", [Gender.Male]),
			]
		}
	if(nextStep == "switchbreasts"):
		switchedbreasts = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-5]),
				partEffect("breasts", BodypartSlot.Breasts, "SwitchPart", ["malebreasts"]),
			]
		}
	if(nextStep == "decbreasts"):
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-5]),
				partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [-1]),
			]
		}
	if(nextStep == "switchhair"):
		switchedhair = true
		
		var theChar = getChar()
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Hair, theChar, theChar.getSpecies(), NpcGender.Male, true)
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-5]),
				partEffect("newpart", BodypartSlot.Hair, "SwitchPart", [newPartID]),
			]
		}
	if(nextStep == "extendpenis"):
#		var currentPenLen = getChar().getPenisSize()
#		var mod:float = 1.0
#		if(currentPenLen >= 20):
#			mod = 2.0
#		if(currentPenLen >= 30):
#			mod = 3.0
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-10]),
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [RNG.randi_range(3,5)]),
			]
		}
	if(nextStep == "remvagina"):
		addedPenis = true
		removedVag = true
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-10]),
				partEffect("remvag", BodypartSlot.Vagina, "SwitchPart", [""]),
			]
		}
	if(nextStep == "vagtopenis"):
		addedPenis = true
		removedVag = true
		
		var theChar = getChar()
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Penis, theChar, theChar.getSpecies(), NpcGender.Male, true)
		if(possiblePartIDs.has("")):
			possiblePartIDs.erase("")
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-10]),
				partEffect("remvag", BodypartSlot.Vagina, "SwitchPart", [""]),
				partEffect("addpenis", BodypartSlot.Penis, "SwitchPart", [newPartID]),
			]
		}
	if(nextStep == "growpenis"):
		addedPenis = true
		removedVag = true
		
		var theChar = getChar()
		var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Penis, theChar, theChar.getSpecies(), NpcGender.Male, true)
		if(possiblePartIDs.has("")):
			possiblePartIDs.erase("")
		if(possiblePartIDs.empty()):
			return {}
		var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
		return {
			step = nextStep,
			effects = [
				charEffect("fem", "AddFemininity", [-10]),
				partEffect("addpenis", BodypartSlot.Penis, "SwitchPart", [newPartID]),
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
	
	
	if(step in ["extendpenis", "remvagina", "vagtopenis", "growpenis"]):
		playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})
	elif(step in ["switchbreasts", "decbreasts"]):
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
	
	data["rv"] = removedVag
	data["ap"] = addedPenis
	data["sb"] = switchedbreasts
	data["sh"] = switchedhair
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	removedVag = SAVE.loadVar(_data, "rv", false)
	addedPenis = SAVE.loadVar(_data, "ap", false)
	switchedbreasts = SAVE.loadVar(_data, "sb", false)
	switchedhair = SAVE.loadVar(_data, "sh", false)
