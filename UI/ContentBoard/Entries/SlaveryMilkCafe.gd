extends ContentBoardEntryBase

func _init():
	id = "SlaveryMilkCafe"
	
func getName() -> String:
	return "Ежедневная капля"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Будь продан на аукционе рабов очаровательной паре, которая держит кафе и отчаянно нуждается в молоке и конче."
	return "Будь продан на аукционе рабов очаровательной паре, которая держит кафе и отчаянно нуждается в молоке и конче."

func getKinks() -> Array:
	return [
		"Мягкий плохой финал",
		"Игрок — сабмиссив",
		"Дойка, много дойки (цель — ПК)",
		"Sex/Pegging/Breeding",
	]

func getCompletedDesc() -> String:
	return "Вам удалось сбежать из рабства!"

func getStatus() -> int:
	if(GM.main.PSH.didComplete("MilkCafe")):
		return ContentBoardStatus.Completed
	if(GM.main.isInSpecificPlayerSlavery("MilkCafe")):
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
