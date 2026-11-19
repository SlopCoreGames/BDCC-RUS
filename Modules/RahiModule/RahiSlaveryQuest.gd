extends QuestBase

func _init():
	id = "RahiSlaveryQuest"

func getVisibleName():
	return "Мокрые усы Рахи"

func getProgress():
	var result = []
	
	result.append("Похоже, у Рахи проблемы с алкоголем. Тебе стоит поговорить с ней об этом.")

	if(getFlag("RahiModule.rahi3SceneHappened")):
		result.append("Рахи сильно отравилась алкоголем. Загляни к ней на скамейку на следующий день, чтобы проверить, всё ли с ней в порядке.")

	if(getFlag("RahiModule.rahi4SceneHappened")):
		result.append("Ты спас Рахи. Но теперь тебе нужно ей помочь. Навести её в камере, когда она немного отдохнёт.")

	if(getFlag("RahiModule.rahi5SceneHappened")):
		result.append("Заходи к Рахи каждый день, чтобы давать ей поручения.")

	if(getFlag("RahiModule.rahiMile8Happened")):
		result.append("Теперь Рахи счастлива. Отличная работа.")

	return result

func isVisible():
	return getFlag("RahiModule.rahi1ElizaSceneHappened")

func isCompleted():
	return getFlag("RahiModule.rahiMile8Happened")

func isMainQuest():
	return false
