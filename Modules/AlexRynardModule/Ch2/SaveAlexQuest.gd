extends QuestBase

func _init():
	id = "SaveAlexQuest"

func getVisibleName():
	return "Проблемы с доверием"

func getProgress():
	var result = []
	
	result.append("Протез позвоночника Алекса сильно поврежден, и для его ремонта нужны запчасти. Избей инженеров или соверши налет на склад инженерного отсека. Тебе нужно как минимум 10 деталей. Сейчас собрано: "+str(getFlag("AlexRynardModule.ch2FoundParts", 0))+" parts.")

	if(getFlag("AlexRynardModule.ch2FoundParts", 0) >= 10):
		result.append("Все необходимые детали на месте! Иди и поговори с Элизой в медицинском вестибюле!")

	if(getFlag("AlexRynardModule.ch2FinalSceneHappened")):
		result.append("Алекс снова может ходить. Отличная работа.")

	return result

func isVisible():
	return getFlag("AlexRynardModule.ch2CheckAlexSceneHappened")

func isCompleted():
	return getFlag("AlexRynardModule.ch2FinalSceneHappened")

func isMainQuest():
	return false
