extends Module

func getFlags():
	return {
		"shyness": flag(FlagType.Number),
		"pawslut": flag(FlagType.Number),
		"corruption": flag(FlagType.Number),
		"chastity": flag(FlagType.Number),
		
		"busyUntilDay": flag(FlagType.Number),
		
		"s0happened": flag(FlagType.Bool),
		"s1happened": flag(FlagType.Bool),
		"s1day": flag(FlagType.Number),
		"s2happened": flag(FlagType.Bool),
		"s3happened": flag(FlagType.Bool),
		"s3day": flag(FlagType.Number),
		"s4happened": flag(FlagType.Bool),
		"s5happened": flag(FlagType.Bool),
		"s5day": flag(FlagType.Number),

		
		"s4Outcome": flag(FlagType.Text), #left offerself won lost
		"s5GaveMassage": flag(FlagType.Bool),
		"s6FirstTime": flag(FlagType.Bool),
		"s6AskedLeg": flag(FlagType.Bool),
		"s6AskedRisha": flag(FlagType.Bool),
		"s6AskedPaws": flag(FlagType.Bool),
		"s6AskedMood": flag(FlagType.Bool),
		"s6HeardStory": flag(FlagType.Bool),
		"s6GrabbedThroat": flag(FlagType.Bool),
		"s6HadRoughSex": flag(FlagType.Bool),
		"s6HadRoughSexCameInside": flag(FlagType.Bool),
		"s6ateday": flag(FlagType.Number),
		
		"corruptionBegan": flag(FlagType.Bool),
		"NoClothes": flag(FlagType.Bool),
		"wearsPortalPanties": flag(FlagType.Bool),
		"isLusty": flag(FlagType.Bool),
		"firstTimeWait": flag(FlagType.Bool),
		
		"gotChastityDenied": flag(FlagType.Bool),
		"cagedDay": flag(FlagType.Number),
		"cagedTotalDays": flag(FlagType.Number),
		"cagedAcceptStage": flag(FlagType.Number),
		
		"TentaclesPcHasFlower": flag(FlagType.Bool),
		"TentaclesArticaHasFlower": flag(FlagType.Bool),
		
		"nextReaction": flag(FlagType.Text), # t1won t1lost t1ran t1bully t2con t2noncon t3hap t4hap s1hap s2bul s2lost s2won s3hap d1hap d2won d2pc d3hap p1hap p2pc p2alone rahireturned
		
		"eventTentacles": flag(FlagType.Number),
		"eventSelfsuck": flag(FlagType.Number),
		"eventDildo": flag(FlagType.Number),
		"eventPortalPanties": flag(FlagType.Number),
		
		"lastQuestStarted": flag(FlagType.Bool),
		"LQTalkedOnce": flag(FlagType.Bool),
		"articaLostDreamcatcher": flag(FlagType.Bool),
		"lastQuestSawPorn": flag(FlagType.Bool),
		"lqLastNPC": flag(FlagType.Text),
		"lqClues": flag(FlagType.Number),
		"LQArticaGotDreamCatcher": flag(FlagType.Bool),
		"LQArticaGotBrainwashed": flag(FlagType.Bool),
		"rewardNotFirst": flag(FlagType.Bool),
		
		"gaveBirthTimes": flag(FlagType.Number),
		"canReactGaveBirth": flag(FlagType.Bool),
		"gaveBirthToEggs": flag(FlagType.Bool),
		"CurvyForm": flag(FlagType.Bool),
	}

func _init():
	id = "ArticaModule"
	author = "Rahi"
	
	scenes = [
		"res://Modules/ArticaModule/c0Shy/articaS0IntakeScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS1CellblockScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS2HungryScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS3CanteenScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS4CanteenScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS5CanteenPawsScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS6CanteenTalkScene.gd",
		"res://Modules/ArticaModule/c0Shy/articaS7FirstShowerScene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/articaTalkScene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Tease/articaCanteenTeaseScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Tease/articaCellTeaseScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Tease/articaSlaveGangbangScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Tease/articaMilkingInCellScene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexRideScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexBreedScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexPawjobScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexRopesScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexMutualPawjobScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Sex/articaSexHypnovisorScene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Other/articaShowerScene.gd",
		"res://Modules/ArticaModule/c1Corruption/Other/articaPlusRahiScene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventTentacles1Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventTentacles1dot5Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventTentacles2Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventTentacles3Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventTentacles4Scene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventSelfsuck1Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventSelfsuck2Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventSelfsuck3Scene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventDildo1Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventDildo2Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventDildo3Scene.gd",
		
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventPortalPanties1Scene.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/articaEventPortalPanties2Scene.gd",
		
		"res://Modules/ArticaModule/c2LastQuest/articaLastQuest1Scene.gd",
		"res://Modules/ArticaModule/c2LastQuest/articaSadTalkScene.gd",
		"res://Modules/ArticaModule/c2LastQuest/articaLastQuest2Scene.gd",
		"res://Modules/ArticaModule/c2LastQuest/articaLastQuestBadEndScene.gd",
		]
	characters = [
		"res://Modules/ArticaModule/ArticaCharacter.gd",
	]
	items = []
	events = [
		"res://Modules/ArticaModule/c1Corruption/ArticaTalkEvent.gd",
		"res://Modules/ArticaModule/c0Shy/ArticaIntroEvent.gd",
		"res://Modules/ArticaModule/c0Shy/ArticaShyTalkEvent.gd",
		"res://Modules/ArticaModule/c1Corruption/Event/ArticaGreenhousesStealFlowerEvent.gd",
		"res://Modules/ArticaModule/c2LastQuest/articaLQBadEndEvent.gd",
		"res://Modules/ArticaModule/c2LastQuest/articaLQGoodEndEvent.gd",
		"res://Modules/ArticaModule/c2LastQuest/ArticaLQInmatesHints.gd",
		"res://Modules/ArticaModule/c2LastQuest/ArticaSadTalkEvent.gd",
	]
	species = [
		"res://Modules/ArticaModule/IceJogauniSpecies.gd",
	]
	worldEdits = [
		"res://Modules/ArticaModule/c1Corruption/ArticaWorldEdit.gd",
	]
	quests = [
		"res://Modules/ArticaModule/c2LastQuest/ArticaLastQuest.gd",
	]

func startCaged():
	setFlag("ArticaModule.cagedDay", GM.main.getDays())

func endCaged():
	var cagedDay = getFlag("ArticaModule.cagedDay", -1)
	if(cagedDay > 0):
		var daysCaged = GM.main.getDays() - cagedDay
		increaseFlag("ArticaModule.cagedTotalDays", daysCaged)
	setFlag("ArticaModule.cagedDay", -1)

func getCagedDaysCurrently():
	var cagedDay = getFlag("ArticaModule.cagedDay", -1)
	if(cagedDay > 0):
		var daysCaged = GM.main.getDays() - cagedDay
		return daysCaged
	return 0

func getCagedDays():
	var recordedDaysCaged = getFlag("ArticaModule.cagedTotalDays", 0)
	var cagedDay = getFlag("ArticaModule.cagedDay", -1)
	if(cagedDay > 0):
		var daysCaged = GM.main.getDays() - cagedDay
		recordedDaysCaged += daysCaged
	return recordedDaysCaged

func resetFlagsOnNewDay():
	pass

func getShyness():
	return clamp(getFlag("ArticaModule.shyness", 1.0), 0.0, 1.0)

func removeShy(howMuch, showMessage = true):
	var oldShyness = getShyness()
	var newValue = clamp(oldShyness - howMuch, 0.0, 1.0)
	if(oldShyness != newValue && showMessage):
		if(newValue > oldShyness):
			GM.main.addMessage("Застенчивость Артики выросла до "+str(Util.roundF(newValue*100.0, 1))+"%!")
		else:
			GM.main.addMessage("Застенчивость Артики снизилась до "+str(Util.roundF(newValue*100.0, 1))+"%!")
	
	setFlag("ArticaModule.shyness", newValue)
	
func getPawSlut():
	return clamp(getFlag("ArticaModule.pawslut", 0.0), 0.0, 1.0)

func getPawslut():
	return getPawSlut()

func addPawslut(howMuch, showMessage = true):
	var oldPawslut = getPawSlut()
	var newValue = clamp(oldPawslut + howMuch, 0.0, 1.0)
	if(oldPawslut != newValue && showMessage):
		if(newValue > oldPawslut):
			GM.main.addMessage("Интерес Артики к лапкам вырос до "+str(Util.roundF(newValue*100.0, 1))+"%!")
		else:
			GM.main.addMessage("Интерес Артики к лапкам снизился до "+str(Util.roundF(newValue*100.0, 1))+"%!")
	
	setFlag("ArticaModule.pawslut", newValue)

func getCorruption():
	return clamp(getFlag("ArticaModule.corruption", 0.0), 0.0, 1.0)

func addCorruption(howMuch, showMessage = true):
	var oldCorruption = getCorruption()
	var newValue = clamp(oldCorruption + howMuch, 0.0, 1.0)
	if(oldCorruption != newValue && showMessage):
		if(newValue > oldCorruption):
			GM.main.addMessage("Развращенность Артики выросла до "+str(Util.roundF(newValue*100.0, 1))+"%!")
		elif(newValue < oldCorruption):
			GM.main.addMessage("Развращенность Артики снизилась до "+str(Util.roundF(newValue*100.0, 1))+"%!")
	
	setFlag("ArticaModule.corruption", newValue)

func triggerCorruption(howMuch, showMessage = true):
	addCorruption(howMuch, showMessage)
	setFlag("ArticaModule.isLusty", false)

func isSlut():
	return getCorruption() >= 0.4

func isVerySlut():
	return getCorruption() >= 0.8

func getChastity():
	return clamp(getFlag("ArticaModule.chastity", 0.0), 0.0, 1.0)

func addChastity(howMuch, showMessage = true):
	var oldChastity = getChastity()
	var newValue = clamp(oldChastity + howMuch, 0.0, 1.0)
	if(oldChastity != newValue && showMessage):
		if(newValue > oldChastity):
			GM.main.addMessage("Склонность Артики к целомудрию выросла до "+str(Util.roundF(newValue*100.0, 1))+"%!")
		else:
			GM.main.addMessage("Склонность Артики к целомудрию снизилась до "+str(Util.roundF(newValue*100.0, 1))+"%!")
	
	setFlag("ArticaModule.chastity", newValue)

func getShynessString():
	var theShyness = getShyness()
	
	if theShyness >= 0.8:
		return "Крайне застенчивая"
	elif 0.5 <= theShyness && theShyness < 0.8:
		return "Довольно застенчивая"
	elif 0.3 <= theShyness && theShyness < 0.5:
		return "Весьма застенчивая"
	elif 0.1 <= theShyness && theShyness < 0.3:
		return "Слегка застенчивая"
	else:
		return "Немного уверенная в себе"

func getPawslutString():
	var thePawSlut = getPawSlut()

	if thePawSlut >= 0.9:
		return "Артика просто помешана на лапках"
	elif 0.7 <= thePawSlut && thePawSlut < 0.9:
		return "Артика — фанатичная любительница лапок"
	elif 0.5 <= thePawSlut && thePawSlut < 0.7:
		return "Артика в диком восторге от игр с лапками"
	elif 0.3 <= thePawSlut && thePawSlut < 0.5:
		return "Артика интересуется лапками"
	elif 0.1 <= thePawSlut && thePawSlut < 0.3:
		return "Артика умеренно интересуется играми с лапками"
	elif 0.05 <= thePawSlut && thePawSlut < 0.1:
		return "Артику, кажется, слегка забавляют лапки"
	else:
		return "Артику явно не интересуют лапки"

func isLusty():
	return getFlag("ArticaModule.isLusty", false)

func makeLusty():
	setFlag("ArticaModule.isLusty", true)

func canTriggerWaitScene():
	return getNextWaitSceneInfo() != null

#		"TentaclesPcHasFlower": flag(FlagType.Bool),
#		"TentaclesArticaHasFlower": flag(FlagType.Bool),
#
#		"nextReaction": flag(FlagType.Text), #
#
#		"eventTentacles": flag(FlagType.Number),
#		"eventSelfsuck": flag(FlagType.Number),
#		"eventDildo": flag(FlagType.Number),
#		"eventPortalPanties": flag(FlagType.Number),

func getCorruptionEventScenes():
	var isAlexBusy:bool = GM.main.isEventBusy("AlexRynardBusy")
	var isElizaBusy:bool = GM.main.isEventBusy("ElizaBusy")
	
	return {
		"eventTentacles": [
			{
				"name": "Разведка теплиц",
				"scene": "articaEventTentacles1Scene",
				"canstart": !isElizaBusy,
				"hint": "Элиза Куинн должна быть свободна",
			},
			{
				"name": "Маленькие щупальца",
				"scene": "articaEventTentacles2Scene",
				"canstart": !isElizaBusy && getFlag("ArticaModule.TentaclesArticaHasFlower", false),
				"hint": ("Артике нужен особенный цветок. Укради его в оранжереях и подари ей! " if !getFlag("ArticaModule.TentaclesArticaHasFlower", false) else "")+("Элиза Куинн должна быть свободна" if isElizaBusy else ""),
			},
			{
				"name": "Огромные щупальца",
				"scene": "articaEventTentacles3Scene",
				"canstart": !isElizaBusy,
				"hint": "Элиза Куинн должна быть свободна",
			},
		],
		"eventSelfsuck": [
			{
				"name": "Первая йога",
				"scene": "articaEventSelfsuck1Scene",
			},
			{
				"name": "Конфликт в спортзале",
				"scene": "articaEventSelfsuck2Scene",
			},
			{
				"name": "Глубокий прогиб...",
				"scene": "articaEventSelfsuck3Scene",
			}
		],
		"eventDildo": [
			{
				"name": "Создание формы",
				"scene": "articaEventDildo1Scene",
			},
			{
				"name": "Дилдо-рояль!",
				"scene": "articaEventDildo2Scene",
			},
			{
				"name": "Большая награда",
				"scene": "articaEventDildo3Scene",
			}
		],
		"eventPortalPanties": [
			{
				"name": "Гипновизор",
				"scene": "articaEventPortalPanties1Scene",
				"canstart": !isAlexBusy,
				"hint": "Алекс Ринард должен быть свободен",
			},
			{
				"name": "Портальные трусики",
				"scene": "articaEventPortalPanties2Scene",
				"canstart": !isAlexBusy && !GlobalRegistry.getCharacter("artica").isWearingChastityCage(),
				"hint": ("Артика не должна быть в девайсе целомудрия. " if GlobalRegistry.getCharacter("artica").isWearingChastityCage() else "")+("Алекс Ринард должен быть свободен." if isAlexBusy else ""),
			}
		]
	}

func getNextWaitSceneInfo():
	var possible = []
	
	var scenesInfo = getCorruptionEventScenes()
	
	for eventID in scenesInfo:
		var eventScenes:Array = scenesInfo[eventID]
		var sceneAmount = eventScenes.size()
		var flagValue = int(getFlag("ArticaModule."+eventID, 0))
		
		if(flagValue >= sceneAmount):
			continue
		
		var theSceneInfo = eventScenes[flagValue]
		var canStart = (true if (!theSceneInfo.has("canstart")) else theSceneInfo["canstart"])
		
		if(canStart):
			possible.append([theSceneInfo["scene"], eventID])
		
	if(possible.size() == 0):
		return null
	
	return RNG.pick(possible)

func hasAnyWaitScenesLeft():
	var scenesInfo = getCorruptionEventScenes()
	
	for eventID in scenesInfo:
		var eventScenes:Array = scenesInfo[eventID]
		var sceneAmount = eventScenes.size()
		var flagValue = int(getFlag("ArticaModule."+eventID, 0))
		
		if(flagValue < sceneAmount):
			return true
	
	return false

func getBlockingReqs():
	var allblockingreqs = []
	
	var scenesInfo = getCorruptionEventScenes()
	
	for eventID in scenesInfo:
		var eventScenes:Array = scenesInfo[eventID]
		var sceneAmount = eventScenes.size()
		var flagValue = int(getFlag("ArticaModule."+eventID, 0))
		
		if(flagValue >= sceneAmount):
			continue
		
		var theSceneInfo = eventScenes[flagValue]
		var canStart = (true if (!theSceneInfo.has("canstart")) else theSceneInfo["canstart"])
		
		if(!canStart):
			allblockingreqs.append(theSceneInfo["hint"])
		
	return Util.join(allblockingreqs, "\n")

#		"eventTentacles": flag(FlagType.Number),
#		"eventSelfsuck": flag(FlagType.Number),
#		"eventDildo": flag(FlagType.Number),
#		"eventPortalPanties": flag(FlagType.Number),
func getReplayMenuScenes():
	var possible = {}
	
	var scenesInfo = getCorruptionEventScenes()
	
	var eventIDToName = {
		"eventTentacles": "Tentacles",
		"eventSelfsuck": "Self-sucking",
		"eventDildo": "Большой собачий дилдо",
		"eventPortalPanties": "Подопытный",
	}
	for eventID in scenesInfo:
		possible[eventID] = {
			"name": eventIDToName[eventID],
			"scenes": [],
		}
		
		var eventScenes:Array = scenesInfo[eventID]
		#var sceneAmount = eventScenes.size()
		var flagValue = int(getFlag("ArticaModule."+eventID, 0))
		
		var _i = 0
		for theSceneInfo in eventScenes:
			var canStart = (true if (!theSceneInfo.has("canstart")) else theSceneInfo["canstart"])
			
			if(!canStart):
				possible[eventID]["scenes"].append({
					"name": theSceneInfo["name"],
					"desc": "Эту сцену нельзя повторить!\n\n"+theSceneInfo["hint"],
					"canstart": canStart,
					"scene": theSceneInfo["scene"],
				})
			elif(flagValue <= _i):
				possible[eventID]["scenes"].append({
					"name": theSceneInfo["name"],
					"desc": "Эта сцена еще не наступила",
					"canstart": false,
					"scene": theSceneInfo["scene"],
				})
			elif(canStart):
				possible[eventID]["scenes"].append({
					"name": theSceneInfo["name"],
					"desc": "Повторить эту сцену",
					"canstart": canStart,
					"scene": theSceneInfo["scene"],
				})

			_i += 1
		
	return possible

func getReactionFor(_topic):
	if(_topic == "rahireturned"):
		return "С-спасибо тебе еще раз.. Я н-никогда не забуду то, что ты сделал.. Т-та к-кошечка.. Р-Рахи?.. Я н-не злюсь на нее.. Н-но от ее взгляда мне с-становится как-то странно.."
	
	if(_topic == "t1won"):
		return "Ты реально проучил ту хаски.. ха-ха.. Еще раз спасибо, сама бы я этот цветок точно не сорвала.."
	if(_topic == "t1lost"):
		return "Так жаль, что мне не удалось заполучить тот цветок.. Но всё равно спасибо.."
	if(_topic == "t1ran"):
		return "Та хаски явно что-то замышляла против меня.. Интересно, что именно.. Жаль, что я оставила цветок там.."
	if(_topic == "t1bully"):
		return "Некоторые охранники такие злюки.. Их электродубинки такие.. с-страшные.. ммм.. мм.."
	if(_topic == "t2con"):
		return "С-советую быть осторожнее возле теплиц.. Н-некоторые растения там разрослись больше человека.."
	if(_topic == "t2noncon"):
		return "С-советую быть осторожнее возле теплиц.. Н-некоторые растения выросли такими огромными, что могут.. да.. ммм.."
	if(_topic == "t3hap"):
		return "Эм.. Мой живот не кажется больше обычного?.. К-кажется, я с-сегодня переела.. д-да.. мм.."
	if(_topic == "t4hap"):
		return "По крайней мере, живот уже не такой раздутый.. Было н-неловко, когда люди пялились на меня, думая, что я беременна.. М-мне любопытно, а яйца на вк-кус.. н-нормальные?.."
	if(_topic == "s1hap"):
		return "У меня есть прогресс, но... я всё ещё не такая уж гибкая... Думаю, если ещё немного потренироваться, я смогу принять всё до конца. М-м... ну, ты понимаешь... получить полный опыт... э-э... йога-опыт... д-да... йога..."
	if(_topic == "s2bul"):
		return "Сегодня я встретила парочку злюк... Но мне к-кажется, это было... бл-благословением под маской неудачи?.. Н-не переживай об этом..."
	if(_topic == "s2lost"):
		return "С-спасибо, что попытался меня спасти... П-прости, что всё так вышло..."
	if(_topic == "s2won"):
		return "С-спасибо за помощь, п-правда... Думаю, я всё ещё могу... стать лучше. Хочу посмотреть, как далеко я смогу зайти... н-ну, ты понимаешь..."
	if(_topic == "s3hap"):
		return "Ты, наверное, д-думаешь, что я... ш-шалава... Просто... н-ну... э-э... м-мне и п-правда нечего п-против этого сказать..."
	if(_topic == "d1hap"):
		return "Сегодня я встретила одну очень полезную девушку... Н-не все здесь такие злые... Ой, в смысле... т-ты ведь не злая... к-конечно же... ха-ха... Но та девчонка такая с-счастливая... интересно, н-не связано ли это с её... наготой... хах."
	if(_topic == "d2won"):
		return "Я уж г-готова была с-сдаться... Но ты п-помог мне... преодолеть это... мм-м... с-спасибо, что помог мне сохранить мою... в смысле... э-э... ой... выиграть ту игрушку, хах..."
	if(_topic == "d2pc"):
		return "Я д-думала, что п-потеряю свою... в смысле... э-э... и-игрушку... которую не д-должна была получить... Я думала... М-м... ой... с-спасибо..."
	if(_topic == "d3hap"):
		return "Ноги всё ещё дрожат... Т-ты даже не представляешь, как это было хорошо... ммм... э-эй, забудь!.. ха-ха... Но эта ш-штучка реально классная... боги, я болтаю как настоящая шлюха..."
	if(_topic == "p1hap"):
		return "Эм... хай... ха-ха... я такая шлюха, когда дело доходит до гипноза... Да-а-а... п-погоди... что я только что сказала?.. боги... Что я тебе только что выдала?.. У м-меня в голове всё немного перемешалось, н-не обращай внимания, если я несу какую-то ерунду..."
	if(_topic == "p2pc"):
		return "М-мне сказали, что я могу о-оставить трусики себе... О-они такие... классные... П-пока не верится, что такое вообще в-возможно... Х-хочешь, я их надену?.."
	if(_topic == "p2alone"):
		return "Эй... эм... я нашла классные трусики... они такие... ну... сложно объяснить... они вроде как прозрачные... но не совсем... скорее... тактильные?.. Х-хочешь, я их примерю?.. С ними было о-очень весело... если не сказать слишком мягко..."
	
	return ""

func getReaction():
	# Gave birth reaction
	if(getFlag("ArticaModule.canReactGaveBirth")):
		var gaveBirthReaction = ""
		var gaveBirthAmount = getFlag("ArticaModule.gaveBirthTimes", 0)
		
		if(gaveBirthAmount <= 1):
			gaveBirthReaction = "О, привет... Я... я только что их получила... Н-никогда не думала, что стану мамочкой... ой... Г-говорили, что я не могу их оставить... м-может, так даже лучше..."
		elif(gaveBirthAmount <= 2):
			gaveBirthReaction = "П-привет. У меня появилось ещё... щенят... боги... Это становится всё проще, но я всё ещё... не уверена. Это так с-странно..."
		elif(gaveBirthAmount <= 3):
			gaveBirthReaction = "П-привет.. Я.. я с-снова родила.. Кажется, я начинаю к этому привыкать. Это б-больно.. но мне.. мне вроде как нравится видеть своих щенков в п-первый раз.. с-слышать их милые голоса.. Это делает меня.. с-странной?"
		elif(gaveBirthAmount <= 4):
			gaveBirthReaction = "Приве-етик.. У меня еще одно потомство.. Начинаю чувствовать, что.. может, именно для этого я и создана. Это.. в каком-то смысле даже будоражит.. ха-ха.."
		elif(gaveBirthAmount <= 5):
			gaveBirthReaction = "Привет. У меня.. у меня еще больше.. щенков.. Ч-честно говоря.. теперь я не могу сдержать восторга. Обожаю смотреть на них, чувствовать, как они растут внутри меня. Это.. это вызывает зависимость.."
		elif(gaveBirthAmount <= 6):
			gaveBirthReaction = "Приветики.. Все больше и больше щенков.. Кажется.. кажется, мне это реально начинает нравиться. Быть наполненной, рожать. Это.. это то, чего я жажду.. Когда же ты.. мм.."
		elif(gaveBirthAmount <= 7):
			gaveBirthReaction = "Приве-етик.. Я.. я не могу перестать думать об этом. Обожаю быть беременной, чувствовать их внутри себя. Хочу е-еще. Мне н-нужно больше.. П-пожалуйста?.."
		elif(gaveBirthAmount <= 8):
			gaveBirthReaction = "Я на этом реально подсела.. Обожаю быть сучкой для размножения, набитой щенками. Хочу, чтобы меня использовали снова и снова.. Х-хочу, чтобы мою п-пипку набивали до краев в-вирильным с-спермом.. Не могу перестать об этом думать.."
		elif(gaveBirthAmount <= 9):
			gaveBirthReaction = "Приветики.. боги.. еще одно потомство. Обожаю быть фабрикой котят, сучкой для размножения, производительницей щенков.. П-пожалуйста, е-еще.. Хочу, чтобы меня наполняли, чтобы я р-рожала снова и снова.."
		else:
			gaveBirthReaction = RNG.pick([
				"Приве-етик.. Снова р-родила деток.. и мне всё ещё н-нравится. Обожаю быть фабрикой щенков, шлюхой для размножения. Жажду новых оплодотворений.. мне это н-нужно. Пожалуйста, сделай меня своей сучкой для вязки навеки..",
				"П-приве-етик.. Я столько раз р-рожала.. Я такая.. р-размножающаяся шлюшка.. это с-стало моим предназначением..",
				"Приветик.. Я уже сбилась со счёта, с-сколько раз я р-родила к этому м-моменту.. Точно б-больше десяти.. Н-не могу с собой ч-что поделать.. х-хочу ещё..",
			])
		
		setFlag("ArticaModule.canReactGaveBirth", false)
		return gaveBirthReaction
	
	# Corruption event reaction
	var customReaction = getReactionFor(getFlag("ArticaModule.nextReaction", ""))
	if(customReaction != ""):
		setFlag("ArticaModule.nextReaction", "")
		return customReaction
	
	# Visibly pregnant reaction
	if(GlobalRegistry.getCharacter("artica").isVisiblyPregnant()):
		#var gaveBirthReaction = ""
		var gaveBirthAmount = getFlag("ArticaModule.gaveBirthTimes", 0)
		
		if(GlobalRegistry.getCharacter("artica").isVisiblyPregnantFromPlayer()):
			if(gaveBirthAmount <= 0):
				return RNG.pick([
					"Ох.. п-привет.. Кажется.. я б-беременна.. от тебя.. Раньше я н-ни разу не б-была беременной..",
					"Привет.. Я.. я.. б-беременна.. кажется, от т-тебя.. ч-что же мне делать..",
					"П-привет.. Скоро я с-стану м-мамочкой.. в п-первый раз.. Мне с-страшно..",
				])
			elif(gaveBirthAmount <= 3):
				return RNG.pick([
					"П-привет.. Я снова беременна. Это.. всё ещё пугает, но я п-привыкаю.. Они там так много дёргаются, а мои.. мои соски такие чувствительные..",
					"Моё тело так сильно меняется.. М-моя грудь выглядит такой надутой.. а п-живот.. такой большой.. с твоим п-потомком..",
					"Мой ж-живот такой огромный.. я ед-едва могу д-двигаться.. ах.. они иногда п-пинаются внутри..",
				])
			elif(gaveBirthAmount <= 6):
				return RNG.pick([
					"Я.. кажется, мне начинает н-нравиться это ощущение внутри меня..",
					"Эй... во мне снова полно твоих щенков. Ха-ха... Я... я просто не могу сдержать возбуждения. Кажется, мне начинает н-нравиться это чувство...",
					"М-мои соски так чешутся и они такие ч-чувствительные. Думаю... думаю, я начинаю к этому т-тяготеть..."
				])
			else:
				return RNG.pick([
					"Пожалуйста, сделай меня своей сукой для разведения... чтобы я всегда была полна твоих щенков...",
					"Я о-обожаю, когда меня набивают до отказа... и о-обожаю вынашивать твой помет...",
					"С-смотри... это т-твои щенки внутри меня...",
				])
		else:
			if(gaveBirthAmount <= 0):
				return RNG.pick([
					"Ох... п-привет... Кажется... я б-беременна... и даже не з-знаю от к-кого... Раньше я н-ни разу не б-беременела...",
					"Привет... Я... я... б-беременна... от к-кого-то... я д-даже не з-знаю... ч-что же мне делать...",
					"П-привет.. Скоро я с-стану м-мамочкой.. в п-первый раз.. Мне с-страшно..",
				])
			elif(gaveBirthAmount <= 3):
				return RNG.pick([
					"П-привет.. Я снова беременна. Это.. всё ещё пугает, но я п-привыкаю.. Они там так много дёргаются, а мои.. мои соски такие чувствительные..",
					"Моё тело так сильно меняется... М-моя грудь выглядит такой распухшей... а мой живот... такой большой... в нем ч-чей-то помет...",
					"М-мой живот такой огромный... я е-едва могу д-двигаться... ах... иногда они т-толчками шевелятся внутри... и я д-даже не з-знаю отца...",
				])
			elif(gaveBirthAmount <= 6):
				return RNG.pick([
					"Я.. кажется, мне начинает н-нравиться это ощущение внутри меня..",
					"Эй... во мне снова полно щенков. Ч-чьих-то... Ха-ха... Я... просто не могу сдержать возбуждения. Кажется, мне начинает н-нравиться это чувство...",
					"М-мои соски так чешутся и они такие ч-чувствительные. Думаю... думаю, я начинаю к этому т-тяготеть..."
				])
			else:
				return RNG.pick([
					"Я о-очень люблю быть сучкой для разведения... вечно набитой щенками...",
					"Я о-обожаю, когда меня набивают до отказа... и о-обожаю вынашивать помёт за помётом...",
					"Я н-ношу чьих-то щенков... о-ощущения просто божественные...",
				])
	
	# Corruption based, last resort
	var theCorruption = getCorruption()
	if(theCorruption > 0.8):
		return RNG.pick([
			"Привет...",
			"Приветик... Надеюсь, у тебя всё путём, ха-ха.",
			"Привет...",
			"Приветики...",
		])
	elif(theCorruption > 0.4):
		return RNG.pick([
			"О, привет... Всегда рада тебя видеть...",
			"Здравствуй...",
			"Приветик...",
		])
	else:
		return RNG.pick([
			"Oh.. hey..",
			"Здравствуй...",
			"Эй...",
		])

func getLastQuestHints():
	return [
		"Кто-то украл ловца снов. И для Артики это не просто потеря.",
		"Ловца снов украл какой-то воришка прямо на Артике, пока она была в нём.",
		"Ловца снов украл кто-то из заключённых.",
		"Вор, укравший ловца снов, одет в стандартную робу общего блока.",
		"У вора, укравшего ловца снов, коричневый мех и голубые глаза.",
		"Вор, укравший ловца снов, — это кошка.",
		"У вора, укравшего ловца снов, волосы собраны в хвост.",
		"Вор, укравший ловца снов, — это девчонка.",
	]
