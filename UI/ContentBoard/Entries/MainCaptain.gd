extends ContentBoardEntryBase

func _init():
	id = "MainCaptain"
	
func getName() -> String:
	return "Капитан Роут"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Стань самым доверенным заключенным капитана и помоги ему в его поисках. Этот маршрут предназначен для игроков, предпочитающих подчиняющуюся роль. (Работа над этим маршрутом начнется после завершения ветки Кейт)"
	return "Стань самым доверенным заключенным капитана. Предназначено для игроков с сабмиссивным стилем игры. (В планах)"

func getCompletedDesc() -> String:
	return "Ты сделал невозможное!"

func getStatus() -> int:
	if(GM.main.MRH.didCompleteCaptainRouteBefore() && !GM.main.hasCommittedToCaptainMainRoute()):
		return ContentBoardStatus.Completed
	#if(GM.main.hasCommittedToMainRoute() && !GM.main.hasCommittedToCaptainMainRoute()):
	#	return ContentBoardStatus.Cancelled
	return ContentBoardStatus.Unavailable

func getStartConditions() -> Array:
	return [
		[ContentBoardCondition.InProgress, "Будь добр к Рахи и жди выхода этого маршрута."],
		[ContentBoardCondition.Incomplete, "Наслаждайся прохождением."],
	]

func getProgressText() -> String:
	return "Выполняй задания, которые будет давать тебе капитан."
