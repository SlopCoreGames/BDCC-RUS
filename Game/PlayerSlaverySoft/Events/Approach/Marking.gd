extends NpcOwnerEventBase

var markedAmount:int = 0
var enough:bool = false

func _init():
	id = "Marking"
	reactsToTags = [E_APPROACH]
	
	eventMinLevel = 2
	eventWeight = 0.5
	eventTagWeightOverrides = {NOET.BDSM: 1.5}

func start():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER)})
	
	saynn("Твой хозяин подходит к тебе, сжимая в руке маркер.")
	talkModularOwnerToPC("SoftSlaveryMarkingStart") #I feel like marking my {npc.npcSlave}. So stand still while I do this.
	saynn("Похоже, {npc.he} {npc.isAre} собирается оставить на твоём теле надпись.")
	
	addButton("Повиноваться", "Позволить им пометить тебя", "let")
	addButton("Нет?", "Сказать «нет»", "no")
	addButton("Пожалуйста, только не это", "Умолять об этом", "pleaseno")

func start_do(_id:String, _args:Array):
	if(_id == "let"):
		incMarked()
		setState("afterBodywriting")
	if(_id == "no"):
		if(smartChance(max(10.0 - ownerPersonality(PersonalityStat.Mean)*80.0, 10.0)+getOwnerNOM(NOM.Kind)*30.0, 0.0)):
			setState("fineEnough")
		else:
			setState("fightOrMark")
	if(_id == "pleaseno"):
		if(smartChance(max(20.0 - ownerPersonality(PersonalityStat.Mean)*80.0, 20.0)+getOwnerNOM(NOM.Kind)*30.0, 0.0)):
			setState("pleaseFineEnough")
		else:
			setState("beggingStart")

func afterBodywriting():
	playAnimation(StageScene.Duo, "stand", {npc=getRoleID(C_OWNER), bodyState={naked=true}})
	
	if(markedAmount <= 1):
		saynn("Ты повинуешься и позволяешь хозяину оставить на тебе метку!")
	elif(markedAmount == 2):
		saynn("Ты позволяешь хозяину оставить на тебе вторую метку!")
	elif(markedAmount == 3):
		saynn("Ты позволяешь хозяину оставить на тебе третью метку. Теперь ты выглядишь довольно... интересно.")
	elif(markedAmount == 4):
		saynn("Вы позволяете владельцу поставить на вас четвертую метку. Теперь вы выглядите весьма... многообещающе.")
	elif(markedAmount == 5):
		saynn("Вы позволяете владельцу поставить на вас пятую метку. Теперь вы выглядите чертовски похотливо!")
	else:
		saynn("Вы позволяете владельцу поставить на вас еще одну.. метку. Теперь вы выглядите запредельно шлюшливо!")
	
	addInfluenceObey(0.1)
	
	if(enough):
		talkModularOwnerToPC("SoftSlaveryMarkingEnough")
		addContinueCheckExtra()
		return
	
	addContinue("setState", ["tryWriting"])

func tryWriting():
	saynn("Оставив на вас метку.. ваш владелец всё еще сжимает маркер в руке.")
	talkModularOwnerToPC("SoftSlaveryMarkingAnother") #Another one?

	addButton("Да", "Позволить им пометить тебя", "let")
	addButton("Нет?", "Сказать «нет»", "no")
	addButton("Пожалуйста, только не это", "Умолять об этом", "pleaseno")

func tryWriting_do(_id:String, _args:Array):
	if(_id == "let"):
		incMarked()
		setState("afterBodywriting")
	if(_id == "no"):
		if(RNG.chance(markedAmount*10.0+getOwnerNOM(NOM.Kind)*30.0)):
			setState("fineEnough")
		else:
			setState("fightOrMark")
	if(_id == "pleaseno"):
		if(RNG.chance(markedAmount*10.0+getOwnerNOM(NOM.Kind)*30.0)):
			setState("pleaseFineEnough")
		else:
			setState("beggingStart")

func fineEnough():
	if(markedAmount <= 0):
		saynn("Вы говорите владельцу, что не хотите, чтобы вас помечали.")
		saynn("К вашему удивлению, владелец кивает и просто убирает маркер.")
		talkModularOwnerToPC("SoftSlaveryMarkingNoStart") #Whatever, I guess I'm not marking you
		addInfluenceResist()
	else:
		saynn("Вы говорите владельцу, что на сегодня хватит.")
		saynn("Ваш владелец кивает и убирает маркер.")
		talkModularOwnerToPC("SoftSlaveryMarkingNo") #Alright. I guess this is enough for now.
	addContinueCheckExtra()

func fightOrMark():
	if(markedAmount <= 0):
		saynn("Вы говорите владельцу, что не хотите, чтобы вас помечали.")
	else:
		saynn("Вы говорите владельцу, что на сегодня хватит.")
	saynn("Но {npc.name} не отступает.")
	talkModularOwnerToPC("SoftSlaveryMarkingNoFail")

	addButton("Ладно", "Позволить им пометить тебя", "let")
	addButton("Сопротивляться", "Сопротивляться", "resist")

func fightOrMark_do(_id:String, _args:Array):
	if(_id == "let"):
		incMarked()
		setState("afterBodywriting")
	if(_id == "resist"):
		runResist()

func pleaseFineEnough():
	if(markedAmount == 0):
		talkPC("Please, no.")
	else:
		talkPC("Please, that's enough.")
	saynn("Ты умоляешь хозяина остановиться.")
	saynn("{npc.name} слышит это... и действительно останавливается.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegYes") #"You are being so cute, begging me. How can I say no?"
	saynn("{npc.He} {npc.verb('put')} маркер подальше.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegYes2") #That's enough then
	addContinueCheckExtra()

func beggingStart():
	if(markedAmount == 0):
		talkPC("Please, no.")
	else:
		talkPC("Please, that's enough.")
	saynn("Ты умоляешь хозяина остановиться.")
	saynn("Но {npc.name} всё ещё сжимает маркер.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegNo") #If you're gonna beg, do it on your knees
	saynn("Ты слегка наклоняешь голову.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegNo2") #Kneel, now
	addButton("Встать на колени", "Делать, как велит хозяин", "kneel")
	addButton("Сопротивляться", "Ты не посмеешь!", "resist")

func beggingStart_do(_id:String, _args:Array):
	if(_id == "kneel"):
		setState(RNG.pick(["begHumiliateSelf", "begKissFoot", "begGiveCredits"]))
	if(_id == "resist"):
		runResist()

func begGiveCredits():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID()})
	saynn("Ты беспрекословно подчиняешься приказу, преклоняя колени перед {npc.name}. Под сверлящим взглядом {npc.His} ты невольно опускаешь глаза.")
	addInfluenceObey(0.5)
	talkModularOwnerToPC("SoftSlaveryMarkingBegCredits")
	saynn("Маркер завис совсем близко к твоей коже.")
	
	if(GM.pc.getCredits() >= 5):
		addButton("Заплатить", "Передать им кредиты", "pay")
	else:
		addDisabledButton("Заплатить", "У тебя недостаточно средств...")
	addButton("Отказаться", "Отказаться это делать", "getmarked")

func begGiveCredits_do(_id:String, _args:Array):
	if(_id == "pay"):
		GM.pc.addCredits(-5)
		setState("begGiveCreditsPaid")
	if(_id == "getmarked"):
		for _i in range(RNG.randi_range(3, 5)):
			incMarked()
		setState("begGiveCreditsMarked")

func begGiveCreditsPaid():
	saynn("Ты протягиваешь своему хозяину кредитный чип.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegCreditsGive") #Thanks. These are more useful to me anyway.
	addInfluenceObey(0.5)
	saynn("Довольный кредитами, твой хозяин убирает маркер.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegCreditsGive2") #I guess thats it then.
	addContinueCheckExtra()

func begGiveCreditsMarked():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID(), bodyState={naked=true}})
	saynn("Ты отказываешься отдавать свои кредиты.")
	addInfluenceResist(0.5)
	saynn("Увидев это, {npc.name} начинает оставлять на твоей коже множество надписей!")
	talkModularOwnerToPC("SoftSlaveryMarkingBegNoMarked") #That's what you get. Enjoy the marks
	saynn("Твой хозяин решает остановиться лишь тогда, когда получает свою порцию удовольствия.")
	addContinue("endEvent")


func begKissFoot():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID()})
	saynn("Ты беспрекословно подчиняешься приказу, преклоняя колени перед {npc.name}. Под сверлящим взглядом {npc.His} ты невольно опускаешь глаза.")
	addInfluenceObey(0.5)
	talkModularOwnerToPC("SoftSlaveryMarkingBegFoot")
	saynn("Маркер завис совсем близко к твоей коже.")
	
	addButton("Поцеловать", "Поцеловать ногу", "setState", ["begKissFootKiss"])
	addButton("Отказаться", "Отказаться это делать", "getmarked")

func begKissFoot_do(_id:String, _args:Array):
	if(_id == "getmarked"):
		for _i in range(RNG.randi_range(3, 5)):
			incMarked()
		setState("begKissFootMarked")

func begKissFootKiss():
	saynn("Ты наклоняешься ниже и целуешь {npc.foot}, в точности как было приказано.")
	saynn("{npc.name} замечает это и улыбается.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegFootKiss")
	addInfluenceObey(0.5)
	saynn("Когда ты заканчиваешь поклоняться {npc.feet} {npc.his}, {npc.he} наконец убирает маркер.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegFootKiss2")
	addContinueCheckExtra()

func begKissFootMarked():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID(), bodyState={naked=true}})
	saynn("Ты отказываешься приближаться к {npc.feet} {npc.name}.")
	addInfluenceResist(0.5)
	saynn("Увидев это, {npc.name} начинает оставлять на твоей коже множество надписей!")
	talkModularOwnerToPC("SoftSlaveryMarkingBegNoMarked") #That's what you get. Enjoy the marks
	saynn("Твой хозяин решает остановиться лишь тогда, когда получает свою порцию удовольствия.")
	addContinue("endEvent")
	

func begHumiliateSelf():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID()})
	saynn("Ты беспрекословно подчиняешься приказу, преклоняя колени перед {npc.name}. Под сверлящим взглядом {npc.His} ты невольно опускаешь глаза.")
	addInfluenceObey(0.5)
	talkModularOwnerToPC("SoftSlaveryMarkingBegHumiliation")
	saynn("Маркер завис совсем близко к твоей коже.")
	
	addButton("Признать", "Сказать это", "admit")
	addButton("Молчать", "Отказаться говорить", "getmarked")

func begHumiliateSelf_do(_id:String, _args:Array):
	if(_id == "admit"):
		setState("begHumiliateSelfAdmit")
	if(_id == "getmarked"):
		for _i in range(RNG.randi_range(3, 5)):
			incMarked()
		setState("begHumiliateSelfMarked")

func begHumiliateSelfAdmit():
	saynn("Ты говоришь.")
	talkPC("I'm your {npc.npcSlave}.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegHumiliation2")
	saynn("Кончик маркера начинает оставлять след на твоей коже.")
	talkPC("I'm your {npc.npcSlave}! Nothing but your property!")
	talkModularOwnerToPC("SoftSlaveryMarkingBegHumiliation3")
	addInfluenceObey(0.5)
	saynn("{npc.name} наконец убирает маркер.")
	talkModularOwnerToPC("SoftSlaveryMarkingBegHumiliation4")
	addContinueCheckExtra()

func begHumiliateSelfMarked():
	playAnimation(StageScene.Duo, "kneel", {npc=getOwnerID(), bodyState={naked=true}})
	saynn("Ты отказываешься во всём признаваться.")
	addInfluenceResist(0.5)
	saynn("Видя твоё неповиновение, {npc.name} начинает исписывать твою кожу множеством надписей!")
	talkModularOwnerToPC("SoftSlaveryMarkingBegNoMarked") #That's what you get. Enjoy the marks
	saynn("Твой хозяин решает остановиться лишь тогда, когда получает свою порцию удовольствия.")
	addContinue("endEvent")
	
func incMarked():
	markedAmount += 1
	
	var fetishChance:float = 10.0 - ownerFetish(Fetish.Bodywritings)*5.0
	
	if(RNG.chance(markedAmount*fetishChance)):
		enough = true
		
	var zone = BodyWritingsZone.getRandomZone()
	var theWritingID:String = BodyWritings.getRandomWritingIDForZone(zone)
	GM.pc.addBodywriting(zone, theWritingID, false, getOwnerID())
	
	GM.main.addMessage("You have a received a '"+BodyWritings.getWritingText(theWritingID)+"' writing on your "+BodyWritingsZone.getZoneVisibleName(zone))

func addContinueCheckExtra():
	var extraChance:float = 50.0 - ownerPersonality(PersonalityStat.Subby)*30.0+getOwnerNOM(NOM.Mean)*40.0
	if(GM.pc.hasBodywritings()):
		extraChance *= 0.9
	
	if(!RNG.chance(extraChance)):
		addContinue("endEvent")
	else:
		addContinue("setState", [RNG.pick(["notDoneYetCum", "notDoneYetPerm"])])

func notDoneYetPerm():
	talkModularOwnerToPC("SoftSlaveryMarkingNotDone") #"Actually.. you know what.. I'm not done with you just yet."
	saynn("Твой хозяин достаёт поводок...")
	addButton("Повиноваться", "Позволь своему хозяину делать с тобой всё, что угодно...", "go")
	addButton("Сопротивляться", "Довольно!", "resist")

func notDoneYetPerm_do(_id:String, _args:Array):
	if(_id == "go"):
		runParadeTo(RNG.pick([LOC_STOCKS]))
	if(_id == "resist"):
		runResist()

func notDoneYetPerm_eventResult(_event, _tag:String, _args:Array):
	setState("aboutToPermWriting")

func aboutToPermWriting():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getRoleID(C_OWNER), bodyState={naked=true}})

	saynn("{npc.name} тащит тебя на платформу для наказаний, где {npc.he} {npc.verb('lock')} тебя в колодки!")
	talkModularOwnerToPC("SoftSlaveryMarkingNotDoneStocks") #"This is just so you don't run away now."
	saynn("Сказав это, {npc.he} {npc.verb('pull')} достает [b]перманентный[/b] маркер!")
	
	addContinue("getMarked")

func aboutToPermWriting_do(_id:String, _args:Array):
	GM.pc.addBodywritingRandom(true, getOwnerID())
	setState("afterGetPermMarked")

func afterGetPermMarked():
	playAnimation(StageScene.StocksSexOral, "tease", {npc=getRoleID(C_OWNER), bodyState={naked=true}})
	saynn("Твой хозяин что-то черкает на тебе перманентным маркером!")
	talkModularOwnerToPC("SoftSlaveryMarkingNotDoneStocks2") #Perfect. This is art.
	addInfluenceObey(0.3)
	saynn("Показав тебя напоказ какое-то время, твой хозяин наконец решает освободить тебя и отпустить.")
	addContinue("endEvent")

func notDoneYetCum():
	talkModularOwnerToPC("SoftSlaveryMarkingNotDone") #"Actually.. you know what.. I'm not done with you just yet."
	saynn("Твой хозяин достаёт поводок...")
	addButton("Повиноваться", "Позволь своему хозяину делать с тобой всё, что угодно...", "go")
	addButton("Сопротивляться", "Довольно!", "resist")

func notDoneYetCum_do(_id:String, _args:Array):
	if(_id == "go"):
		runParadeTo(RNG.pick([LOC_BATHROOM1, LOC_BATHROOM2]))
	if(_id == "resist"):
		runResist()

func notDoneYetCum_eventResult(_event, _tag:String, _args:Array):
	setState("cumMarkUrinal")

func cumMarkUrinal():
	playAnimation(StageScene.UrinalPeeing, "idle", {npc=getOwnerID(), bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
	var theOwner := getOwner()
	if(theOwner.hasReachablePenis()):
		saynn("Твой хозяин приковывает тебя к писсуару и вытаскивает {npc.his} {npc.penis}, уже нежно поглаживая его!")
	elif(theOwner.hasVagina()):
		saynn("Твой хозяин приковывает тебя к писсуару и выставляет напоказ {npc.his} киску, уже нежно потирая её!")
	talkModularOwnerToPC("SoftSlaveryMarkingNotDoneUrinal")
	addContinue("getMarked")

func cumMarkUrinal_do(_id:String, _args:Array):
	if(_id == 'getMarked'):
		var theOwner := getOwner()
		if(theOwner.hasReachablePenis()):
			GM.pc.cummedOnBy(getOwnerID(), FluidSource.Penis)
		elif(theOwner.hasVagina()):
			GM.pc.cummedOnBy(getOwnerID(), FluidSource.Vagina)
		setState("cumMarkUrinalMarked")

func cumMarkUrinalMarked():
	var theOwner := getOwner()
	if(theOwner.hasReachablePenis()):
		playAnimation(StageScene.UrinalPeeing, "stroke", {npc=getOwnerID(), npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
	
		saynn("И вот, после нежных поглаживаний, твой хозяин помечает тебя {npc.his} {npc.cum}! {npc.His} {npc.penis} пульсирует, выстреливая липкими струями прямо тебе в лицо!")
	else:
		playAnimation(StageScene.UrinalPeeing, "peefemale", {npc=getOwnerID(), npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		if(theOwner.hasVagina()):
			saynn("И вот, после того как твою киску хорошенько потерли, твой хозяин стонет, когда {npc.his} {npc.pussyStretch} {pussy} заливает всё твоё лицо и тело, покрывая тебя слоем {npc.his} соков!")
		else:
			saynn("И вот, спустя некоторое время, твой хозяин помечает тебя, кончая тебе прямо на лицо!")
		
	talkModularOwnerToPC("SoftSlaveryMarkingNotDoneUrinal2") #"Mmhh.. Good {npc.npcSlave}."
	addInfluenceObey(0.3)
	
	saynn("Спустя какое-то время твой хозяин наконец снимает с тебя наручники у писсуара и отпускает тебя.")
	addContinue("endEvent")
	
func saveData() -> Dictionary:
	var data := .saveData()
	
	data["markedAmount"] = markedAmount
	data["enough"] = enough
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	markedAmount = SAVE.loadVar(_data, "markedAmount", 0)
	enough = SAVE.loadVar(_data, "enough", false)
