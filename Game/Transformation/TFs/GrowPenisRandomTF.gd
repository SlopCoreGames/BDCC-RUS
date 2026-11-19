extends TFBase

var addedPenis:bool = false
var targetLen:float = 15
var specificPartID:String = ""

func _init():
	id = "GrowPenisRandomTF"
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Выращивает случайный член"

func getPillName() -> String:
	return "BoneRoll"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Поразительно! Похоже, эта таблетка содержит смесь факторов роста и гормональных предшественников, способных стимулировать трансформацию тканей пениса. После приема она, вероятно, как-то повлияет на твой член... Думаю, назову её... «Костяной рулет». Почему бы и нет!",
		tryOptions = [
			{
				name = "Заставить Элизу сожрать это",
				desc = "Спросить, хватит ли ей смелости попробовать собственный продукт. Скорее всего, в итоге она окажется в доильном аппарате...",
				sceneID = "ElizaDrugTestRandomCockScene",
			},
		],
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат вырастит тебе случайный пенис случайного размера от 15 до 25 см. Если у тебя уже есть член, он трансформируется в другой.\n\nПервая стадия наступит примерно через 10 минут. После этого последующие будут происходить в среднем каждые 30 минут. Процесс можно ускорить, только используя препарат QuickShift.\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет больше нечего.\n\nС помощью продвинутого лабораторного оборудования можно выбрать тип пениса и его целевую длину."

func getTFCheckTags() -> Dictionary:
	return {
		"growpenis": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 2500.0,
	}

func isPossibleFor(_char) -> bool:
	#if(_char.hasPenis()):
	#	return false
	return true

func start(_args:Dictionary):
	if(_args.has("targetLen")):
		targetLen = _args["targetLen"]
	else:
		targetLen = round(RNG.randf_range(15.0, 25.0))
	if(_args.has("specificPartID")):
		specificPartID = _args["specificPartID"]

func getPillOptions() -> Dictionary:
	var lengths:Array = [5.0, 8.0, 10.0, 12.0, 15.0, 18.0, 20.0, 22.0, 25.0, 28.0, 30.0]
	var lenArray:Array = []
	for theLen in lengths:
		lenArray.append([theLen, str(theLen)+"cm"])
	
	var dicks:Array = [["", "Random"]]
	for dickID in GlobalRegistry.getBodypartsIdsBySlotForTF(BodypartSlot.Penis):
		dicks.append([dickID, GlobalRegistry.getBodypartRef(dickID).getName()])
	
	return {
		"specificPartID": {
			name = "Тип члена",
			desc = "Какого размера член вырастет под действием препарата.",
			value = "",
			values = dicks,
		},
		"targetLen": {
			name = "Длина",
			desc = "Какой длины должен быть новый член.",
			value = 12.0,
			values = lenArray,
		},
	}

func canTransformFurther() -> bool:
	if(getStage() == 0):
		return true
	if(addedPenis):
		return false
	return true
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 500
	return 60*30
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(getStage() == 0):
		return {}
	var theChar:BaseCharacter = getChar()

	if(addedPenis):
		return {}
	addedPenis = true
	
	var newPartID:String = specificPartID
	if(newPartID == "" || GlobalRegistry.getBodypartRef(newPartID) == null):
		var possiblePartIDs:Array = GlobalRegistry.getBodypartsIdsBySlotForTF(BodypartSlot.Penis)#Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Penis, theChar, theChar.getSpecies(), NpcGender.Male)
		if(possiblePartIDs.has("")):
			possiblePartIDs.erase("")
		if(theChar.hasPenis()):
			var currPenis:String = theChar.getBodypart(BodypartSlot.Penis).id
			if(possiblePartIDs.has(currPenis)):
				possiblePartIDs.erase(currPenis)
		if(possiblePartIDs.empty()):
			return {}
		newPartID = RNG.pick(possiblePartIDs)
	
	if(theChar.hasPenis() && abs(theChar.getPenisSize()-targetLen)>0.1):
		var toAdd:float = targetLen - theChar.getPenisSize()
		return {
			effects = [
				partEffect("newpart", BodypartSlot.Penis, "SwitchPart", [newPartID]),
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [toAdd]),
			]
		}
	else:
		return {
			effects = [
				partEffect("newpart", BodypartSlot.Penis, "SwitchPart", [newPartID, {lengthCM=targetLen}]),
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
	
	data["ap"] = addedPenis
	data["tl"] = targetLen
	data["sp"] = specificPartID
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	addedPenis = SAVE.loadVar(_data, "ap", false)
	targetLen = SAVE.loadVar(_data, "tl", 15.0)
	specificPartID = SAVE.loadVar(_data, "sp", "")
