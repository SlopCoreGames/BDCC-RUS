extends TFBase

var removedPenis:bool = false

func _init():
	id = "RemovePenisTF"
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Удаляет пенис"

func getPillName() -> String:
	return "CockBeGone"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Ох, эта таблетка — настоящий облом. В ней содержатся гормональные блокаторы и агенты, регулирующие ткани, которые могут воздействовать на пенисную ткань. О да, она, если честно, полностью уничтожит всю пенисную ткань. У такой таблетки есть только одно название: «CockBeGone».",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат заставит твой член трансформироваться и исчезнуть, если он у тебя есть. Это происходит путем постепенного уменьшения длины, пока член не станет достаточно маленьким (менее 8 см), чтобы полностью трансформироваться в ничто.\n\nПервая стадия наступит через несколько минут. После этого следующие будут происходить примерно каждые 5 часов. Процесс можно ускорить с помощью препарата QuickShift или заставив подопытного испытуемого [b]достичь оргазма[/b].\n\nУ этого препарата нет фиксированного количества стадий. Он будет продолжать уменьшать член до тех пор, пока тот не исчезнет окончательно."

func getTFCheckTags() -> Dictionary:
	return {
		"penis": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 500.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasPenis()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	#if(getStage() == 0 && !getChar().hasPenis()):
	#	return true
	if(removedPenis):
		return false
	if(getChar().hasPenis()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*60*5
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(removedPenis):
		return {}
	var theChar:BaseCharacter = getChar()
	if(theChar.hasPenis()):
		if(theChar.hasPenis() && theChar.getPenisSize() > 8):
			return {
				showPenis = true,
				effects = [
					partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [-RNG.randi_range(3, 6)])
				],
			}
	removedPenis = true
	return {
		effects = [
			partEffect("newpart", BodypartSlot.Penis, "SwitchPart", [""]),
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
	
	data["rp"] = removedPenis
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	removedPenis = SAVE.loadVar(_data, "rp", false)
