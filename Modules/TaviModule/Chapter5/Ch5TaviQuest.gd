extends QuestBase

func _init():
	id = "Ch5TaviQuest"

func getVisibleName():
	return "Линия токсичной крови"

func getProgress():
	var result = []
	
	result.append("Найди Нову и забери у неё датапад. Или можно просто побить охранников — вдруг у кого-то из них найдётся нужный тебе девайс.")
	
	if(getFlag("TaviModule.Ch5StoleDatapadFromGuard") || getFlag("TaviModule.Ch5StoleDatapadFromNova")):
		result.append("Датапад у тебя! Отлично!")
	
	result.append("Проникни в инженерный блок и раздобудь две вещи: частоту блюспейса для ошейника и прототип гранаты.")
	
	if(getFlag("TaviModule.Ch5SearchedLabFirstTime")):
		result.append("Найди способ подать питание в сборочную лабораторию. Стоит проверить соседний офис.")
	
	if(getFlag("TaviModule.Ch5SentinelXHappened")):
		if(getFlag("TaviModule.Ch5StoleDatapadFromGuard") || getFlag("TaviModule.Ch5StoleDatapadFromNova")):
			result.append("Теперь ты знаешь частоту ошейника и у тебя есть прототип гранаты.")
		else:
			result.append("Теперь ты знаешь частоту ошейника и у тебя есть прототип гранаты. Осталось только раздобыть датапад у Новы или охранников.")
	
	if(getFlag("TaviModule.Ch5StoleDatapadFromGuard") || getFlag("TaviModule.Ch5StoleDatapadFromNova")):
		if(getFlag("TaviModule.Ch5SentinelXHappened")):
			result.append("Ты собрал всё, что нужно Тави! Пора возвращаться к ней.")
	
	return result

func isVisible():
	return getFlag("TaviModule.Ch5NewPlanSceneHappend")

func isCompleted():
	return getFlag("TaviModule.Ch5BigSceneStarted")

func isMainQuest():
	return true
