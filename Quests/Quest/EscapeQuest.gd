extends QuestBase
class_name EscapeQuest

func _init():
	id = "EscapeQuest"

func getVisibleName():
	return "Побег из тюрьмы"

func getProgress():
	var result = []
	
	result.append("Похоже, ты застрял здесь надолго. Стоит попробовать выяснить, реально ли вообще сбежать из этой космической тюрьмы.")
	
	if(GM.main.getModuleFlag("TaviModule", "Tavi_ToldHowToEscape")):
		result.append("(Смена маршрута) Тави говорит, что поможет тебе сбежать, если ты найдешь способ добраться до Капитана и заставишь его снять твой ошейник.")
	elif(GM.main.getModuleFlag("TaviModule", "Tavi_IntroducedTo")):
		result.append("(Смена маршрута) Ты можешь найти Тави возле шахт и узнать, поможет ли она тебе сбежать из этой тюрьмы.")
	if(GM.main.getFlag("KaitModule.talkedKaitArena")):
		result.append("(Маршрут Доминанта) Похоже, Кейт собирает команду, чтобы попытаться подчинить себе всю тюрьму!")
	elif(GM.main.getFlag("KaitModule.gotMetByKait")):
		result.append("(Маршрут Доминанта) Ты встретил Кейт — снежную леопардицу, которую, кажется, интересуют только те заключенные, что умеют драться.")
	
	return result

func isVisible():
	return !GM.main.hasCommittedToMainRoute() || isCompleted()

func isCompleted():
	return getFlag("TaviModule.Ch7CaptainSceneHappened")

func isMainQuest():
	return true
