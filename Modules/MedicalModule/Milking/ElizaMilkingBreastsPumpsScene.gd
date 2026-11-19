extends SceneBase

var amountCollected = 0.0
var removedItemID:String = ""

func _init():
	sceneID = "ElizaMilkingBreastsPumpsScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		aimCameraAndSetLocName("med_milkingroom")
		playAnimation(StageScene.Grope, "tease", {pc="pc", npc="eliza", milkTank=true, bodyState={exposedChest=true}})
		saynn("Вы просите доктора подоить вас. Она кивает и ведет вас в специальную комнату. Она выбирает стойло, в котором уже установлено доильное оборудование.")

		saynn("Вы обнажаете свою {pc.breasts} и ждете её команд. Вы чувствуете возбуждение.")

		saynn("[say=eliza]Идеально. Давай заставим твою грудь поработать~.[/say]")

		saynn("Она жестом указывает вам занять нужное место... перед длинной трубой, к которой прикреплены манжеты-фиксаторы. Ваши глаза также замечают два подготовленных устройства, состоящих из прозрачных воронкообразных чаш с насосами в каждом... оба они соединены с большим баком для молока гибкими трубками.")

		saynn("Лапа доктора ложится вам на спину и начинает надавливать, приглашая вас наклониться вперед.")

		addButton("Наклониться вперед", "Сделать то, что она хочет", "get_locked")
	if(state == "get_locked"):
		playAnimation(StageScene.MilkingStallSolo, "start", {pc="pc", npc="eliza", bodyState={exposedChest=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Вы следуете указаниям этой лапы, медленно наклоняясь вперед и принимая окончательную позу. Вы вставляете запястья в предназначенные для них отверстия в фиксаторах... и наблюдаете, как доктор затягивает их. Затем она также достает короткий поводок на цепи, пристегивая один конец к вашему ошейнику, а другой — к прочной трубе...")

		saynn("[say=eliza]Мы ведь не хотим, чтобы наша коровка сбежала, не подоенная, верно~?[/say]")

		saynn("Справедливо... Вы не можете не заметить... что ваше положение довольно... уязвимое... а ваша {pc.breasts} соблазнительно свисает под вами.")

		saynn("Элиза опускается перед тобой на колени, протягивая лапы, чтобы нежно обхватить твои холмики и ощутить их тяжесть. От её прикосновений твои соски твердеют..")

		saynn("Осторожно она берет два промышленных молокоотсоса и начинает прикреплять их к твоей чувствительной, налитой молоком груди, идеально совмещая мягкие присоски с твоими затвердевшими сосками. Отрицательное давление внутри позволяет им без проблем удерживаться на груди..")

		saynn("Почему-то вид этого приспособления, прикрепленного к твоей груди.. заставляет тебя слегка вздрогнуть.. Элиза закусывает губу, любуясь твоей реакцией.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_milk_start")
	if(state == "do_milk_start"):
		playAnimation(StageScene.MilkingStallSolo, "milking", {pc="pc", npc="eliza", bodyState={exposedChest=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Элиза быстро проверяет, чтобы всё было надежно закреплено.. после чего щелкает выключателем активации.")

		saynn("Почти мгновенно стойку наполняет мягкое ритмичное гудение — молокоотсосы начинают свою работу. Они не то чтобы нежные.. от первых рывков за твои чувствительные соски ты тихо ахаешь.. Ты смотришь вниз на свою грудь и видишь, как машина тянет твои соски.. снова и снова.. пока первые капли твоего {pc.milk} не начинают скапливаться на дне присосок.. В какой-то момент молока собирается достаточно много, чтобы оно потекло по присоединенным трубкам..")

		saynn("Ваши взгляды встречаются с улыбающейся докторшей.")

		saynn("[say=eliza]Хорошая маленькая коровка. Тебе нравится, когда тебя доят, правда?[/say]")

		saynn("От её слов ты заливаешься краской. Но отрицать очевидное трудно... твоё тело едва заметно ерзает в цепях и оковах... пока насосы усиливают свои ритмичные пульсации, посылая волны приятной дрожи по всей груди... твоя грудь откликается на них, поддерживая ровный поток, и каждое всасывание заставляет её соблазнительно колыхаться...")

		saynn("[say=eliza]Не беспокойся обо мне, сосредоточься на своём теле... Сосредоточься на том, как насосы тянут твои соски... сосредоточься на своих выменях, маленькая коровка... Чувствуй, как тебя доят...[/say]")

		saynn("Её слова так возбуждают... Трудно не приоткрыть губы и не начать тяжело дышать... тихие, едва уловимые стоны удовольствия срываются с твоих губ, заглушаемые механическим гулом работающих насосов. Потоки твоего {pc.milk} наполняют прозрачные трубки, оставляя на них кремовые разводы...")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_milk_faster")
	if(state == "do_milk_faster"):
		playAnimation(StageScene.MilkingStallSolo, "fast", {pc="pc", npc="eliza", bodyState={exposedChest=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Насосы работают неустанно... без устали... вытягивая всё больше и больше {pc.milk} из твоих набухших сосков... Ощущения одновременно электризуют и гипнотизируют... машина заставляет одновременно срабатывать каждый нерв твоих чувствительных бутонов.")

		saynn("[say=eliza]Просто расслабься... Издавай любые звуки, какие захочешь, сдерживание себя только ухудшит качество молока~.[/say]")

		saynn("[say=pc]Мм..[/say]")

		saynn("Твои глаза закрываются... все остальные мысли медленно уплывают прочь... все тревоги... весь стресс... все проблемы... всё это не имеет значения. Есть только дойка... твоя единственная цель... дать как можно больше молока...")

		saynn("Прерывистые стоны сами собой срываются с твоих губ... Твоё тело ерзает всё сильнее..."+str(" Твоя заброшенная киска пропиталась соками, так что внутренние стороны бедер стали влажными.." if GM.pc.hasReachableVagina() else "")+""+str(" Твой {pc.penis} слегка пульсирует.." if GM.pc.hasPenis() else "")+"")

		saynn("[say=pc]...муу...[/say]")

		saynn("Срывается странный звериный звук... ты даже не успеваешь осознать его природу... просто кажется, что так и должно быть...")

		saynn("[say=eliza]Идеально.[/say]")

		saynn("Дойка продолжается какое-то время... погружая тебя всё глубже в эту бездну непрекращающегося наслаждения... Как же хорошо...")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_milk_process")
	if(state == "do_milk_process"):
		playAnimation(StageScene.MilkingStallSolo, "start", {pc="pc", npc="eliza", bodyState={exposedChest=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("В конце концов поток начинает ослабевать... непрерывный поток превращается в медленное, нудное капанье...")

		saynn("Элиза медленно отсоединяет насосы. Когда стимуляция прекращается, ты открываешь глаза...")

		saynn("[say=eliza]С возвращением~.[/say]")

		saynn("Она протягивает лапу и нежно чешет тебя за ушком.")

		saynn("[say=eliza]Ты так много нацедила... молодец... мне нравится. Теперь тебе нужно отдохнуть.[/say]")

		saynn("Ты киваешь... всё тело всё еще покалывает от отголосков оргазма... по крайней мере, грудь больше не кажется такой тяжелой...")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_milking")
	if(state == "after_milking"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		GM.pc.setLocation("med_nearmilking")
		aimCameraAndSetLocName("med_nearmilking")
		saynn("Элиза осторожно снимает всасывающие чаши... подставляя твои соски холодному стерильному воздуху.")

		saynn("Она помогает тебе подняться, отстегивая поводок. Странное чувство — снова стоять в полный рост.")

		saynn("После этого она просто выводит тебя в коридор.")

		saynn("[say=eliza]Надеюсь, ты ещё заглянешь к нам, а мне пора заполнить кое-какие бумажки.[/say]")

		saynn("Пора идти..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		if(!removedItemID.empty()):
			var theItem = GM.pc.getInventory().getItemByUniqueID(removedItemID)
			if(theItem):
				GM.pc.getInventory().equipItem(theItem)
		endScene()
		return

	if(_action == "get_locked"):
		processTime(5*60)
		var theRemovedItem:ItemBase = GM.pc.getInventory().unequipSlot(InventorySlot.UnderwearTop)
		if(theRemovedItem && theRemovedItem.uniqueID != null):
			removedItemID = theRemovedItem.uniqueID
		
		var thePump = GlobalRegistry.createItem("BreastPump")
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(thePump)

	if(_action == "do_milk_start"):
		processTime(5*60)
		var thePump = GM.pc.getInventory().getEquippedItem(InventorySlot.UnderwearTop)
		if(thePump):
			var theFluids = thePump.getFluids()
			if(theFluids):
				theFluids.addFluid("Milk", 400.0)

	if(_action == "do_milk_faster"):
		processTime(5*60)
		var thePump = GM.pc.getInventory().getEquippedItem(InventorySlot.UnderwearTop)
		if(thePump):
			var theFluids = thePump.getFluids()
			if(theFluids):
				theFluids.addFluid("Milk", 400.0)

	if(_action == "do_milk_process"):
		processTime(5*60)
		amountCollected = GM.main.SCI.processMilkPlayerBreasts()

	if(_action == "after_milking"):
		processTime(3*60)
		GM.pc.getInventory().clearSlot(InventorySlot.UnderwearTop)

	setState(_action)

func saveData():
	var data = .saveData()

	data["amountCollected"] = amountCollected
	data["removedItemID"] = removedItemID

	return data

func loadData(data):
	.loadData(data)

	amountCollected = SAVE.loadVar(data, "amountCollected", 0.0)
	removedItemID = SAVE.loadVar(data, "removedItemID", "")
