extends SceneBase

var biggestStat = -1

func _init():
	sceneID = "PSTentaclesSmallEndOfDay"

func _reactInit():
	addCharacter(GM.main.PS.getTentaclesCharID())

func resolveCustomCharacterName(_charID):
	if(_charID == "ten"):
		return GM.main.PS.getTentaclesCharID()
	if(_charID == "sci1"):
		return GM.main.PS.getScientist1CharID()
	if(_charID == "sci2"):
		return GM.main.PS.getScientist2CharID()

func _run():
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(state == ""):
		GM.pc.setLocation(_tentacles.getMonsterLoc())
		aimCameraAndSetLocName(_tentacles.getMonsterLoc())
		
		biggestStat = _tentacles.getBiggestStat()
		if (biggestStat == _tentacles.STAT_ANGER):
			saynn("Становится поздно... Щупальцевое чудовище тоже выглядит довольно уставшим... даже если оно этого не показывает.")

		elif (biggestStat == _tentacles.STAT_AGILITY):
			saynn("Становится поздно... Щупальцевое чудовище сегодня изрядно размялось, так что оно тоже выглядит измотанным.")

		elif (biggestStat == _tentacles.STAT_MIND):
			saynn("Становится поздно... И щупальцевое чудовище устало так же сильно, как и ты... ты в этом почти уверена.")

		else:
			saynn("Становится поздно... Щупальцевое чудовище тоже выглядит довольно уставшим, оно даже не так сильно раскачивается.")

		addButton("Отдохнуть", "Пора отдыхать!", "before_rest")
	if(state == "before_rest"):
		playAnimation(StageScene.TentaclesDuo, "idle", {plant=true,tentaclesSizeSmall=true})
		
		saynn("Прежде чем лечь спать, нужно убрать щупальца на место.")

		saynn("[say=pc]Почему бы тебе не вернуться в свое гнездо... э-э...[/say]")

		saynn("Ты понимаешь, что так и не дала ему имени. Называть его «чудовищем» кажется немного странным, особенно сейчас.")

		saynn("[say=pc]Как же мне тебя называть... хм...[/say]")

		_tentacles.addMonsterNameButtons(self)
		if (false):
			addButton("PICKNAME", "ЭТОГО НЕ ДОЛЖНО БЫЛО ТЕБЯ ВИДЕТЬ", "pickName")
	if(state == "pickName"):
		removeCharacter(_tentacles.getTentaclesCharID())
		addCharacter(_tentacles.getTentaclesCharID())
		playAnimation(StageScene.TentaclesDuo, "sleep", {plant=true,tentaclesSizeSmall=true})
		aimCameraAndSetLocName(_tentacles.LOC_MIDDLE)
		GM.pc.setLocation(_tentacles.LOC_MIDDLE)
		saynn("[say=pc]Как насчет.. {psTentacles}?[/say]")

		if (biggestStat == _tentacles.STAT_ANGER):
			saynn("Щупальца мгновенно дергаются, направляя свои острые кончики в твою сторону. Кажется, будто за тобой наблюдает целый лес кинжалов.")

			saynn("Это определенно привлекло их внимание... похоже, название удачное.")

		elif (biggestStat == _tentacles.STAT_AGILITY):
			saynn("Когда ты это произносишь, щупальца начинают нетерпеливо раскачиваться и подпрыгивать. Похоже, выбранное тобой имя привело их в полный восторг.")

			saynn("Должно быть, это хорошее имя.")

		elif (biggestStat == _tentacles.STAT_MIND):
			saynn("Щупальца не проявляют видимых эмоций... но ты кожей чувствуешь, что им нравится это имя. Словно между вами возникла какая-то связь.")

			_tentacles.talk("We approve that name.")
			saynn("Ну... должно быть, имя и впрямь хорошее.")

		else:
			saynn("Услышав это имя, щупальца тянутся к тебе и ласкают твою кожу. Похоже, им очень нравится.")

			saynn("Должно быть, это хорошее имя.")

		saynn("Ты приглашаешь {psTentacles} вернуться в гнездо... и оно послушно следует за тобой.")

		saynn("Но прежде чем ты ляжешь спать... ты слышишь стук в стекло. Точно.")

		addButton("Окно", "Подойти к нему", "window")
	if(state == "window"):
		removeCharacter(_tentacles.getTentaclesCharID())
		addCharacter(_tentacles.getScientist1CharID())
		addCharacter(_tentacles.getScientist2CharID())
		playAnimation(StageScene.Duo, "stand", {pc=_tentacles.getScientist1CharID(), npc=_tentacles.getScientist2CharID()})
		aimCameraAndSetLocName(_tentacles.LOC_IMPORTANT)
		GM.pc.setLocation(_tentacles.LOC_IMPORTANT)
		_tentacles.tpScientistsWindow()
		saynn("Ты подходишь к армированному окну. По ту сторону, в свете стерильных ламп коридора, ты видишь двух знакомых учёных.")

		saynn("[say=sci1]Ты всё ещё жива. Что ж, я удивлена.[/say]")

		saynn("[say=sci2]В самом деле... подопытный всё ещё сохранил большинство своих {pc.his} конечностей.[/say]")

		saynn("Ты скрещиваешь руки на груди; тон, которым они разговаривают, кажется довольно... пренебрежительным.")

		saynn("[say=pc]Всех до единой. У меня все на месте.[/say]")

		saynn("[say=sci2]Вообще-то, тебя никто не спрашивал.[/say]")

		saynn("[say=pc]Вообще-то, когда вы уже собираетесь меня отпустить?[/say]")

		saynn("Второй учёный хмурит {sci2.his} брови.")

		saynn("[say=sci1]Ну что, уходишь? Просто оставишь это беднягу-пришельца подыхать в одиночестве? Как жестоко.[/say]")

		saynn("Первый ученый насмешливо {sci1.his} цокает языком. Второй наклоняется ближе, запотевая {sci2.his} дыханием... прежде чем вытереть стекло {sci2.his} рукавом.")

		saynn("[say=sci1]Я думал, мы посадили в эту камеру всего одного монстра.[/say]")

		saynn("[say=sci2]Вообще-то... Мы действительно поместили всего лишь одного...[/say]")

		saynn("[say=sci1]Тсс, замолчи.[/say]")

		saynn("Второй ученый обиженно дует губы.")

		saynn("[say=pc]Ну?[/say]")

		saynn("В твою сторону летит самодовольная ухмылка.")

		saynn("[say=sci1]У нас есть кое-какие результаты. Но делиться ими с кем-то вроде тебя мы не собираемся.[/say]")

		saynn("[say=sci2]Слабоумный человек всё равно бы ничего не понял.[/say]")

		saynn("[say=sci1]Дня через два это исследование, скорее всего, будет завершено.[/say]")

		saynn("{sci1.He} говорит это так непринужденно... а затем переглядывается с коллегой {sci1.his}.")

		saynn("[say=pc]Закончили?[/say]")

		saynn("[say=sci1]Да, закончили.[/say]")

		saynn("Тебе не нравится, как это звучит.")

		saynn("[say=sci2]«Закончили» значит, что исследование..[/say]")

		saynn("[say=pc]Не спрашивал.[/say]")

		saynn("[say=sci2]Ну, вообще-то, ты спросил..[/say]")

		saynn("[say=pc]Тсс.[/say]")

		saynn("[say=sci2]Хмф..[/say]")

		saynn("{sci2.He} надувает губы еще сильнее.")

		saynn("[say=pc]Ты нас прикончишь, да?[/say]")

		saynn("[say=sci1]Хочешь дать нам повод? Нет, мы не особо склонны к насилию. Лично я не вижу смысла избавляться от такого... адаптивного... подопытного.[/say]")

		saynn("Застрять здесь... быть подопытным для таких людей... Тюрьма начинает казаться куда более заманчивым местом.")

		saynn("[say=pc]А как же щупальца?[/say]")

		saynn("[say=sci1]Они вроде бы не представляют опасности. Если мы разработаем достаточно прочный стеклянный контейнер, этот пришелец вполне может стать нашим новым офисным растением.[/say]")

		saynn("[say=sci2]Если только наши исследования не найдут этому экземпляру применение получше.[/say]")

		saynn("[say=sci1]В этом и заключается план, да.[/say]")

		saynn("Офисное растение... не самая худшая участь... но и не самая лучшая.")

		saynn("Бросив последний пренебрежительный взгляд на тебя и на монстра за твоей спиной, они разворачиваются и уходят, а их приглушенный разговор постепенно затихает.")

		if (biggestStat == _tentacles.STAT_MIND):
			saynn("Когда ты оборачиваешься, щупальца сворачиваются в клубок.")

		saynn("На этом пора и спать.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pickName"):
		_tentacles.setMonsterName(_args[0])
		_tentacles.setStage(_tentacles.STAGE_SMALL_ENDDAY)
		_tentacles.setMonsterLoc(_tentacles.LOC_MIDDLE)

	setState(_action)

func saveData():
	var data = .saveData()

	data["biggestStat"] = biggestStat

	return data

func loadData(data):
	.loadData(data)

	biggestStat = SAVE.loadVar(data, "biggestStat", -1)
