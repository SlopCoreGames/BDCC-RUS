extends Module

func getFlags():
	return {
		"Jacki_FirstTimeEncountered": flag(FlagType.Bool),
		"Jacki_FirstTimeWasMean": flag(FlagType.Bool),
		"Jacki_FirstTimeWasMeanPinned": flag(FlagType.Bool),
		"Jacki_FirstTimeWasKind": flag(FlagType.Bool),
		
		"BathroomBulliesSceneWillHappen": flag(FlagType.Bool),
		"BathroomBulliesSceneHappened": flag(FlagType.Bool),
		"BathroomBulliesWon": flag(FlagType.Bool),
		"BathroomBulliesLost": flag(FlagType.Bool),
		"BathroomBulliesSubmitted": flag(FlagType.Bool),
		"BathroomBulliesPayed": flag(FlagType.Bool),
		"BathroomBulliesBecameCumToilet": flag(FlagType.Bool),
		"BathroomBulliesBecamePissToilet": flag(FlagType.Bool),
		
		"Jacki_ContentDisabled": flag(FlagType.Bool),
		"Jacki_PCKnowsName": flag(FlagType.Bool),
		
		"Jacki_StocksSceneHappened": flag(FlagType.Bool),
		"Jacki_StocksPunishedByPC": flag(FlagType.Bool),
		"Jacki_StocksFuckedByPC": flag(FlagType.Bool),
		"Jacki_StocksFingeredByPC": flag(FlagType.Bool),
		"Jacki_StocksPCLied": flag(FlagType.Bool),
		"Jacki_StocksSavedByPC": flag(FlagType.Bool),
		"Jacki_StocksPCWonFight": flag(FlagType.Bool),
		"Jacki_StocksPCLostFight": flag(FlagType.Bool),
		"Jacki_StocksPCLostFightAndWatched": flag(FlagType.Bool),
		
		"Jacki_ch2IntroSceneHappened": flag(FlagType.Bool),
		"Jacki_ch2GotEnslaved": flag(FlagType.Bool),
		"Jacki_ch2SlaveText": flag(FlagType.Text),
		"Jacki_ch2GotPussyFreed": flag(FlagType.Bool),
		"Jacki_ch2GotExtraPiercings": flag(FlagType.Bool),
		"Jacki_punchingBagSceneHappened": flag(FlagType.Bool),
		"Jacki_urinalSceneHappened": flag(FlagType.Bool),
		
		"jackiCorruption": flag(FlagType.Number),
		"jackiAnger": flag(FlagType.Number),
		"jackiLust": flag(FlagType.Number),
		
		"jackiSkillButtslut": flag(FlagType.Number),
		"jackiSkillSounding": flag(FlagType.Number),
		"jackiSkillWhore": flag(FlagType.Number),
		"jackiSkillWatersports": flag(FlagType.Number),
		
		"jackiReceivedBra": flag(FlagType.Bool),
		"jackiReceivedShorts": flag(FlagType.Bool),
		"jackiReceivedHorsecockDildo": flag(FlagType.Bool),
		"jackiGotFollowed": flag(FlagType.Bool),
		"jackiFirstTimeBlocked": flag(FlagType.Bool),
		"jackiBusyUntil": flag(FlagType.Number),
	}

func _init():
	id = "JackiModule"
	author = "Rahi"
	
	scenes = [
		"res://Modules/JackiModule/Ch1/JackiFirstEncounterScene.gd",
		"res://Modules/JackiModule/Ch1/JackiBulliesInBathroomScene.gd",
		"res://Modules/JackiModule/Ch1/JackiStuckInStocksScene.gd",
		
		"res://Modules/JackiModule/Ch2/jackiCh2s1Intro.gd",
		"res://Modules/JackiModule/Ch2/jackiCh2s2GymScene.gd",
		"res://Modules/JackiModule/Ch2/jackiPunchingBagScene.gd",
		"res://Modules/JackiModule/Ch2/jackiUrinalScene.gd",
		]
	characters = [
		"res://Modules/JackiModule/JackiCharacter.gd",
	]
	items = []
	events = [
		"res://Modules/JackiModule/Ch1/JackiFirstEncounterEvent.gd",
		"res://Modules/JackiModule/Ch1/JackiBulliesInBathroomEvent.gd",
		"res://Modules/JackiModule/Ch1/JackiStuckInStocksEvent.gd",
		"res://Modules/JackiModule/Ch2/JackiGymTalkEvent.gd",
	]
	quests = [
	]

func resetFlagsOnNewDay():
	if(getFlag("JackiModule.BathroomBulliesSceneWillHappen")):
		setFlag("JackiModule.BathroomBulliesSceneWillHappen", false)


func addCorruption(howMuch, showMessage = true):
	howMuch /= 100.0
	var currentCorruption = getFlag("JackiModule.jackiCorruption", 0.0)
	var oldCor = currentCorruption
	
	currentCorruption += howMuch
	if(howMuch > 0.0 && currentCorruption > 1.0):
		currentCorruption = 1.0
		
		addAnger(-howMuch*2.0*100.0, showMessage)
	if(howMuch < 0.0 && currentCorruption < 0.0):
		currentCorruption = 0.0
	
	setFlag("JackiModule.jackiCorruption", currentCorruption)
	
	if(showMessage):
		var diff = currentCorruption - oldCor
		if(diff > 0.0):
			GM.main.addMessage("Уровень развращенности Джеки вырос до "+str(Util.roundF(currentCorruption * 100.0, 1))+"%")
		elif(diff < 0.0):
			GM.main.addMessage("Уровень развращенности Джеки снизился до "+str(Util.roundF(currentCorruption * 100.0, 1))+"%")

func addLust(howMuch, showMessage = true):
	howMuch /= 100.0
	var currentLust = getFlag("JackiModule.jackiLust", 0.0)
	var oldLust = currentLust
	
	currentLust += howMuch
	if(howMuch > 0.0 && currentLust > 1.0):
		currentLust = 1.0
		
		addCorruption(howMuch/2.0*100.0, showMessage)
	if(howMuch < 0.0 && currentLust < 0.0):
		currentLust = 0.0
	
	setFlag("JackiModule.jackiLust", currentLust)
	
	if(showMessage):
		var diff = currentLust - oldLust
		if(diff > 0.0):
			GM.main.addMessage("Уровень похоти Джеки вырос до "+str(Util.roundF(currentLust * 100.0, 1))+"%")
		elif(diff < 0.0):
			GM.main.addMessage("Уровень похоти Джеки снизился до "+str(Util.roundF(currentLust * 100.0, 1))+"%")


func addAnger(howMuch, showMessage = true):
	howMuch /= 100.0
	var currentAnger = getFlag("JackiModule.jackiAnger", 0.0)
	if(currentAnger < -0.1 && howMuch > 0.0):
		howMuch *= 2.0
	var currentActualCorruption = clamp(getFlag("JackiModule.jackiCorruption", 0.0), 0.0, 1.0)
	var oldAnger = currentAnger
	
	if(howMuch > 0):
		howMuch *= (1.0 - currentActualCorruption)
	
	currentAnger += howMuch
	if(howMuch > 0.0 && currentAnger > 1.0):
		currentAnger = 1.0
	if(howMuch < 0.0 && currentAnger < -1.0):
		currentAnger = -1.0
	
	setFlag("JackiModule.jackiAnger", currentAnger)
	
	if(showMessage):
		var diff = currentAnger - oldAnger
		
		if(currentAnger > 0.0):
			if(diff > 0.0):
				GM.main.addMessage("Уровень гнева Джеки вырос до "+str(Util.roundF(currentAnger * 100.0, 1))+"%")
			elif(diff < 0.0):
				GM.main.addMessage("Уровень гнева Джеки снизился до "+str(Util.roundF(currentAnger * 100.0, 1))+"%")
		else:
			if(diff < 0.0):
				GM.main.addMessage("Уровень доброты Джеки вырос до "+str(Util.roundF(-currentAnger * 100.0, 1))+"%")
			elif(diff > 0.0):
				GM.main.addMessage("Уровень доброты Джеки снизился до "+str(Util.roundF(-currentAnger * 100.0, 1))+"%")

func shouldWearSportsBra():
	return getFlag("JackiModule.jackiReceivedBra", false)

func shouldWearSportsShorts():
	return getFlag("JackiModule.jackiReceivedShorts", false)

func shouldUnderwear():
	return shouldWearSportsBra() && shouldWearSportsShorts()

func doBetray():
	var currentKind = -getFlag("JackiModule.jackiAnger", 0.0)
	
	if(currentKind > 0.0):
		addCorruption(currentKind * 60)
		addAnger(500)
		
		return true
	return false

func getSkillScore(skillID):
	return Util.mini(Util.maxi(int(getFlag("JackiModule."+str(skillID), 0)), 0), 7)

func advanceSkill(skillID, maxLevel = 7):
	if(getFlag("JackiModule."+str(skillID), 0) < maxLevel):
		increaseFlag("JackiModule."+str(skillID), 1)
	return true

func degradeSkill(skillID, howMuchRemove = 1):
	var currentSkill = getFlag("JackiModule."+str(skillID), 0)
	currentSkill -= howMuchRemove
	if(currentSkill < 0):
		currentSkill = 0
	setFlag("JackiModule."+str(skillID), currentSkill)

func getButtTightness():
	var buttscore = getSkillScore("jackiSkillButtslut")
	if(buttscore <= 0):
		return "virgin-tight"
	if(buttscore <= 1):
		return "невероятно узкая"
	if(buttscore <= 2):
		return "довольно узкая"
	if(buttscore <= 3):
		return "скорее узкая"
	if(buttscore <= 4):
		return "слегка поношенная"
	if(buttscore <= 5):
		return "очень растянутая и поношенная"
	if(buttscore <= 6):
		return "полностью растянутая"
	return "невероятно растянутая"

func makeJackiBusy(howManyDays = 1):
	setFlag("JackiModule.jackiBusyUntil", GM.main.getDays() + howManyDays)

func getAngerText():
	var currentAnger = getFlag("JackiModule.jackiAnger", 0.0)
	
	if(currentAnger < 0.1 && currentAnger >= -0.1):
		return "безразлична к тебе"
	elif(currentAnger > 0.0):
		if(currentAnger < 0.15):
			return "слегка раздражена"
		if(currentAnger < 0.25):
			return "раздражена тобой"
		if(currentAnger < 0.35):
			return "сильно раздражена"
		if(currentAnger < 0.45):
			return "злится на тебя"
		if(currentAnger < 0.55):
			return "в бешенстве от тебя"
		if(currentAnger < 0.65):
			return "презирает тебя"
		if(currentAnger < 0.75):
			return "в тебе нет ничего, что бы ей нравилось"
		if(currentAnger < 0.85):
			return "лучше бы жила на другой планете, лишь бы подальше от тебя"
		if(currentAnger < 0.95):
			return "почти ненавидит тебя"
		return "ненавидит тебя"
	else:
		if(currentAnger > -0.15):
			return "ты ей в целом не противен"
		if(currentAnger > -0.25):
			return "ты ей вроде как нравишься"
		if(currentAnger > -0.35):
			return "ты ей нравишься"
		if(currentAnger > -0.45):
			return "ты ей очень нравишься"
		if(currentAnger > -0.55):
			return "ей приятно твое общество"
		if(currentAnger > -0.65):
			return "считает тебя очень милым"
		if(currentAnger > -0.75):
			return "обожает тебя"
		if(currentAnger > -0.85):
			return "ценит вашу дружбу"
		if(currentAnger > -0.95):
			return "дорожит тобой"
		return "ты ей симпатичен"
			
func getLustText():
	var currentLust = getFlag("JackiModule.jackiLust", 0.0)
	
	if(currentLust <= 0.01):
		return "никакого вожделения ни к кому"
	if(currentLust <= 0.1):
		return "едва заинтригована"
	if(currentLust <= 0.2):
		return "легкое любопытство"
	if(currentLust <= 0.3):
		return "зарождающийся интерес к пошлостям"
	if(currentLust <= 0.4):
		return "растущее влечение к сексу"
	if(currentLust <= 0.5):
		return "одержимость сексом"
	if(currentLust <= 0.6):
		return "сильное желание, чтобы ее трахнули"
	if(currentLust <= 0.7):
		return "неистовая жажда"
	if(currentLust <= 0.8):
		return "всепоглощающая похоть"
	if(currentLust <= 0.9):
		return "всепоглощающая страсть"
	return "полное обожание"

func getCorruptionText():
	var currentLust = getFlag("JackiModule.jackiCorruption", 0.0)
	
	if(currentLust <= 0.01):
		return "pure"
	if(currentLust <= 0.1):
		return "практически чистая"
	if(currentLust <= 0.2):
		return "теряющая невинность"
	if(currentLust <= 0.3):
		return "внутренняя борьба"
	if(currentLust <= 0.4):
		return "легкая деградация"
	if(currentLust <= 0.5):
		return "любит пожестче"
	if(currentLust <= 0.6):
		return "сильная моральная деградация"
	if(currentLust <= 0.7):
		return "почти настоящая шлюха"
	if(currentLust <= 0.8):
		return "любопытная шлюха"
	if(currentLust <= 0.9):
		return "жадная шлюха"
	return "полная шлюха"
