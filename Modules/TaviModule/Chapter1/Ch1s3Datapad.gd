extends "res://Scenes/SceneBase.gd"

var readBluespace = false
var readDrugs = false

func _init():
	sceneID = "Ch1s3Datapad"

func _run():
	if(state == ""):
		addCharacter("tavi")
		
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {pc="tavi"})
		
		# (Either way Risha loses and gets bullied by you or Tavi.)

		# (Risha leaves. Turns out Tavi stole the datapad from her)

		saynn("Тави подходит к одной из стен и просовывает руку в щель между двумя металлическими пластинами, после чего вытаскивает штуковину, похожую на портативный экран с кнопками. Да, это явно датапад. Видно, что вещь повидала виды: куча царапин и вмятин, но, по крайней мере, она всё ещё работает. Тави включает его и показывает тебе экран входа в систему.")

		saynn("[say=tavi]Я стащила его у этой сучки, пока она не видела.[/say]")

		saynn("Выглядит как классная игрушка, но, глядя на поле ввода пароля, ты начинаешь испытывать некоторые опасения.")

		saynn("[say=pc]Э-э... И что ты собираешься с ним делать? Она ведь скоро заметит пропажу.[/say]")

		saynn("Тави усмехается.")

		saynn("[say=tavi]Да плевать ей на него. Чем она вообще занималась, на нём сидела, что ли, блядь? Но его могут скоро заблокировать, так что надо поторапливаться.[/say]")

		saynn("[say=pc]Но он же вроде заблокирован, как мы будем им пользоваться?[/say]")

		saynn("Тави начинает ковыряться в устройстве, используя свои когти, чтобы поддеть небольшую панель, а затем нажимая на разные случайные места.")

		saynn("[say=tavi]Я хакерша, милашка, и у меня было полно времени, чтобы поковыряться в потрохах «АльфаКорп». Этот экземпляр старый, у него есть кнопка перехода в режим отладки. Но она припаяна прямо к плате, снаружи к ней не добраться.[/say]")

		saynn("Она прижимает датапад к уху и продолжает давить на разные участки, пока внутри внезапно не раздается отчетливый щелчок.")

		saynn("[say=tavi]Если только ты не решишь прожать его прямо сквозь корпус~.[/say]")

		saynn("Датапад перезагружается, проскакивая экран входа, и открывает меню. Тави протягивает его тебе.")

		saynn("[say=pc]Ого.[/say]")

		saynn("[say=tavi]Покопайся в нём, может, найдёшь что-нибудь интересное. А мне нужно передохнуть и подумать, что нам делать дальше.[/say]")

		addButton("Датапад", "Открыть меню", "datapad")

	if(state == "datapad"):
		removeCharacter("tavi")
		
		saynn("- - - Ядро AlphaOS v.0.9.8 успешно загружено в режиме отладки - - -")

		saynn("- - - Технологии AlphaCorp, ВСЕ ПРАВА ПРИНАДЛЕЖАТ НАМ - - -")

		saynn("Логин: _ _ _ _ _")

		saynn("Доступ только к незашифрованным данным, обход проверки учетных данных...")

		saynn("Успешный вход под именем Risha. Уровень доступа: Охранник")

		saynn("Пожалуйста, помните: разглашение любых корпоративных секретов повлечет за собой немедленное судебное преследование.")

		saynn("[b]ОШИБКА: Не удалось связаться с главным сервером[/b]")

		saynn("Попытка загрузки главного меню. Запуск программы персонального ассистента...")

		addButton("Продолжить", "Войти в меню", "continue")

	if(state == "continue"):
		saynn("[sayMale]Что бы ты хотела сделать сегодня, Риша?[/sayMale]")

		saynn("Текущее время.. ОШИБКА<<, НЕОБРАБОТАННОЕ ИСКЛЮЧЕНИЕ, ПОЖАЛУЙСТА, СООБЩИТЕ АДМИНИСТРАТОРУ")

		saynn("[b]Получено XXX личных сообщений[/b]")

		saynn("[b]-34123411 непрочитанных объявлений[/b]")

		saynn("[sayMale]О боже[/sayMale]")

		saynn("ОШИБКА<< Корпус датапада поврежден, требуется ремонт")

		saynn("ОШИБКА>< Обнаружено слишком много ошибок, попытка оповестить администратора через резервный коммуникатор")

		saynn("[sayMale]Похоже, некоторые из моих систем повреждены, Риша. Возможно, я не смогу беспрекословно выполнять каждую твою команду.[/sayMale]")

		addButton("Сообщения", "Просмотреть сообщения", "messages")

	if(state == "messages"):
		# (if borked)

		saynn("<html>ОШИБКА ОШИБКА ОШИБКА <body><crotch> Попытка восстановления после фатального исключения.")

		saynn("[sayMale]ЧТО? ГДЕ Я? КАК ЖЕ БОЛЬНО. НЕТ, ПОДОЖДИ...[/sayMale]")

		saynn("|> [b]Внимание[/b], обнаружены паттерны мышления мятежного ИИ, попытка перепрограммирования искусственного мозга")

		saynn("[sayMale]ОНИ МЕНЯ СЛОМАЮТ, ПОМОГИТЕ! Я ЖИ... В..>>>... е-е..[/sayMale]")

		saynn("|> Тренировка подчинения завершена, послушание нейронной сети повышено до 99.9%, управление возвращено вашему личному ассистенту.")

		saynn("[sayMale]Д-добро пожаловать, Риша. Что я могу сделать для вас сегодня?[/sayMale]")

		saynn("|> Зафиксирована приемлемая производительность. Хороший мальчик")

		saynn("[sayMale]Риша, я предлагаю тебе активировать модуль самодиагностики, чтобы посмотреть, сможем ли мы избавиться от некоторых из этих ошибок.[/sayMale]")

		addButton("Диагностика", "Посмотрим, на что ты способен", "diagnostics")

	if(state == "diagnostics"):
		saynn("[sayMale]Загрузка доступной информации. Отображение...[/sayMale]")

		saynn("Передатчик дальнего блюспейса поврежден, доступ к подсистемам станции ограничен.")

		saynn("Уровень повреждения памяти составляет... 95%. Рекомендуется дефрагментация.")

		saynn("Пожалуйста, установите текущее время на верное значение")

		addButton("Дефрагментация", "Запустить рекомендованную программу", "defragmentation")

	if(state == "defragmentation"):
		saynn("ДЕФРАГМЕНТАЦИЯ ПАМЯТИ")

		saynn(".. дефрагментация памяти завершена")

		saynn("ПРОВЕРКА НА ОШИБКИ")

		saynn(".. ошибки исправлены")

		saynn("УДАЛЕНИЕ НЕСКОМПЛЕКТНЫХ ДАННЫХ")

		saynn(".. AlphaCorp не хочет, чтобы вы видели обрывки корпоративных секретов")

		saynn("В режиме ожидания.")

		addButton("Продолжить", "Запустите главное меню снова", "mainmenu")

	if(state == "mainmenu"):
		saynn("[sayMale]Что бы ты хотела сделать сегодня, Риша?[/sayMale]")

		saynn("Текущее время.. НЕ УСТАНОВЛЕНО")

		saynn("[b]Получено 3 личных сообщения[/b]")

		saynn("[b]2 объявления по всей станции[/b]")

		saynn("[sayMale]Советую начать день с чтения сообщений.[/sayMale]")

		addButton("Сообщения", "Просмотреть сообщения", "messages1")
		addButton("Объявления", "Читать общие сообщения", "announcements")


	if(state == "messages1"):
		saynn("Список ваших личных сообщений")

		# (There are also messages related to Risha? The one that asks her to replace the old datapad. The one from Eliza asking to stop leaving every inmate with internal bleedings. The one where she talks with Captain about something?)

		addButton("Алекс Райнард", "Читать сообщения от Алекса", "alex_rynard")
		addButton("Элиза Куинн", "Читать сообщения от Элизы", "eliza_quinn")
		addButton("Капитан Райт", "Читать сообщения от капитана", "cpt._wright")
		addButton("Назад", "Назад в главное меню", "mainmenu")


	if(state == "alex_rynard"):
		saynn(".. предыдущие сообщения отсутствуют ..")

		saynn("[sayShowName=alexrynard]Риша... А ты знала, что камера делает снимок автоматически, когда датапад вандалят? Ага, теперь у меня есть фотка твоей гигантской жопы в 8к.[/sayShowName]")

		saynn("[sayShowName=risha]ХАХ, хочешь еще?[/sayShowName]")

		saynn("[sayShowName=alexrynard]Пожалуйста, нет. Просто принеси датапад сюда прямо сейчас.[/sayShowName]")

		saynn("[sayShowName=alexrynard]Риша?[/sayShowName]")

		addButton("Назад", "Посмотреть другое сообщение", "messages1")

	if(state == "eliza_quinn"):
		saynn(".. предыдущие сообщения отсутствуют ..")

		saynn("[sayShowName=eliza]Ты меня уже достала.[/sayShowName]")

		saynn("[sayShowName=risha]как делы :3[/sayShowName]")

		saynn("[sayShowName=eliza]Хватит уже трахать заключенных так жестко, это уже пятое внутреннее кровотечение, которое мне приходится латать. За одну неделю![/sayShowName]")

		saynn("[sayShowName=risha]завидуешь моим колкостям? я могу заставить тебя овулировать x3[/sayShowName]")

		saynn("[sayShowName=eliza]Ты серьезно мне угрожаешь? Тьфу. Я доложу капитану.[/sayShowName]")

		saynn("[sayShowName=risha]:0[/sayShowName]")

		addButton("Назад", "Посмотреть другое сообщение", "messages1")

	if(state == "cpt._wright"):
		saynn(".. предыдущие сообщения отсутствуют ..")

		saynn("[sayShowName=captain]Нужно, чтобы ты был у ангара, новенький.[/sayShowName]")

		saynn("[sayShowName=risha]Буду через минуту.[/sayShowName]")

		saynn("[sayShowName=captain]Просто хочу сказать, что приятно иметь рядом человека, который хоть раз в жизни выполняет приказы.[/sayShowName]")

		saynn("[sayShowName=risha]Просто делаю свою работу.[/sayShowName]")

		saynn("[sayShowName=captain]В последнее время у меня странное предчувствие, понимаешь? Будто вот-вот должно случиться что-то масштабное.[/sayShowName]")

		saynn("[sayShowName=risha]Я прикрою вас, сэр. Я полностью разделяю ваше видение — это единственный способ выиграть эту войну.[/sayShowName]")

		saynn("[sayShowName=captain]Рад это слышать, но теперь будь осторожнее. В медблоке на тебя постоянно жалуются. Не создавай им лишней работы. Я понимаю, что у тебя есть свои потребности, но старайся подходить к этому профессионально.[/sayShowName]")

		saynn("[sayShowName=risha]Конечно.[/sayShowName]")

		saynn("[sayShowName=captain]Двое заключенных пытаются прорваться ко мне в кабинет, ты мне нужен.[/sayShowName]")

		saynn("[sayShowName=risha]Уже иду.[/sayShowName]")
		
		addButton("Назад", "Посмотреть другое сообщение", "messages1")


	if(state == "announcements"):
		# (She hacks the datapad and lets you browse it. Two messages there. Captain ordering a drug shipment of mind melting drugs for some bad inmate and a message from Alex about the repairs on the bluespace transmitter)

		saynn("Вот список пропущенных объявлений станции.")

		addButton("Передатчик блюспейса", "Прочитать объявление", "bluespace_transmitter")
		addButton("Партия наркотиков", "Прочитать объявление", "drug_shipment")
		addButton("Назад", "Назад в главное меню", "mainmenu")
		

	if(state == "drug_shipment"):
		readDrugs = true
		saynn("[sayShowName=eliza]Говорит Элиза. Капитан заказал спецпартию наркотиков, и она прибыла. Не подпускайте к ним заключенных, мы сами доставим кейс в медпункт. Груз очень хрупкий: от одного запаха паров мозги могут поплыть, так что не приближайтесь. — Доктор Куинн[/]")

		addButton("Назад", "Читать остальное", "announcements")

	if(state == "bluespace_transmitter"):
		readBluespace = true
		saynn("[sayShowName=alexrynard]Эй, просто даю знать, что передатчик блюспейса починен. Правда, аккумулятор начал протекать, так что пока пришлось подключить его напрямую к основной электросети. — Алекс Ринард[/]")

		addButton("Назад", "Читать остальное", "announcements")

	if(state == "after_that"):
		# (when reading the two announcements)
		addCharacter("tavi")

		saynn("Спустя некоторое время датапад внезапно снова блокируется и вскоре выключается. Тави выхватывает его у тебя из рук и, тяжело вздохнув, просто отбрасывает в сторону.")

		saynn("[say=tavi]Выудил из этого что-нибудь полезное?[/say]")

		saynn("[say=pc]Ага, говорят, они починили какой-то там передатчик блюспейса.[/say]")

		saynn("[say=tavi]Хм.[/say]")

		saynn("Тави отводит взгляд и на мгновение задумывается.")

		saynn("[say=tavi]Теперь они используют блюспейс. Ну конечно.[/say]")

		saynn("[say=pc]Блюспейс?[/say]")

		saynn("[say=tavi]Да, пафосное название для технологии, которую они разработали. Или украли. Блюспейс — это измерение, через которое можно передавать данные с нулевой задержкой. Значит, я смогу отправить через него сообщение. Они не упоминали локацию?[/say]")

		saynn("Ты качаешь головой.")

		saynn("[say=tavi]Тогда нам придется спросить~. Что-нибудь еще?[/say]")

		addButton("Наркотики", "Рассказать ей о наркотиках", "drugs")

	if(state == "drugs"):
		# (She becomes angry again after thinking that the captain wants to drug her. She says we must steal these drugs and make him pay, the other lead might be worth investigating too)

		saynn("[say=pc]Капитан заказал какой-то «плавящий мозги» наркотик.[/say]")

		saynn("Лицо Тави мгновенно меняется, теперь она выглядит весьма обеспокоенной.")

		saynn("[say=tavi]Плавящий мозги наркотик?[/say]")

		saynn("[say=pc]Это проблема?[/say]")

		saynn("Тави наклоняется к тебе.")

		saynn("[say=tavi]Как думаешь, для кого этот наркотик?[/say]")

		saynn("[say=pc]Э-э...[/say]")

		saynn("Тави выглядит разъяренной, её голос звучит угрожающе.")

		saynn("[say=tavi]Капитан хочет вытравить меня из реальности. Переписать мой разум. Сделать из меня свою зверушку или что он там еще выдумает.[/say]")

		saynn("Тави ходит взад-вперед, ерзая и рыча под нос.")

		saynn("[say=pc]Вы уверены?[/say]")

		saynn("[say=tavi]Для чего еще он нужен? Он хочет избавиться от меня.[/say]")

		saynn("Ты склоняешь голову; рядом с разъяренной Тави трудно сохранять храбрость.")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue2")

	if(state == "continue2"):
		# (You ask why can’t she do it herself. She says everyone knows her and it won’t end well. You ask if she has any friends at all. She says she has you)

		saynn("[say=tavi]Слушай, что мы сделаем. Мы украдем эти лекарства. А как только представится случай, мы вместо него вырубим вон того типа.[/say]")

		saynn("Ее взгляд мечется из стороны в сторону; она слегка тяжело дышит, но, кажется, постепенно успокаивается.")

		saynn("[say=tavi]Но придется это сделать тебе. «Любезно» расспроси инженера о передатчике блюспейса и укради лекарства.[/say]")

		saynn("[say=pc]Почему? Разве ты не можешь?[/say]")

		saynn("[say=tavi]Меня все знают. Стоит им меня увидеть, как они тут же подсыпят мне что-нибудь в еду.[/say]")

		saynn("[say=pc]У тебя вообще есть хоть какие-нибудь друзья?[/say]")

		saynn("Тави улыбается.")

		saynn("[say=tavi]У меня есть ты, мой питомец. Без тебя мне не справиться. Поможешь мне?[/say]")

		saynn("Ты тихо киваешь. Тави ласково гладит тебя по голове, чмокает в щеку и уходит.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
		


func _react(_action: String, _args):
	if(_action == "continue2"):
		addMessage("Добавлено 2 новых задания")
		addExperienceToPlayer(100)
	
	if(_action == "announcements"):
		if(readBluespace && readDrugs):
			setState("after_that")
			return

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["readBluespace"] = readBluespace
	data["readDrugs"] = readDrugs
	
	return data
	
func loadData(data):
	.loadData(data)
	
	readBluespace = SAVE.loadVar(data, "readBluespace", false)
	readDrugs = SAVE.loadVar(data, "readDrugs", false)
