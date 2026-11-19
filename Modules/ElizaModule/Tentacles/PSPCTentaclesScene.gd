extends SceneBase

var tentMood = ""
var firstPlay = false
var hasNeuro = false
var slaveID = ""

func _init():
	sceneID = "PSPCTentaclesScene"

func _reactInit():
	firstPlay = true

func resolveCustomCharacterName(_charID):
	if(_charID == "slave"):
		return slaveID

func _run():
	if(state == ""):
		addCharacter("PCTentacles")
		tentMood = getFlag("ElizaModule.tent_mood", "")
		hasNeuro = getFlag("ElizaModule.tent_neurolink", false)
		saynn("Вы приближаетесь к {pcTentacles}.")

		if (tentMood == "mean"):
			playAnimation(StageScene.TentaclesDuo, "glare", {plant=true, instantSleep=firstPlay})
			saynn("Похоже, оно в скверном настроении.")

		elif (tentMood == "kind"):
			playAnimation(StageScene.TentaclesStroke, RNG.pick(["tease", "stroke"]), {plant=true})
			saynn("Похоже, оно в благодушном настроении.")

		elif (tentMood == "lusty"):
			playAnimation(StageScene.TentaclesGrope, "tease", {plant=true})
			saynn("Похоже, оно в похотливом настроении и лениво ощупывает вас.")

		else:
			playAnimation(StageScene.TentaclesDuo, "idle", {plant=true, instantSleep=firstPlay})
			saynn("Похоже, оно в своем обычном настроении.")

		firstPlay = false
		addButton("Подчиниться", "(Секс) Подчиниться щупальцам и позволить им делать с вами всё, что им вздумается...", "doSubmit")
		if (GM.main.getDynamicCharacterIDsFromPool(CharacterPool.Slaves).size() <= 0):
			addDisabledButton("Предложить рабыню", "В данный момент у вас нет рабов...")
		else:
			addButton("Предложить рабыню", "(Секс) Отдать щупальцам одну из своих рабынь, чтобы они могли развлечься", "pick_slave_menu")
		addButton("Настроение", "Взаимодействуйте с щупальцами, чтобы изменить их настроение", "mood_menu")
		if (!hasNeuro):
			if (GM.pc.getInventory().hasItemID("TentNeuroLink")):
				addButton("Нейролинк", "Ввести в щупальца чип Нейро-Связи", "doInjectNeuro")
			else:
				addDisabledButton("Нейролинк", "Сначала нужно разблокировать и создать чип Нейро-Связи в биолаборатории...")
		addButton("Изменить имя", "Изменить обращение к щупальцам", "name_menu")
		addButton("Уйти", "Оставить щупальца в покое", "endthescene")
	if(state == "doInjectNeuro"):
		playAnimation(StageScene.TentaclesDuo, "glare", {plant=true})
		saynn("Вы приближаетесь к {pcTentacles}, стараясь не высовывать инъектор.")

		saynn("Но кажется, они всё равно что-то подозревают. Зелёные кончики буквально сверлят вас взглядами. Тогда вы решаете просто показать инъектор и объяснить, для чего он нужен.")

		saynn("[say=pc]Это... это апгрейд для вас. Он... расширит горизонты ваших возможностей.[/say]")

		saynn("Вы подходите чуть ближе и пытаетесь вонзить иглу в один из отростков... но тот ловко уворачивается и отвешивает вам смачный подзатыльник.")

		saynn("Оно явно тебе не доверяет.")

		saynn("[say=pc]Ладно.. Судя по всему, оно позволит мне временно управлять тобой. Это правда. По-моему, звучит весело, не так ли?[/say]")

		saynn("Все щупальца переглядываются, безмолвно принимая решение.")

		saynn("[say=pc]Что думаешь? Обещаю не злоупотреблять этой властью.. если вообще всё сработает.[/say]")

		saynn("Большинство щупалец сосредоточены на главном, самом толстом отростке. Он замирает на несколько секунд, наблюдая за тобой. Почему-то ты чувствуешь, как от макушки начинает разливаться.. тепло..")

		saynn("Это щупальце.. оно читает твои мысли? Скорее всего, сканирует их, чтобы понять твои намерения.")

		saynn("Пока оно это делает.. его зеленые кончики становятся совсем скользкими и влажными.. куда сильнее, чем раньше.")

		saynn("Толстое щупальце медленно тянется к тебе. Оно замирает возле твоей головы.. и едва заметно кивает.")

		saynn("Оно знает, что ты собираешься сделать.")

		saynn("Медленно ты подносишь к нему инъектор.. и вводишь препарат; инструмент издает тихое шипящее звуко.")

		saynn("Когда ты заканчиваешь... ты понимаешь, что в инъекторе всё ещё что-то осталось. Ах да, в нём же содержимое для реципиента.")

		saynn("Ты зашёл уже так далеко... так почему бы не довести дело до конца?")

		saynn("Ты подносишь инъектор к затылку... и вводишь препарат в себя.")

		saynn("На мгновение ничего не происходит.")

		saynn("А затем... весь мир разлетается на осколки.")

		saynn("Ты чувствуешь пульсирующую головную боль, подобной которой никогда не испытывал. Кажется, будто твой разум расширяется... но слишком быстро, чтобы это было приятно. Ты пошатываешься, хватаясь за стену, чтобы не упасть. Зрение затуманивается... чувства начинают различать цвета, которых не существует... и звуки, лишенные всякого смысла...")

		saynn("[say=pc]Ааагх...[/say]")

		saynn("Так продолжается около минуты... но в конце концов боль утихает, и очертания твоей камеры снова обретают четкость.")

		saynn("Тентакли наблюдают за тобой, с любопытством водя своими кончиками.")

		saynn("[say=PCTentacles]Ты слышишь нас?[/say]")

		saynn("Что? Ого, ничего себе.")

		saynn("[say=pc]Да.. Кажется, так и есть.[/say]")

		saynn("[say=PCTentacles]Хорошо. Но ты чувствуешь нас?[/say]")

		saynn("Ты моргаешь и на секунду задумываешься.")

		saynn("Ох.")

		saynn("Ты ощущаешь легкий ветерок. Но он касается не тебя.. он касается твоего продолжения. Ты понимаешь, что чувствуешь каждый отдельный отросток. Они все там.. где-то на задворках твоего сознания.")

		saynn("Ты думаешь о том, чтобы приподнять толстый щупалец.. И, без каких-либо сознательных усилий, он подчиняется.")

		saynn("Ты думаешь о том, чтобы отпустить его. И он повинуется.")

		saynn("Ты направляешь одно из щупалец вперед и касаешься себя, кончик проводит по самому подбородку. Это сюрреалистичное чувство.. ты ощущаешь оба касания одновременно.")

		saynn("[say=pc]Я могу управлять тобой.. Я действительно могу тобой управлять. Я могу заставить тебя делать всё, что угодно.[/say]")

		saynn("[say=PCTentacles]Можешь. Но не станешь.[/say]")

		saynn("Верно.. Тебе тоже нужно держать себя в руках.")

		saynn("[say=pc]Ты способен взять меня под контроль?[/say]")

		saynn("[say=PCTentacles]Возможно, и смогли бы. Но не станем. Потому что мы тебе благодарны. Без тебя не было бы нас.[/say]")

		saynn("Ты закрываешь глаза и сосредотачиваешься. И вот они.. множественные разумы щупалец.. их мысли. Любопытство. Привязанность. Доверие.. Голод.")

		saynn("[say=pc]Так.. Могу ли я управлять тобой, когда принесу немного..[/say]")

		saynn("[say=PCTentacles]Пожалуйста, чувствуй себя как дома. Мы желаем оплодотворить как можно больше представителей твоего вида.[/say]")

		saynn("Ну и похотливые же они трахины.")

		if (getFlag("ElizaModule.tent_eliza")):
			saynn("[say=PCTentacles]И спасибо, что предложила нам.. Элизу.. так её зовут. Точно. Она была отличной кормилицей для наших яиц, нам очень понравилось её общество.[/say]")

			saynn("Ты киваешь.")

			saynn("[say=pc]Для неё это, похоже, стало скорее.. специфическим вкусом.. со временем.[/say]")

		saynn("И вот так просто... вы все узнали что-то новое.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "name_menu"):
		saynn("Как ты хочешь назвать свои щупальца?")

		addTentacleNameButtons()
		if (false):
			addButton("Игнорировать", "тебе не стоит на это смотреть", "pick_name")
	if(state == "picked_name"):
		removeCharacter("PCTentacles")
		addCharacter("PCTentacles")
		saynn("[say=pc]Думаю.. {pcTentacles} тебе отлично подходит.[/say]")

		saynn("Услышав тебя, отростки задергались. Похоже, имя им понравилось.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "doSubmit"):
		playAnimation(StageScene.TentaclesDuo, "glare", {plant=true, npcAction="kneel"})
		saynn("Ты подходишь к {pcTentacles} и опускаешься перед ним на колени.")

		saynn("Как только ты это делаешь, множество щупалец уже начинают тянуться к тебе и твоему телу...")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_sex")
	if(state == "after_sex"):
		saynn("После секса ты поднимаешься и отходишь от щупалец...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "mood_menu"):
		saynn("Что ты хочешь сделать с щупальцами?")

		addButton("Погладить", "Погладить щупальца, чтобы сделать их ласковыми", "mood_pat")
		addButton("Шлепок", "Хлестнуть щупальца, чтобы разозлить их", "mood_slap")
		addButton("Подразнить", "Дразнить щупальца, чтобы они изголодались по твоим дырочкам...", "mood_tease")
		addButton("Просто поболтать", "Поболтать с щупальцами, чтобы сбросить их настроение", "mood_chat")
		addButton("Назад", "Вы передумали", "")
	if(state == "mood_pat"):
		playAnimation(StageScene.TentaclesStroke, "fast", {plant=true})
		saynn("Ты подходишь к {pcTentacles} и начинаешь поглаживать его щупальца!")

		saynn("Отростки радостно извиваются и тянутся к твоим рукам, меняясь местами каждые несколько секунд.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "mood_slap"):
		playAnimation(StageScene.TentaclesDuo, "whip", {plant=true, npcAction="shove"})
		saynn("Ты решаешь шлепнуть {pcTentacles}, ударив по одному из его щупалец!")

		saynn("Щупальца отпрянули от твоей внезапной атаки... и попытались ударить тебя в ответ, а их кончики теперь свирепо смотрят на тебя.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "mood_tease"):
		playAnimation(StageScene.TentaclesGrope, "grope", {plant=true})
		saynn("Ты виляешь своей попой {pc.thick} перед щупальцами... и наблюдаешь, как их кончики становятся влажными и скользкими.")

		saynn("Множество щупалец тянутся к тебе, жадно ощупывая тело.")

		saynn("Ты позволяешь им это делать какое-то время... прежде чем вырваться из их хватки.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "mood_chat"):
		playAnimation(StageScene.TentaclesDuo, "idle", {plant=true})
		saynn("Ты просто немного болтаешь с щупальцами. Объясняешь им, что это за место, как оно устроено и всё в таком духе.")

		saynn("Щупальца, кажется, не могут ответить... но они явно слушают и понимают почти всё, что ты говоришь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "pick_slave_menu"):
		saynn("Какую из твоих рабынь ты хочешь отдать на растерзание щупальцам?")

		addButton("Отмена", "Вы передумали", "endthescene")
		addSlaveButtons()
		if (false):
			addButton("Неа", "Этого вообще не должны были видеть", "pick_slave")
	if(state == "confirm_pick_slave"):
		addCharacter(slaveID)
		playAnimation(StageScene.TentaclesGrope, "tease", {pc=slaveID, plant=true})
		saynn("Ты заталкиваешь {slave.name} прямо в свои щупальца!")

		saynn("Щупальца мгновенно хватают {slave.him}, готовясь оторваться по полной...")

		addButton("Продолжить", "Дать щупальцам самим развлечься с твоей рабыней", "start_slave_sex")
		if (hasNeuro):
			addButton("Нейролинк", "Использовать нейро-линк, чтобы управлять щупальцами, пока они трахают твою рабыню", "start_slave_sex_neuro")
		else:
			addDisabledButton("Нейролинк", "Сначала вам нужно разблокировать и создать устройство Нейро-Связи в биолаборатории...")
	if(state == "after_sex_slave"):
		saynn("После этого секса ты хватаешь свою рабыню и снова {slave.him} на поводок...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addTentacleNameButtons():
	for theName in PlayerSlaveryTentacles.MONSTER_NAMES:
		addButton(theName, "Выбери это имя!", "pick_name", [theName])

func addSlaveButtons():
	var slaves = GM.main.getDynamicCharacterIDsFromPool(CharacterPool.Slaves)
	for charID in slaves:
		var character:DynamicCharacter = getCharacter(charID)
		var npcSlavery:NpcSlave = character.getNpcSlavery()
		if(npcSlavery == null):
			continue
		if(npcSlavery.isDoingActivity()):
			addDisabledButton(character.getName(), "Эта рабыня сейчас занята")
			continue
		addButton(character.getName(), character.getSmallDescription(), "pick_slave", [charID])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "doInjectNeuro"):
		processTime(20*60)
		setFlag("ElizaModule.tent_neurolink", true)
		GM.pc.getInventory().removeXOfOrDestroy("TentNeuroLink", 1)
		addMessage("Теперь вы можете управлять щупальцами еще до начала секса!")

	if(_action == "pick_name"):
		setFlag("ElizaModule.tent_name", _args[0])
		setState("picked_name")
		return

	if(_action == "start_sex"):
		getCharacter("PCTentacles").prepareForSex()
		runScene("GenericSexScene", ["PCTentacles", "pc", SexType.TentaclesSex, {}], "tentaclesSex")
		setState("after_sex")
		return

	if(_action == "mood_pat"):
		setFlag("ElizaModule.tent_mood", "kind")
		addMessage("Щупальца больше не будут вести себя жестоко.")

	if(_action == "mood_slap"):
		setFlag("ElizaModule.tent_mood", "mean")
		addMessage("Теперь во время секса щупальца будут вести себя очень грубо.")

	if(_action == "mood_tease"):
		setFlag("ElizaModule.tent_mood", "lusty")
		addMessage("Теперь щупальца невероятно жаждут осеменения.")

	if(_action == "mood_chat"):
		setFlag("ElizaModule.tent_mood", "")
		addMessage("Теперь у щупалец нет никаких предпочтений во время секса.")

	if(_action == "pick_slave"):
		slaveID = _args[0]
		setState("confirm_pick_slave")
		return

	if(_action == "start_slave_sex"):
		getCharacter("PCTentacles").prepareForSex()
		runScene("GenericSexScene", ["PCTentacles", slaveID, SexType.TentaclesSex, {}], "tentaclesSexSlave")
		setState("after_sex_slave")
		return

	if(_action == "start_slave_sex_neuro"):
		getCharacter("PCTentacles").prepareForSex()
		runScene("GenericSexScene", ["PCTentacles", slaveID, SexType.TentaclesSex, {SexMod.PCControlsDoms:true}], "tentaclesSexSlaveNeuro")
		setState("after_sex_slave")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["tentMood"] = tentMood
	data["firstPlay"] = firstPlay
	data["hasNeuro"] = hasNeuro
	data["slaveID"] = slaveID

	return data

func loadData(data):
	.loadData(data)

	tentMood = SAVE.loadVar(data, "tentMood", "")
	firstPlay = SAVE.loadVar(data, "firstPlay", false)
	hasNeuro = SAVE.loadVar(data, "hasNeuro", false)
	slaveID = SAVE.loadVar(data, "slaveID", "")
