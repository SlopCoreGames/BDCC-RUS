extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "TaviTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["tavi"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("tavi")
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		
	if(state == ""):
		if(getModuleFlag("TaviModule", "Tavi_IsAngryAtPlayer")):
			saynn("Вы подходите к высокой кошкоподобной фигуре, стоящей в полумраке. Её лицо почти не выражает эмоций, но вы понимаете, что она явно не в духе. Она сверлит вас взглядом своих злобных глаз.")

			saynn("[say=tavi]Какого хера тебе нужно?[/say]")
		else:
			saynn("Вы подходите к Тави; кажется, она сидит на каком-то куске оборудования.")

			saynn("[say=pc]Мисс Тави?[/say]")

			saynn("Она слушает вас и улыбается.")

			saynn("[say=tavi]Да, мой личный питомец?[/say]")

		addButton("Поговорить", "Выберите тему для разговора", "talk")
		addButton("Внешность", "Рассмотреть Тави поближе", "appearance")
		addButton("Атаковать", "Это может закончиться только одним способом", "attack")
		if(getModuleFlag("TaviModule", "Tavi_IsAngryAtPlayer")):
			var day = getModuleFlag("TaviModule", "Tavi_AngryUntilDay", -10)
			if(GM.main.getDays() >= day):
				addButton("Подчиниться", "Попытаться наладить отношения", "submit")
			else:
				addDisabledButton("Подчиниться", "Тави всё ещё злится на вас, попробуйте снова через день или два")
		else:
			# Player is friendly towards Tavi
			
			addButton("Накажи меня", "Попросить Тави наказать тебя", "askForPunishment")
			
			if(!getModuleFlag("TaviModule", "Tavi_ToldHowToEscape")):
				addButton("Замышлять побег", "Тави упомянула, что может помочь тебе сбежать", "plot_to_escape")
			
			if(getModuleFlag("TaviModule", "Tavi_NeedsApple") && !getModuleFlag("TaviModule", "Tavi_GotApple")):
				if(GM.pc.getInventory().hasItemID("appleitem")):
					addButton("Дать яблоко", "Тави хочет яблоко", "give_apple")
				else:
					addDisabledButton("Дать яблоко", "У тебя его нет")
					
			if(GM.QS.isCompleted("TaviAppleQuest") && !getModuleFlag("TaviModule", "Tavi_Quest2Started", false)):
				addButton("Что теперь?", "Спросить Тави, что дальше", "quest2start")
		
		addButton("Уйти", "Сделать что-то другое", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["tavi"])
		
	if(state == "appearance"):
		saynn("Перед тобой очень высокая кошачьеподобная особа, около двух метров ростом. Её самая уникальная черта — мех: странного фиолетового цвета с яркими зелеными пятнами и полосами, из-за которых её отлично видно в темноте; фиолетовый цвет на животе и в районе пасти светлее, чем на остальном теле. У неё волосы, уложенные набок, средней длины, едва достигающие плеч. Волосы тоже фиолетовые, но с несколькими зелеными прядями сзади. Глаза разного цвета: правый — красный, левый — зеленый. Видно, что внутренняя часть ушей, рот и язык имеют ядовито-зеленый оттенок — значит, таков цвет её плоти и крови. Она выглядит довольно подтянутой, но выраженных мышц не заметно; похоже, основная сила сосредоточена в ногах, а женственные бедра выглядят очень аппетитно. Сзади у неё обычный кошачий хвост.")

		saynn("Насколько можно судить, её грудь примерно D-го размера, но, учитывая её рост, она не кажется огромной. Соски имеют тот самый ярко-зеленый цвет её плоти — выглядит очень экзотично.")

		saynn("Между ног у неё киска. По форме она кажется узкой; можно предположить, что эта леди не слишком часто трахается и ей удалось избежать участи стать секс-игрушкой, как некоторым другим заключенным.")
		
		addButton("Назад", "Назад", "")
		
	if(state == "attack"):
		if(!getModuleFlag("TaviModule", "Tavi_IsAngryAtPlayer")):
			saynn("[say=pc]Мне осточертело быть твоей рабыней, этому придет конец![/say]")

			saynn("Тави склоняет голову набок и выпрямляется.")

			saynn("[say=tavi]Неужели? У кого-то наконец-то выросли яйца? Так и быть, я лично переломаю их пополам.[/say]")

			saynn("Похоже, назревает драка")
		else:
			saynn("[say=pc]Я здесь, чтобы надрать тебе задницу.[/say]")

			saynn("Тави хрустит костяшками пальцев и слегка разминается.")

			saynn("[say=tavi]Ну что ж... Это была огромная ошибка, и я это докажу.[/say]")

			saynn("Похоже, назревает драка")
			
		addButton("Продолжить", "В бой!", "startfight")
	
	if(state == "won_fight"):
		TaviModule.makeTaviAngry()
		
		saynn("Побежденная Тави рухнула на пол. Она шипит и свирепо смотрит на тебя.")

		saynn("[say=tavi]Ну и что теперь, глупышка?[/say]")
		
	if(state == "won_fight_lust"):
		TaviModule.makeTaviAngry()
		
		saynn("Побежденная Тави рухнула на пол; ты замечаешь легкий зеленый румянец на её щеках, который она пытается скрыть.")

		saynn("[say=tavi]И что же ты теперь со мной сделаешь, глупышка..[/say]")
		
	if(state == "won_fight" || state == "won_fight_lust"):
		addButtonWithChecks("Доминировать над Тави", "Заставить эту сучку подчиниться силой", "dominateTavi", [], [ButtonChecks.NotHandsBlocked])
		if(getModuleFlag("TaviModule", "Tavi_Submissiveness", 0) >= 1):
			addButtonWithChecks("Унизить Тави", "Заставить её вести себя как щеночка", "degradeTavi", [], [ButtonChecks.NotHandsBlocked])
		else:
			addDisabledButton("Унизить Тави", "Тави должна быть хотя бы капельку послушной")
		addDisabledButton("Трахать Тави", "Еще не готово :(")
		
		addButton("Продолжить", "Оставить её в покое", "endthescene")
	
	if(state == "lost_fight"):
		saynn("Ты падаешь на колени, окончательно обессилев.")

		saynn("[say=tavi]Какая же ты дурочка, неужели ты правда думала, что сможешь победить? Похоже, пришло время тебя наказать.[/say]")

		addButton("Продолжить", "О нет", "startrandompunishment")
	
	#if(state == "submit"):
	#	saynn("((ЗДЕСЬ БУДЕТ СЦЕНА ПОКОРЕНИЯ))")
		
	#	addButton("Продолжить", "Ты прощена", "endthescene")
	
	if(state == "talk"):
		if(getModuleFlag("TaviModule", "Tavi_IsAngryAtPlayer")):
			saynn("[say=pc]Мы можем поговорить?[/say]")

			saynn("Она рычит на твою слабую попытку заговорить; её руки сжимаются в кулаки, а голос звучит строго и раздражённо.")

			saynn("[say=tavi]Ты сделала свой выбор, я сделала свой. Не трать моё гребаное время.[/say]")
			
			addButton("Продолжить", "Ну, ты хотя бы попытался", "")
		else:
			saynn("[say=pc]Эй, можно тебя кое о чем спросить?[/say]")

			saynn("Тави издает короткий смешок.")

			saynn("[say=tavi]Можешь попробовать.[/say]")
			
			addButton("Мех", "Спросить про её мех", "fur")
			addButton("Как её поймали", "Спросить Тави, как её арестовали", "how_she_got_caught")
			addButton("Почему она здесь?", "Спросить, почему она здесь сидит", "why_is_she_here")
			addButton("Назад", "Назад", "")

	if(state == "fur"):
		saynn("[say=pc]Почему ты так выглядишь?[/say]")

		saynn("Тави на секунду замолкает, собираясь с мыслями.")

		saynn("[say=tavi]Ну, если ты об этом, то сама я это не выбирала. Это результат множества генетических модификаций.[/say]")

		saynn("Она смотрит на свою лапу, на пальцы, затем слегка шевелит ими, прежде чем снова взглянуть на тебя.")

		saynn("[say=tavi]Меня вырастили в лаборатории. У меня нет ни отца, ни матери — по сути, я просто клон со случайным набором ДНК. Вот почему. Достаточно убедительно?[/say]")

		saynn("Ты что-то напеваешь себе под нос, пытаясь переварить услышанное. Лабораторная кошка, значит.")

		saynn("[say=pc]Но в чём был смысл? Если ты здесь, значит, что-то пошло чертовски не так.[/say]")

		saynn("Тави усмехается и похлопывает тебя по плечу.")

		saynn("[say=tavi]Если я выложу тебе всё как есть, на следующий день меня, скорее всего, выкинут в открытый космос.[/say]")

		saynn("[say=pc]Ты мне не веришь?[/say]")

		saynn("Услышав твой вопрос, Тави хитро улыбается.")

		saynn("[say=tavi]Я тебе верю, милашка. Но есть люди, которые умеют вытягивать информацию, даже если ты не собираешься ею делиться. Скажем так: всё прошло лучше, чем они ожидали.[/say]")

		addButton("Назад", "Назад", "talk")

	if(state == "how_she_got_caught"):
		saynn("[say=pc]Как тебя поймали?[/say]")

		saynn("[say=tavi]Всё шло слишком гладко. Я расслабилась. И меня поймали. В общем, вот и всё.[/say]")

		saynn("[say=pc]Что это было слишком хорошо?[/say]")

		saynn("Тави чешет тебя под подбородком.")

		saynn("[say=tavi]Я хакер, я использую самое слабое звено в любой системе — людей. Но знаешь, я ведь тоже человек.[/say]")

		saynn("Можно догадаться, что Тави занималась преступлениями в галактической паутине и в конце концов попалась.")

		saynn("[say=pc]Ты не особо разговорчива.[/say]")

		saynn("[say=tavi]Информация — самая ценная вещь в современном мире, дорогуша.[/say]")

		saynn("Похоже, здесь есть что еще раскопать, но она просто не хочет делиться.")

		addButton("Назад", "Назад", "talk")

	if(state == "why_is_she_here"):
		saynn("[say=pc]Почему ты сидишь здесь, в стороне от всех?[/say]")

		saynn("Тави пожимает плечами; кажется, этот вопрос застал её врасплох.")

		saynn("[say=tavi]Не люблю толпу. Я всегда работала одна. И тебе лучше перестать задавать эти глупые вопросы.[/say]")

		saynn("Она слегка шлепает тебя по заднице.")

		addButton("Назад", "Назад", "talk")

	if(state == "plot_to_escape"):
		# (triggers once)
		setModuleFlag("TaviModule", "Tavi_ToldHowToEscape", true)
		setModuleFlag("TaviModule", "Tavi_NeedsApple", true)
		addMessage("You got a new task")

		saynn("Ты усаживаешься на один из пустых ящиков для руды.")

		saynn("[say=pc]Так... Насчет этого побега. Думаешь, это реально?[/say]")

		saynn("Тави придвигается ближе и переходит на полушепот.")

		saynn("[say=tavi]Ммм~ Кто-то очень хочет мне помочь, да?[/say]")

		saynn("[say=pc]Взвешиваю варианты. И что ты будешь делать с ошейником? Разве они не могут просто поджарить тебе шею дистанционно?[/say]")

		saynn("Ты дергаешь за свой — он сидит так же плотно, как и всегда, постоянно напоминая о своем существовании.")

		saynn("[say=tavi]Если есть только одно решение, значит, оно верное. Нам просто нужно заставить капитана снять их.[/say]")

		saynn("Тави наблюдает за твоим удивленным лицом.")

		saynn("[say=pc]И как ты планируешь это сделать? Встанешь перед ним на колени и начнешь умолять?[/say]")

		saynn("Она посмеивается и берет тебя за подбородок.")

		saynn("[say=tavi]Да ну,~. Это же твоя работа, сладенький. Бьюсь об заклад, капитан не такой уж сильный, каким хочет казаться. Стоит дать ему правильную... мотивацию... и он позволит ошейникам всего двух заключенных соскользнуть.[/say]")

		saynn("Тави нежно поглаживает тебя по подбородку, стараясь поймать твой взгляд.")

		saynn("[say=pc]Может быть... Но что тогда?.. Транспортные шаттлы даже не способны на сверхсветовой прыжок, этот огромный корабль нас просто раздавит.[/say]")

		saynn("[say=tavi]Все, что мне нужно — это компьютер с доступом к экстранету~ У меня есть люди, которые будут очень рады узнать координаты этой станции в обмен на то, что вытащат нас отсюда. Все дело в информации и нужных людях, милашка. Посмотри на меня.[/say]")

		saynn("Она обхватывает твою голову лапами, заставляя смотреть ей прямо в глаза. На её лице играет легкая ухмылка, пока она сверлит тебя своим взглядом.")

		saynn("[say=tavi]Забудь об этом пока что. Как видишь, сейчас я тебе очень сильно доверяю. И верю, что ты будешь держать язык за зубами, если они начнут расспрашивать. Уверен, что справишься?[/say]")

		saynn("Ты едва заметно киваешь. Тави наклоняет голову, её лапы слегка двигаются, почесывая тебя за ушами. Ты невольно издаешь милый звук от удовольствия. Внезапно её голос меняется с мягкого на строгий.")

		saynn("[say=tavi]Найди мне яблоко, я проголодалась.[/say]")

		saynn("[say=pc]Эм..[/say]")

		saynn("[say=tavi]Что-то не так, питомец?[/say]")

		saynn("Ты качаешь головой, и Тави убирает лапы. Ты встаешь и оглядываешься по сторонам.")

		saynn("[say=tavi]Их выращивают в теплицах. Считай это своим тестом.[/say]")

		saynn("[say=pc]Да, мисс...[/say]")

		addButton("Продолжить", "Продолжить путь", "endthescene")


	if(state == "give_apple"):
		var apples = GM.pc.getInventory().getAllOf("appleitem")
		var pcStoleApple = false
		for apple in apples: # if at least one apple is illegal, present that one to tavi
			if !apple.isLegal:
				pcStoleApple = true
				break
		
		
		saynn("Ты подходишь к Тави и протягиваешь ей блестящее яблоко.")

		saynn("[say=pc]Вот, мисс, как вы и просили.[/say]")

		saynn("Она хватает его, держит, даже дышит на него, но в итоге возвращает обратно.")

		saynn("[say=tavi]Хорошо. Оставь себе." + ("Bet you went through some things to get it." if pcStoleApple else "Even though you took the easy way to get it.") + "[/say]")

		saynn("Её слова сбивают тебя с толку. Она с огромным интересом наблюдает за твоей реакцией.")

		saynn("[say=pc]Но..[/say]")

		saynn("[say=tavi]Встань на колени перед мной, мой маленький питомец.[/say]")

		saynn("Ты делаешь всё, как она говорит, медленно опускаясь на колени. Она наклоняется и ласкает твою щеку, проводя по ней лапой. Затем она притягивает тебя ближе и внезапно быстро целует в губы. На твоем лице проступает легкий румянец.")

		saynn("[say=tavi]Хочешь быть хорошим питомцем, да?[/say]")

		saynn("Ты киваешь, и твои щеки краснеют еще сильнее.")

		saynn("[say=tavi]Скажи это.[/say]")

		saynn("[say=pc]Я хочу быть хорошим питомцем для своей Госпожи..[/say]")

		saynn("[say=tavi]Умница {pc.boy}~. Оставь яблоко себе.[/say]")

		saynn("[say=pc]Спасибо, Госпожа..[/say]")

		addButton("Продолжить", "Продолжить путь", "endthescene")
		
	if(state == "askForPunishment"):
		saynn("Вы садитесь на колени и прижимаетесь к ногам Тави")
		
		saynn("[say=pc]Вы можете наказать меня, Госпожа Тави?[/say]")
		
		saynn("[say=tavi]Зачем мне наказывать свою милашку?[/say]")
		
		saynn("[say=pc]За все те плохие вещи, что я сделала.[/say]")
		
		saynn("[say=tavi]Хмм.[/say]")
		
		addButton("Продолжить", "Посмотреть, что будет", "startrandompunishment")
		

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "startfight"):
		runScene("FightScene", ["tavi"], "tavifight")
	
	if(_action == "give_apple"):
		addExperienceToPlayer(50)
		setModuleFlag("TaviModule", "Tavi_GotApple", true)
	
	if(_action == "submit"):
		#setModuleFlag("TaviModule", "Tavi_IsAngryAtPlayer", false)
		runScene("TaviSubmitToScene")
		endScene()
		return
	
	if(_action == "startrandompunishment"):
		runScene(TaviModule.getPunishmentScene())
		endScene()
		return
		
	if(_action == "dominateTavi"):
		runScene("DominateTaviScene")
		endScene()
		return
		
	if(_action == "degradeTavi"):
		runScene("DegradeTaviScene")
		endScene()
		return
		
	if(_action == "quest2start"):
		runScene("TaviQuest2Start")
		endScene()
		return
	
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "tavifight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		var wonHow = _result[1]
		
		if(battlestate == "win"):
			if(wonHow == "lust"):
				setState("won_fight_lust")
			else:
				setState("won_fight")
			addExperienceToPlayer(20)
		else:
			setState("lost_fight")
			addExperienceToPlayer(5)
