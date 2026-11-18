extends "res://Scenes/SceneBase.gd"

var eggsToLay:int = 0
var eggReport:String = ""
var eggQueue:Array = []
var eggs:Array
var lastBodypartToLayEgg:String

func _init():
	sceneID = "PlayerWantsToLayEggsScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.TFLook, "start")
		saynn("Ты замираешь, потому что больше не можешь сделать ни шагу...")
		
		var stuffedHoles := GM.pc.getEggStuffedHoles()
		var stuffedHolesTexts:Array = []
		for theHole in stuffedHoles:
			if(theHole == BodypartSlot.Vagina):
				stuffedHolesTexts.append("womb")
			elif(theHole == BodypartSlot.Anus):
				stuffedHolesTexts.append("butt")
			else:
				stuffedHolesTexts.append(BodypartSlot.getVisibleNameNoCap(theHole))
		if(stuffedHolesTexts.empty()):
			stuffedHolesTexts = ["butt"]
		
		saynn("Яйца, что внутри твоей "+Util.humanReadableList(stuffedHolesTexts)+" просто рвутся наружу прямо сейчас...")
		
		saynn("Можно попытаться сжать мышцы, чтобы удержать их... но на это нужно много выносливости.")
		
		addButton("Отложить яйца", "Посмотреть, что будет...", "start_laying_eggs")
		addButton("Сжать", "Попытаться удержать их!", "do_clench")
	
	if(state == "no_stamina_must_lay"):
		playAnimation(StageScene.TFLook, "crotch")

		saynn("Ты кряхтишь и пытаешься сжаться... но сил совсем не осталось...")
		saynn("Как бы ты ни старалась, сейчас тебе придётся отложить эти яйца...")
		addButton("Отложить яйца", "Посмотреть, что будет...", "start_laying_eggs")
	
	if(state == "start_laying_eggs"):
		playAnimation(StageScene.EggLaying, "idle", {bodyState={naked=true}})
		
		saynn("Ты осторожно опускаешься на пол, широко разведя ноги...")
		
		saynn("А затем... ты начинаешь тужиться.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "layOne")
		addButton("Пропустить", "Увидеть их все разом", "skipToEnd")
	
	if(state == "layOne"):
		playAnimation(StageScene.EggLaying, "eggs", {eggQueue=eggQueue, shouldAutoFlop=false, bodyState={naked=true}})
		
		var stuffedHoles := [lastBodypartToLayEgg] if !lastBodypartToLayEgg.empty() else []
		var stuffedHolesTexts:Array = []
		for theHole in stuffedHoles:
			stuffedHolesTexts.append(BodypartSlot.getVisibleNameNoCap(theHole))
		if(stuffedHolesTexts.empty()):
			stuffedHolesTexts = ["tailhole"]
		
		#if(eggsToLay <= 0 ):
		#	saynn("К сожалению, почему-то ничего не выходит. Странно.")
		#elif(eggsToLay == 1):
		saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывает одно яйцо"+Util.humanReadableList(stuffedHolesTexts)+", из-за чего ты чувствуешь, как тебя нещадно растягивает...")
		#elif(eggsToLay == 2):
		#	saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывают два яйца"+Util.humanReadableList(stuffedHolesTexts)+", одно за другим, из-за чего тебя нещадно растягивает...")
		#else:
		#	saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывает сразу несколько яиц"+Util.humanReadableList(stuffedHolesTexts)+", одно за другим, из-за чего тебя нещадно растягивает...")
		
		saynn("Вы отложили "+str(eggs.size())+" egg"+("s" if eggs.size() != 1 else "")+"!")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "layOne")
		addButton("Пропустить", "Увидеть их все разом", "skipToEnd")
	
	if(state == "skipToEnd"):
		playAnimation(StageScene.EggLaying, "eggs", {eggQueue=eggQueue, shouldAutoFlop=true, bodyState={naked=true}})
		
		var stuffedHoles := GM.pc.getEggStuffedHoles()
		var stuffedHolesTexts:Array = []
		for theHole in stuffedHoles:
			stuffedHolesTexts.append(BodypartSlot.getVisibleNameNoCap(theHole))
		if(stuffedHolesTexts.empty()):
			stuffedHolesTexts = ["tailhole"]
		
		if(eggsToLay <= 0 ):
			saynn("К сожалению, почему-то ничего не выходит. Странно.")
		elif(eggsToLay == 1):
			saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывает одно яйцо"+Util.humanReadableList(stuffedHolesTexts)+", из-за чего ты чувствуешь, как тебя нещадно растягивает...")
		elif(eggsToLay == 2):
			saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывают два яйца"+Util.humanReadableList(stuffedHolesTexts)+", одно за другим, из-за чего тебя нещадно растягивает...")
		else:
			saynn("Ты кряхтишь и стонешь, когда из твоей @@B*@@ выскальзывает сразу несколько яиц"+Util.humanReadableList(stuffedHolesTexts)+", одно за другим, из-за чего тебя нещадно растягивает...")
		
		saynn("В итоге вы отложили "+str(eggsToLay)+" egg"+("s" if eggsToLay != 1 else "")+"!")
		
		saynn(eggReport)
		
		saynn("Вы продолжаете держать "+("it" if eggsToLay == 1 else "them")+" при себе..")
		
		addButton("Продолжить", "Пора идти..", "endthescene")
	
	if(state == "doLayEnd"):
		playAnimation(StageScene.EggLaying, "eggs", {eggQueue=eggQueue, shouldAutoFlop=true, bodyState={naked=true}})
		
		saynn("В итоге вы отложили "+str(eggsToLay)+" egg"+("s" if eggsToLay != 1 else "")+"!")
		
		saynn(eggReport)
		
		saynn("Вы продолжаете держать "+("it" if eggsToLay == 1 else "them")+" при себе..")
		
		addButton("Продолжить", "Пора идти..", "endthescene")
	
	if(state == "after_clenching"):
		playAnimation(StageScene.TFLook, "crotch")
		
		saynn("Вы сжимаетесь изо всех сил и вам удается удержать яйца внутри! По крайней мере, пока..")
		saynn("Ты потратила уйму выносливости в этом процессе... Может, стоит использовать что-нибудь, чтобы закупорить твои дырочки? Это было бы неплохой идеей.")
		addButton("Продолжить", "Пора идти..", "endthescene")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "do_clench"):
		if(GM.pc.getStamina() <= 0):
			setState("no_stamina_must_lay")
		else:
			GM.pc.addStamina(-30)
			setState("after_clenching")
			var menstrualCycle:MenstrualCycle = GM.pc.getMenstrualCycle()
			if(menstrualCycle):
				menstrualCycle.delayEggs()
		return
	
	if(_action == "skipToEnd"):
		processTime(30*60)
		var menstrualCycle:MenstrualCycle = GM.pc.getMenstrualCycle()
		if(menstrualCycle):
			#eggsToLay = menstrualCycle.getAmountOfEggsReadyToBeLaid()
			var newEggs := menstrualCycle.layEggs()
			eggs.append_array(newEggs)
			eggsToLay += newEggs.size()
			eggQueue = EggLaid.getEggQueue(newEggs)#menstrualCycle.getEggQueue()
			eggReport = menstrualCycle.generateLayEggsReport(eggs)
			menstrualCycle.giveEggItems(eggs)
	
	if(_action == "layOne"):
		processTime(120)
		var menstrualCycle:MenstrualCycle = GM.pc.getMenstrualCycle()
		if(menstrualCycle):
			var theLaidEgg := menstrualCycle.laySingleEgg()
			
			if(theLaidEgg):
				eggs.append(theLaidEgg)
				eggsToLay += 1
				eggQueue = EggLaid.getEggQueue([theLaidEgg])
				lastBodypartToLayEgg = OrificeType.toBodypart(theLaidEgg.orifice)
				if(lastBodypartToLayEgg == BodypartSlot.Head):
					lastBodypartToLayEgg = BodypartSlot.Anus
				setState("layOne")
				return
			else:
				lastBodypartToLayEgg = BodypartSlot.Anus
		
		eggQueue = []
		eggReport = menstrualCycle.generateLayEggsReport(eggs)
		menstrualCycle.giveEggItems(eggs)
		setState("doLayEnd")
		return
				
			#eggsToLay = menstrualCycle.getAmountOfEggsReadyToBeLaid()
			#eggs.append_array(menstrualCycle.layEggs())
			#eggsToLay += eggs.size()
			#eggQueue = EggLaid.getEggQueue(eggs)#menstrualCycle.getEggQueue()
			#menstrualCycle.giveEggItems(eggs)
	
#	if(_action == "doLay"):
#		var menstrualCycle:MenstrualCycle = GM.pc.getMenstrualCycle()
#		if(menstrualCycle):
#			eggReport = menstrualCycle.generateLayEggsReport(eggs)
#			menstrualCycle.giveEggItems(eggs)
#		processTime(10*60)
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["eggsToLay"] = eggsToLay
	data["eggReport"] = eggReport
	data["lastBodypartToLayEgg"] = lastBodypartToLayEgg
	var eggsData:Array = []
	for theEgg in eggs:
		eggsData.append(theEgg.saveData())
	data["eggs"] = eggsData

	return data
	
func loadData(data):
	.loadData(data)
	
	eggsToLay = SAVE.loadVar(data, "eggsToLay", 0)
	eggReport = SAVE.loadVar(data, "eggReport", "")
	lastBodypartToLayEgg = SAVE.loadVar(data, "lastBodypartToLayEgg", "")
	
	eggs.clear()
	var eggsData:Array = SAVE.loadVar(data, "eggs", [])
	for theEntry in eggsData:
		var theEgg := EggLaid.new()
		theEgg.loadData(theEntry)
		eggs.append(theEgg)
