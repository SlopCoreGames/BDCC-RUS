extends QuestBase

func _init():
	id = "AvyArenaQuest"

func getVisibleName():
	return "Падший чемпион"

func getProgress():
	var result = []
	
	result.append("Доктор Куинн попросила меня украсть особенное растение с афродизиакальными свойствами. Она сказала, что их можно найти в теплицах.")

	if(getFlag("FightClubModule.StolePlantForEliza")):
		result.append("Ты украл растение. Пора возвращаться к доктору Куинн. Найти её можно в вестибюле медицинского крыла.")

	if(getFlag("FightClubModule.ReturnedPlantToEliza")):
		result.append("Доктор Куинн приготовила препарат и отдала его Рише, а значит, теперь он должен быть у Эви. Возвращайся к Эви и брось ей вызов!")

	return result

func isVisible():
	return getFlag("FightClubModule.GotTaskToStealPlant")

func isCompleted():
	return getFlag("FightClubModule.AvyGotRekt")

func isMainQuest():
	return false
