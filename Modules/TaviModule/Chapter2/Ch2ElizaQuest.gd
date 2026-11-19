extends QuestBase

func _init():
	id = "Ch2ElizaQuest"

func getVisibleName():
	return "Выносящие мозг наркотики"

func getProgress():
	var result = []
	
	result.append("Тебе нужно отправиться в медпункт и найти способ украсть эти выносящие мозг препараты, пока их не вкололи Тави. Поговори с Элизой.")
	
	if(GM.main.getFlag("TaviModule.ch2PCFailedToStealDuringCheckup")):
		result.append("Единственный способ украсть лекарства сейчас — это найти комнату, где они хранятся. Где-то в медпункте.")

	return result

func isVisible():
	return GM.main.getFlag("TaviModule.ch1ApproachedAfterQuest2")

func isCompleted():
	return GM.main.getFlag("TaviModule.ch2PCStoleDrugs")

func isMainQuest():
	return true
