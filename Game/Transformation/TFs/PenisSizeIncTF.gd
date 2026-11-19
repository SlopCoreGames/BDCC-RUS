extends TFBase

var target:float = 0.0
var hasTarget:bool = false

func _init():
	id = "PenisSizeIncTF"
	
	canStack = true
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Увеличивает длину пениса"

func getPillName() -> String:
	return "SuperShaft"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Поразительно! Похоже, эта таблетка содержит смесь факторов роста и вазодилататоров, которые могут способствовать удлинению пениса. При приеме она, вероятно, приведет к заметному увеличению размера. Думаю, я назову её... «Супер-Шланг». Если хочешь моего совета... огромный член — это, конечно, здорово... но в какой-то момент он начинает скорее приносить боль, чем удовольствие.",
	}
	
func getPillDatabaseDesc() -> String:
	return "Этот препарат увеличит длину твоего пениса. Это происходит постепенно, пока не будет достигнуто максимальное количество стадий.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 5 часов. Этот процесс можно ускорить с помощью препарата QuickShift или заставив подопытного [b]оргазмировать[/b].\n\nПо умолчанию этот препарат имеет максимум 3 стадии. С помощью продвинутого лабораторного оборудования можно изменить этот алгоритм и задать целевую длину пениса. В таком случае количество стадий не будет фиксированным, и препарат будет увеличивать длину, пока не будет достигнут нужный результат."

func getTFCheckTags() -> Dictionary:
	return {
		"penis": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 1200.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasPenis()):
		return false
	if(hasTarget):
		return _char.getPenisSize() < target
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
			desc = "Какой должна быть итоговая длина пениса (этот препарат увеличивает только длину).",
			value = 18.0,
			values = lenArray,
		},
	}

func canTransformFurther() -> bool:
	if(!getChar().hasPenis()):
		return false
	if(hasTarget):
		return getChar().getPenisSize() < target
	return .canTransformFurther()
	
func getMaxStage() -> int:
	return 3
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 300
	return 60*60*5
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(hasTarget):
		var currentSize:float = getChar().getPenisSize()
		var delta:float = target - currentSize
		if(delta > 4.0):
			delta = 4.0
		if(delta < 0):
			delta = 0
		return {
			effects = [
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [delta])
			]
		}
	return {
		effects = [
			partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [RNG.randi_range(2, 4)])
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
