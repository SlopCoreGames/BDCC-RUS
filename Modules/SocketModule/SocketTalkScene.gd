extends SceneBase

func _init():
	sceneID = "SocketTalkScene"

func _run():
	if(state == ""):
		addCharacter("socket")
		playAnimation(StageScene.Duo, "stand", {npc="socket"})
		saynn("Вы подходите к Сокет. Она одаривает вас доброй улыбкой.")

		if (getFlag("SocketModule.punishLineShouldSay", false)):
			setFlag("SocketModule.punishLineShouldSay", false)
			saynn("[say=socket]Надеюсь, я не слишком сильно тебя отмучила.[/say]")

		elif (getCharacter("socket").isVisiblyPregnant()):
			saynn("[say=socket]Я беременна, да?.. Может, мне не стоит позволять всем кончать в меня.. Но ты такой милый..[/say]")

		elif (getFlag("SocketModule.h5completed")):
			saynn("[say=socket]Хей! Надеюсь, у тебя всё путём.[/say]")

		elif (getFlag("SocketModule.h4completed")):
			saynn("[say=socket]Привет. Мне всё ещё трудно вспомнить, чем мы занимались в прошлый раз..[/say]")

		elif (getFlag("SocketModule.h3completed")):
			saynn("[say=socket]Не бойся использовать мою киску через портальное устройство! Она всегда в твоём распоряжении![/say]")

		elif (getFlag("SocketModule.h2completed")):
			saynn("[say=socket]Наверное, мне стоит сделать вентиляцию на этой станции шире.. А может, и не стоит..[/say]")

		elif (getFlag("SocketModule.h1completed")):
			saynn("[say=socket]Шахты полностью освещены, мы отлично поработали! Хочешь продолжить?[/say]")

		else:
			saynn("[say=socket]Что-то нужно?[/say]")

		addButton("Поговорить", "Поболтать", "talk_options")
		if (getFlag("SocketModule.h5completed")):
			addButton("Задания", "Выбери одно из старых заданий, чтобы пройти его снова с Сокетом", "pick_task")
			addButton("Плакат", "На одной из стен здесь висит плакат...", "look_poster")
		else:
			addButton("Помочь ей", "Показать Сокет окрестности", "do_show_around")
		addButton("Улучшения камеры", "Посмотреть, что Сокет может улучшить в твоей камере", "see_cell_upgrades")
		if (getFlag("SocketModule.h2completed", false)):
			addButton("Вентиляция", "Спросить Сокет, какие вентиляционные шахты она может для тебя прочистить", "ask_vents")
		addButton("Уйти", "Хватит болтать", "endthescene")
	if(state == "look_poster"):
		saynn("Ты оглядываешься по сторонам и замечаешь плакат на одной из стен.")

		saynn("[say=socket]Нравится?[/say]")

		saynn("[say=pc]Симпатично. Сокет Хекс?[/say]")

		saynn("[say=socket]Да, это моё полное имя![/say]")

		saynn("Уму непостижимо, как ты узнал об этом только сейчас.")

		addButton("Назад", "Хватит пялиться", "")
	if(state == "pick_task"):
		saynn("Какое задание ты хотел выполнить вместе с Сокетом?")

		addButton("Назад", "Проехали", "")
		addButton("Шахты", "Выполнить первое задание", "do_1_task")
		addButton("Туалет", "Выполнить второе задание", "do_2_task")
		addButton("Вендинговые автоматы", "Выполнить третье задание", "do_3_task")
		addButton("Подземелье", "Выполнить четвертое задание", "do_4_task")
		addButton("Камеры", "Выполни пятую задачу", "do_5_task")
	if(state == "talk_options"):
		saynn("О чем хочешь поговорить с Сокетом?")

		addButton("Непринужденная нагота", "Спросить, почему она практически голая", "ask_casual_nudity")
		addButton("Гарнитура", "Спросить, что у неё на голове", "ask_headset")
		addButton("Новый инженер", "Спросить, почему она решила здесь работать", "ask_why_work_here")
		if (getFlag("SocketModule.askedWhyWorkHere")):
			addButton("Секс без обязательств", "Спросить её о случайном сексе", "ask_casual_sex")
		else:
			addDisabledButton("Секс без обязательств", "Ты об этом еще не знаешь, тише...")
		if (getFlag("SocketModule.touchedPussy")):
			addButton("Биоинженерная киска", "Спросить, что это значит", "ask_bioengineered_pussy")
		else:
			addDisabledButton("Биоинженерная киска", "Ты об этом точно ещё не знаешь, так что молчи")
		addButton("Назад", "Хватит вопросов", "")
	if(state == "ask_casual_nudity"):
		saynn("[say=pc]Можно тебя кое о чём спросить? О чём-то очевидном.[/say]")

		saynn("Сокет слегка наклоняет голову, выглядя немного растерянной.")

		saynn("[say=socket]Конечно.[/say]")

		saynn("[say=pc]Почему ты голая?[/say]")

		saynn("Она наклоняет голову ещё сильнее, демонстрируя тебе свои бронированные сапоги и наручи.")

		saynn("[say=socket]Я не голая, на мне же есть это! И рюкзак... и очки... и...[/say]")

		saynn("[say=pc]Но твои... причиндалы наружу.[/say]")

		saynn("Она улыбается и выпячивает грудь, отчего её {socket.breasts} слегка колышутся.")

		saynn("[say=socket]Да капитан сказал, что персоналу можно.[/say]")

		saynn("Заставляет задуматься...")

		saynn("[say=pc]Ты случайно... не эксгибиционистка?[/say]")

		saynn("Сокет впадает в полное замешательство от твоего вопроса.")

		saynn("[say=socket]Эм... Нет? С чего ты это взял?[/say]")

		saynn("Ладно... Теперь твоя очередь недоумевать. Она делает это не ради того, чтобы собирать реакции окружающих... но тогда зачем?")

		saynn("[say=pc]Обычная одежда для тебя слишком жаркая или типа того?[/say]")

		saynn("[say=socket]Жаркая? Не особо. Отопление здесь не идеальное, но работает.[/say]")

		saynn("Похоже, это не какая-то физиологическая потребность.")

		saynn("[say=pc]Тогда... почему ты так одета?[/say]")

		saynn("Сокет смотрит на себя... и пожимает плечами.")

		saynn("[say=socket]Так было всегда. Сколько я себя помню.[/say]")

		saynn("Вряд ли тебе удастся вытянуть из неё что-то большее.")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_options")
	if(state == "ask_why_work_here"):
		setFlag("SocketModule.askedWhyWorkHere", true)
		saynn("Она кажется доброй... невольно задумываешься, что она здесь забыла.")

		saynn("[say=pc]Почему ты решила работать здесь, в тюрьме?[/say]")

		saynn("Сокет пожимает плечами.")

		saynn("[say=socket]Почему это?[/say]")

		saynn("[say=pc]Здесь полно плохих людей.[/say]")

		saynn("[say=socket]Плохие люди есть везде! Не беспокойся обо мне, я могу за себя постоять.[/say]")

		saynn("Она показывает тебе шоковый пульт — такой же, как у остальных сотрудников.")

		saynn("[say=pc]И всё же, почему именно тюрьма?[/say]")

		saynn("[say=socket]Это больше, чем просто тюрьма. Это возможность! Здесь столько всего можно исправить, столько всего улучшить. Мне эта станция уже очень нравится, не терпится начать делать её лучше.[/say]")

		saynn("Значит, она... трудоголик?")

		saynn("[say=socket]А еще я слышал, что здесь полно секса и всякого такого![/say]")

		saynn("Один из инженеров на заднем плане сплевывает кофе.")

		saynn("Секс, значит..")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_options")
	if(state == "ask_casual_sex"):
		saynn("[say=pc]Ты что-то говорила про секс..[/say]")

		saynn("Сокет кивает.")

		saynn("[say=socket]Тебе что, не нравится секс?[/say]")

		saynn("Ты заглядываешь ей в глаза... и не видишь ни капли стыда.")

		saynn("[say=pc]Эм.. Ты относишься к этому довольно просто.[/say]")

		saynn("Она улыбается и игриво виляет бедрами.")

		saynn("[say=socket]Секс — это невероятно весело, с чего бы к нему относиться как-то иначе? Я рада, что здесь такие расслабленные правила.[/say]")

		saynn("В её словах есть смысл.")

		saynn("[say=pc]Но не весь секс здесь — просто развлечение. Иногда всё проходит довольно жестко.[/say]")

		saynn("Сокет пожимает плечами.")

		saynn("[say=socket]Меня это не пугает.[/say]")

		saynn("Интересно.")

		addButton("Попросить потрогать", "Спросить, не против ли она, если ты прикоснёшься к её интимным местам", "ask_to_touch")
		addButton("Продолжить", "Спросить о чем-то другом", "talk_options")
	if(state == "ask_to_touch"):
		playAnimation(StageScene.Grope, "grope", {pc="socket", npc="pc"})
		setFlag("SocketModule.touchedPussy", true)
		saynn("[say=pc]Должен признать, у тебя отличная фигура.[/say]")

		saynn("Сокет улыбается.")

		saynn("[say=socket]О, спасибо![/say]")

		saynn("[say=pc]Можно мне... потрогать её?[/say]")

		saynn("Сокет что-то напевает под нос.")

		saynn("[say=socket]Конечно, нет![/say]")

		saynn("Заметив твоё растерянное лицо, она усмехается.")

		saynn("[say=socket]Ты забыла сказать «пожалуйста», глупышка.[/say]")

		saynn("Очевидно..")

		saynn("[say=pc]Можно мне тебя потрогать?[/say]")

		saynn("[say=socket]Конечно![/say]")

		saynn("Она кивает и выпячивает грудь, открывая тебе полный доступ ко... всему.")

		saynn("Ты начинаешь осторожно, проводя ладонью по короткому меху на её животе и бёдрах. На ощупь она очень мягкая и тёплая, а её бока имеют приятный изгиб. Ты смотришь ей в глаза и получаешь невербальное согласие продолжать.")

		saynn("Твои руки ложатся на её {socket.breasts}. Они не самые огромные... но отлично ложатся в ладони. О чём ещё можно мечтать? Сокет с огромным интересом наблюдает за твоими руками, пока ты ласкаешь и мнёшь её грудь, потирая пальцами её твёрдые, упругие соски.")

		saynn("[say=socket]М-ммм..[/say]")

		saynn("Её взгляд смягчается, дыхание становится глубже. После нескольких ощупываний Сокет раздвигает ноги ещё шире... для тебя... это приглашение.")

		saynn("Одна рука остается на её груди, а другая скользит вниз, к промежности. Ты чувствуешь... тепло... исходящее от её милых, узких половых губ.")

		saynn("Твои пальцы скользят по её влажным складкам, слегка дразня клитор. Пока ты это делаешь, взгляд Сокет становится всё более жадным; она прикусывает губы, застыв на месте и позволяя тебе продолжать, делая вид, что всё это совершенно нормально. Разве нет?..")

		saynn("К этому моменту ты, вероятно, делаешь уже гораздо больше, чем просто касаешься... но ладно... ты осторожно раздвигаешь лепестки её киски и сразу замечаешь несколько струек сока, тянущихся между ними. Как похотливо.")

		saynn("[say=socket]Тебе нравится?[/say]")

		saynn("[say=pc]Да, киска что надо.[/say]")

		saynn("[say=socket]Спасибо. Она биоинженерная, специально так сделана.[/say]")

		saynn("Биоинженерная... что?..")

		addButton("Продолжить", "Спросить о чем-то другом", "talk_options")
	if(state == "ask_bioengineered_pussy"):
		saynn("[say=pc]Ты сказала, что твоя киска... биоинженерная?[/say]")

		saynn("Сокет кивает и затем осторожно раздвигает складки для тебя.")

		saynn("[say=socket]Один из биотехов помог мне. Её изменили, чтобы она была более растяжимой, эластичной и упругой.[/say]")

		saynn("Неужели она и правда такая помешанная на размерах? С первого взгляда и не скажешь.")

		saynn("[say=socket]Так что внутренние стенки моей киски могут лучше выдерживать различные химические соединения, вроде сахара или слабых органических кислот.[/say]")

		saynn("Что.. что ты сказала..")

		saynn("[say=pc]Зачем тебе кислота в киске..[/say]")

		saynn("Сокет пожимает плечами.")

		saynn("[say=socket]Слабые кислоты. Ну, как те, что добавляют в напитки, понимаешь?[/say]")

		saynn("От этого объяснение не стало звучать лучше. Но ты чувствуешь, что стоит остановиться, пока не посыпались еще более.. сочные подробности.")

		addButton("Продолжить", "Спросить о чем-то другом", "talk_options")
	if(state == "ask_headset"):
		saynn("Ты указываешь на стильные очки, которые Сокет сдвинула на лоб.")

		saynn("[say=pc]А это что у тебя на голове?[/say]")

		saynn("Сокет так закатывает глаза, что у неё даже кончик языка высовывается.")

		saynn("[say=socket]А, это! Чтобы нетраннить![/say]")

		saynn("[say=pc]Нетраннить?[/say]")

		saynn("Она часто-часто кивает.")

		saynn("[say=socket]Кибербезопасность. Нетраннинг — это то, как я защищаю сети от киберугроз![/say]")

		saynn("Интересно. Похоже, Сокет не просто инженер.")

		saynn("[say=socket]К сожалению, на этой станции нет нужного оборудования. Из-за этого чувствую себя совершенно потерянной...[/say]")

		saynn("Она оглядывается по сторонам.")

		saynn("[say=socket]Так что буду рада любой помощи.[/say]")

		saynn("Справедливо.")

		addButton("Продолжить", "Спросить о чем-то другом", "talk_options")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_show_around"):
		if(!getFlag("SocketModule.h1completed", false)):
			setFlag("SocketModule.h1completed", true)
			runScene("SocketHelp1Mineshaft")
			endScene()
			return
		if(!getFlag("SocketModule.h2completed", false)):
			setFlag("SocketModule.h2completed", true)
			runScene("SocketHelp2Scene")
			endScene()
			return
		if(!getFlag("SocketModule.h3completed", false)):
			setFlag("SocketModule.h3completed", true)
			runScene("SocketHelp3Scene")
			endScene()
			return
		if(!getFlag("SocketModule.h4completed", false)):
			setFlag("SocketModule.h4completed", true)
			runScene("SocketHelp4Scene")
			endScene()
			return
		if(!getFlag("SocketModule.h5completed", false)):
			setFlag("SocketModule.h5completed", true)
			runScene("SocketHelp5Scene")
			endScene()
			return

	if(_action == "see_cell_upgrades"):
		runScene("SocketBuyCellUpgradesScene")
		endScene()
		return

	if(_action == "ask_vents"):
		runScene("SocketBuyFastTravelScene")
		return

	if(_action == "do_1_task"):
		runScene("SocketHelp1Mineshaft")
		endScene()
		return

	if(_action == "do_2_task"):
		runScene("SocketHelp2Scene")
		endScene()
		return

	if(_action == "do_3_task"):
		runScene("SocketHelp3Scene")
		endScene()
		return

	if(_action == "do_4_task"):
		runScene("SocketHelp4Scene")
		endScene()
		return

	if(_action == "do_5_task"):
		runScene("SocketHelp5Scene")
		endScene()
		return

	setState(_action)
