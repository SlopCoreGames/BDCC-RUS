extends QuestBase

func _init():
	id = "PortalPantiesQuest"

func getVisibleName():
	return "Трусики из блюспейса"

func getProgress():
	var result = []
	
	result.append("Найди обычные женские трусики и принеси их Алексу Ринарду. Он сказал, что их можно купить в прачечной.")
	
	if(GM.main.getFlag("PortalPantiesModule.Panties_GavePantiesToAlex")):
		result.append("Теперь на тебе портативные трусики. Алекс сказал, что за каждый тест, который они с тобой проведут, ты будешь получать по одному кредиту.")
	
	if(GM.main.getFlag("PortalPantiesModule.Panties_PcDenied")):
		result.append("Ты отклонила его предложение.")
	
	if(GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsGotStolen")):
		result.append("Тебя трахнули прямо через портативные трусики! Тебе нужно вернуться к Алексу и выяснить, как такое случилось.")
	
	if(GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsAskedAlex")):
		result.append("Каким-то образом флешлайты с твоими интимными частями украли! Алекс сказал, что их можно поискать в жилом блоке, рядом с камерами.")
	
	if(GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsFoundFleshlights")):
		result.append("Ты раздобыла флешлайты! Верни их Алексу, чтобы он разблокировал твои портативные трусики.")
	
	return result

func isVisible():
	return GM.main.getFlag("PortalPantiesModule.Panties_AskedAlex")

func isCompleted():
	return GM.main.getFlag("PortalPantiesModule.Panties_PcDenied") || GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex")

func isMainQuest():
	return false
