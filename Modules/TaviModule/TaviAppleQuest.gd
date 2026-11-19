extends QuestBase

func _init():
	id = "TaviAppleQuest"

func getVisibleName():
	return "Запретный плод (Переключение маршрута)"

func getProgress():
	var result = []
	
	result.append("Тави сказала, что хочет яблоко. Его можно найти в теплицах рядом с тюремным двором.")
	if(GM.pc.getInventory().hasItemID("appleitem")):
		result.append("У меня есть яблоко. Надо отдать его Тави. Она вечно ошивается на шахтерском уровне.")
	
	return result

func isVisible():
	return GM.main.getModuleFlag("TaviModule", "Tavi_NeedsApple")

func isCompleted():
	return GM.main.getModuleFlag("TaviModule", "Tavi_GotApple")

func isMainQuest():
	return true
