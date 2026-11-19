extends ContentBoardEntryBase

func _init():
	id = "Vion"
	
func getName() -> String:
	return "Вион"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Найдите способ помочь дракону-гипнотизеру с его проблемой «жеребца». Также получите шанс изучить навыки гипноза Виона. Этот контент был предоставлен пользователем PeteTimesSix."
	return "Найдите способ помочь дракону-гипнотизеру с его проблемой «жеребца». (От PTS)"

func getKinks() -> Array:
	return [
		"Игрок будет выступать в обеих ролях: и доминанта, и сабмиссива",
		"Гипноз",
		"Насилие",
	]

func getCompletedDesc() -> String:
	return "Вам удалось помочь Виону с Рашем!"

func getStatus() -> int:
	if(getFlag("HypnokinkModule.RushSubdued", false)):
		return ContentBoardStatus.Completed
	if(getFlag("HypnokinkModule.KnowAboutRush", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIfBool(GM.main.getDays() >= 4), "Подождите, пока пройдет как минимум 4 дня."],
		[completeIf("HypnokinkModule.DidVionGlance"), "Исследуйте тюрьму, пока случайно не наткнетесь на Виона."],
		[completeIf("HypnokinkModule.DidVionIntroduction"), "Найдите Виона в сиреневом блоке камер."],
		[completeIf("HypnokinkModule.KnowAboutRush"), "Расспросите его о Раше."],
	]

func getProgressText() -> String:
	return "Выполните задание \"Стать жеребцом на время\"."
