extends Object
class_name DatapackSceneTriggerType

const None = "None"
const EnterRoom = "EnterRoom"
const EnterAnyRoom = "EnterAnyRoom"
const EnterPlayerCell = "EnterPlayerCell"
const EnterRoomOnFloor = "EnterRoomOnFloor"

const TalkingToDynamicNPC = "TalkingToDynamicNPC"
const MeetDynamicNPC = "MeetDynamicNPC"
const TalkingToNPC = "TalkingToNPC"

const TakingAShower = "TakingAShower"
const Waiting = "Waiting"
const EatingInCanteen = "EatingInCanteen"
const WorkingInMines = "WorkingInMines"
const SleepInCell = "SleepInCell"
const WakeUpInCell = "WakeUpInCell"
const ApproachedYogaMats = "ApproachedYogaMats"
const ApproachedWeightsBench = "ApproachedWeightsBench"
const InsideElevator = "InsideElevator"
const PCLookingForTrouble = "PCLookingForTrouble"
const SceneAndStateHook = "SceneAndStateHook"

static func getAll():
	return [
		None,
		EnterRoom,
		EnterAnyRoom,
		EnterPlayerCell,
		EnterRoomOnFloor,
		
		TalkingToDynamicNPC,
		MeetDynamicNPC,
		TalkingToNPC,
		
		TakingAShower,
		Waiting,
		EatingInCanteen,
		WorkingInMines,
		SleepInCell,
		WakeUpInCell,
		ApproachedYogaMats,
		ApproachedWeightsBench,
		InsideElevator,
		PCLookingForTrouble,
		SceneAndStateHook,
	]

static func getName(triggerType):
	return str(triggerType)

static func getDescription(triggerType):
	if(triggerType == None):
		return "Этот тип триггера никогда не сработает; можно использовать для его отключения"
	if(triggerType == EnterRoom):
		return "Если установлено значение «React», код выполнится сразу при входе в конкретную комнату. Если «Run», можно добавлять кнопки и выводить текст"
	if(triggerType == EnterAnyRoom):
		return "Если установлено значение «React», код выполнится сразу при входе в любую комнату. Если «Run», можно добавлять кнопки и выводить текст"
	if(triggerType == EnterPlayerCell):
		return "Если установлено значение «React», код выполнится сразу при входе в камеру игрока. Если «Run», можно добавлять кнопки и выводить текст"
	if(triggerType == EnterRoomOnFloor):
		return "Выполнит код при входе в любую комнату на указанном этаже"
	
	if(triggerType == TalkingToDynamicNPC):
		return "Выполнит код, если вы столкнетесь с этим динамическим NPC во время любого события (событие будет отменено) ИЛИ если вы встретите его через меню встреч. Поддерживает ТОЛЬКО тип выполнения REACT"
	if(triggerType == MeetDynamicNPC):
		return "Выполнит код, если вы встретите его через меню встреч (имеет более высокий приоритет, чем TalkingToDynamicNPC). Поддерживает ТОЛЬКО тип выполнения REACT"
	if(triggerType == TalkingToNPC):
		return "Выполнит код при разговоре с определенными статичными NPC. Вам доступны только поддерживаемые NPC"
	
	if(triggerType == TakingAShower):
		return "Срабатывает, когда игрок принимает душ"
	if(triggerType == Waiting):
		return "Срабатывает, когда игрок ждет. Поддерживает ТОЛЬКО тип выполнения REACT"
	if(triggerType == EatingInCanteen):
		return "Срабатывает, когда игрок ест в столовой"
	if(triggerType == WorkingInMines):
		return "Срабатывает, когда игрок работает в шахте"
	if(triggerType == SleepInCell):
		return "Срабатывает, когда игрок ложится спать в камере (перед сном). Поддерживает ТОЛЬКО тип выполнения REACT"
	if(triggerType == WakeUpInCell):
		return "Срабатывает, когда игрок просыпается в камере (после сна)"
	if(triggerType == ApproachedYogaMats):
		return "Срабатывает, когда игрок подходит к коврикам для йоги"
	if(triggerType == ApproachedWeightsBench):
		return "Срабатывает, когда игрок подходит к скамье для жима"
	if(triggerType == InsideElevator):
		return "Срабатывает, когда игрок находится в лифте. Поддерживает ТОЛЬКО тип выполнения RUN"
	if(triggerType == PCLookingForTrouble):
		return "(Отключено, не использовать!) Срабатывает, когда игрок нажимает кнопку «искать неприятности». Поддерживает ТОЛЬКО тип выполнения REACT"
	if(triggerType == SceneAndStateHook):
		return "Продвинутый триггер, позволяющий подключиться к любой сцене. Используйте, только если понимаете, что делаете. Поддерживает ТОЛЬКО тип выполнения RUN"
	
	return "Описание отсутствует"

static func getAllWithNames():
	var result = []
	for triggerType in getAll():
		result.append([triggerType, getName(triggerType)])
	return result

static func getEditVars(triggerType):
	if(triggerType == EnterRoom):
		return {
			"room": {
				name = "Название комнаты",
				type = "location",
				value = "main_punishment_spot",
			},
		}
	if(triggerType == SceneAndStateHook):
		return {
			"scene": {
				name = "ID сцены",
				type = "string",
				value = "MeScene",
			},
			"state": {
				name = "Состояние сцены",
				type = "string",
				value = "wait",
			},
		}
	if(triggerType == EnterRoomOnFloor):
		var allFloors = GlobalRegistry.getMapFloors().keys()
		return {
			"floor": {
				name = "Этаж",
				type = "selector",
				value = allFloors[0] if allFloors.size() > 0 else "",
				values = allFloors,
			},
		}
	if(triggerType in [TalkingToDynamicNPC, MeetDynamicNPC]):
		return {
			"npc": {
				name = "NPC",
				type = "selector",
				value = "",
				values = [],
				involvedDatapackNPCs = true,
			},
		}
	if(triggerType == TalkingToNPC):
		return {
			"npc": {
				name = "NPC",
				type = "selector",
				value = "alexrynard",
				values = [
					"alexrynard",
					"eliza",
					"artica",
					"rahi",
					"rahiSlavery",
					"announcer",
					"avy",
					"bulldog",
					"jacki",
					"nurse",
					"nova",
					"tavi",
					"taviSlavery",
					"kidlat",
					"kidlatShop",
					"kait",
					"kaitIntro",
				],
			},
		}
	
	return {}
