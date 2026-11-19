extends QuestBase

func _init():
	id = "ArticaLastQuest"

func getVisibleName():
	return "Ловля снов"

func getProgress():
	var result = []
	
	result.append("Кто-то стащил ловца снов Артики, пока ты не видела! Выясни, кто это сделал, избивая заключенных и допрашивая их!\n\nИли же ты можешь навестить доктора Куинн — возможно, она поможет исцелить печаль Артики иными, альтернативными способами...")

	var clueNumber = getFlag("ArticaModule.lqClues", 0)
	var allClues = GlobalRegistry.getModule("ArticaModule").getLastQuestHints()
	
	if(clueNumber > 0):
		var learnedClues = []
		
		var _i = 0
		for clue in allClues:
			if(_i < clueNumber):
				learnedClues.append(clue)
			else:
				break
			_i += 1
		
		result.append("Вот все зацепки, которые тебе известны о ловце снов Артики:\n"+Util.join(learnedClues, "\n"))

	if(getFlag("ArticaModule.LQArticaGotDreamCatcher")):
		result.append("Ловец снов вернулся к Артике! Она бесконечно тебе благодарна...")

	if(getFlag("ArticaModule.LQArticaGotBrainwashed")):
		result.append("Артика даже не помнит, что у неё когда-то был ловец снов. Теперь она счастлива быть твоей послушной шлюхой!")

	return result

func isVisible():
	return getFlag("ArticaModule.lastQuestStarted")

func isCompleted():
	return getFlag("ArticaModule.LQArticaGotDreamCatcher") || getFlag("ArticaModule.LQArticaGotBrainwashed")

func isMainQuest():
	return false
