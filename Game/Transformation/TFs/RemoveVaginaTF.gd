extends TFBase

var removedVag:bool = false

func _init():
	id = "RemoveVaginaTF"
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Удаляет пизду"

func getPillName() -> String:
	return "PussyBeGone"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Охх... У меня аж в паху ноет, когда я на это смотрю. Эта таблетка нацелена на ткани влагалища... чтобы избавиться от них... вместе со всей репродуктивной системой. «PussyBeGone» — подходящее название, пожалуй.",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат заставит твою киску исчезнуть, если она у тебя есть.\n\nТрансформация проходит всего в одну стадию и занимает примерно 20 минут. Ускорить процесс можно только с помощью препарата QuickShift."

func getTFCheckTags() -> Dictionary:
	return {
		"vagina": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 500.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasVagina()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	if(removedVag):
		return false
	if(getChar().hasVagina()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 60*20
	return 60*60*2
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(removedVag):
		return {}
	removedVag = true
	return {
		effects = [
			partEffect("newpart", BodypartSlot.Vagina, "SwitchPart", [""]),
		]
	}


func reactProgress(_context:Dictionary, _result:TFResult):
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["rv"] = removedVag
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	removedVag = SAVE.loadVar(_data, "rv", false)
