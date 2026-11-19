extends QuestBase
class_name TestQuest

const Flag_something = "testFlag"

func _init():
	id = "TestQuest"

func getVisibleName():
	return "Тестовый квест"

func getProgress():
	var result = []
	
	result.append("Тест тест")
	result.append("мяу-мяу")
	
	return result

func isVisible():
	return false

func isCompleted():
	return true

func isMainQuest():
	return false
