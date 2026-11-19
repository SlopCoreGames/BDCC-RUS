extends QuestBase

func _init():
	id = "TaviQuest2"

func getVisibleName():
	return "Синдикат"

func getProgress():
	var result = []
	
	result.append("(Основной маршрут, ориентированный на переключение) Тави велела встретиться ей у контрольно-пропускного пункта, чтобы вы могли добраться до кабинета капитана и попытаться дозвониться до «друзей Тави».")

	return result

func isVisible():
	if(GM.main.getModuleFlag("TaviModule", "Tavi_Quest2Completed")):
		return true
	if(GM.main.hasCommittedToMainRoute()):
		return false
	
	return GM.main.getModuleFlag("TaviModule", "Tavi_Quest2Started")

func isCompleted():
	return GM.main.getModuleFlag("TaviModule", "Tavi_Quest2Completed")

func isMainQuest():
	return true
