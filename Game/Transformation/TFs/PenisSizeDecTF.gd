extends TFBase

var target:float = 0.0
var hasTarget:bool = false

func _init():
	id = "PenisSizeDecTF"
	
	canStack = true
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Уменьшает длину пениса"

func getPillName() -> String:
	return "ShrinkRay"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Пикантно! Похоже, эта таблетка создана на основе смеси гормональных ингибиторов и агентов, уменьшающих ткани, которые воздействуют именно на размер пениса. При приеме она, скорее всего, приведет к уменьшению длины. Думаю, назову её... «ShrinkRay» (Лучик сжатия). Потому что она... сжимает твой «луч»... понимаешь?",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат уменьшит длину твоего пениса. Это происходит постепенно, пока не будет достигнуто максимальное количество стадий или пока длина пениса не станет 9 см или меньше.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 5 часов. Процесс можно ускорить с помощью препарата QuickShift или заставив подопытного [b]кончить[/b].\n\nПо умолчанию этот препарат имеет максимум 5 стадий. С помощью продвинутого лабораторного оборудования можно изменить этот алгоритм и задать целевую длину пениса. В таком случае количество стадий станет переменным, и пенис будет уменьшаться до тех пор, пока не достигнет заданной длины."

func getTFCheckTags() -> Dictionary:
	return {
		"penis": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 300.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasPenis()):
		return false
	if(hasTarget):
		return _char.getPenisSize() > target
	if(_char.getPenisSize() <= 9):
		return false
	return true

func start(_args:Dictionary):
	if(_args.has("target")):
		hasTarget = true
		target = _args["target"]

func getPillOptions() -> Dictionary:
	var lengths:Array = [5.0, 8.0, 10.0, 12.0, 15.0, 18.0, 20.0, 22.0, 25.0, 28.0, 30.0]
	var lenArray:Array = []
	for theLen in lengths:
		lenArray.append([theLen, str(theLen)+"cm"])
	return {
		"target": {
			name = "Цель",
			desc = "Какова должна быть итоговая длина пениса (этот препарат может только уменьшать длину).",
			value = 10.0,
			values = lenArray,
		},
	}

func canTransformFurther() -> bool:
	if(hasTarget):
		return getChar().getPenisSize() > target
	if(!getChar().hasPenis() || getChar().getPenisSize() <= 9):
		return false
	return .canTransformFurther()
	
func getMaxStage() -> int:
	return 5
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 300
	return 60*60*5
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(hasTarget):
		var currentSize:float = getChar().getPenisSize()
		var delta:float = target - currentSize
		if(delta < -4.0):
			delta = -4.0
		if(delta > 0):
			delta = 0
		return {
			effects = [
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [delta])
			]
		}
	return {
		effects = [
			partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [-RNG.randi_range(2, 4)])
		]
	}

func reactProgress(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})

func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.Orgasmed]):
		if(_event.getTargetChar() == _npc):
			accelerateTimer(1.0)

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["ht"] = hasTarget
	data["tt"] = target
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	hasTarget = SAVE.loadVar(_data, "ht", false)
	target = SAVE.loadVar(_data, "tt", 18.0)
