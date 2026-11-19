extends TFBase

var removedHorns:bool = false

func _init():
	id = "RemoveHornsTF"
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Убирает рога"

func getPillName() -> String:
	return "HornsBeGone"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Похоже, эта таблетка содержит смесь соединений, регулирующих ткани, и ингибиторов роста, которые могут нарушить развитие рогов. При приеме она, вероятно, способствует их удалению... если они у тебя вообще есть. Думаю, назову её... «РогаПрочь».",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат избавит тебя от рогов, если они у тебя есть.\n\nТрансформация проходит всего в одну стадию и занимает примерно 20 минут. Ускорить процесс можно только с помощью препарата QuickShift."

func getTFCheckTags() -> Dictionary:
	return {
		"horns": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 250.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasHorns()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	if(removedHorns):
		return false
	if(getChar().hasHorns()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 60*20
	return 60*60*2
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(removedHorns):
		return {}
	removedHorns = true
	return {
		effects = [
			partEffect("newpart", BodypartSlot.Horns, "SwitchPart", [""]),
		]
	}


func reactProgress(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "head")
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["rh"] = removedHorns
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	removedHorns = SAVE.loadVar(_data, "rh", false)
