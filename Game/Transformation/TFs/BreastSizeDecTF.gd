extends TFBase

var stages:int = 3

func _init():
	id = "BreastSizeDecTF"
	
	canStack = true
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Уменьшает размер груди"

func getPillName() -> String:
	return "Just-Ice"
	
func getUnlockData() -> Dictionary:
	return {
		eliza = "Интересно. Похоже, в составе смесь фитоэстрогенов и ферментов, активируемых холодом, которые воздействуют на жировую ткань в области груди. При приеме они должны вызвать локальное уменьшение жировых клеток. Эта таблетка, скорее всего, уменьшит твою грудь. Хм... Назову-ка я её... "+getPillName()+"... Думаю, это название ему отлично подойдет.",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат уменьшает размер груди. Он делает это по одному размеру за раз, пока грудь не станет плоской или пока не будет достигнута последняя стадия трансформации. Он [b]не[/b] превратит твою грудь в мужские грудные мышцы.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 30 часов. Процесс можно ускорить с помощью препарата QuickShift или путем стимуляции груди подопытной, когда её соски [b]чувствительны[/b].\n\nУ этого препарата будет от 3 до 5 стадий. С помощью продвинутого оборудования количество стадий можно увеличить до 10."

func getTFCheckTags() -> Dictionary:
	return {
		"breasts": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 250.0,
	}

func isPossibleFor(_char) -> bool:
	if(_char.getBreastsBaseSize() <= BreastsSize.FLAT):
		return false
	return true

func start(_args:Dictionary):
	if(_args.has("stages")):
		stages = _args["stages"]
	else:
		stages = RNG.randi_range(3, 5)

func getPillOptions() -> Dictionary:
	return {
		"stages": {
			name = "Стадии",
			desc = "Сколько раз нужно уменьшить грудь?",
			value = 3,
			values = [
				[1, "1"],
				[2, "2"],
				[3, "3"],
				[4, "4"],
				[5, "5"],
				[6, "6"],
				[7, "7"],
				[8, "8"],
				[9, "9"],
				[10, "10"],
			],
		},
	}

func canTransformFurther() -> bool:
	if(getChar().getBreastsBaseSize() <= BreastsSize.FLAT):
		return false
	return .canTransformFurther()
	
func getMaxStage() -> int:
	return stages
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*60*30
	
func doProgress(_context:Dictionary) -> Dictionary:
	return {
		effects = [
			partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [-1]),
		]
	}

func reactProgress(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "breasts", {bodyState={exposedChest=true}})
	
func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.BreastsGroped, SexEvent.BreastFeeding, SexEvent.BreastsPumpMilked]):
		if(_event.getTargetChar() == _npc):
			if(_npc.hasSoreNipples()):
				accelerateTimer(0.4)
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["st"] = stages
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	stages = SAVE.loadVar(_data, "st", 3)
