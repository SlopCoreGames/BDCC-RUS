extends SceneBase

var howManyTimes = 0

func _init():
	sceneID = "AlexS4FixingDatapadsScene"

func _initScene(_args = []):
	addCharacter("alexrynard")
	howManyTimes = getFlag("AlexRynardModule.ch1HowMoreIdles", 0)
	
	if(howManyTimes == 0):
		setState("first_time")
		increaseFlag("AlexRynardModule.ch1HowMoreIdles")
		return
	if(howManyTimes == 1):
		setState("time2")
		increaseFlag("AlexRynardModule.ch1HowMoreIdles")
		return
	if(howManyTimes == 2):
		setState("time3")
		increaseFlag("AlexRynardModule.ch1HowMoreIdles")
		return
	if(howManyTimes == 3 || true):
		setState("time4")
		increaseFlag("AlexRynardModule.ch1HowMoreIdles")
		return

func _run():
	if(state == ""):
		addCharacter("alexrynard")
	if(state == "first_time"):
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard", npcAction="sit"})
		saynn("Ты присоединяешься к Алексу. И сегодня тебе впервые разрешили помочь!")

		saynn("[say=alexrynard]Не слишком радуйся. Видишь вот эти? Замени в них батарейки.[/say]")

		saynn("Это довольно просто. Хоть и скучно.")

		saynn("Ты начинаешь с того, что берешь одно из сломанных устройств, снимаешь крышку батарейного отсека и вытаскиваешь старую батарейку. Эта была особенно протекшей, так что ты берешь спиртовые салфетки и быстро все вытираешь, прежде чем вставить новую батарейку.")

		saynn("Алекс следит за каждым твоим движением. От этого становится немного не по себе, но зато заставляет тебя работать очень аккуратно.")

		saynn("Заменив несколько батареек, он кивает и принимается за попытки починить самые убитые датапады. Те, что кажутся почти безнадежными.")

		saynn("Ты гадаешь, можно ли уже начать расспрашивать его о чем-нибудь.")

		saynn("[say=pc]Почему тебе не помогают другие инженеры?[/say]")

		saynn("[say=alexrynard]Это тяжелая и нудная работа. У местных инженеров не хватает терпения. Впрочем, их можно понять: я бы тоже этим не занимался, если бы капитан не приказал.[/say]")

		saynn("Хм.")

		saynn("[say=pc]Это что, своего рода наказание?[/say]")

		saynn("[say=alexrynard]Наказание? Да нет. Кап просто хочет занять меня делом, наверное.[/say]")

		saynn("[say=pc]Есть какая-то причина?[/say]")

		saynn("Алекс хмурится.")

		saynn("[say=alexrynard]Ты здесь, чтобы помочь, или чтобы отвлекать?[/say]")

		saynn("Справедливо. Ты решаешь пока помалкивать, просто меняя батарейки.")

		addButton("Продолжить", "Смотреть, что будет дальше", "skiphours_check")
	if(state == "toolate"):
		saynn("Время летит... Смена инженера подходит к концу, как раз вовремя.")

		if (!getFlag("AlexRynardModule.ch1CommentedPay")):
			setFlag("AlexRynardModule.ch1CommentedPay", true)
			saynn("[say=alexrynard]Вот, держи.[/say]")

			saynn("Алекс протягивает тебе чип.")

			saynn("[say=pc]А?[/say]")

			saynn("[say=alexrynard]Один рабочий кредит. Подумала, что стоит тебе хоть что-то заплатить.[/say]")

			saynn("Немного за целый день... но всё же лучше, чем ничего.")

		else:
			saynn("[say=alexrynard]Вот. Спасибо за помощь.[/say]")

			saynn("Алекс протягивает тебе чип.")

		saynn("Пора идти..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "aftersomefixing"):
		saynn("Время летит. Вы с Алексом чините еще несколько датападов.")

		saynn("[say=alexrynard]Давай пока сделаем перерыв.[/say]")

		saynn("Он аккуратно убирает инструменты и недоделанную работу в один из ящиков, а затем запирает его.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "time2"):
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard", npcAction="sit"})
		saynn("Вы с Алексом садитесь рядом. Оба принимаетесь за починку сломанных датападов.")

		saynn("Сегодня особо ничего не происходит. Но вы чините большинство простых устройств, которым требуется всего лишь замена батареи!")

		addButton("Продолжить", "Смотреть, что будет дальше", "skiphours_check")
	if(state == "time3"):
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard", npcAction="sit"})
		saynn("Вы решаете взглянуть на кучу сломанных датападов. Она определенно... немного уменьшилась. Ура!")

		saynn("Это дает вам прилив мотивации продолжать работу.")

		saynn("[say=alexrynard]Можешь попробовать вот эти. Замени матрицы дисплея и кнопки там, где это необходимо.[/say]")

		saynn("О, это не должно быть слишком сложно. Алекс наблюдает, как вы берете один из датападов, откручиваете переднюю панель, осторожно отсоединяете дисплей от материнской платы, а затем заменяете его. Увидев, как вы делаете это несколько раз, он тоже принимается за ремонт.")

		saynn("[say=pc]И что ты собираешься делать, когда мы разберемся со всеми залежами?[/say]")

		saynn("[say=alexrynard]Сомневаюсь, что это случится.[/say]")

		saynn("[say=pc]Возможно.[/say]")

		saynn("[say=alexrynard]Сначала Вселенная сдохнет.[/say]")

		saynn("[say=pc]И всё же.[/say]")

		saynn("[say=alexrynard]Я предпочитаю не видеть снов. Их всё равно украдут.[/say]")

		saynn("Вау, ну и зануда.")

		saynn("Внезапно его личный датапад начинает пищать и жужжать.")

		saynn("[say=alexrynard]Ах, черт возьми. Надо сбегать по делам.[/say]")

		saynn("[say=pc]Можно мне с тобой?[/say]")

		saynn("[say=alexrynard]Не, это личное. Вообще, лучше оставайся здесь, но не смей трогать датапады, пока меня не будет.[/say]")

		saynn("[say=pc]Не стану.[/say]")

		saynn("Он качает головой и достает... пластиковые стяжки.")

		saynn("[say=alexrynard]Мы оба знаем, что станешь. Руки за спину.[/say]")

		saynn("Он что, реально...")

		addButton("Руки за спину", "Сделать, как он говорит", "time3_tie")
	if(state == "time3_tie"):
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard", npcAction="stand"})
		saynn("Пожалуй, стоит ему довериться. Ты заводишь руки за спину и ждешь, пока Алекс стягивает твои запястья к спинке стула с помощью стяжек. Пикантно.")

		saynn("[say=alexrynard]Я знаю, что ты умеешь чинить вещи. Но я не верю, что ты не начнешь их ломать.[/say]")

		saynn("[say=pc]Что?[/say]")

		saynn("[say=alexrynard]Мне пора.[/say]")

		saynn("Он поспешно уходит.")

		addButton("Продолжить", "Смотреть, что будет дальше", "time3_alexleaves")
	if(state == "time3_alexleaves"):
		removeCharacter("alexrynard")
		playAnimation(StageScene.Solo, "sit")
		saynn("Проходит некоторое время...")

		saynn("Вы сидите в одиночестве за одним из рабочих столов. Делать особо нечего.")

		saynn("Вам становится так скучно, что вы начинаете дергать за ремни.")

		saynn("И... хм... Похоже, Алекс не затянул их как следует. Кажется, если продолжать, можно вырваться.")

		saynn("Он может разозлиться, если вы это сделаете. Но, может, это станет доказательством его ошибки?")

		addButton("Замереть", "Просто позволить скуке поглотить вас", "time3_bored")
		addButton("Дергать сильнее", "Попытаться освободиться от пут", "time3_escape")
	if(state == "time3_bored"):
		saynn("Лучше не злить этого лиса и просто сидеть смирно.")

		saynn("Не то чтобы это было захватывающе... но, по крайней мере, ты не подрываешь его доверие.")

		addButton("Продолжить", "Смотреть, что будет дальше", "time3_bored_return")
	if(state == "time3_bored_return"):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard"})
		saynn("Алекс скоро вернется. Он замечает, что твои руки всё еще связаны... но всё равно проверяет, не трогали ли инструменты или датапады.")

		saynn("[say=alexrynard]Отличная работа, ты справилась.[/say]")

		saynn("Алекс звучит немного саркастично. Но по-доброму.")

		saynn("[say=pc]Спасибо. Ты не против?[/say]")

		saynn("[say=alexrynard]Точно, я почти забыла.[/say]")

		saynn("Он снимает стяжки с твоих рук.")

		saynn("[say=pc]Ты не кажешься мне забывчивым человеком.[/say]")

		saynn("[say=alexrynard]Такое ощущение, будто ты на что-то намекаешь.[/say]")

		saynn("Он мягко улыбается.")

		saynn("После всего этого вы вдвоем возвращаетесь к починке датападов.")

		addButton("Продолжить", "Смотреть, что будет дальше", "skiphours_check")
	if(state == "time3_escape"):
		playAnimation(StageScene.Solo, "sit")
		saynn("Да, ты докажешь ему, что ему можно тебе доверять.")

		saynn("Ты всё сильнее тянешь за пластиковые стяжки, постепенно ослабляя их. Это занимает время... но в конце концов тебе удается вырвать запястья!")

		saynn("И теперь... снова время ничего не делать.")

		addButton("Продолжить", "", "time3_escape_return")
	if(state == "time3_escape_return"):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard"})
		saynn("Алекс возвращается довольно быстро. Он сразу замечает, что твои руки не связаны — ты ведь особо и не пряталась. Кажется, он хочет разозлиться... так что стоит ударить первой.")

		saynn("[say=pc]Видишь? Я ничего не трогала, всё точно, как ты и сказал. Ты ведь только и сказал, что не трогать.[/say]")

		saynn("Лицо лиса меняется, когда он осознает... что ты права.")

		saynn("[say=alexrynard]Думаю, мне стоит формулировать правила получше.[/say]")

		saynn("[say=pc]Пожалуйста. А я позабочусь о том, чтобы найти способы их обойти.[/say]")

		saynn("[say=alexrynard]Хах.[/say]")

		saynn("Он мягко улыбается.")

		saynn("После всего этого вы вдвоем возвращаетесь к починке датападов.")

		addButton("Продолжить", "Смотреть, что будет дальше", "skiphours_check")
	if(state == "time4"):
		playAnimation(StageScene.Duo, "sit", {npc="alexrynard", npcAction="sit"})
		saynn("Пора снова взяться за ремонт датападов! Вы с Алексом чините их быстрее, чем приходят новые, так что куча постепенно тает.")

		saynn("К тому же Алекс позволяет тебе чинить практически любые датапады, что максимально повышает вашу общую эффективность.")

		addButton("Продолжить", "Смотреть, что будет дальше", "skiphours_special_check")
	if(state == "offer_hypno"):
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})
		saynn("Становится поздно... Смена Фокси, скорее всего, скоро закончится, так что ты начинаешь убирать инструменты и незавершенную работу.")

		saynn("[say=alexrynard]Эй. Есть минутка?[/say]")

		saynn("В этом есть что-то... другое.")

		saynn("[say=pc]Что такое?[/say]")

		saynn("Алекс чешет затылок.")

		saynn("[say=alexrynard]В последнее время у меня появилось гораздо больше свободного времени. Так что... ну, спасибо.[/say]")

		saynn("[say=pc]Да, всё путём.[/say]")

		saynn("Он кивает.")

		saynn("[say=alexrynard]И раз мне теперь не нужно так сильно париться из-за этого ремонта, у меня даже нашлось время поработать над собственными прототипами.[/say]")

		saynn("[say=pc]Портальные трусики? Приятно слышать.[/say]")

		saynn("[say=alexrynard]Ага, что-то вроде того. Вообще-то я хотел показать одни капитану, узнать, что он о них думает.[/say]")

		saynn("Он снова чешет затылок.")

		saynn("[say=pc]В этом есть какая-то проблема?[/say]")

		saynn("[say=alexrynard]Ну, мне нужно сначала их протестировать. Убедиться, что эта штука вообще работает.[/say]")

		saynn("У тебя появляется подозрение, к чему он всё это клонит.")

		saynn("[say=pc]Тебе снова нужен подопытный?[/say]")

		saynn("[say=alexrynard]Ну... да. Этот конкретный прототип я не смогу протестировать в одиночку.[/say]")

		saynn("[say=pc]Что такое?[/say]")

		saynn("Алекс на секунду замолкает.")

		saynn("[say=alexrynard]Тебе придётся мне довериться.[/say]")

		saynn("[say=pc]Оно может... убить меня?[/say]")

		saynn("Он смотрит в потолок и потирает подбородок.")

		saynn("[say=alexrynard]Не должно. Я буду неподалеку.[/say]")

		saynn("Очень вдохновляюще. И всё же. Хочешь помочь ему?")

		addButton("Согласиться", "Согласиться протестировать прототип", "start_hypnoscene")
		addButton("Не сегодня", "Сегодня тебе совсем не хочется этим заниматься.", "hypno_nottoday")
	if(state == "hypno_nottoday"):
		saynn("Ты начинаешь обдумывать, как лучше всего сказать «нет».")

		saynn("[say=pc]Не сегодня, я чертовски устала.[/say]")

		saynn("Он кивает.")

		saynn("[say=alexrynard]Ладно, я понимаю.[/say]")

		saynn("Пора идти.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "start_hypnoscene"):
		saynn("[say=pc]Конечно. Хочешь прямо сейчас или как?[/say]")

		saynn("Он улыбается и кивает.")

		saynn("[say=alexrynard]Да, сейчас было бы в самый раз. За мной, заключенный.[/say]")

		saynn("Заключенный, значит.")

		addButton("Следовать", "Посмотреть, куда он тебя приведет", "start_thehypno")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "skiphours_check"):
		processTime(RNG.randi_range(6,9) * 60 * 60)
		
		if(GM.main.isVeryLate()):
			setState("toolate")
			GM.pc.addCredits(1)
			addMessage("Вы получили 1 кредит!")
		else:
			setState("aftersomefixing")
			if(getFlag("AlexRynardModule.ch1CommentedPay")):
				GM.pc.addCredits(1)
				addMessage("Вы получили 1 кредит!")
		return

	if(_action == "time3_tie"):
		processTime(25*60)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ZiptiesWrist"))

	if(_action == "time3_alexleaves"):
		processTime(60*60)

	if(_action == "time3_bored"):
		processTime(10*60)

	if(_action == "time3_escape"):
		processTime(10*60)
		GM.pc.freeArmsDeleteAll()

	if(_action == "time3_bored_return"):
		processTime(10*60)
		GM.pc.freeArmsDeleteAll()

	if(_action == "time3_escape_return"):
		processTime(10*60)

	if(_action == "skiphours_special_check"):
		processTime(RNG.randi_range(6,9) * 60 * 60)
		
		if(GM.main.isVeryLate()):
			setState("offer_hypno")
		else:
			setState("aftersomefixing")
		return

	if(_action == "start_thehypno"):
		setFlag("AlexRynardModule.ch1HypnovisorHappened", true)
		runScene("AlexS5HypnovisorIntroScene")
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["howManyTimes"] = howManyTimes

	return data

func loadData(data):
	.loadData(data)

	howManyTimes = SAVE.loadVar(data, "howManyTimes", 0)
