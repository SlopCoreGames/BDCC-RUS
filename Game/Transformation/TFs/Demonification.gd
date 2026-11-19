extends "res://Game/Transformation/TFs/SpeciesTF.gd"

func _init():
	id = "Demonification"
	
	canStack = false
	
	pointsOnUnlock = 15

func getName() -> String:
	return "Демонификация"

func getPillName() -> String:
	return "DemoniX"

func getPillDatabaseDesc() -> String:
	return "Этот препарат превратит тебя в полудемона. Он заставит у тебя вырасти рога, демонический хвост и копыта. Также он изменит твой пенис, превратив его в лошадиный вариант, и увеличит его длину примерно до 20 см, если сейчас он короче.\n\nПервая стадия наступит через несколько минут. Вторая стадия наступит примерно через 5 часов. Третья стадия — через 10 часов, четвертая — через 15 часов и так далее. Процесс можно ускорить с помощью препарата QuickShift или если подопытный будет причинять [b]боль[/b] другим во время половых актов.\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет больше нечего."

func getTFCheckTags() -> Dictionary:
	return {
		"species": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Cum": 1000.0,
	}

func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 300
	return 60*60*5*_theStage

func isPossibleFor(_char) -> bool:
	if(Species.Demon in _char.getSpecies()):
		return false
	return true

func start(_args:Dictionary):
	newSpecies = [Species.Demon]

func getPillOptions() -> Dictionary:
	return {}

func getUnlockData() -> Dictionary:
	return {
		eliza = "Похоже, этот даст тебе рога, уникальный хвост и копыта. Назову-ка я его... "+getPillName()+"... Думаю, это название ему отлично подойдет.",
		tryOptions = [
			{
				name = "Заставить Элизу сожрать это",
				desc = "(Покорный секс) Спросить, хватит ли ей смелости попробовать собственный продукт. Вероятно, она возбудится и станет доминантной... очень доминантной...",
				sceneID = "ElizaDrugTestDemoniXScene",
			},
		],
	}

func getSlotsToTransform() -> Array:
	return [
		BodypartSlot.Horns,
		BodypartSlot.Tail,
		BodypartSlot.Penis,
		BodypartSlot.Legs,
	]

func allowsRemovingParts() -> bool:
	return false

func canTransformFurther() -> bool:
	var theChar:BaseCharacter = getChar()
	if(theChar.hasPenis() && theChar.getPenisSize() <= 20):
		return true
	return .canTransformFurther()

func doProgress(_context:Dictionary) -> Dictionary:
	var result:Dictionary = .doProgress(_context)
	
	if(!result.empty()):
		return result
	
	var theChar:BaseCharacter = getChar()
	if(theChar.hasPenis() && theChar.getPenisSize() <= 20):
		return {
			showPenis = true,
			effects = [
				partEffect("penLen", BodypartSlot.Penis, "PenisLengthChange", [RNG.randi_range(4, 5)])
			],
		}
	return {}

func onSexEvent(_event : SexEvent):
	var _npc = getChar()
	if(_event.getType() in [SexEvent.PainInflicted, SexEvent.Choking]):
		if(_event.getSourceChar() == _npc):
			accelerateTimer(0.4)
