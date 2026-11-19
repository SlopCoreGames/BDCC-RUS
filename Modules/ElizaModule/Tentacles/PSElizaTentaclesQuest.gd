extends QuestBase

func _init():
	id = "PSElizaTentaclesQuest"

func getVisibleName():
	return "Семена желания"

func getProgress():
	var result = []
	
	result.append("Элиза хочет, чтобы ты принес ей одно растительное яйцо. Зачем именно оно ей нужно — она толком не объяснила.")
	
	if(getFlag("ElizaModule.tent_firstegg", false)):
		result.append("Элизе нужно больше растительных яиц, чтобы создать идеальное яйцо! Каждое яйцо снижает итоговую стоимость. Ты принес ей "+str(getFlag("ElizaModule.tent_eggs", 0))+" egg"+("s" if (getFlag("ElizaModule.tent_eggs", 0) != 1) else "")+".")
	
	if(getFlag("ElizaModule.tent_born", false)):
		result.append("Теперь в твоей камере живет монстр-щупальце. Наслаждайся!")
	if(getFlag("ElizaModule.tent_elizaAnnoy", false)):
		result.append("Элиза отдала тебе одно из тех яиц-щупалец, что она отложила!")
	
	return result

func isVisible():
	return getFlag("ElizaModule.tent_started")

func isCompleted():
	return getFlag("ElizaModule.tent_born")

func isMainQuest():
	return false
