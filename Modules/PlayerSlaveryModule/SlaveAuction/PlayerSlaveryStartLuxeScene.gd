extends SceneBase

var luxeTimes = 0

func _init():
	sceneID = "PlayerSlaveryStartLuxeScene"

func _reactInit():
	GM.main.PSH.storePlayersItems()
	addMessage("All your items were safely stored")

func _run():
	if(state == ""):
		playAnimation(StageScene.GivingBirth, "idle", {pc="pc"})
		aimCameraAndSetLocName("market_luxe")
		luxeTimes = getFlag("PlayerSlaveryModule.luxeTimes", 0)
		saynn("В голове звенит... всё пульсирует в такт сердцебиению... и это совсем не приятное чувство. Под тобой — холодная поверхность из черного дерева, помогающая сознанию медленно возвращаться к реальности.")

		saynn("Пора открывать глаза.")

		saynn("Ты заставляешь зрение сфокусироваться. Ты... в роскошной комнате. Письменный стол, дорогая деревянная мебель с золотой отделкой, светящаяся голо-карта... Погоди... Ты прекрасно знаешь эту комнату.")

		saynn("Ты пытаешься подняться... но ошейник резко дергает тебя назад. Ты прикован цепью к одному из крюков на полу.")

		if (luxeTimes <= 0):
			saynn("[say=pc]Блядь.[/say]")

		else:
			saynn("[say=pc]Блядь. Только не снова.[/say]")

		saynn("[say=luxe]Хм.[/say]")

		saynn("Ты слышишь его хриплый голос... и его шаги."+str(" You already know that your fate is sealed.." if luxeTimes >= 1 else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "luxe_comes_in")
	if(state == "luxe_comes_in"):
		playAnimation(StageScene.Duo, "kneel", {npc="luxe", npcAction="sit", bodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		addCharacter("luxe")
		if (luxeTimes <= 0):
			saynn("Люкс входит в кабинет и просто проходит мимо тебя.")

			saynn("[say=pc]Эй, эм... меня тут кто-то приковал к полу.[/say]")

			saynn("Он просто сидит в своем кресле. Кажется, будто он тебя не заметил... но на самом деле он всё прекрасно понял.")

			saynn("[say=luxe]Это был я.[/say]")

			saynn("Он? Люкс приковал тебя к углу своего кабинета?")

			saynn("[say=pc]Что?[/say]")

			saynn("[say=luxe]Чтобы ты не сбежал(ла).[/say]")

			saynn("Его голос спокоен и холоден... в то время как в твоем отчетливо слышны нотки нервозности.")

			saynn("[say=pc]Сбежать куда? Ты что, решил(а) сделать из меня свою сучку?[/say]")

			saynn("Он едва заметно качает головой.")

			saynn("[say=luxe]Мне не нужен раб из АльфаКорп. А вот кому-то другому — вполне возможно.[/say]")

			saynn("[say=pc]На что ты намекаешь?[/say]")

		else:
			saynn("Люкс входит в кабинет и просто проходит мимо тебя.")

			saynn("[say=pc]И тебе привет.[/say]")

			saynn("Он просто сидит в своем кресле. Кажется, будто он тебя не заметил... но на самом деле он всё прекрасно понял.")

			saynn("[say=luxe]М-м...[/say]")

			saynn("Люксу требуется некоторое время, чтобы просмотреть твои документы.")

			saynn("[say=pc]Ты собираешься меня продать?[/say]")

			saynn("Он бросает на тебя быстрый, но молчаливый взгляд. Сказанного было достаточно.")

			saynn("[say=pc]Понятно..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "luxe_leashes_pc")
	if(state == "luxe_leashes_pc"):
		playAnimation(StageScene.Duo, "kneel", {npc="luxe", bodyState={leashedBy="luxe"}})
		if (luxeTimes <= 0):
			saynn("Люкс встает и подходит к тебе. Одной своей мощной рукой он вцепляется тебе в волосы, а второй хватает цепь-поводок.")

			saynn("[say=luxe]Мы можем сделать всё по-хорошему. Или можем по-жестокому.[/say]")

			saynn("Ты морщишься... попытка убрать его пальцы лишь заставляет его впиваться когтями в твой скальп.")

			saynn("[say=pc]Гх... Ты продаешь меня? После всего, что я сделал?[/say]")

			saynn("Его рука тянет тебя за волосы всё сильнее, усиливая боль.")

			saynn("[say=luxe]Я продаю тебя. Потому что именно так я и поступаю с рабами.[/say]")

			saynn("Его голос пробирает тебя до самых костей. Ты ерзаешь... от дискомфорта невозможно усидеть на месте, а с губ срываются невольные стоны.")

			saynn("[say=luxe]Аукцион вот-вот начнется. Вставай.[/say]")

		else:
			saynn("Закончив с документами, Люкс поднимается и подходит к тебе. Одной своей мощной рукой он хватает тебя за волосы, а другой вцепляется в цепь-поводок.")

			saynn("[say=luxe]Мы можем сделать всё по-хорошему. Или можем по-жестокому.[/say]")

			saynn("Ты морщишься... попытка убрать его пальцы лишь заставляет его впиваться когтями в твой скальп.")

			saynn("[say=pc]Полегче, так и быть...[/say]")

			saynn("Его рука тянет тебя за волосы всё сильнее, усиливая боль.")

			saynn("[say=luxe]Я буду продавать тебя в рабство снова и снова, пока ты не выучишь свое место.[/say]")

			saynn("Его голос пробирает тебя до самых костей. Ты ерзаешь... от дискомфорта невозможно усидеть на месте, а с губ срываются невольные стоны.")

			saynn("[say=luxe]Аукцион вот-вот начнется. Вставай.[/say]")

		addButton("Следовать", "Смотреть, что будет дальше", "about_to_start")
	if(state == "about_to_start"):
		playAnimation(StageScene.HangingDuo, "idle", {pc="pc", npc="luxe", bodyState={naked=true}})
		aimCameraAndSetLocName("market_market")
		saynn("Ты поднимаешься и следуешь за Люксом по тускло освещенным коридорам.")

		saynn("[say=pc]А где мои вещи?[/say]")

		saynn("[say=luxe]Они у «АльфаКорп». Я людей продаю, а не устраиваю распродажу хлама в гараже.[/say]")

		saynn("Жестокая правда. По крайней мере, есть шанс, что их вернут...")

		saynn("Он выводит тебя на сцену... и ставит в самый центр. Твои запястья заковывают в цепи высоко над головой, заставляя стоять на цыпочках.")

		saynn("Сердце колотится всё сильнее, когда за плотными шторами начинают слышаться голоса.")

		saynn("Люкс поднимается на небольшое возвышение... и ждет подходящего момента.")

		saynn("Аукцион вот-вот начнется... и ты — первый лот.")

		addButton("Аукцион", "Посмотреть, что будет", "start_auction")
	if(state == "after_auction"):
		playAnimation(StageScene.Duo, "stand", {npc="luxe", bodyState={leashedBy="luxe"}, flipNPC=true})
		saynn("Всё произошло слишком быстро...")

		saynn("Люкс подходит к тебе и опускает цепи, прежде чем схватить тебя за поводок.")

		saynn("Твои {pc.feet} плотно прижимаются к земле. В голове проносится миллион мыслей.")

		saynn("[say=luxe]Движение.[/say]")

		saynn("Люкс ведет тебя к новому владельцу... а затем вручает ему поводок.")

		saynn("[say=luxe]Хороший выбор. Наслаждайтесь товаром.[/say]")

		saynn("Фигура в маске кивает... и забирает тебя с собой на свой космический корабль.")

		saynn("Спустя несколько минут ты уже несешься сквозь звезды... но не как свободный человек... а как чья-то собственность.")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_slavery")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "luxe_comes_in"):
		processTime(3*60)

	if(_action == "luxe_leashes_pc"):
		processTime(3*60)

	if(_action == "about_to_start"):
		processTime(3*60)

	if(_action == "start_auction"):
		runScene("PlayerSlaveryAuctionScene", [{}, "luxe"])
		setState("after_auction")
		return

	if(_action == "start_slavery"):
		increaseFlag("PlayerSlaveryModule.luxeTimes")
		endScene()
		runScene("PlayerSlaveryPickScene")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["luxeTimes"] = luxeTimes

	return data

func loadData(data):
	.loadData(data)

	luxeTimes = SAVE.loadVar(data, "luxeTimes", 0)
