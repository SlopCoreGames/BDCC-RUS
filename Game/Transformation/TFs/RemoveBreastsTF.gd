extends TFBase

var removedBreasts:bool = false

func _init():
	id = "RemoveBreastsTF"
	
	pointsOnUnlock = 5

func getName() -> String:
	return "Делает грудь плоской"

func getPillName() -> String:
	return "BreastsBeGone"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Хм. Похоже, эта таблетка содержит комбинацию гормональных супрессоров и жиросжигающих агентов, нацеленных именно на ткани молочных желез. При приеме она, скорее всего, приведет к эффекту уплощения груди. Думаю, назову её... «Грудь-Прощай». Это название идеально отражает желаемый результат!",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат уменьшает размер груди. Он делает это поэтапно, на один размер за раз, пока грудь не станет полностью плоской. Он [b]не[/b] превратит твою грудь в мужские грудные мышцы.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 5 часов. Процесс можно ускорить с помощью препарата QuickShift или путем стимуляции груди подопытной, когда её соски [b]чувствительны[/b].\n\nУ этого препарата нет фиксированного количества стадий. Он будет продолжать уменьшать грудь до тех пор, пока это физически возможно."

func getTFCheckTags() -> Dictionary:
	return {
		"breasts": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 350.0,
	}

func isPossibleFor(_char) -> bool:
	if(!_char.hasNonFlatBreasts()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	#if(getStage() == 0 && !getChar().hasPenis()):
	#	return true
	if(removedBreasts):
		return false
	if(getChar().hasNonFlatBreasts()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*60*5
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(removedBreasts):
		return {}
	var theChar:BaseCharacter = getChar()
	var breastSize:int = theChar.getBreastsBaseSize()
	if(breastSize == BreastsSize.A):
		removedBreasts = true
	var toRemove:int = 1
	if(breastSize > BreastsSize.O):
		toRemove = RNG.randi_range(2,5)
	elif(breastSize > BreastsSize.DD):
		toRemove = RNG.randi_range(2,3)
	elif(breastSize > BreastsSize.C):
		toRemove = RNG.randi_range(1,2)
	return {
		effects = [
			partEffect("breasts", BodypartSlot.Breasts, "BreastSizeChange", [-toRemove]),
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
	
	data["rb"] = removedBreasts
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	removedBreasts = SAVE.loadVar(_data, "rb", false)
