extends ContentBoardEntryBase

func _init():
	id = "MainTavi"
	
func getName() -> String:
	return "Основной маршрут Тави"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Станьте напарником Тави и найдите способ сбежать из тюрьмы вместе. Этот путь создан для игроков-свитчей — тех, кому одинаково нравится и доминировать, и подчиняться."
	return "Станьте напарником Тави и найдите способ сбежать из тюрьмы вместе. Для игроков-свитчей."

func getKinks() -> Array:
	return [
		"Игрок будет и доминантом, и сабмиссивом",
		"Любой вид секса",
		"BDSM",
		"Развращение",
		"Noncon (optional)",
	]

func getCompletedDesc() -> String:
	if(getFlag("TaviModule.Ch7NoEnding")):
		return "Вы вместе с Тави совершили побег из тюрьмы!"
	if(getFlag("TaviModule.Ch7YesEnding")):
		return "Вы с Тави стали лучшими шпионскими агентами капитана! Теперь у вас прекрасная жизнь."
	if(getFlag("TaviModule.Ch7KillEnding")):
		return "Вы с Тави стали лучшими шпионскими агентами капитана! Теперь у вас прекрасная жизнь."
	return ""

func getStatus() -> int:
	if(GM.main.MRH.didCompleteTaviRouteBefore() && !GM.main.hasCommittedToTaviMainRoute()):
		return ContentBoardStatus.Completed
	if(getFlag("TaviModule.Ch7NoEnding", false) || getFlag("TaviModule.Ch7YesEnding", false) || getFlag("TaviModule.Ch7KillEnding", false)):
		return ContentBoardStatus.Completed
	if(GM.main.hasCommittedToMainRoute() && !GM.main.hasCommittedToTaviMainRoute()):
		return ContentBoardStatus.Cancelled
	if(getFlag("TaviModule.Tavi_IntroducedTo", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("Mining_IntroducedToMinning"), "Выполните приказ Риши и отправляйтесь работать в шахты."],
		[completeIf("TaviModule.Tavi_IntroducedTo"), "Познакомьтесь с Тави и подчинитесь ей."],
	]

func getProgressText() -> String:
	return "Выполняйте задания, которые дает вам Тави."
