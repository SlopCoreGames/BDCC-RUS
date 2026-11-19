extends ContentBoardEntryBase

func _init():
	id = "MainKait"
	
func getName() -> String:
	return "Основная ветка Кейт"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Покорите всю тюрьму вместе со своей командой! Сломайте любого, кто встанет у вас на пути. Этот маршрут создан для доминантных игроков. (Этот маршрут еще не полностью завершен)"
	return "Покорите всю тюрьму! Создано для доминантных игроков.\n(в процессе разработки)"

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Все виды доминантных кинков",
	]

func getCompletedDesc() -> String:
	#return "You made the captain your bitch!"
	return "Вы завершили все доступные на данный момент основные миссии."

func getStatus() -> int:
	if(GM.main.MRH.didCompleteKaitRouteBefore() && !GM.main.hasCommittedToKaitMainRoute()):
		return ContentBoardStatus.Completed
	if(GM.main.MS.didCompleteAllMainMissions()):
		return ContentBoardStatus.Completedish
	#if(getFlag("TaviModule.Ch7NoEnding", false) || getFlag("TaviModule.Ch7YesEnding", false) || getFlag("TaviModule.Ch7KillEnding", false)):
	#	return ContentBoardStatus.Completed
	if(GM.main.hasCommittedToMainRoute() && !GM.main.hasCommittedToKaitMainRoute()):
		return ContentBoardStatus.Cancelled
	if(getFlag("KaitModule.joinedTeam", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[ContentBoardCondition.Complete if(getFlag("KaitModule.gotMetByKait", false) || getFlag("KaitModule.talkedKaitArena", false)) else ContentBoardCondition.Incomplete, "Найдите Кейт: отправляйтесь на добычу ресурсов, а затем изобьйте Тави. Или же найдите Кейт на скрытой арене."],
		[completeIf("KaitModule.talkedKaitArena"), "Поговорите с Кейт о том, чтобы объединиться."],
		[completeIf("KaitModule.joinedTeam"), "Объединитесь с Кейт."],
	] + ([] if !GM.main.MS.didCompleteAllMainMissions() else [[ContentBoardCondition.InProgress, "Ждите, пока Рахи добавит новые миссии..."]] )

func getProgressText() -> String:
	return "Выполняйте миссии, которые дает вам доска заданий в вашем убежище."
