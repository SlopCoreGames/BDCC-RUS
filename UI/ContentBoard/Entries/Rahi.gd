extends ContentBoardEntryBase

func _init():
	id = "Rahi"
	
func getName() -> String:
	return "Рахи"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Помоги застенчивой коричневой кошечке справиться с её проблемой с алкоголем. Занимай тело и разум Рахи, чтобы ей стало легче.\nМилый спрайт Рахи нарисован [url=https://silkiedraws.carrd.co/]Silkie! [img=32]res://UI/ContentBoard/Util/heart_silkie2.png[/img][/url]"
	return "Помоги застенчивой коричневой кошечке справиться с её проблемой с алкоголем."

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Вагинальный секс / Осеменение",
		"Анальный секс",
		"Masochism (Rahi)",
		"Смена ролей (Доминант -> Сабмиссив)",
		"Эксгибиционизм",
		"Петплей",
		"Prostitution/Sharing (optional)",
		"Watersports (optional)",
	]

func getCompletedDesc() -> String:
	if(getFlag("RahiModule.rahiMile7Proposed")):
		return "Теперь Рахи — твоя счастливая жена! Мяу-мяу."
	return "Теперь Рахи — твоя личная рабыня! Мяу-мяу."

func getStatus() -> int:
	if(getFlag("RahiModule.rahiMile8Happened", false)):
		return ContentBoardStatus.Completed
	if(getFlag("RahiModule.rahi5SceneHappened", false)):
		return ContentBoardStatus.InProgress
	if(getFlag("RahiModule.rahi4SceneHappened", false)):
		return ContentBoardStatus.NotStarted
	if(getFlag("RahiModule.Rahi_Denied", false)):
		return ContentBoardStatus.Cancelled
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("RahiModule.Rahi_GaveApple"), "Укради яблоко в теплицах и отдай его Рахи на скамье возле колодок."],
		[completeIf("RahiModule.Rahi_ShowerHappened"), "Найди Рахи в душевых и развлекись там с ней."],
		[completeIf("RahiModule.rahi1ElizaSceneHappened"), "Поспи в своей камере и посмотри, что будет."],
		[completeIf("RahiModule.rahi2SceneHappened"), "Поговори с Рахи о её проблеме."],
		[completeIf("RahiModule.rahi3SceneHappened"), "Поспи в своей камере и посмотри, что будет."],
		[completeIf("RahiModule.rahi4SceneHappened"), "Найди Рахи."],
		[completeIf("RahiModule.rahi5SceneHappened"), "Поговори с Рахи в общем блоке камер для заключенных."],
	]

func getProgressText() -> String:
	return "Тренируй Рахи каждый день, повышая её послушание или привязанность. Когда один из этих показателей достигнет нужного уровня, откроется возможность перейти к следующему этапу."
