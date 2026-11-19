extends SceneBase

func _init():
	sceneID = "VionRepeatConversation"

func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "stand", {npc="vion"})
		saynn("Вы стоите в камере {vion.name}.")

		if(!getFlag("HypnokinkModule.VionTopicKnown_NoSex")):
			addButton("Секс?", "Хочешь трахнуться?", "ask_sex_fromMain")
			
		addButton("Вопросы", "У вас есть вопросы", "questions")
		
		if(getFlag("HypnokinkModule.VionTopicKnown_Hypnotist")):
			addButton("Сеансы", "У вас есть время для гипнотического сеанса", "sessions")
		else:
			addDisabledButton("Сеансы", "Узнать больше об этой теме")
			
		if(not getFlag("HypnokinkModule.VionTopicKnown_Hypnotist", false)):
			addDisabledButton("Скидка", "Узнать больше об этой теме")
		elif(getFlag("HypnokinkModule.FreebieSessionSample", false)):
			addDisabledButton("Скидка", "Первый раз — бесплатно")
		elif(getFlag("HypnokinkModule.RushSubdued", false)):
			addButton("Скидка", "Спросить о цене сеанса", "discount_onthehouse")
		elif(getFlag("HypnokinkModule.OnTheHouseSessions", 0) > 0):
			addButton("Скидка", "Спросить о цене сеанса", "discount_onthehouse_temporary")
		elif(not getFlag("HypnokinkModule.KnowAboutRush", false)):
			addButton("Скидка", "Спросить о цене сеанса", "discount_rush_intro")
		else:
			addButton("Скидка", "Спросить о цене сеанса", "discount_rush_reminder")
			
		if(getFlag("HypnokinkModule.Vion_HaveDatapad", false)):
			addButton("Использовать датапад", "Попробовать взломать как хакер", "use_alex_datapad")
			
			
		addButton("До свидания", "Пока что всё", "endthescene")
		
		#addButton("DEBUG FIGHT", "Ха-ха, получил хук в челюсть!", "debug_fight")
		#addButton("ДЕБАГ СЕКСА", "Ха-ха, получи, лохушка!", "debug_sex")
		#addButton("ДЕБАГ ТЕКСТА", "тест текстовых эффектов", "test_effects") 
		
	if(state == "test_effects"):
		saynn("Гипно-текст: [tornado radius=3.0 freq=2.0 connected=1][pulse color=#FF33FF height=0.0 freq=3.0]Гипнослово[/pulse][/tornado]")
		saynn("Волна: [wave amp=50.0 freq=5.0 connected=1]Быстрая коричневая лиса прыгает через ленивую собаку.[/wave]")
		saynn("Торнадо: [tornado radius=10.0 freq=1.0 connected=1]Быстрая коричневая лиса прыгает через ленивую собаку.[/tornado]")
		saynn("Тряска: [shake rate=20.0 level=5 connected=1]Быстрая коричневая лиса прыгает через ленивую собаку.[/shake]")
		saynn("Затухание: [fade start=4 length=14]Быстрая коричневая лиса прыгает через ленивую собаку.[/fade]")
		saynn("Радуга: [rainbow freq=1.0 sat=0.8 val=0.8]Быстрая коричневая лиса прыгает через ленивую собаку.[/rainbow]")
		saynn("Пульсация: [pulse color=#00FFAA height=0.0 freq=2.0]Быстрая коричневая лиса прыгает через ленивую собаку.[/pulse]")
		saynn("Матрица: [matrix clean=2.0 dirty=1.0 span=50]Быстрая коричневая лиса прыгает через ленивую собаку.[/matrix]")
		saynn("Призрак: [ghost freq=5.0 span=10.0]Быстрая коричневая лиса прыгает через ленивую собаку.[/ghost]")
		saynn("Испорченный: [corrupt]Быстрая коричневая лиса прыгает через ленивую собаку.[/corrupt]")
		saynn("Консоль: [console freq=5.0 span=10.0]Быстрая коричневая лиса прыгает через ленивую собаку.[/console]")
		addButton("До свидания", "Пока что всё", "endthescene")
		
	if(state == "questions"):
		saynn("[say=vion]Спрашивай.[/say]")

		addButton("Диван", "Спросить про диван", "ask_sofa")
		
		if(getFlag("HypnokinkModule.VionTopicKnown_Services")):
			addButton("Услуги", "Спросить об услугах", "ask_job")
		else:
			addDisabledButton("Услуги", "Узнать больше об этой теме")
		addButton("Секс?", "Хочешь трахнуться?", "ask_sex")
		
		if(not getFlag("HypnokinkModule.Vion_FreedFromCage")):
			if(getFlag("HypnokinkModule.VionTopicKnown_NoSex")):
				addButton("Никакого секса?", "Необычно для сиреневой", "ask_sex2")
			else:
				addDisabledButton("Никакого секса?", "Узнать больше об этой теме")
			
		if(getFlag("HypnokinkModule.VionTopicKnown_Backstory")):
			addButton("Долгая история", "У тебя полно времени", "ask_background")
			if(not getFlag("HypnokinkModule.Vion_FreedFromCage")):
				addButton("Целомудрие", "Спросить про клетку", "ask_chastity")
		else:
			addDisabledButton("Долгая история", "Узнать больше об этой теме")
			if(not getFlag("HypnokinkModule.Vion_FreedFromCage")):
				addDisabledButton("Целомудрие", "Узнать больше об этой теме")
		
		addButton("Готово", "Вопросов больше нет", "")
		
	if(state == "ask_sofa"):
		saynn("Ты сидишь на подлокотнике дивана.")

		saynn("[say=pc]Эта штука выглядит тяжелой. Раз ты затащила её сюда, значит, ты сильнее, чем кажешься.[/say]")

		saynn("[say=vion]Если бы только. Мне помогали некоторые сокамерницы, которые ценят мои услуги.[/say]")

		saynn("[say=pc]И охрана тебе это просто спускает с рук?[/say]")

		saynn("[say=vion]Ну, если они попытаются, то им придется объяснять, почему они до сих пор не избавились от этой хреновины, как положено. Нельзя их винить за лень — ты когда-нибудь пробовала тащить диван в лифт?[/say]")

		saynn("Справедливо.")
		
		setFlag("HypnokinkModule.VionTopicKnown_Services", true)

		addButton("Назад", "", "questions")
	if(state == "ask_job"):
		saynn("[say=pc]Так когда ты говоришь об услугах...[/say]")
		
		saynn("{vion.name} поднимает руку, чтобы остановить тебя.")
		
		saynn("[say=vion]Уверяю тебя, это не совсем то, о чем ты подумал.[/say]")
		
		saynn("[say=vion]Вообще-то, мои профессиональные навыки оказываются довольно полезными даже в тюрьме. Я... хм. Я [i]была[/i] лицензированным гипнотизером.[/say]")

		saynn("На твоем лице, должно быть, отразился скептицизм, потому что {vion.name} тут же добавляет:")
		
		saynn("[say=vion]Это не то, что показывают в дешевых киношках или эротических романах. Я не обещаю чудес и не заставлю людей верить, что они лягушки или типа того. Считай это скорее направленной релаксацией и базовой терапией.[/say]")
		
		saynn("[say=pc]И это чертовски полезная штука, не так ли?[/say]")
		
		saynn("[say=vion]Тебя это удивляет? В тюрьме вроде этой полно людей, которым не помешало бы хоть какое-то бегство от реальности. И еще больше тех, кто хочет научиться лучше контролировать свои не самые приятные импульсы.[/say]")

		saynn("Ты на мгновение задумываешься. Если рассуждать в таком ключе, то в этой идее действительно есть смысл.")
		
		saynn("Он подмигивает тебе и добавляет:")
		
		saynn("[say=vion]Если сомневаешься, всегда можешь попробовать сама. Первый раз — бесплатно![/say]")
		
		setFlag("HypnokinkModule.VionTopicKnown_Hypnotist", true)
		
		addButton("Назад", "", "questions")
	if(state == "ask_sex" || state == "ask_sex_fromMain"):
		if(not getFlag("HypnokinkModule.Vion_FreedFromCage")):
			saynn("Ты решаешь, что нет смысла ходить вокруг да около.")
			saynn("[say=pc]Хочешь трахнуться?[/say]")
			saynn("Он на мгновение закрывает глаза и вздыхает.")
			saynn("[say=vion]Я [i]не[/i] являюсь эмпатом.[/say]")
			saynn("Ну, это было неожиданно.")
			setFlag("HypnokinkModule.VionTopicKnown_NoSex", true)
		else:
			saynn("[say=pc]Хочешь трахнуться?[/say]")
			saynn("[say=vion]Прямо сейчас — нет.[/say]")

		addButton("Назад", "", "questions" if state == "ask_sex" else "")
	if(state == "ask_sex2"):
		saynn("Твой взгляд задерживается на цвете его униформы.")

		saynn("[say=vion]...ну давай, спрашивай.[/say]")

		saynn("[say=pc]Ладно. Обычно сирень чуть более...[/say]")

		saynn("[say=vion]Шаловливая?[/say]")

		saynn("[say=pc]Ага.[/say]")

		saynn("Он пожимает плечами.")

		saynn("[say=vion]Короче говоря, я предпочитаю, чтобы мои любовные приключения были не такими уж [i]легкомысленными[/i]. К тому же, моя любимая поза сейчас недоступна.[/say]")

		saynn("Он на мгновение оттягивает шорты, позволяя тебе мельком увидеть металл между его ног. Ох. Должно быть, это чертовски дразнит.")

		setFlag("HypnokinkModule.VionTopicKnown_Backstory", true)
		
		addButton("Назад", "", "questions")
	if(state == "ask_background"):
		saynn("[say=pc]У меня есть время. Так в чем заключается эта длинная история?[/say]")

		saynn("[say=vion]Как скажешь.[/say]")

		saynn("Он откидывается назад.")

		saynn("[say=vion]Опять обычный сиреневый? Попалась на продаже своего тела не на том углу улицы или с такими видосиками в датападе, которые общество считает «неприемлемыми»? Хочешь знать, как я здесь оказалась?[/say]")

		saynn("Вы жестом просите его продолжать.")

		saynn("[say=vion]Оказалось, что если у твоего парня есть тревожные склонности к собственничеству, стоит убедиться, что эти черты не достались ему от отца. И, разумеется, что этот самый отец — не технический директор крупнейшего технологического конгломерата.[/say]")

		saynn("Он встает и начинает мерить комнату шагами.")

		saynn("[say=vion]Однажды ночью я просыпаюсь от того, что полдюжины громил выламывают мою дверь. Прежде чем я успеваю хоть что-то возразить, они набрасывают мне на голову мешок и утаскивают прочь. Спустя два часа дрожи в холодной темной камере, меня швыряют прямиком в зал суда![/say]")

		saynn("[say=vion]Из того, что я успела понять во время этого липового процесса, Папочка-Дедушка решил, что я пытаюсь промыть мозги его драгоценному отпрыску, чтобы превратить его в секс-раба. Хотя лично я подозреваю, что в моем банковском счете просто было недостаточно нулей для его вкуса.[/say]")

		saynn("Он делает паузу.")

		saynn("[say=vion]Хотя стоит отдать старику должное. Настоящий кенгуру в роли судьи — это было вдохновенно.[/say]")

		saynn("[say=vion]В любом случае, если я не вставлю ни слова в течение десяти минут, меня признают виновным, швырнут обратно в камеру, а на следующий же день отправят в какую-то сомнительную с точки зрения закона космическую тюрьму черт знает где.[/say]")

		saynn("Он прислоняется к стене и скрещивает руки на груди.")

		saynn("[say=vion]Так что да, это не совсем обычный сиреневый.[/say]")

		addButton("Назад", "", "questions")
	if(state == "ask_chastity"):
		saynn("[say=pc]Значит, доктор Куинн опять за свои привычные делишки?[/say]")

		saynn("Вы указываете жестом в сторону его паха. Он усмехается.")

		saynn("[say=vion]Ха, если бы. Тогда я бы смог хоть что-то [i]с этим сделать[/i]. Нет, это последний подарок от моей бывшей. На самом деле, одна из самых элитных клеток на рынке, модель DeLoxe S3-Karat. У меня нет устройства, чтобы ввести пароль, да и тот, что я знаю, к этому времени наверняка уже истек![/say]")
		
		saynn("Он фыркает.")
		
		saynn("[say=vion]Ничто, кроме субмолекулярного дезинтегратора, не поможет снять это, не кастрировав меня в процессе. И по какой-то необъяснимой причине в тюрьме строгого режима наблюдается острая нехватка режущих инструментов.[/say]")

		saynn("[say=vion]Забавно, как обычно дотошные охранники умудрились не заметить это во время регистрации, не так ли?[/say]")

		saynn("Он лениво пинает стул, заставляя его громыхать по полу. Вы подозреваете, что {vion.name}[i]не[/i] считает эту шутку очень смешной.")

		setFlag("HypnokinkModule.VionTopicKnown_Chastity", true)
		addButton("Назад", "", "questions")
	if(state == "discount_rush_intro"):
		saynn("[say=pc]Твои навыки не то чтобы дешево обходятся.[/say]")

		saynn("[say=vion]Да, я в курсе. Честно говоря, я бы предпочел ставить цены на сеансы поскромнее, но сейчас мне очень нужны кредиты.[/say]")

		saynn("[say=pc]Почему? Тебе ведь здесь хотя бы за аренду платить не нужно.[/say]")

		saynn("[say=vion]Да, ну... есть один тип, который решил, что может выдвигать мне определенные требования. Пока что мне удавалось просто откупаться, но со временем цена его запросов только растет. У меня есть подозрения насчет его мотивов, но раз уж на кону [i]буквально[/i] моя задница, я бы не стал полагаться на интуицию.[/say]")

		saynn("[say=pc]И что он за тип? Может, я смогу с ним разобраться за тебя.[/say]")

		saynn("[say=vion]Ты уверен? Он не из тех, кого стоит злить. Он... ну... он здоровяк.[/say]")

		saynn("Взгляд Виона на мгновение расфокусируется, когда он уставится в пустоту — видимо, погрузившись в очень яркое воспоминание незаурядного масштаба.")

		saynn("[say=pc]Здоровяк?[/say]")

		saynn("[say=vion]Поверь мне, когда увидишь его, то согласишься, что это самое точное описание. В общем, он гибрид лошади и дракона. Неоново-голубой ирокез, темная шерсть. Заключенный режима высокой безопасности, зовется Рашем. Когда он не бродит вокруг, донимая меня, его обычно можно найти в спортзале или в блоке строгого режима.[/say]")

		saynn("[say=pc]Ладно, посмотрим, что можно сделать.[/say]")

		saynn("[say=vion]Просто... будь осторожнее. Не хочу потом мучиться совестью из-за твоего сломанного позвоночника. Может, стоит рассмотреть, ну... альтернативные методы дипломатии?[/say]")

		addButton("Назад", "", "")
		
	if(state == "discount_onthehouse"):
		saynn("[say=pc]Во сколько мне это обойдется?[/say]")
		
		saynn("[say=vion]Для тебя? Сеансы за счет заведения.[/say]")
		
		addButton("Назад", "", "")
	if(state == "discount_onthehouse_temporary"):
		saynn("[say=pc]Во сколько мне это обойдется?[/say]")
		
		saynn("[say=vion]Для тебя? Сеансы за счет заведения, по крайней мере, пока Раш снова не начнет мне надоедать.[/say]")
		
		addButton("Назад", "", "")
		
	if(state == "discount_rush_reminder"):
		saynn("[say=pc]Как там дела с ценами?[/say]")

		saynn("[say=vion]Раш недавно снова проходил мимо. Извини, но пока с ним не разберутся, придется брать обычную цену.[/say]")
		
		addButton("Назад", "", "")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "sessions"):
		runScene("VionSessionSelect")
		return
		
	if(_action == "discount_rush_intro"):
		setFlag("HypnokinkModule.KnowAboutRush", true)
		
	if(_action == "discount_rush_reminder"):
		if(getFlag("HypnokinkModule.RushDealStruckAtLeastOnce", false)):
			setFlag("HypnokinkModule.RushCausingMoreTrouble", true)
		
	if(_action == "use_alex_datapad"):
		endScene()
		runScene("VionFreed")
		return
		
	if(_action == "debug_fight"):
		runScene("FightScene", ["vion"], "guardfight")
		return
	if(_action == "debug_sex"):
		runScene("GenericSexScene", ["pc", "vion"], "domsex")
		return

	setState(_action)
