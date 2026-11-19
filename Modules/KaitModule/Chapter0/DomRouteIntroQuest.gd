extends QuestBase

func _init():
	id = "DomRouteIntroQuest"

func getVisibleName():
	return "Умение постоять за себя (Рут Дома)"

func getProgress():
	var result:Array = []
	
	result.append("К тебе подошла Кейт, снежный барс цвета сирени. Похоже, она хочет сместить капитана и ищет людей, готовых ей помочь.")
	result.append("Кейт хочет, чтобы ты нашел её на подземной арене, которая спрятана где-то неподалеку от спортзала.")
	
	var amountWon:int = GlobalRegistry.getModule("FightClubModule").getAmountFightersWon()
	
	if(getFlag("KaitModule.talkedKaitArena")):
		result.append("Ты встретил Кейт на подземной арене. Она хочет, чтобы ты доказал свою силу, выиграв 3 боя на арене!\nНа данный момент побед: "+str(amountWon))
	
		if(amountWon >= 3 && !getFlag("KaitModule.joinedTeam")):
			result.append("Кейт готова предложить тебе вступить в команду! Поговори с ней.")
	
	if(getFlag("KaitModule.joinedTeam")):
		if(GlobalRegistry.getModule("RahiModule").isInSlavery()):
			result.append("Найди Рахи и завербуй её! Скорее всего, она у тебя в камере.")
		else:
			result.append("Найди Рахи и завербуй её! Скорее всего, она где-то рядом с колодками.")
	
	if(getFlag("KaitModule.caughtRahi")):
		result.append("Рахи твоя! Теперь тебе осталось только завербовать её.")
	
	return result

func isVisible():
	if(getFlag("KaitModule.joinedTeam")):
		return true
	if(GM.main.hasCommittedToMainRoute()):
		return false
	return getFlag("KaitModule.gotMetByKait") || getFlag("KaitModule.talkedKaitArena")

func isCompleted():
	return getFlag("KaitModule.introCompleted")

func isMainQuest():
	return true
