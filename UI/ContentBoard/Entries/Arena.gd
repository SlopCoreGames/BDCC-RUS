extends ContentBoardEntryBase

func _init():
	id = "Arena"
	
func getName() -> String:
	return "Арена"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Стань великим чемпионом скрытой подземной арены, где действует только одно правило: никаких правил!"
	return "Стань великим чемпионом скрытой подземной арены, где действует только одно правило: никаких правил!"

func getKinks() -> Array:
	return [
		"Насилие",
		"Нонкон",
		"Секс (ПК может быть как сверху, так и снизу)",
	]

func getCompletedDesc() -> String:
	return "Вы победили Эви и стали Великим Чемпионом!"

func getStatus() -> int:
	if(getFlag("FightClubModule.AvyGotRekt", false)):
		return ContentBoardStatus.Completed
	if(getFlag("FightClubModule.FightClubFirstArenaIntroduction", false)):
		return ContentBoardStatus.InProgress
	if(getFlag("FightClubModule.AvyIntroduced", false)):
		return ContentBoardStatus.NotStarted
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("FightClubModule.BulldogFirstTimeHappened"), "Найдите скрытый вход в подземную арену где-то неподалеку от спортзала."],
		[completeIf("FightClubModule.BulldogBypassed"), "Попадите на арену, подкупив бульдога или сразившись с ним."],
		[completeIf("FightClubModule.AnnouncerIntroduced"), "Поговорить с Диктором."],
		[completeIf("FightClubModule.AvyIntroduced"), "Поговорить с Эви."],
		[completeIf("FightClubModule.FightClubFirstArenaIntroduction"), "Начните свой первый бой на арене!"],
	]

func getProgressText() -> String:
	if(getFlag("FightClubModule.GotTaskToStealPlant", false) && !getFlag("FightClubModule.AvyGotRekt", false)):
		return "Выполните задание \"Падший Чемпион\", чтобы победить Эви."
	return "Продвигайтесь по рангам арены, побеждая в боях."
