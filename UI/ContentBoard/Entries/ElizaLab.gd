extends ContentBoardEntryBase

func _init():
	id = "ElizaLab"
	
func getName() -> String:
	return "Ассистент биолаборатории"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Станьте ассистентом Элизы и получите шанс работать в её лаборатории, исследуя новые препараты для трансформации. Улучшайте лабораторию, чтобы получить доступ к новым прототипам."
	return "Стань ассистентом Элизы и получи шанс работать в её лаборатории, исследуя новые препараты для трансформации."

func getKinks() -> Array:
	return [
		"Препараты для трансформации",
		"Элемент рогалика (опционально)",
	]

func getCompletedDesc() -> String:
	return "Теперь у вас есть крутая химическая лаборатория!"

func getStatus() -> int:
	if(getFlag("ElizaModule.storyCompleted", false)):
		return ContentBoardStatus.Completed
	if(getFlag("ElizaModule.s0hap", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.NotStarted

func getStartConditions() -> Array:
	return [
		[completeIf("ElizaModule.s0hap"), "Найдите Элизу Куинн в медпункте и спросите, можете ли вы стать её лаборантом."],
	]

func getProgressText() -> String:
	return "Выполните задание \"Королева алхимии\"!"
