extends QuestBase

func _init():
	id = "WorkInMinesQuest"

func getVisibleName():
	return "Шахты"

func getProgress():
	var result = []
	
	result.append("Риша сказала тебе отправиться на работу в шахты и упомянула о лифте в главном зале, который доставит тебя туда. Возможно, это поможет тебе подзаработать немного кредитов.")
	
	return result

func isVisible():
	return true

func isCompleted():
	return GM.main.getFlag("Mining_IntroducedToMinning", false)

func isMainQuest():
	return false
