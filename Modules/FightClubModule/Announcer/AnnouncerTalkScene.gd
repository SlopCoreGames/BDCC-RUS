extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AnnouncerTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["announcer"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("announcer")
		playAnimation(StageScene.Duo, "stand", {npc="announcer"})

	if(state == ""):
		saynn("Вы ждете, пока Анс освободится, и привлекаете его внимание.")

		saynn("[say=announcer]Привет, крошка.[/say]")

		addButton("Поговорить", "Задать ему несколько вопросов", "talk")
		if(getFlag("FightClubModule.AnnouncerAskedAboutShop")):
			addButton("Купить", "Посмотреть предложения", "buymenu")
			addButton("Продать", "Посмотреть, что можно продать", "sellmenu")
		else:
			addButton("Купить", "Может, он что-то продает", "askbuy")
		addButton("Уйти", "Хватит болтать", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["announcer"])
		if(!getFlag("FightClubModule.CanBuySlaveCollars")):
			if(getModule("NpcSlaveryModule").canEnslave()):
				addButton("Ошейники?", "Спросить, не знает ли он, где можно раздобыть запасной ошейник", "ask_collars")

	if(state == "ask_collars"):
		saynn("[say=pc]Похоже, ты тут знаешь толк. Не подскажешь, где мне достать ошейник?[/say]")
		
		saynn("Он инстинктивно дергает за свой металлический ошейник.")
		
		saynn("[say=announcer]Хмм... Вообще-то, есть. Чисто из любопытства: зачем тебе запасной? Шея недостаточно тяжелая, детка?[/say]")

		saynn("Он чешет подбородок, наблюдая за тобой.")
		
		saynn("[say=announcer]Ха, кажется, я догадываюсь. И, думаю, смогу тебе помочь. Когда мы расчищали это заброшенное пространство, то нашли несколько ящиков со старым снаряжением, включая один, набитый ошейниками. Странно то, что это не та модель, которую носят все здесь.[/say]")
		
		saynn("Отлично. Тебе подойдет любой ошейник. Но ведь всё никогда не бывает так просто, верно?")
		
		saynn("[say=announcer]Эви нашла способ модифицировать их так, чтобы мы, заключенные, могли сами их запирать и отпирать.[/say]")

		saynn("Эви, значит. С ней всё никогда не бывает просто.")
		
		saynn("[say=announcer]Сначала тебе придется заслужить её доверие.[/say]")
		
		saynn("[say=pc]И как же мне это сделать?[/say]")
		
		saynn("Сиреневая указывает на четыре цепных ограждения в центре площадки.")
		
		saynn("[say=announcer]Арена, детка. Это ответ почти на все вопросы в этом месте.[/say]")
		
		saynn("Похоже, чтобы получить доступ к этим ошейникам, тебе сначала придется отделать Эви на арене...")

		if(getFlag("FightClubModule.AvyGotRekt")):
			addButton("Готово!", "Скажи ему, что ты действительно отделал(а) Эви", "unlock_collars")
			addButton("Назад", "Проехали", "")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "")

	if(state == "unlock_collars"):
		saynn("[say=pc]Эви размазали по арене. Теперь я великий чемпион![/say]")
		
		saynn("Парень усмехается и одобрительно хлопает тебя по плечу.")
		
		saynn("[say=announcer]Отличная работа, крошка. Я знала, что ты справишься.[/say]")
		
		saynn("Ты согласно киваешь и ждешь награду.")
		
		saynn("[say=announcer]Эви согласилась отдать тебе один. Если захочешь больше, придется платить кредитами. Она сказала, что не собирается раздавать свои модифицированные версии на халяву.[/say]")

		saynn("Ну конечно, сучка! Эви протягивает тебе старый металлический ошейник. Дизайн и впрямь отличается... этот выглядит даже более громоздким и неудобным, чем твой нынешний. Но, возможно, в этом и есть плюс...")
		
		saynn("[say=pc]Спасибо.[/say]")
		
		saynn("Он кивает.")
		
		saynn("[say=announcer]Не за что, детка. Ты дрался(ась) просто шикарно, толпа от тебя в восторге![/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")

	if(state == "askbuy"):
		setFlag("FightClubModule.AnnouncerAskedAboutShop", true)
		
		saynn("[say=pc]Ты чем-нибудь торгуешь?[/say]")
		
		saynn("Парень потирает подбородок, оценивающе разглядывая тебя.")

		saynn("[say=announcer]Возможно. Ищешь что-нибудь, чтобы подбавить перчинки в постели? У меня есть как раз то, что нужно. [/say]")
		
		saynn("Вы вопросительно приподнимаете бровь.")
		
		saynn("[say=pc]О чем именно идет речь?[/say]")
		
		saynn("Парень усмехается.")
		
		saynn("[say=announcer]Фетиш-шмотки и игрушки. То, чего охрана не хочет нам видеть. У меня есть всё, детка.[/say]")

		saynn("[say=pc]Надо подумать. О каких ценах идет речь?[/say]")
		
		saynn("[say=announcer]Цены разные, смотря что выберешь. Почему бы тебе не глянуть мой товар, а там разберемся?[/say]")
		
		addButton("Инвентарь", "Взглянуть", "buymenu")
		addButton("Неа", "Ты деловой", "")

	if(state == "talk"):
		saynn("[say=pc]Да так, просто хотел поболтать, кое-что спросить.[/say]")

		saynn("Парень опирается на свою шикарную трость.")

		saynn("[say=announcer]Стреляй![/say]")

		addButton("Имя", "Почему его так называют?", "name")
		addButton("Персонал", "Спросить, что будет, если персонал найдет это место", "staff")
		addButton("Эви", "Спросить об Эви", "avy")
		addButton("Назад", "Хватит вопросов", "")

	if(state == "name"):
		saynn("[say=pc]Почему «Диктор»?[/say]")

		saynn("Он усмехается.")

		saynn("[say=announcer]Думаю, из-за голоса. Остальные начали так меня называть, ну и я притерся.[/say]")

		saynn("[say=pc]Твой голос идеально подошел бы для радио.[/say]")

		saynn("Он чешет затылок и улыбается еще шире.")

		saynn("[say=announcer]Не, я не фанат радио. Но всё равно спасибо.[/say]")

		saynn("[say=pc]И кто же ты тогда? Как ты здесь оказался?[/say]")

		saynn("Он опускает взгляд на свою сиреневую одежду.")

		saynn("[say=announcer]Думал, это очевидно. Я сутенёр, детка. Раньше жил на улицах, присматривал за своими девочками. На зеленом шарике грязи под названием «Земля». Хотя сейчас ей больше подходит название «Пустошь».[/say]")

		addButton("Продолжить", "Спросить о чем-то другом", "talk")

	if(state == "staff"):
		saynn("[say=pc]Это место не совсем законное. Что будет, если персонал его обнаружит?[/say]")

		saynn("Парень оглядывается по сторонам.")

		saynn("[say=announcer]У меня почти нет сомнений, что они не знают о моем местечке. Наверное, им просто удобнее закрывать на это глаза? Твоя догадка не хуже моей.[/say]")

		addButton("Продолжить", "Спросить о чем-то другом", "talk")

	if(state == "avy"):
		saynn("[say=pc]Кто такая Эви?[/say]")

		saynn("Парень опирается на свою трость.")

		saynn("[say=announcer]Она занимается организацией боев. А еще она — абсолютная чемпионка арены. Думаю, я умею выбирать людей на нужные роли.[/say]")

		saynn("[say=pc]Никто так и не смог её одолеть?[/say]")

		saynn("[say=announcer]Многие пытались. Кому-то даже удавалось. Но она всегда возвращается, и с каждым разом становится всё сильнее.[/say]")

		addButton("Продолжить", "Спросить о чем-то другом", "talk")


func _react(_action: String, _args):
	if(_action in ["talk", "name", "staff", "avy"]):
		processTime(RNG.randi_range(5, 10) * 60)
	
	if(_action == "talk"):
		runScene("AnsDomRouteChatScene")
		return
	
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "buymenu"):
		runScene("AnnouncerBuySellScene", ["buymenu"])
		setState("")
		return

	if(_action == "sellmenu"):
		runScene("AnnouncerBuySellScene", ["sellmenu"])
		setState("")
		return
	
	if(_action == "unlock_collars"):
		processTime(3*60)
		setFlag("FightClubModule.CanBuySlaveCollars", true)
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("oldcollar"))
		addMessage("You got a slave collar!")
		addMessage("You can now buy more slave collars from Ans")

	setState(_action)
