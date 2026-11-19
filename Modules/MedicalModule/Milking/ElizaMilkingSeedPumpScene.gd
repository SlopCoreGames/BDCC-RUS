extends SceneBase

var amountCollected = 0.0

func _init():
	sceneID = "ElizaMilkingSeedPumpScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		aimCameraAndSetLocName("med_milkingroom")
		playAnimation(StageScene.Grope, "tease", {pc="pc", npc="eliza", milkTank=true, bodyState={exposedCrotch=true}})
		saynn("Вы просите врача подоить вас ради семени. Она кивает и ведет вас в специальную комнату. Она выбирает стойло, в котором уже установлено доильное оборудование.")

		saynn("Вы обнажаете свой {pc.penis} и ждете её команд. Вы чувствуете легкое возбуждение, ваш член уже начинает твердеть...")

		saynn("[say=eliza]Идеально. Давай запрём тебя здесь.[/say]")

		saynn("Она жестом указывает вам занять нужное место... перед длинной трубой... к которой прикреплены фиксаторы, похожие на манжеты. Ваши глаза также замечают специальный насос, соединенный гибкими трубками с большим резервуаром для жидкости.")

		saynn("Лапа доктора ложится вам на спину и начинает надавливать, приглашая вас наклониться вперед.")

		addButton("Наклониться вперед", "Сделать то, что она хочет", "get_locked")
	if(state == "get_locked"):
		playAnimation(StageScene.MilkingStallSolo, "start", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true, chains=[["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Вы следуете указаниям этой лапы, медленно наклоняясь вперед и принимая окончательную позу. Вы вставляете запястья в предназначенные для них отверстия в фиксаторах... и наблюдаете, как доктор затягивает их. Затем она также достает короткий поводок на цепи, пристегивая один конец к вашему ошейнику, а другой — к прочной трубе...")

		saynn("[say=eliza]Мы ведь не хотим, чтобы наш бычок сбежал недоенным, верно~?[/say]")

		saynn("Справедливо...")

		saynn("Элиза хватает этот специализированный пенисный насос и опускается перед вами на колени. Её лапы тянутся к вашему {pc.penis}, осторожно закрепляя насос на вашем уже эрегированном члене. Отрицательное давление внутри позволяет ему без проблем плотно прилегать к вашей паху.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_milk_start")
	if(state == "do_milk_start"):
		playAnimation(StageScene.MilkingStallSolo, "milking", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true, chains=[["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Она включает насос и садится перед вами, просто любуясь процессом.")

		saynn("Почти мгновенно насос приходит в действие. Он оснащен круглым мягким «удовольственным» кольцом, которое начинает свое автоматическое скольжение вдоль вашего ствола, крепко обхватывая его обхват.")

		saynn("[say=pc]Ммм..[/say]")

		saynn("В этом явно не хватает той... нежности... которую может дать прикосновение рук... но всё равно приятно: каждый толчок посылает волну ощущений по всей длине. Ваш член отвечает едва заметными подергиваниями, а с кончика капает предэякулят.")

		saynn("[say=eliza]Просто дай ему делать свою работу, не сдерживайся~.[/say]")

		saynn("Вы киваете и стараетесь стоять как можно неподвижнее, позволяя насосу ласкать ваш член...")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_milk_fast")
	if(state == "do_milk_fast"):
		playAnimation(StageScene.MilkingStallSolo, "fast", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true, chains=[["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Но поглаживания — это еще не всё, на что способна эта промышленная махина. Внезапно ты чувствуешь, как насос... начинает тянуть твой член... Кажется, он работает в режиме чередования: то высасывает почти весь воздух, создавая мощное отрицательное давление внутри... то накачивает его обратно, заставляя твой член получать невероятно жесткое удовольствие...")

		saynn("Вместе с этим волной наслаждения твои ноги начинают слабеть, а с губ срываются тихие стоны... Это чертовски приятно... как будто ты трахаешь самую тугую киску в мире... Твои пальцы ног поджимаются, пока ты извиваешься в путах и цепях...")

		saynn("[say=pc]Мгххх... ммм...[/say]")

		saynn("Неумолимые поглаживания подталкивают тебя всё ближе и ближе к краю. Самодовольная улыбка Элизы сияет, пока она наблюдает за твоими мучениями. Твои яйца дергаются всё сильнее... кажется, ты уже не сможешь сдерживаться...")

		addButton("Кончить", "Пусть всё идет своим чередом", "process_cum")
	if(state == "process_cum"):
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true, chains=[["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]}})
		saynn("Ты кончаешь мощно... Твое тело содрогается, когда твой {pc.penis} начинает пульсировать и выбрасывать порции семени сочными волнами. Ты тяжело дышишь и стонешь, пока прозрачная трубка насоса быстро наполняется твоим густым, горячим семенем... прежде чем всё это будет выкачано в подключенный резервуар для жидкости.")

		saynn("[say=eliza]Позволь ему выдоить тебя досуха... Нам нужна каждая капля твоего семени~.[/say]")

		saynn("[say=pc]Нгхх..[/say]")

		saynn("У тебя всё равно нет выбора: насос продолжает непрерывно ласкать твой пульсирующий член отрицательным давлением, растягивая твой оргазм. Каждое движение выманивает и собирает всё больше твоего {pc.cum}... пока не возникнет ощущение, что твои яйца выдоены до последней капли...")

		saynn("К концу процесса твоё тело кажется совершенно изнурённым... Элиза довольно улыбается, наблюдая, как уровень семени в резервуаре поднимается от последних капель твоей тягучей жижи.")

		saynn("[say=eliza]Чистое... совершенство.[/say]")

		saynn("Она выключает насос и начинает расстегивать ремни...")

		addButton("Продолжить", "Смотреть, что будет дальше", "undo_restraints")
	if(state == "undo_restraints"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		GM.pc.setLocation("med_nearmilking")
		saynn("Она помогает тебе подняться, отстегивая поводок, отпирая наручники и снимая пенисный насос. Странно снова стоять прямо... но то, что твой член больше не подвергается постоянной стимуляции, ощущается ещё страннее...")

		saynn("[say=eliza]Спасибо, что был таким щедрым донором~.[/say]")

		saynn("После этого она просто выводит тебя в коридор.")

		saynn("[say=eliza]Надеюсь, ты ещё заглянешь к нам, а мне пора заполнить кое-какие бумажки.[/say]")

		saynn("Пора идти..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "get_locked"):
		processTime(5*60)
		var thePump = GlobalRegistry.createItem("PenisPump")
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(thePump)

	if(_action == "do_milk_start"):
		processTime(5*60)

	if(_action == "do_milk_fast"):
		processTime(3*60)

	if(_action == "process_cum"):
		amountCollected = GM.main.SCI.processMilkPlayerPenis()
		GM.pc.orgasmFrom("pc")

	if(_action == "undo_restraints"):
		processTime(3*60)
		GM.pc.getInventory().clearSlot(InventorySlot.Penis)

	setState(_action)

func saveData():
	var data = .saveData()

	data["amountCollected"] = amountCollected

	return data

func loadData(data):
	.loadData(data)

	amountCollected = SAVE.loadVar(data, "amountCollected", 0.0)
