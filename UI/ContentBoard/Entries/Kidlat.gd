extends ContentBoardEntryBase

func _init():
	id = "Kidlat"
	
func getName() -> String:
	return "Кидлат"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Найди милую кошечку, застрявшую в бесконечных технических туннелях, и попробуй ей помочь."+("\n\nОригинальный дурашливый спрайт взят из [url=https://www.furaffinity.net/view/53363888/]FurAffinity Кидлат[/url]" if getStatus() == ContentBoardStatus.Completed else "")
	return "Найди милую кошечку, застрявшую в бесконечных технических туннелях. Попробуй ей помочь"

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Элемент рогалика",
		"Секс/Разведение (ПК сверху)",
		"Мацание",
		"Эксгибиционизм",
	]

func getCompletedDesc() -> String:
	return "Кидлат больше не в наркопритоне!"

func getStatus() -> int:
	if(getFlag("DrugDenModule.Kidlat8Hap", false)):
		return ContentBoardStatus.Completed
	if(getFlag("DrugDenModule.Kidlat1Hap", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("ElizaModule.s0hap"), "Найдите Элизу Куинн в медпункте и спросите, можете ли вы стать её лаборантом."],
		[completeIf("ElizaModule.s3hap"), "Выполняй задание \"Королевы Алхимии\", пока не получишь доступ к наркопритону."],
		[completeIf("DrugDenModule.Kidlat1Hap"), "Начни забег в наркопритон и найди там Кидлат."],
	]

func getProgressText() -> String:
	return "Выполни задание \"Лавка Чудес Кидлат\"!"
