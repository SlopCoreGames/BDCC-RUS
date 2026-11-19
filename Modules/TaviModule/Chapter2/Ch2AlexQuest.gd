extends QuestBase

func _init():
	id = "Ch2AlexQuest"

func getVisibleName():
	return "Блюспейснутый"

func getProgress():
	var result = []
	
	result.append("Тебе нужно найти Алекса Ринарда где-то на уровне шахт и разузнать, где находится передатчик блюспейса.")
	
	if(GM.main.getFlag("TaviModule.ch2AlexTalkedTo")):
		result.append("Судя по всему, передатчик блюспейса спрятан где-то в инженерном отсеке. Ищи там.")

	if(GM.main.getFlag("TaviModule.ch2EscapedSymbian")):
		result.append("В комнате отдыха должно быть что-то, что позволит тебе получить доступ в охраняемое крыло инженерного отсека.")

	return result

func isVisible():
	return GM.main.getFlag("TaviModule.ch1ApproachedAfterQuest2")

func isCompleted():
	return GM.main.getFlag("TaviModule.ch2PCLearnedCode")

func isMainQuest():
	return true
