extends QuestBase

func _init():
	id = "DealingWithRush"

func getVisibleName():
	return "Выигрыш времени для жеребца"

func getProgress():
	var result = []
	
	result.append("Виону нужна помощь в обращении с Рашем — гибридом лошади и дракона, чьи требования становятся всё более настойчивыми.")
	if(GM.main.getFlag("HypnokinkModule.RushDealStruckAtLeastOnce", false)):
		result.append("Вы заключили сделку с Рашем, которая должна на время отвязаться от Виона.")
	if(GM.main.getFlag("HypnokinkModule.RushCausingMoreTrouble", false)):
		result.append("Ваше решение проблемы с Рашем оказывается лишь временной мерой. Возможно, стоит найти что-то более постоянное?")
	if(GM.main.getFlag("HypnokinkModule.RushSubdued", false)):
		result.append("С Рашем покончено раз и навсегда.")
	
	return result

func isVisible():
	return GM.main.getFlag("HypnokinkModule.KnowAboutRush", false)

func isCompleted():
	return GM.main.getFlag("HypnokinkModule.RushSubdued", false)

func isMainQuest():
	return false
