extends ContentBoardEntryBase

func _init():
	id = "Jacki"
	
func getName() -> String:
	return "Джеки Нортстар"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Развлекись с милой волчицей, на которой надеты уникальные пирсинги для целомудрия, держащие её половые губы всегда плотно сомкнутыми. Этот контент сосредоточен на развращении и анальном сексе."
	return "Развлекись с доброй волчицей, украшенной уникальными пирсингами целомудрия."

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Noncon/Stalking",
		"Только анальный секс (игрок — топ)",
		"Растяжка отверстия",
		"Развращение",
	]

func getCompletedDesc() -> String:
	if(getFlag("JackiModule.Jacki_ch2GotPussyFreed")):
		return "Джеки теперь твоя! Ты освободил и её киску тоже!"
	if(getFlag("JackiModule.Jacki_ch2GotExtraPiercings")):
		return "Джеки теперь твоя! Ты даже добавил ей несколько лишних пирсингов!"
	return "Джеки теперь твоя!"

func getStatus() -> int:
	if(getFlag("JackiModule.Jacki_ch2GotEnslaved", false)):
		return ContentBoardStatus.Completed
	if(getFlag("JackiModule.Jacki_ch2IntroSceneHappened", false)):
		return ContentBoardStatus.InProgress
	if(getFlag("JackiModule.Jacki_ContentDisabled", false)):
		return ContentBoardStatus.Cancelled
	if(getFlag("JackiModule.Jacki_StocksSceneHappened", false)):
		return ContentBoardStatus.NotStarted
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIfBool(GM.pc.getSkillsHolder().getLevel() >= 5), "Достигните 5-го уровня."],
		[completeIf("JackiModule.Jacki_FirstTimeEncountered"), "Отправляйтесь во двор, чтобы впервые встретить Джеки."],
		[completeIf("JackiModule.Jacki_StocksSceneHappened"), "Найдите Джеки, зажатую в колодах, и решите, что с ней делать."],
		[completeIf("JackiModule.Jacki_ch2IntroSceneHappened"), "Поговорите с Джеки в спортзале!"],
	]

func getProgressText() -> String:
	return "Повышайте показатели похоти и разврата Джеки, взаимодействуя с ней, и открывайте новые варианты действий и сцен по мере прогресса."
