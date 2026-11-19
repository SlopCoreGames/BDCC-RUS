extends ContentBoardEntryBase

func _init():
	id = "AlexRynard"
	
func getName() -> String:
	return "Алекс Райнард"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Составьте компанию одинокому инженеру — чертовски обаятельному парню, который привык никому не доверять. Этот контент сосредоточен на милых взаимодействиях и безопасной практике БДСМ."
	return "Составьте компанию одинокому инженеру — чертовски обаятельному парню, который привык никому не доверять."

func getKinks() -> Array:
	return [
		"Игрок — саб",
		"BDSM",
		"Мягкое подчинение",
		"Секс-машины",
		"Дойка",
		"Гипноз",
		"Секс (ПК — снизу)",
	]

func getCompletedDesc() -> String:
	return "Вы помогли Алексу стать лучшей версией себя!"

func getStatus() -> int:
	if(getFlag("AlexRynardModule.ch2FinalSceneHappened", false)):
		return ContentBoardStatus.Completed
	if(getFlag("AlexRynardModule.ch1StopAlexContent", false)):
		return ContentBoardStatus.Cancelled
	if(getFlag("AlexRynardModule.ch1IntroSceneHappened", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("Mining_IntroducedToMinning"), "Выполните приказ Риши и отправляйтесь работать в шахты."],
		[completeIf("PortalPantiesModule.Alex_FirstTimeTalked"), "Поговорите с Алексом Ринардом у входа в шахты."],
		[completeIf("PortalPantiesModule.Panties_AskedAlex"), "Спросите Алекса Ринарда, не может ли он помочь вам с кредитами."],
		[completeIfBool(getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex", false) || getFlag("PortalPantiesModule.Panties_PcDenied", false)), "Полностью выполни задание с «трусиками-порталами», которое дает Алекс Ринард, или откажи ему после первой же попытки."],
		[completeIf("AlexRynardModule.ch1IntroSceneHappened"), "Спроси Алекса Ринарда в мастерской, не хочет ли он чего-нибудь пошленького!"],
	]

func getProgressText() -> String:
	return "Регулярно навещай Алекса Ринарда в мастерской и помогай ему."
