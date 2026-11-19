extends ContentBoardEntryBase

func _init():
	id = "ElizaChastity"
	
func getName() -> String:
	return "Тренировка послушания"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Пройдите экспериментальную программу тренировки послушания, созданную Элайзой Куинн. Она доступна только заключенным, обладающим основным мужским репродуктивным органом — пенисом. Этот сюжет сосредоточен на целомудрии, анальном сексе и подчинении."
	return "Пройди программу дрессировки послушания от Элизы Куинн, полностью сосредоточенную на мужском целомудрии."

func getKinks() -> Array:
	return [
		"Принудительное подчинение (ПК — саб)",
		"Корсеты целомудрия",
		"Анальный секс / Пеггинг (ПК — боттом)",
		"Поедание спермы",
		"Постоянное целомудрие (опционально)",
	]

func getCompletedDesc() -> String:
	if(getFlag("MedicalModule.Chastity_Event5LockedForever", false)):
		return "Вы прошли всю программу и даже согласились на пожизненную блокировку!"
	if(getFlag("MedicalModule.Chastity_Event5BredEliza", false)):
		return "Вы прошли всю программу, но в конце решили отказаться от вечного целомудрия и осеменить Элайзу!"
	return "Вы прошли всю программу!"

func getStatus() -> int:
	if(getFlag("MedicalModule.Chastity_EventNumber", 0) >= 7):
		return ContentBoardStatus.Completed
	if(getFlag("MedicalModule.Chastity_EventNumber", 0) > 0 && !GM.pc.hasPenis()):
		return ContentBoardStatus.Cancelled
	if(getFlag("MedicalModule.Chastity_EventNumber", 0) > 0):
		return ContentBoardStatus.InProgress
	if(!GM.pc.hasPenis()):
		return ContentBoardStatus.Impossible
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	var ppCond:int = ContentBoardCondition.Incomplete
	if(GM.pc.hasPenis()):
		ppCond = ContentBoardCondition.Complete
	else:
		ppCond = ContentBoardCondition.Impossible
	
	return [
		[ppCond, "Наличие пениса."],
		[completeIf("MedicalModule.PC_ReceivedPermanentCage"), "Найди Элизу в медпункте и запишись в её программу тренировки послушания."],
		[completeIfBool(getFlag("MedicalModule.Chastity_EventNumber", 0) > 0), "Спи в своей камере в девственном поясе. Новые сцены происходят каждые 5 дней."],
	]

func getProgressText() -> String:
	return "Продолжай спать в своей камере в девственном поясе. Новые сцены происходят каждые 5 дней."
