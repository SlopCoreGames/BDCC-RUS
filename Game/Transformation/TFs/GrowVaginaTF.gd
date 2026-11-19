extends TFBase

var addedVag:bool = false

func _init():
	id = "GrowVaginaTF"
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Выращивает киску"

func getPillName() -> String:
	return "P-Bloom"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интригующе! Похоже, эта таблетка содержит смесь эстрогенных соединений и стимуляторов роста тканей, которые могут спровоцировать развитие женских гениталий. При приеме она, вероятно, будет стимулировать рост вагины у тех, у кого её нет. Думаю, назову её... «P-Bloom». Коротко и красиво, как по мне.",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат вырастит тебе вагину. Если она у тебя уже есть, ничего не изменится.\n\nПервая стадия наступит через несколько минут. Вторая стадия наступит примерно через 60 минут. Процесс можно ускорить, только если принять препарат QuickShift.\n\nУ этого препарата 2 стадии. Первая стадия не вызывает видимых внешних изменений. Вторая стадия выращивает вагину."

func getTFCheckTags() -> Dictionary:
	return {
		"growvag": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"GirlCum": 1500.0,
	}

func isPossibleFor(_char) -> bool:
	if(_char.hasVagina()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	if(getStage() == 0 && !getChar().hasVagina()):
		return true
	if(!addedVag && !getChar().hasVagina()):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*60
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(getStage() == 0):
		return {}
	var theChar:BaseCharacter = getChar()
	if(theChar.hasVagina()):
		return {}
	var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Vagina, theChar, theChar.getSpecies(), NpcGender.Female, true)
	if(possiblePartIDs.has("")):
		possiblePartIDs.erase("")
	if(possiblePartIDs.empty()):
		return {}
	var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
	addedVag = true
	return {
		effects = [
			partEffect("newpart", BodypartSlot.Vagina, "SwitchPart", [newPartID]),
		]
	}


func reactProgress(_context:Dictionary, _result:TFResult):
	if(getStage() == 0):
		addText("{npc.YouHe} {npc.youHeVerb('feel')} странное тепло разливается по {npc.yourHis} нижней части живота, словно под кожей начинает обретать форму что-то новое.")
		return
	addText(_result.getAllTFTexts())
	
	playAnim(StageScene.TFLook, "crotch", {bodyState={exposedCrotch=true,hard=true}})
	
func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["av"] = addedVag
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	addedVag = SAVE.loadVar(_data, "av", false)
