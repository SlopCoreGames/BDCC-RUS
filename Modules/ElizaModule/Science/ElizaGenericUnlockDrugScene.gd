extends SceneBase

var drugUniqueID = ""
var tfID = ""

func _init():
	sceneID = "ElizaGenericUnlockDrugScene"

func _reactInit():
	var allStrangePills:Array = GM.main.SCI.getPCUnknownStrangePills()
	
	if(allStrangePills.empty()):
		setState("no_drugs_found")
		return
	drugUniqueID = allStrangePills[0].uniqueID
	tfID = allStrangePills[0].getTFID()

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		aimCameraAndSetLocName("med_researchlab")
		if (GM.pc.getLocation() != "med_researchlab"):
			GM.pc.setLocation("med_researchlab")
			saynn("[say=pc]Кажется, у меня есть кое-что, что можно просканировать.[/say]")

			saynn("[say=eliza]Отлично~. Пошли в лабораторию.[/say]")

			saynn("Не теряя времени, вы с Элизой покидаете вестибюль и направляетесь в исследовательскую лабораторию.")

		else:
			saynn("Вы находите Элизу и приводите её в лабораторию.")

		saynn("Странная на вид таблетка в вашей руке пробуждает её интерес. Она надевает латексные перчатки и берет её.")

		saynn("[say=eliza]Ладно, посмотрим, что она делает![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_unlock_tf")
	if(state == "no_drugs_found"):
		saynn("ПРЕПАРАТ НЕ НАЙДЕН. ИЗВИНИТЕ.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_unlock_tf"):
		var theTF = getTF()
		var tfUnlockData = theTF.getUnlockData()
		saynn("Элиза осторожно помещает таблетку внутрь огромного молекулярного сканера и запускает процесс. Машина начинает свою работу: мигают огни, вращаются внутренние детали. Когда она оживает, вы слышите слабое шипение выходящего пара и высокочастотный жужжащий звук сканирующих лазеров.")

		saynn("Вскоре на ближайшем мониторе вспыхивают результаты.")

		saynn("[say=eliza]Хм... интересно. Очень интересно.[/say]")

		saynn("Она жестом приглашает вас подойти, возбужденно подергивая хвостом. На экране отображается сложная молекулярная структура, выделенная красным и черным цветами. Для вас это почти ничего не значит.")

		saynn("[say=eliza]"+str(tfUnlockData["eliza"])+"[/say]")

		saynn("Сканировав и уничтожив таблетку, Элиза переходит к другим машинам и включает их. Вскоре она демонстрирует тебе идеальную молекулярную копию этой "+str(theTF.getPillName())+" pill.")

		saynn("[say=eliza]Хочешь попробовать~?[/say]")

		addButton("No", "Ты предпочёл не быть подопытным", "no_test_subject")
		addButton("Скушать", "Сожрать таблетку, раз уж она бесплатная!", "yes_eat_pill")
		addUnlockTFButtons(tfUnlockData)
		if (false):
			addButton("Плохо", "Тебе не стоит этого видеть", "doRunUnlockScene")
	if(state == "no_test_subject"):
		saynn("[say=pc]Я, пожалуй, откажусь, спасибо.[/say]")

		saynn("Кошка улыбается.")

		saynn("[say=eliza]Ну ладно, тогда я сама найду себе добровольного подопытного~.[/say]")

		saynn("Её когтистая лапа убирает таблетку.")

		saynn("[say=eliza]Но если найдёшь кого-то первым, протестируй на нём эту таблетку и приводи сюда. Конечно, придётся подождать, пока трансформация не достигнет финальной стадии. Иначе в этом мало смысла.[/say]")

		saynn("Похоже, тебе всё же придётся сделать эту таблетку самому...")

		saynn("[say=eliza]Так держать, ассистент. А я пойду продолжу свою смену.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "eat_no_effect"):
		saynn("Что может пойти не так... Ты хватаешь таблетку из лапы Элизы... и закидываешь её в рот.")

		saynn("[say=eliza]"+str(RNG.pick(["Какая нетерпеливость~.", "Обожаю такой энтузиазм~.", "Вот так~.", "Мне даже не пришлось тебя уговаривать~.", "Если бы все подопытные были такими, как ты~."]))+"[/say]")

		saynn("Ты выравниваешь дыхание и пытаешься сосредоточиться на себе... Время идет... но ты не чувствуешь никаких изменений. Похоже, таблетка не сработала...")

		saynn("[say=eliza]Оу. Не каждая таблетка подходит каждому; наш организм достаточно умен, чтобы отвергать те изменения ДНК, которые не может выдержать.[/say]")

		saynn("[say=pc]И что же мне тогда делать?[/say]")

		saynn("Элиза что-то напевает под нос.")

		saynn("[say=eliza]Тебе придется... найти кого-нибудь другого для теста. Подопытного, именно так. Приведи его ко мне, когда трансформация достигнет финальной стадии, и тогда я смогу просканировать его, чтобы получить больше информации о препарате.[/say]")

		saynn("Подопытный... ясно...")

		saynn("[say=eliza]Ну, или ты всегда можешь попробовать изменить сначала себя... С помощью других таблеток.[/say]")

		saynn("Звучит так, будто всё может быстро выйти из-под контроля...")

		saynn("[say=eliza]В любом случае, так держать, ассистент~. А я пойду продолжу свою смену.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "eat_has_effect"):
		saynn("Что может пойти не так... Ты хватаешь таблетку из лапы Элизы... и закидываешь её в рот.")

		saynn("[say=eliza]"+str(RNG.pick(["Какая нетерпеливость~.", "Обожаю такой энтузиазм~.", "Вот так~.", "Мне даже не пришлось тебя уговаривать~.", "Если бы все подопытные были такими, как ты~."]))+"[/say]")

		saynn("Ты выравниваешь дыхание и пытаешься сосредоточиться на себе... И вскоре ты начинаешь чувствовать... что-то... меняющееся внутри тебя. Трудно понять, что именно... но это определенно происходит.")

		saynn("[say=pc]Я чувствую это..[/say]")

		saynn("Элиза улыбается.")

		saynn("[say=eliza]Отлично! Возвращайся ко мне, когда трансформация достигнет финальной стадии, и тогда я смогу её просканировать! Это даст нам кучу информации об этом процессе.[/say]")

		saynn("Ты чувствуешь себя... подопытным. Потому что так оно и есть.")

		saynn("[say=eliza]Так держать, ассистентка~. Это не мгновенный процесс, нужно время. А пока можешь попытаться раздобыть ещё таблеток. А я пойду возвращаться к смене.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func getPill():
	return GM.pc.getInventory().getItemByUniqueID(drugUniqueID)

func getTF():
	return GlobalRegistry.getTransformationRef(tfID)

func addUnlockTFButtons(tfUnlockData):
	if(!tfUnlockData.has("tryOptions")):
		return
	for optionEntry in tfUnlockData["tryOptions"]:
		addButton(optionEntry["name"], optionEntry["desc"], "doRunUnlockScene", [optionEntry])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_unlock_tf"):
		processTime(25*60)
		GM.main.SCI.doUnlockTF(tfID)
		var thePill = getPill()
		if(thePill != null):
			thePill.removeXOrDestroy(1)

	if(_action == "no_test_subject"):
		processTime(3*60)

	if(_action == "yes_eat_pill"):
		processTime(10*60)
		if(!GM.pc.getTFHolder().canStartTransformation(tfID)):
			setState("eat_no_effect")
		else:
			GM.pc.getTFHolder().startTransformation(tfID)
			setState("eat_has_effect")
		return

	if(_action == "doRunUnlockScene"):
		var optionEntry = _args[0]
		
		runScene(optionEntry["sceneID"])
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["drugUniqueID"] = drugUniqueID
	data["tfID"] = tfID

	return data

func loadData(data):
	.loadData(data)

	drugUniqueID = SAVE.loadVar(data, "drugUniqueID", "")
	tfID = SAVE.loadVar(data, "tfID", "")
