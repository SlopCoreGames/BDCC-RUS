extends TFBase

var addedPenis:bool = false

func _init():
	id = "GrowPenisTF"
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Выращивает пенис"

func getPillName() -> String:
	return "DiRecto"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интересно! Похоже, эта таблетка насыщена смесью андрогенных соединений и стимуляторов тканей, которые могут способствовать развитию пениса. При приеме она, вероятно, спровоцирует рост члена у тех, у кого его нет. Думаю, я назову её... «DiRecto». Весьма подходящее название, не находите?",
		tryOptions = [
			{
				name = "Заставить Элизу сожрать это",
				desc = "Спроси, хватит ли ей смелости опробовать собственный продукт. Скорее всего, ей не терпится протестировать свой новый орган.",
				sceneID = "ElizaDrugTestGrowCockScene",
			},
		],
	}
	
func getPillDatabaseDesc() -> String:
	return "Этот препарат вырастит вам пенис вашего вида. Если он у вас уже есть, ничего не изменится. Если вы гибрид, препарат выберет пенис одного из видов. Действие лекарства прекратится, когда размер вашего нового члена достигнет как минимум 15 см.\n\nПервая стадия наступит через несколько минут. После этого последующие будут происходить примерно каждые 20 минут. Ускорить процесс можно только с помощью препарата QuickShift.\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет больше нечего."

func getTFCheckTags() -> Dictionary:
	return {
		"growpenis": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 1500.0,
	}

func isPossibleFor(_char) -> bool:
	if(_char.hasPenis()):
		return false
	return true

func start(_args:Dictionary):
	pass

func canTransformFurther() -> bool:
	if(getStage() == 0 && !getChar().hasPenis()):
		return true
	if(!addedPenis):
		return true
	var theChar:BaseCharacter = getChar()
	if(theChar.hasPenis() && theChar.getPenisSize() < 15):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 200
	return 60*20
	
func doProgress(_context:Dictionary) -> Dictionary:
	if(getStage() == 0):
		return {}
	var theChar:BaseCharacter = getChar()
	if(theChar.hasPenis()):
		if(theChar.hasPenis() && theChar.getPenisSize() < 15):
			return {
				showPenis = true,
				effects = [
					partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [RNG.randi_range(3, 6)])
				],
			}
		
		return {}
	var possiblePartIDs:Dictionary = Bodypart.findPossibleBodypartIDsDict(BodypartSlot.Penis, theChar, theChar.getSpecies(), NpcGender.Male, true)
	if(possiblePartIDs.has("")):
		possiblePartIDs.erase("")
	if(possiblePartIDs.empty()):
		return {}
	var newPartID:String = RNG.pickWeightedDict(possiblePartIDs)
	addedPenis = true
	return {
		effects = [
			partEffect("newpart", BodypartSlot.Penis, "SwitchPart", [newPartID, {lengthCM=10}]),
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
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	addedPenis = SAVE.loadVar(_data, "ap", false)
