extends QuestBase

func _init():
	id = "ElizaQuest"

func getVisibleName():
	return "Королева Алхимии"

func getProgress():
	var result = []
	
	var amountOfNurseryTasks:int = GM.main.SCI.getAmountOfCompletedNurseryTasks()
	var amountOfPillsUnlocked:int = GM.main.SCI.getUnlockedStrangePillsCount()
	var amountOfPillsTested:int = GM.main.SCI.getTestedStrangePillsCount()
	var s1hap:bool = getFlag("ElizaModule.s1hap", false)
	var s2hap:bool = getFlag("ElizaModule.s2hap", false)
	var s3hap:bool = getFlag("ElizaModule.s3hap", false)
	var s4hap:bool = getFlag("ElizaModule.s4hap", false)
	var s5hap:bool = getFlag("ElizaModule.s5hap", false)
	var s6hap:bool = getFlag("ElizaModule.s6hap", false)
	var s6DateHap:bool = getFlag("ElizaModule.s6DateHap", false)
	var s7hap:bool = getFlag("ElizaModule.s7hap", false)

	result.append("Элиза Куинн велела тебе выполнить 3 заказа в детском отделении, если хочешь получить шанс стать её лаборантом.\nПодойди к доске объявлений в детском отделении, чтобы увидеть сегодняшние заказы. На данный момент ты выполнил(а): "+str(amountOfNurseryTasks)+" task"+("s" if amountOfNurseryTasks != 1 else "")+".")
	
	var nurseryTasks:Array = GM.main.SCI.peekNurseryTasks()
	if(!nurseryTasks.empty()):
		var taskText:String = "Bounties that you remember:"
		for taskA in nurseryTasks:
			var task:NurseryTaskBase = taskA
			
			taskText += ("\n- "+task.getName())
		result.append(taskText)
	
	if(getFlag("ElizaModule.s0hap") && !s1hap && amountOfNurseryTasks >= 3):
		result.append("Ты выполнил(а) достаточно заказов, иди к Элизе!")
	
	if(s1hap):
		result.append("Элиза хочет, чтобы ты нашел(ла) «странную таблетку» и принес(ла) её ей. У некоторых заключенных они могут быть, но они не поделятся ими, пока ты их не заставишь. Проверь раздел «Особый заказ» на доске объявлений в детском отделении, чтобы найти тех, у кого есть эти странные наркотики.")
	
	if(s2hap):
		result.append("Теперь тебе открыт доступ в химическую лабораторию! Ищи новые «странные таблетки» и используй лабораторию, чтобы выяснить, что они делают и как их изготовить. Чтобы продвинуться по сюжету, тебе нужно разблокировать как минимум 3 таблетки. Сейчас у тебя: "+str(amountOfPillsUnlocked)+".")
	
	if(s3hap):
		result.append("Теперь ты можешь исследовать притон! Вход в него находится во внутреннем дворе. Чтобы продвинуться по сюжету, тебе нужно разблокировать как минимум 8 таблеток. Сейчас у тебя: "+str(amountOfPillsUnlocked)+". [b]Также тебе нужно протестировать как минимум одну трансформацию[/b]! Чтобы протестировать трансформацию, съешь таблетку сам(а) или скорми её кому-нибудь. Дождись, пока трансформация достигнет финальной стадии, а затем приди к Элизе сам(а) или приведи трансформированного человека. Сейчас у тебя: "+str(amountOfPillsTested)+" pill"+("s" if amountOfPillsTested != 1 else "")+" tested.")
	
	if(s4hap):
		result.append("Вы встретились с матерью Элизы... Чтобы продвинуться по сюжету, вам нужно разблокировать как минимум 12 таблеток. Сейчас у вас "+str(amountOfPillsUnlocked)+". Также необходимо протестировать как минимум 3 трансформации. Сейчас у вас "+str(amountOfPillsTested)+".")
	
	if(s5hap):
		result.append("Теперь Элиза может автоматически доить ваших рабынь, если вы приведете их к ней. Чтобы продвинуться по сюжету, нужно разблокировать как минимум 15 таблеток. Сейчас у вас "+str(amountOfPillsUnlocked)+". Также необходимо протестировать как минимум 6 трансформаций. Сейчас у вас "+str(amountOfPillsTested)+".")
	
	if(s6hap && !s6DateHap):
		result.append("Элиза предложила встретиться после окончания смены, чтобы вы могли отдохнуть и получше узнать друг друга. Чтобы продолжить историю, встретьтесь с ней в медицинском лобби после 23:00.")
	
	if(s6DateHap):
		result.append("Элизе нужна ваша помощь, чтобы найти и протестировать все препараты. Разблокируйте [b]все[/b] препараты (сейчас у вас разблокировано "+str(GM.main.SCI.getUnlockedStrangePillsCount())+"/"+str(GM.main.SCI.getTotalStrangePillCount())+" таблеток) и протестируйте как минимум [b]10[/b] из них (у вас протестировано "+str(GM.main.SCI.getTestedStrangePillsCount())+"/10). После этого вы сможете подойти к ней и посмотреть, что будет...")
	
	if(s7hap):
		result.append("Элиза решила пока остаться! У вас по-прежнему есть полный доступ к её химической лаборатории.")
	
	return result

func isVisible():
	return getFlag("ElizaModule.s0hap")

func isCompleted():
	return getFlag("ElizaModule.storyCompleted")

func isMainQuest():
	return false
