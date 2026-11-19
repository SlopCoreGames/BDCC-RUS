extends ContentBoardEntryBase

func _init():
	id = "Socket"
	
func getName() -> String:
	return "Гнездо"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Познакомьтесь с доброй и легкой на подъем инженером-феннеком в очень интересном наряде. Помогайте ей с делами по всей тюрьме. Сопротивляйтесь искушению заняться с ней чем-нибудь пошлым на публике... или не сопротивляйтесь."
	return "Познакомьтесь с доброй инженером-феннеком в интересном наряде. Помогайте ей с делами по всей тюрьме."

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Секс на публике",
		"Публичное использование",
		"Свободное использование",
		"Секс в режиме скрытности",
		"Эксгибиционизм",
		"Гипноз",
	]

func getCompletedDesc() -> String:
	if(getFlag("SocketModule.removedWombImplant", false)):
		return "Вы помогли Сокет со всеми её задачами! Вы даже удалили ей имплант матки!"
	return "Вы помогли Сокет со всеми её задачами!"

func getStatus() -> int:
	if(getFlag("SocketModule.h5completed", false)):
		return ContentBoardStatus.Completed
	if(getFlag("SocketModule.socketIntroduced", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("Mining_IntroducedToMinning"), "Выполните приказ Риши и отправляйтесь работать в шахты."],
		[completeIf("PortalPantiesModule.Alex_FirstTimeTalked"), "Поговорите с Алексом Ринардом у входа в шахты."],
		[completeIf("PortalPantiesModule.Panties_AskedAlex"), "Спросите Алекса Ринарда, не может ли он помочь вам с кредитами."],
		[completeIfBool(getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex", false) || getFlag("PortalPantiesModule.Panties_PcDenied", false)), "Полностью выполни задание с «трусиками-порталами», которое дает Алекс Ринард, или откажи ему после первой же попытки."],
		[completeIfBool(GM.pc.getSkillsHolder().getLevel() >= 10), "Достигните 10 уровня."],
		[completeIf("SocketModule.socketIntroduced"), "Войдите в мастерскую, чтобы встретить Сокет!"],
	]

func getProgressText() -> String:
	return "Помогайте Сокет выполнять её поручения по всей тюрьме."
