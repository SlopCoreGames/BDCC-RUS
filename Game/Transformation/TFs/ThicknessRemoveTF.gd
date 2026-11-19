extends TFBase

var target:int = 0
var hasTarget:bool = false

func _init():
	id = "ThicknessRemoveTF"
	
	canStack = true
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Делает тебя стройнее"

func getPillName() -> String:
	return "SliMM"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Похоже, в состав этой таблетки входят подавители аппетита и жиросжигающие компоненты, которые помогут тебе сбросить лишние килограммы... Она напоминает какой-нибудь дешевый товар из фальшивой рекламы... но эта, кажется, реально работает, а? Если ее принять, ты наверняка похудеешь... так что я очень хочу назвать ее... «SliMM».",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат будет постепенно уменьшать объем твоего тела. Процесс идет, пока твоя толщина выше 0% or, вплоть до достижения последней стадии.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 12 часов. Процесс можно ускорить с помощью препарата QuickShift или если [b]шлепнуть[/b] подопытную.\n\nЭтот препарат ограничен 3 стадиями. Однако это ограничение можно обойти с помощью продвинутого лабораторного оборудования, выбрав конкретное целевое значение толщины."

func getTFCheckTags() -> Dictionary:
	return {
		"thickness": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 300.0,
	}

func isPossibleFor(_char) -> bool:
	if(_char.getThickness() <= 0):
		return false
	if(hasTarget):
		return _char.getThickness() > target
	return true

func start(_args:Dictionary):
	if(_args.has("target")):
		hasTarget = true
		target = _args["target"]

func getPillOptions() -> Dictionary:
	var possibleVals:Array = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150]
	var posVals:Array = []
	for theVal in possibleVals:
		posVals.append([theVal, str(theVal)+"%"])
	return {
		"target": {
			name = "Цель",
			desc = "Каким должен быть итоговый объем (этот препарат может только уменьшать толщину).",
			value = 50,
			values = posVals,
		},
	}

func canTransformFurther() -> bool:
	if(getChar().getThickness() <= 0):
		return false
	if(hasTarget):
		return getChar().getThickness() > target
	return .canTransformFurther()
	
func getMaxStage() -> int:
	return 3
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 300
	return 60*60*12
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(hasTarget):
		var currentThickness:int = getChar().getThickness()
		var delta:int = target - currentThickness
		if(delta < -13):
			delta = -13
		if(delta > 0):
			delta = 0
		return {
			effects = [
				charEffect("thi", "AddThickness", [delta]),
			]
		}
	
	return {
		effects = [
			charEffect("thi", "AddThickness", [-RNG.randi_range(7, 13)]),
		]
	}

func reactProgress(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "hands")
	
func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.Spanked]):
		if(_event.getTargetChar() == _npc):
			accelerateTimer(0.4)
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["ht"] = hasTarget
	data["tt"] = target
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	hasTarget = SAVE.loadVar(_data, "ht", false)
	target = SAVE.loadVar(_data, "tt", 50)
