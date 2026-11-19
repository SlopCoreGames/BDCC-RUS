extends ContentBoardEntryBase

func _init():
	id = "SlaveryTentacles"
	
func getName() -> String:
	return "Биолаборатория щупалец"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Будь продан на аукционе рабов в биолабораторию, где тебе предстоит вырастить собственного монстра с щупальцами!"
	return "Будь продан на аукционе рабов в биолабораторию, где тебе предстоит вырастить собственного монстра с щупальцами!"

func getKinks() -> Array:
	return [
		"Мягкий плохой финал",
		"Тентакли",
		"Механика игры в стиле тамагочи",
		"Секс с тентаклями (опционально)",
		"Oviposition (optional)"
	]

func getCompletedDesc() -> String:
	return "Вам удалось сбежать из рабства!"

func getStatus() -> int:
	if(GM.main.PSH.didComplete("Tentacles")):
		return ContentBoardStatus.Completed
	if(GM.main.isInSpecificPlayerSlavery("Tentacles")):
		return ContentBoardStatus.InProgress
	if(getFlag("PlayerSlaveryModule.foundMeme", false)):
		return ContentBoardStatus.NotStarted
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("FightClubModule.BulldogBypassed"), "Найдите способ попасть на подпольную арену."],
		[completeIf("PlayerSlaveryModule.foundMeme"), "Найдите кредитный чип, приклеенный к полу в одном из углов. Попробуйте его отклеить!"],
		[completeIfBool(getFlag("PlayerSlaveryModule.mirriTimes", 0)>0||getFlag("PlayerSlaveryModule.luxeTimes", 0)>0), "Быть проданным на аукционе рабов."],
	]

func getProgressText() -> String:
	return "Найдите способ сбежать из рабства."
