extends QuestBase

func _init():
	id = "KidlatQuest"

func getVisibleName():
	return "Лавка чудес Кидлата"

func getProgress():
	var result = []
	
	var curPurAm:int = getFlag("DrugDenModule.KidlatItemsBought", 0)
	var s1hap:bool = getFlag("DrugDenModule.Kidlat1Hap", false)
	var s2hap:bool = getFlag("DrugDenModule.Kidlat2Hap", false)
	var s3hap:bool = getFlag("DrugDenModule.Kidlat3Hap", false)
	var s4hap:bool = getFlag("DrugDenModule.Kidlat4Hap", false)
	var s5hap:bool = getFlag("DrugDenModule.Kidlat5Hap", false)
	var s6hap:bool = getFlag("DrugDenModule.Kidlat6Hap", false)
	var s6knows:bool = getFlag("DrugDenModule.Kidlat6Knows", false)
	var s7hap:bool = getFlag("DrugDenModule.Kidlat7Hap", false)
	var s7knows:bool = getFlag("DrugDenModule.Kidlat7Knows", false)
	var s8hap:bool = getFlag("DrugDenModule.Kidlat8Hap", false)
	
	var whatDoStr:String = ""
	
	if(s1hap && !s2hap):
		if(curPurAm < 3):
			var diff:int = 3 - curPurAm
			whatDoStr = "Buy "+str(diff)+" еще предметов"+("s" if diff != 1 else "")+" у нее, чтобы продвинуться по сюжету."
		else:
			whatDoStr = "Встреться с ней во время [b]нового[/b] рейда в притон, чтобы продвинуться по сюжету."
	
	result.append("Вы нашли Кидлат — кошечку, которая держит свою лавочку в притоне. На данный момент вы купили у неё "+str(curPurAm)+" item"+("s" if curPurAm != 1 else "")+" товаров.")
	
	if(s2hap && !s3hap):
		whatDoStr = ""
		result.append("Какой-то торчок в притоне украл форму Кидлат! Найдите её, чтобы продвинуться по сюжету. Скорее всего, вы узнаете кое-что полезное, если изобьёте одного из главных наркоманов.")
	
	if(s3hap):
		result.append("Вы вернули Кидлат её форму! Теперь она будет продавать более качественные вещи.")
	
		if(curPurAm < 6):
			var diff:int = 6 - curPurAm
			whatDoStr = "Buy "+str(diff)+" еще предметов"+("s" if diff != 1 else "")+" у нее, чтобы продвинуться по сюжету."
		else:
			whatDoStr = "Встреться с ней во время [b]нового[/b] рейда в притон, чтобы продвинуться по сюжету."
	
	if(s4hap && !s5hap):
		whatDoStr = ""
		result.append("Кидлат сработала на ловушку, и на неё защёлкнулись оковы. Найдите 2 ключа и отдайте их ей, чтобы продвинуться по сюжету.")
	
	if(s5hap):
		result.append("Вы помогли освободить Кидлат из оков! Теперь у неё в продаже будет больше товаров.")
		
		if(curPurAm < 9):
			var diff:int = 9 - curPurAm
			whatDoStr = "Buy "+str(diff)+" еще предметов"+("s" if diff != 1 else "")+" у нее, чтобы продвинуться по сюжету."
		else:
			whatDoStr = "Встреться с ней во время [b]нового[/b] рейда в притон, чтобы продвинуться по сюжету."
	
	if(s6knows && !s6hap):
		whatDoStr = ""
		result.append("Кидлат дико развезло от алкоголя, и она чертовски хочет секса. Найдите и дайте ей таблетку-антиафродизиак, чтобы продвинуться по сюжету.")
		
	if(s6hap):
		result.append("Вы помогли Кидлат остыть! Теперь цены у неё для вас станут лучше.")
		
		if(curPurAm < 12):
			var diff:int = 12 - curPurAm
			whatDoStr = "Buy "+str(diff)+" еще предметов"+("s" if diff != 1 else "")+" у нее, чтобы продвинуться по сюжету."
		else:
			whatDoStr = "Встретьтесь с ней во время рейда в притоне, чтобы продвинуться по сюжету."
	
	if(s7knows && !s7hap):
		whatDoStr = ""
		result.append("Чтобы продвинуться по сюжету, вам нужно защитить Кидлат от торчков.")
		
	if(s7hap):
		whatDoStr = ""
		result.append("Вы защитили Кидлат от алкашей-наркоманов!")
		
		if(!s8hap):
			whatDoStr = "Найдите Кидлат в блоке камер, чтобы продвинуться по сюжету!"
	
	if(s8hap):
		whatDoStr = ""
		result.append("Теперь Кидлата можно найти в сиреневом блоке камер!")
	
	if(whatDoStr != "" && !result.empty()):
		result[result.size() - 1] += (" " + whatDoStr)

	return result

func isVisible():
	return getFlag("DrugDenModule.Kidlat1Hap")

func isCompleted():
	return getFlag("DrugDenModule.Kidlat8Hap")

func isMainQuest():
	return false
