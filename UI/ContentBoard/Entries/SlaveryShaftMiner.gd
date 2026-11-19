extends ContentBoardEntryBase

func _init():
	id = "SlaveryShaftMiner"
	
func getName() -> String:
	return "Шахтер шахты"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Будь продан на аукционе рабов и стань шахтером на какой-то богом забытой планете."
	return "Будь продан на аукционе рабов и стань шахтером на какой-то богом забытой планете."

func getKinks() -> Array:
	return [
		"Мягкий плохой финал",
		"Несексуальный акцент",
		"Механики прогрессии",
		"Добыча руды",
	]

func getCompletedDesc() -> String:
	return "Вам удалось сбежать из рабства!"

func getStatus() -> int:
	if(GM.main.PSH.didComplete("ShaftMiner")):
		return ContentBoardStatus.Completed
	if(GM.main.isInSpecificPlayerSlavery("ShaftMiner")):
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
