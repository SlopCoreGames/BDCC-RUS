extends SceneBase

var socketLine = ""

func _init():
	sceneID = "SocketPunishmentScene"

func _reactInit():
	var possible = ["tieup", "tieup"]
	if(!GM.pc.isWearingHypnovisor()):
		possible.append("hypnovisor")
	
	var pickedRandom = RNG.pick(possible)
	
	if(pickedRandom == "hypnovisor"):
		var visor = GlobalRegistry.createItem("HypnovisorMk0")
		visor.restraintData.setLevel(5)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(visor)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ZiptiesWrist"))
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("bondagemittens"))
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
	
	
	if(pickedRandom == "tieup"):
		var rope = GlobalRegistry.createItem("ropeharness")
		rope.restraintData.setLevel(5)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(rope)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("blindfold"))
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ZiptiesAnkle"))
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ZiptiesWrist"))
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("bondagemittens"))
	
	setState(pickedRandom)
	
	socketLine = "Что-то не так! Скажи разработчику! Погоди, почему я это сказала..."
	var punishReason = getFlag("SocketModule.punishReason", "")
	if(punishReason == "stuckroughfuck"):
		socketLine = "Вчера ты был очень груб со мной! У меня до сих пор киска болит."
	elif(punishReason == "stuckroughassfuck"):
		socketLine = "Анальный секс со мной — это табу! Моя жопка только для того, чтобы её лапали. Надеюсь, теперь ты это запомнишь."
	elif(punishReason == "spikeddrink"):
		socketLine = "Вчера я чувствовала себя странно. И решила кое-что проверить. В моей киске нашли следы мощного афродизиака! Ты ведь ничего об этом не знаешь, а? И ты мне не сказал!"
	elif(punishReason == "hadcumafterbrainwash"):
		socketLine = "Я не помню, что произошло вчера... Но у меня болела жопа и из неё текла сперма! Думаю, это твоя вина... Анальный секс со мной — это табу!"
	return

func _run():
	if(state == ""):
		saynn("Этого здесь быть не должно.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "tieup"):
		addCharacter("socket")
		playAnimation(StageScene.Hogtied, "idle", {pc="pc"})
		saynn("После долгой ночи твои глаза открываются...")

		saynn("Вокруг очень темно... Неужели кто-то забыл включить свет?")

		saynn("Ты пытаешься протереть глаза... но быстро понимаешь, что не можешь — что-то тебе мешает. Верёвки! Ты привязан к собственной кровати.")

		saynn("[say=socket]О, ты уже проснулась! Доброе утро! Гадаешь, почему ты с повязкой на глазах и связана?[/say]")

		saynn("Хм. Похоже, Сокет тебя за что-то наказывает.")

		saynn("[say=socket]"+str(socketLine)+"[/say]")

		saynn("Ну да... В этой ситуации преимущество явно на её стороне.")

		saynn("[say=pc]Прости, что?[/say]")

		saynn("[say=socket]Ты прощена![/say]")

		saynn("Это было быстро.")

		saynn("[say=pc]Теперь можешь меня развязать?[/say]")

		saynn("Ответа нет...")

		saynn("[say=pc]Розетка?[/say]")

		saynn("Похоже, она ушла...")

		addButton("Продолжить", "Смотреть, что будет дальше", "escape_loop")
	if(state == "escape_loop"):
		removeCharacter("socket")
		playAnimation(StageScene.Hogtied, "idle", {pc="pc"})
		saynn("Ты привязана к кровати в своей собственной камере.")

		addButton("Отдохнуть", "Перевести дух", "escape_rest")
		addButtonWithChecks("Сопротивление", "Начать вырываться из пут", "escape_do_struggle", [], [[ButtonChecks.HasStamina]])
		addButtonWithChecks("Встать", "Хватит валяться без дела", "escape_do_getup", [], [[ButtonChecks.NotArmsRestrained], [ButtonChecks.NotLegsRestrained], [ButtonChecks.NotWearingItem, "ropeharness"]])
	if(state == "escape_do_getup"):
		playAnimation(StageScene.Solo, "stand")
		saynn("Ура, тебе удалось пережить маленькое наказание от Сокета. О, смотри, на твоей подушке лежит кредитный чип с одной монетой. Неужели Сокет его оставил?")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "escape_rest"):
		saynn("Ты сдаешься и пытаешься немного отдохнуть...")

		addButton("Отдых", "Ты отдыхаешь", "escape_rest1")
	if(state == "escape_rest1"):
		saynn("Ты отдыхаешь...")

		addButton("Отдых", "Ты отдыхаешь", "escape_rest2")
	if(state == "escape_rest2"):
		saynn("Всё ещё отдыхаешь...")

		addButton("Отдых", "Ты отдыхаешь", "escape_rest3")
	if(state == "escape_rest3"):
		saynn("Ты проспал несколько часов...")

		if (GM.main.isVeryLate()):
			saynn("Каким-то образом тебе удалось провести весь день в мучениях! Пора спать...")

			addButton("Спать", "Лечь спать", "escape_sleep")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "escape_loop")
	if(state == "escape_sleep"):
		saynn("Добро пожаловать в новый день! Сон в связанном состоянии — не самое приятное впечатление в твоей жизни...")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_decides_to_save")
	if(state == "socket_decides_to_save"):
		addCharacter("socket")
		playAnimation(StageScene.Duo, "stand", {npc="socket"})
		saynn("Внезапно ты чувствуешь, что кто-то развязывает тебя на кровати!")

		saynn("[say=socket]Эй, мне было не по себе от того, что я оставила тебя в таком виде на весь день. Прости![/say]")

		saynn("Ого, какая добрая лисичка-фенек.")

		saynn("[say=pc]Всё в порядке. Сейчас развяжешь меня?[/say]")

		if (GM.pc.isBlindfolded()):
			saynn("Никакой реакции... опять...")

			saynn("[say=pc]Так..[/say]")

		else:
			saynn("Сокет улыбается и просто уходит. Ну да, конечно...")

		saynn("По крайней мере, ты свободна. В каком-то смысле.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "hypnovisor"):
		addCharacter("socket")
		playAnimation(StageScene.Duo, "stand", {npc="socket"})
		saynn("После долгой ночи ты открываешь глаза... и понимаешь, что мир кажется куда более живым. Единственная проблема в том, что твои руки, кажется, связаны...")

		saynn("[rainbow freq=0.05 sat=0.9 val=1.0]Всё такое яркое и красочное.[/rainbow]")

		saynn("[say=socket]Доброе утро! Хорошо спалось?[/say]")

		saynn("Ты встаешь с кровати и видишь Сокет неподалеку. Тебе кажется... что это она сделала с тобой... и кажется, что ты должна её поблагодарить...")

		saynn("[say=pc]Да, спасибо![/say]")

		saynn("Сокет хихикает.")

		saynn("[say=socket]Интересно, почему я это сделала?[/say]")

		saynn("Ты качаешь головой. Зачем вообще об этом думать...")

		saynn("Сокет снова хихикает.")

		saynn("[say=socket]"+str(socketLine)+"[/say]")

		saynn("Понятно...")

		saynn("[say=pc]Мне очень жаль, больше никогда, никогда, никогда не повторится![/say]")

		saynn("[say=socket]Ты прощена![/say]")

		saynn("Это было быстро. Вы киваете. Сокет кивает в ответ.")

		saynn("Сокет уходит...")

		saynn("Похоже, визор остается у тебя. Она такая милая, правда?")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "escape_do_struggle"):
		runScene("StrugglingScene", [true, false], "escape_struggle")
		return

	if(_action == "escape_do_getup"):
		GM.pc.addCredits(1)

	if(_action == "escape_rest1"):
		processTime(60*60)
		GM.pc.addStamina(15)

	if(_action == "escape_rest2"):
		processTime(60*60)
		GM.pc.addStamina(15)

	if(_action == "escape_rest3"):
		processTime(70*60)
		GM.pc.addStamina(15)

	if(_action == "escape_sleep"):
		GM.main.startNewDay()
		GM.pc.afterSleepingInBed()

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "escape_struggle"):
		processTime(5*60)
		setState("escape_loop")

func saveData():
	var data = .saveData()

	data["socketLine"] = socketLine

	return data

func loadData(data):
	.loadData(data)

	socketLine = SAVE.loadVar(data, "socketLine", "")
