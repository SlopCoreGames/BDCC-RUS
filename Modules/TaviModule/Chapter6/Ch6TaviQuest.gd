extends QuestBase

func _init():
	id = "Ch6TaviQuest"

func getVisibleName():
	return "Последствия"

func getProgress():
	var result = []
	
	result.append("Найди Тави.")
	
	if(getFlag("TaviModule.Ch5FoundPunishedTavi")):
		result.append("Тави сломлена и стала твоей домашней зверушкой. Относись к ней хорошо или преврати её в ещё большую шлюху.")

	if(getFlag("TaviModule.Ch7PlanningSceneHappened")):
		result.append("Ты можешь попытаться штурмовать командный мостик в одиночку или натренировать Тави так, чтобы она смогла тебе помочь. Прежде чем это сделать, стоит прибраться за собой и закрыть все хвосты.")

	return result

func isVisible():
	return getFlag("TaviModule.Ch5BigSceneStarted")

func isCompleted():
	return getFlag("TaviModule.Ch7CaptainSceneHappened")

func isMainQuest():
	return true
