extends QuestBase

func _init():
	id = "Ch3TaviQuest"

func getVisibleName():
	return "Месть Тави"

func getProgress():
	var result = []
	
	result.append("Всё необходимое при тебе. Пора идти к Тави.")
	
	if(GM.QS.isCompleted("Ch2ElizaQuest") && !GM.main.getFlag("TaviModule.ch2DrugsGaveToTavi")):
		result.append("Наркота у тебя. Иди и отдай её Тави.")

	if(GM.main.getFlag("TaviModule.ch3StartedInfiltration")):
		result.append("Тебе нужно найти диспетчерскую и запустить протокол техобслуживания, чтобы открыть дверь к передатчику блюспейса.")

	if(GM.main.getFlag("TaviModule.ch3CompletedDoorHack")):
		result.append("Протокол техобслуживания запущен. Возвращайся к Тави.")

	if(GM.main.getFlag("TaviModule.Ch4ServedPunishment")):
		result.append("Ты на свободе! Но сначала нужно отомстить той кошке, которая разболтала капитану о твоих планах. Ищи Кейт в сиреневом блоке по утрам.")

	if(GM.main.getFlag("TaviModule.Ch4KaitSceneHappened")):
		result.append("С Кейт пока покончено. Иди отдохни в камере, Тави нужно время, чтобы придумать новый план.")

	return result

func isVisible():
	return GM.QS.isCompleted("Ch2ElizaQuest") && GM.QS.isCompleted("Ch2AlexQuest")

func isCompleted():
	return GM.main.getFlag("TaviModule.Ch5NewPlanSceneHappend")

func isMainQuest():
	return true
