extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "ElizaTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["eliza"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcAction="stand"})
		
	if(state == ""):
		if(!GM.main.getModuleFlag("MedicalModule", "Eliza_IntroducedMedical")):
			GM.main.setModuleFlag("MedicalModule", "Eliza_IntroducedMedical", true)
			
			saynn("Вестибюль медицинского крыла выглядит ярко: стены из белого бетона залиты светом множества люминесцентных ламп. За стойкой вы видите врача — знакомое лицо, та самая женщина, что оформляла вас в день прибытия. Она сидит в офисном кресле и потягивает кофе. Кружка у неё, похоже, личная — ваш взгляд цепляется за надпись «Лучшая мама».")

			saynn("Она зевает, а затем замечает ваше присутствие. Поерзав в кресле, она поспешно поправляет выбившуюся прядь волос.")

			saynn("[say=eliza]О, привет, заключенный. Что-то нужно?[/say]")

			saynn("[say=pc]Да так, просто брожу по коридорам.[/say]")

			saynn("[say=eliza]Ну, это медицинское крыло — место, где заключенных латают, так или иначе. Я всего лишь один из врачей, меня зовут доктор Куинн, на случай если ты забыл.[/say]")

			saynn("Вы оглядываетесь: широкая стойка отделяет вестибюль от зоны для персонала. С обоих концов вестибюля расположены два шлюза с панелями, которые, кажется, требуют специального доступа. Также есть проход в другую комнату.")

			saynn("[say=eliza]Без специального разрешения тебе разрешено находиться только в вестибюле. И в детской.[/say]")

			saynn("[say=pc]В детской?[/say]")

			saynn("[say=eliza]Ага. Тебе что-то нужно, заключенный?[/say]")
		else:
			saynn("Вы подходите к стойке, и вас встречает знакомая кошачья мордашка. Кажется, доктор всегда прихлёбывает кофе из своей кружки.")

			saynn("[say=eliza]На связи доктор Куинн. Что-то нужно?[/say]")
		
		if(getModule("ElizaModule").canTFEliza()):
			addButtonAt(14, "Меню ТФ", "Прикажите Элизе принимать или прекратить прием определенных препаратов для трансформации!", "openTFMenu")
		
		addButton("Поговорить", "Задать ей несколько вопросов", "talk")
		addButton("Внешность", "Рассмотреть поближе", "appearance")
		if(getModuleFlag("MedicalModule", "Med_pcKnowsAboutTests")):
			addButton("Исследовать", "Вас любопытствуют эксперименты", "research")
		else:
			addDisabledButton("Исследовать", "Сначала обсудить это с Элизой")
		if(getModuleFlag("MedicalModule", "Med_pcKnowsAboutMilking")):
			addButton("Дойка", "Выяснить, как вас можно подоить", "milking_menu")
			
#			if(GM.pc.hasPerk(Perk.MilkNoSoreNipples) || (!getModuleFlag("MedicalModule", "Med_wasMilkedToday", false) && !GM.pc.hasEffect(StatusEffect.SoreNipplesAfterMilking))):
#				addButton("Дойка", "Попросить, чтобы вас подоили", "milking")
#			else:
#				addDisabledButton("Дойка", "Дать себе немного отдохнуть")
		else:
			addDisabledButton("Дойка", "Сначала обсудить это с Элизой")
		
		var isHurt = false
		if(GM.pc.getPainLevel() > 0.5 || GM.pc.hasEffect(StatusEffect.Wounded) || GM.pc.hasEffect(StatusEffect.StretchedPainfullyPussy) || GM.pc.hasEffect(StatusEffect.StretchedPainfullyAnus)):
			isHurt = true
			
		if(isHurt):
			if(!getFlag("MedicalModule.Medical_FirstTimeHealedHappened")):
				addButtonWithChecks("Мне больно", "Попросить медицинской помощи", "firsttimecryo", [], [ButtonChecks.NotGagged])
			else:
				addButtonWithChecks("Мне больно", "Попросить медицинской помощи", "healmenu", [], [ButtonChecks.NotGagged])
		else:
			addDisabledButton("Мне больно", "Ты не настолько ранен, чтобы просить помощи")
			
		if(getModule("ElizaModule").canSexEliza()):
			addButton("Секс!", "Развлечься с Элизой", "start_sex_menu")
			addButton("Покормить", "Покормить Элизу", "feedmenu")
			
		addButton("Уйти", "Сделать что-то другое", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["eliza"])
		
	if(state == "healmenu"):
		saynn("[say=pc]Ох.. док. Что-то мне нехорошо. Можете меня снова подлатать?[/say]")
		
		saynn("Элиза выходит из-за стойки и подходит к тебе, быстро осматривая с ног до головы.")
		
		saynn("[say=eliza]Могу, но... боюсь, что бесплатным был только первый раз.[/say]")
		
		saynn("Ты вопросительно приподнимаешь бровь.")
		
		saynn("[say=eliza]Да, мне самой жаль. Но теперь за каждое использование криокапсулы придётся платить 10 кредитов. Заключённые слишком уж злоупотребляли бесплатным лечением.[/say]")
		
		saynn("[say=pc]Понятно.[/say]")
		
		saynn("[say=eliza]Но если твои повреждения касаются только твоих «интимных мест», я могу предложить другой вариант. Это обойдётся всего в 5 кредитов.[/say]")
		
		if(GM.pc.getCredits() < 10):
			saynn("Элиза быстро просматривает твои медицинские записи на своём датападе.")
		
			saynn("[say=eliza]А если кредитов всё равно не хватит... у меня есть разрешение уводить счета заключённых в минус. На случай, если дела совсем плохи.[/say]")
		
		addButton("Криокапсула", "Заплатить 10 кредитов и пройти процедуру в криокапсуле, которая заживляет большинство ран и повреждений", "cryopodsimple")
		if(GM.pc.hasEffect(StatusEffect.StretchedPainfullyPussy) || GM.pc.hasEffect(StatusEffect.StretchedPainfullyAnus)):
			addButtonWithChecks("Подлечить хозяйство", "Заплатите 5 кредитов и получите «инъекцию» заживляющего геля прямо в свои причиндалы", "healinggel", [], [ButtonChecks.HasReachableAnus])
		else:
			addDisabledButton("Подлечить хозяйство", "Ваши интимные места не получили никаких повреждений")
		addButton("Проехали", "С вами всё в порядке", "")
		
#ACEPREGEXPAC - Eliza has pregnancy descriptors if you oogle her
#I might change this depending on whats in Eliza content but until then, whatever.
#that "make me a woman" line at the breeder ending of chastity content has to be a hint, right?
	if(state == "appearance"):
		if(getCharacter("eliza").isHeavilyPregnant()):
			saynn("Доктор Элиза Куинн выглядит уставшей; для кошки она довольно высокая — около 1,8 метра. Её мех пастельно-жёлтого цвета с белыми и розовыми акцентами, длинные волосы собраны в хвост. Она носит очки и белый лабораторный халат с именным бейджем, под которым видны зелёная кофта и чёрная юбка до колен, перехваченная поясом с медицинским оборудованием.")
			
			saynn("Её кофта изо всех сил пытается скрыть её позднюю беременность, но всё равно задирается, позволяя мельком увидеть животик. Её увеличившиеся груди также натягивают ткань топа.")
			
			saynn("Вы слишком боитесь засунуть голову ей под юбку, но между её ног не видно никакого бугорка...")
			
			saynn("В целом, она выглядит как милая кошка-врач.")
		elif(getCharacter("eliza").isVisiblyPregnant()):
			saynn("Доктор Куинн похожа на типичного врача: она довольно высокая для кошки, около 1,8 метра, её мех пастельно-жёлтого цвета с белыми и розовыми акцентами. Длинные волосы собраны в хвост. На ней очки и белый халат с прикрепленным бейджем. Под ним можно заметить зелёную кофту и чёрную юбку до колен. Также заметно, что на ней надеты тёмные прозрачные колготки. Кажется, в её карманах и на поясе полно снаряжения — в основном медицинского, но также там есть пульт для шокера.")
			
			saynn("Даже плотная одежда не может скрыть округлившийся живот, выдающий её беременность, а её грудь уже начинает едва сдерживать размер D-cup.")
			
			saynn("Ты слишком боишься засунуть голову ей под юбку, чтобы разглядеть, есть ли у неё между ног бугорок.")
			
			saynn("В целом, она выглядит как милая кошка-врач.")
		else:
			saynn("Доктор Куинн похожа на типичного врача: она довольно высокая для кошки, около 1,8 метра, её мех пастельно-жёлтого цвета с белыми и розовыми акцентами. Длинные волосы собраны в хвост. На ней очки и белый халат с прикрепленным бейджем. Под ним можно заметить зелёную кофту и чёрную юбку до колен. Также заметно, что на ней надеты тёмные прозрачные колготки. Кажется, в её карманах и на поясе полно снаряжения — в основном медицинского, но также там есть пульт для шокера.")

			saynn("Под всей этой одеждой можно лишь догадываться, что её грудь — скромный C-cup.")

			saynn("Ты слишком боишься засунуть голову ей под юбку, чтобы разглядеть, есть ли у неё между ног бугорок.")

			saynn("В целом, она выглядит как милая кошка-врач.")
		
		addButton("Назад", "Назад", "")
		
	if(state == "talk"):
		saynn("[say=pc]Можно тебя кое о чем спросить?[/say]")

		saynn("Доктор слегка ерзает в кресле и смотрит на тебя.")

		saynn("[say=eliza]Давай, заключенный.[/say]")
		
		addButton("Лучшая мама?", "Спросить, почему у неё такое лицо", "best_mom?")
		addButton("Работать", "Что здесь вообще происходит", "work")
		if(getModuleFlag("MedicalModule", "Med_pcKnowsAboutWork")):
			addButton("Беременности", "Спросить о том, как проходят роды", "pregnancies")
			addButton("Исследовать", "Спросить, что здесь исследуют", "talkresearch")
		else:
			addDisabledButton("Беременности", "Вы об этом пока ничего не знаете")
			addDisabledButton("Исследовать", "Вы об этом пока ничего не знаете")
		if(getModuleFlag("MedicalModule", "Med_pcKnowsAboutBreeding")):
			addButton("Дойка", "Что это вообще за дела?", "talkmilking")
		else:
			addDisabledButton("Дойка", "Вы об этом пока ничего не знаете")

		addButton("Назад", "Назад", "")

#ACEPREGEXPAC - Eliza gives a different response if you comment on her best mom mug
	if(state == "best_mom?"):
		if (getCharacter("eliza").isVisiblyPregnant()):
			saynn("[say=pc]Твоя кружка. Ты мать?[/say]")
			
			saynn("Элиза смотрит на свою кружку с кофе и тяжело вздыхает.")
			
			saynn("[say=eliza]По крайней мере, пока что. Постараюсь наслаждаться этим, пока есть возможность.[/say]")
			
			saynn("Звучало это... не очень оптимистично. Пожалуй, не стоит постоянно поднимать эту тему.")
			
			#addMessage("[Whatever Rahi has planned for Eliza's content, I dont know it. Sorry. -Ace]")
			
			addButton("Продолжить", "Продолжить разговор", "talk")
		elif(GM.CS.getChildrenAmountOfOnlyMother("eliza") > 0):
			saynn("[say=pc]Твоя кружка. Ты мать?[/say]")

			saynn("Доктор смотрит на свою кружку с кофе и тяжело вздыхает.")

			saynn("[say=eliza]Очевидно, что нет... погоди. Кажется, теперь да. Хах. У меня уже была такая кружка.[/say]")

			saynn("Похоже, этот предмет связан с какими-то грустными воспоминаниями.")

			addButton("Продолжить", "Продолжить разговор", "talk")
		else:
			saynn("[say=pc]Твоя кружка. Ты мать?[/say]")

			saynn("Доктор смотрит на свою кружку с кофе и тяжело вздыхает.")

			saynn("[say=eliza]Грубовато, конечно, спрашивать такое. Но... нет, не такая. И это долгая история.[/say]")

			saynn("Похоже, этот предмет связан с какими-то грустными воспоминаниями.")

			addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "work"):
		setModuleFlag("MedicalModule", "Med_pcKnowsAboutWork", true)
		
		saynn("[say=pc]Сюда попадают заключенные, которых сильно избили?[/say]")

		saynn("Доктор поправляет очки одним пальцем.")

		saynn("[say=eliza]Ну да. Мы лечим не только физические травмы, но и гораздо большее. У нас проводят операции, лечат зубы, ведут беременных и следят за детьми. Есть даже психиатрическое отделение для тех, кому нужна такая помощь. А еще мы тут занимаемся научными исследованиями в качестве подработки.[/say]")

		saynn("Ого, это довольно много.")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "pregnancies"):
		setModuleFlag("MedicalModule", "Med_pcKnowsAboutBreeding", true)
		
		saynn("[say=pc]А что происходит с заключенными, которые беременеют?[/say]")

		saynn("[say=eliza]Заключенным разрешено рожать, но оставить детей себе они не могут. По очевидным причинам. Мы можем помочь ускорить развитие плода — современные технологии позволяют это сделать. После родов детей забирают. Но им обеспечивают должный уход: питание, образование, работа — всё необходимое. У них есть шанс на нормальную жизнь.[/say]")

		saynn("Доктор на секунду отводит взгляд на стену, на её лице почти нет эмоций.")

		saynn("[say=eliza]Тебе не о чем беспокоиться, заключенная. Те, кто кормит грудью, могут по желанию сдавать молоко здесь.[/say]")

		saynn("[say=pc]То есть вы хотите сказать, что заключенных можно трахать и плодить, и это даже не считается чем-то предосудительным?[/say]")

		saynn("Доктор хмурится, глядя на тебя.")

		saynn("[say=eliza]Когда ты оказалась здесь, ты лишилась всех прав человека, заключенная. Стерилизовать всех подряд было бы слишком накладно.[/say]")

		saynn("Вот это система! Конечно, заключенные будут плодиться друг с другом, если представится случай. И, судя по всему, у тюрьмы нет никаких финансовых проблем.")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "talkresearch"):
		setModuleFlag("MedicalModule", "Med_pcKnowsAboutTests", true)
		
		saynn("[say=pc]Какие исследования вы здесь проводите?[/say]")

		saynn("После этого вопроса в глазах доктора вспыхивает азарт.")

		saynn("[say=eliza]Множество. Здесь, в лаборатории, мы синтезируем новые виды лекарств и медикаментов. Вообще-то, это моя основная работа. Но мы также тестируем прототипы технологий и проводим другие эксперименты, которые обычно запрещены в обычных условиях.[/say]")

		saynn("Тебе требуется секунда, чтобы переварить услышанное. Лекарства? Тесты? Всё это звучит весьма тревожно.")

		saynn("[say=pc]В смысле «запрещены»? Вы что, говорите об использовании заключенных в качестве подопытных морских свинок? Насколько всё это безопасно?[/say]")

		saynn("Доктор выдыхает и делает еще глоток кофе, прежде чем ответить.")

		saynn("[say=eliza]У нас на всё есть бумаги, всё абсолютно законно. «АльфаКорп» платит огромные бабки за любые прорывные открытия. Вопросы безопасности и морали — не твоя забота, заключенный. За каждый успешный тест тебе будут платить рабочими кредитами — их хватит, чтобы окупить все риски.[/say]")

		saynn("Ну, по крайней мере, это не бесплатно... Тебе будут платить валютой, которая буквально нигде больше ничего не стоит, офигеть!")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "talkmilking"):
		setModuleFlag("MedicalModule", "Med_pcKnowsAboutMilking", true)
		
		saynn("[say=pc]Если у меня идет лактация, я могу сдавать здесь молоко?[/say]")

		saynn("Доктор улыбается.")

		saynn("[say=eliza]Да, у нас здесь целый ряд станций для дойки. Мы можем собирать молоко, семя, мужской и женский преэякулят. Тебе, конечно, будут платить, но некоторые делают это просто ради удовольствия.[/say]")

		saynn("[say=pc]Ну, это мило, наверное.[/say]")

		addButton("Продолжить", "Продолжить разговор", "talk")
		
	if(state == "research"):
		saynn("[say=pc]Так чем я могу помочь?[/say]")

		saynn("Элиза посмеивается.")

		saynn("[say=eliza]Конечно же, предложив себя. Потому что мне действительно нужны подопытные. Вот список видов исследований, которыми мы занимаемся.[/say]")

		saynn("Элиза показывает вам список вариантов.")
		
		#addDisabledButton("Тестирование препаратов", "Протестировать случайный препарат со случайным эффектом. В бумагах сказано, что долгосрочных последствий быть не должно.")
		addButton("Индукция лактации", "Она, скорее всего, введет тебе какой-нибудь препарат. По крайней мере, это бесплатно.", "induce_lactation")
		addButton("Эксперименты", "Попроси провести над тобой эксперименты. Скорее всего, это подразумевает роль подопытного для медицинских препаратов с неизвестными свойствами, а также тестирование новых прототипов (Внимание: сцены включают много употребления веществ, временных трансформаций и опытов, меняющих сознание)", "startexperiments")
		
		if(!getFlag("MedicalModule.PC_ReceivedPermanentCage")):
			if(!GM.pc.hasReachablePenis()):
				addDisabledButton("Тренировка послушания", "(контент с принудительным целомудрием) Чтобы начать эту программу, у тебя должен быть доступный для использования пенис")
			else:
				addButton("Тренировка послушания", "(контент с принудительным целомудрием) В одной из брошюр говорится о новом исследовании, целью которого является повышение низкого уровня послушания у заключенных", "startobedient")
		else:
			addDisabledButton("Тренировка послушания", "(контент с принудительным целомудрием) Ты уже записан на эту программу")
		
		if(!getFlag("ElizaModule.s0hap")):
			addButton("Лаборантка", "Попроси стать лаборантом Элизы — возможно, ей как раз не хватает помощника", "startlabassist")
		
		#addDisabledButton("Тестирование прототипов", "Испытать ультрасовременные высокотехнологичные машины или устройства")
		addButton("Назад", "Тебе не интересно", "")


	if(state == "milking_menu"):
		saynn("[say=pc]Мне интересно. Ты говорила о возможности донации молока и спермы?[/say]")

		saynn("Кошка убирает кружку и встает со стула.")

		saynn("[say=eliza]Да, лишним не будет. Как бы ты хотела, чтобы тебя подоили?[/say]")
		
		if(getModule("ElizaModule").hasLabAccess()):
			sayTanksVolume()
		
		if(!GM.pc.hasSoreNipples()):
			if(GM.pc.canBeMilked()):
				if(canBeMilked()):
					addButton("Молоко..", "Показать способы, которыми Элиза может доить твою грудь", "milk_breasts_menu")
				else:
					addDisabledButton("Молоко..", "Твоя грудь недостаточно полная, чтобы её доили")
			else:
				addDisabledButton("Молоко..", "Твои сиськи нельзя доить")
		else:
			addDisabledButton("Молоко..", "Соски болят, дай груди отдохнуть!")
		if(GM.pc.canBeSeedMilked()):
			if(canBeSeedMilked()):
				addButton("Семя..", "Показать, как Элиза может доить твой член", "milk_penis_menu")
			else:
				addDisabledButton("Семя..", "Твои яйца недостаточно полны для сбора семени")
		else:
			addDisabledButton("Семя..", "Способов доить твоё семя нет..")
		if(GM.pc.hasReachableVagina()):
			if(!getFlag("MedicalModule.Milked_Pussy", false)):
				addButton("Девичья конча..", "Показать, как Элиза может доить твою киску", "milk_vagina_menu")
			else:
				addDisabledButton("Девичья конча..", "Ты и так уже доила свою киску сегодня, дай ей отдохнуть!")
		else:
			addDisabledButton("Девичья конча..", "Твоя вагина находится вне зоны досягаемости, чтобы Элиза могла её подоить")
		if(GM.main.SCI.hasMilkingTier3()):
			if(!getFlag("MedicalModule.Milked_Breasts", false) && !getFlag("MedicalModule.Milked_Penis", false) && !getFlag("MedicalModule.Milked_Pussy", false)):
				addButton("Быстрое доение", "Попросить Элизу подоить всё разом и максимально быстро!", "do_start_milking_scene_quick")
			else:
				addDisabledButton("Быстрое доение", "Этот вариант доступен только если тебя еще не доили сегодня каким-либо другим способом")
		else:
			addDisabledButton("Быстрое доение", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
		
		addButton("Назад", "Назад", "")

	if(state == "milk_breasts_menu"):
		saynn("Как именно Элиза должна подоить твой {pc.breasts}?")
		
		if(getModule("ElizaModule").hasLabAccess()):
			sayTanksVolume()

		addButton("Ручное доение", "Позволить Элизе доить твою грудь руками", "do_start_milking_scene_breasts", ["ElizaMilkingBreastsHandScene"])
		if(GM.main.SCI.hasMilkingTier1()):
			addButton("Ручное доение в стойле", "Позволить Элизе доить твою грудь руками, находясь в стойле для доения", "do_start_milking_scene_breasts", ["ElizaMilkingBreastsStallScene"])
			addButton("Молочные насосы", "Позволить Элизе использовать промышленные молочные насосы на тебе", "do_start_milking_scene_breasts", ["ElizaMilkingBreastsPumpsScene"])
		else:
			addDisabledButton("Ручное доение в стойле", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
			addDisabledButton("Молочные насосы", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
		if(GM.main.SCI.hasMilkingTier2()):
			addButton("Доильный аппарат", "Позволить Элизе использовать доильный аппарат для твоей груди", "do_start_milking_scene_breasts", ["ElizaMilkingBreastsBDSMMachineScene"])
		else:
			addDisabledButton("Доильный аппарат", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
		
		addButton("Назад", "Назад", "milking_menu")

	if(state == "milk_penis_menu"):
		saynn("Как именно Элиза должна доить твой {pc.penis}?")
		
		if(getModule("ElizaModule").hasLabAccess()):
			sayTanksVolume()
			
		addButtonWithChecks("Ручное доение", "Позволить Элизе доить твой член руками", "do_start_milking_scene_seed", ["ElizaMilkingSeedHandScene"], [[ButtonChecks.HasReachablePenis]])
		addButton("Доение простаты", "Позволить Элизе доить твой член, массируя простату её пальцами", "do_start_milking_scene_seed", ["ElizaMilkingProstateHandScene"])
		if(GM.main.SCI.hasMilkingTier1()):
			addButtonWithChecks("Помпа для пениса", "Позволить Элизе доить твой член с помощью промышленного пенис-пампа", "do_start_milking_scene_seed", ["ElizaMilkingSeedPumpScene"], [[ButtonChecks.HasReachablePenis]])
			addButton("Доение страпоном", "Позволить Элизе доить твой член, используя страпон для стимуляции простаты", "do_start_milking_scene_seed", ["ElizaMilkingProstateStraponScene"])
		else:
			addDisabledButton("Помпа для пениса", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
			addDisabledButton("Доение страпоном", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
		if(GM.main.SCI.hasMilkingTier2()):
			addButtonWithChecks("Павджоб", "Позволить Элизе доить твой член её задними лапами", "do_start_milking_scene_seed", ["ElizaMilkingSeedPawjobScene"], [[ButtonChecks.HasReachablePenis]])
			if(getFlag("SocketModule.h5completed", false)):
				addButtonWithChecks("Флешлайт", "Позволить Элизе позвать кого-нибудь ещё, чтобы они доили твой член флешлайтом", "do_start_milking_scene_seed", ["ElizaMilkingSeedFleshlightScene"], [[ButtonChecks.HasReachablePenis]])
			else:
				addDisabledButton("Флешлайт", "Чтобы разблокировать этот вариант, нужно завершить сюжетную линию Сокета. Также твой член должен быть в зоне досягаемости")
			addButton("Доильный аппарат", "Позволить Элизе подоить твой член с помощью доильного аппарата. Включает стимуляцию простаты", "do_start_milking_scene_seed", ["ElizaMilkingSeedBDSMMachineScene"])
		else:
			addDisabledButton("Павджоб", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
			addDisabledButton("Флешлайт", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
			addDisabledButton("Доильный аппарат", "Тебе нужно стать ассистентом Элизы и достаточно прокачать лабораторию, чтобы использовать этот вариант.")
			
		addButton("Назад", "Назад", "milking_menu")

	if(state == "milk_vagina_menu"):
		saynn("Как именно Элиза должна доить твою киску?")
		
		if(getModule("ElizaModule").hasLabAccess()):
			sayTanksVolume()
		
		addButton("Сибиан", "Позволить Элизе использовать вибратор Sybian, чтобы выжать девичью кончу из твоей киски", "do_start_milking_scene_girlcum", ["ElizaMilkingGirlcumSybianScene"])
		
		addButton("Назад", "Назад", "milking_menu")

	if(state == "milk"):
		# (First time scene)
		if(!getModuleFlag("MedicalModule", "Med_milkingMilkFirstTime")):
			setModuleFlag("MedicalModule", "Med_milkingMilkFirstTime", true)
			saynn("[say=pc]Я хочу, чтобы мои сиськи подоили..[/say]")

			saynn("Доктор отходит от стойки и скрывается за стеной, чтобы спустя несколько секунд появиться из одного из шлюзов. Она подходит к тебе и начинает пристально осматривать.")

			# (if has forever flat breasts)
			if(!GM.pc.hasNonFlatBreasts()):
				saynn("[say=eliza]К сожалению, я не смогу тебя подоить, у твоих {pc.breasts} слишком маленькие молочные железы. Сначала нужно увеличить грудь.[/say]")

				saynn("Оууу.")

				addButton("Продолжить", "Окей", "")
				return
			# (scene ends)

			# (if has breasts)

			saynn("[say=eliza]Хмм.. Можно?[/say]")

			saynn("Ты не совсем понимаешь, что она имеет в виду, но всё равно киваешь. Элиза подсовывает руки под твои {pc.breasts}, проверяя их вес. Затем она начинает их крепко сжимать. Ты невольно издаешь тихий стон.")

			var breasts:BodypartBreasts = GM.pc.getBodypart(BodypartSlot.Breasts)
			# (if lactating and clothed)
			
			if(breasts.getProducedFluidAmount() > 0.1):
				if(!GM.pc.isFullyNaked()):
					saynn("Её усилия не прошли даром: после небольшого разминания груди ты замечаешь два влажных пятнышка на одежде примерно там, где находятся твои соски.")

					saynn("[say=eliza]О да. А у тебя тут сочные молочные бутылочки. Мы справимся.[/say]")

				# (if lactating and naked)
				else:
					saynn("Её усилия не прошли даром: после небольшого разминания груди ты замечаешь, что из сосков начинает сочиться молоко.")

					saynn("[say=eliza]О да. А у тебя тут сочные молочные бутылочки. Мы справимся.[/say]")
			else:
			# (if not lactating)

				saynn("Но как бы она ни старалась, ей не удавалось выдавить ни единой капли. Хотя твои соски теперь ощущаются твердыми и возбужденными.")

				saynn("[say=eliza]Ну, сейчас ты не лактируешь, так что это будет пустой тратой сил. Но... у тебя есть варианты. Беременность — очевидный выбор. Пока ты будешь беременна, грудь увеличится в размерах и начнет вырабатывать молоко сама собой. Если тебе это не нравится или не получается забеременеть — мы всегда можем вызвать лактацию. С помощью лекарств. Знаешь, даже мужчины могут кормить грудью.[/say]")
				
				addButton("Продолжить", "Окей", "")
				return
		else:
			# (not first time)
			var breasts:BodypartBreasts = GM.pc.getBodypart(BodypartSlot.Breasts)

			saynn("[say=pc]Я хочу, чтобы мои сиськи подоили..[/say]")

			saynn("Элиза быстро оглядывает тебя.")

			# (if not lactating and empty breasts)
			if(breasts.getProducedFluidAmount() < 0.1):
				saynn("[say=eliza]Ну, боюсь, для этого нужно, чтобы у тебя уже шла лактация.[/say]")
				addButton("Продолжить", "Окей", "")
				return
			# (scene end)

			# (if has milk)

			saynn("[say=eliza]Ладно, заключенный. Есть какие-нибудь предпочтения?[/say]")
			
			sayn("Количество сданного молока: "+str(floor(getModuleFlag("MedicalModule", "Med_milkMilked", 0.0)))+" ml")
			saynn("Количество доек: "+str(getModuleFlag("MedicalModule", "Med_milkedMilkTimes", 0)))
			
		if(GM.pc.canBeMilked()):
			addButton("Дойка руками", "Ты не особо привередлив, старый добрый способ вполне подойдет", "milk_handmilk")
		else:
			addDisabledButton("Дойка руками", "Сейчас тебя не доят")
		if(getModuleFlag("MedicalModule", "Med_milkedMilkTimes", 0) >= 1 && getModuleFlag("MedicalModule", "Med_milkMilked", 0.0) > 0.0):
			if(GM.pc.canBeMilked()):
				addButton("Доильные насосы", "Автоматизированная дойка звучит заманчиво", "milk_pumps")
			else:
				addDisabledButton("Доильные насосы", "Сейчас тебя не доят")
		addDisabledButton("Дойка (вагинальная)", "не завершено")
		addDisabledButton("Дойка (анальная)", "не завершено")
		addDisabledButton("Экстремальная дойка", "не завершено")
		addButton("Проехали", "Вы передумали", "")

		

	if(state == "seed"):
		# (first time)
		if(!getModuleFlag("MedicalModule", "Med_milkingSeedFirstTime")):
			setModuleFlag("MedicalModule", "Med_milkingSeedFirstTime", true)
			saynn("[say=pc]Я хочу, чтобы меня подоили.[/say]")

			saynn("Доктор отходит от стойки и скрывается за стеной, чтобы спустя пару секунд появиться из одного из шлюзов. Она подходит к тебе и начинает осматривать, сосредоточив всё внимание на твоей промежности.")

			# (if has reachable cock)
			if(GM.pc.hasReachablePenis()):
				saynn("[say=eliza]Да, это можно устроить, нам всегда нужно больше генетического материала.[/say]")

				saynn("Она одаривает тебя лукавой улыбкой.")
			else:
				# (if has non-reachable cock)

				saynn("[say=eliza]Вижу, ты в целомудрии. Это ограничивает варианты, но мы всё равно можем это сделать, просто стимуляция будет... косвенной... если понимаешь, о чём я.[/say]")

				saynn("Она одаривает тебя лукавой улыбкой.")
		else:
			# (if not first time)

			saynn("[say=pc]Я хочу, чтобы меня подоили.[/say]")

			saynn("Элиза бросает на тебя быстрый взгляд.")

			saynn("[say=eliza]Мы вполне можем это устроить~.[/say]")
			
			sayn("Количество сданного семени: "+str(floor(getModuleFlag("MedicalModule", "Med_seedMilked", 0.0)))+" ml")
			saynn("Количество доек: "+str(getModuleFlag("MedicalModule", "Med_milkedSeedTimes", 0)))
			
			
		if(GM.pc.canBeSeedMilked()):
			if(GM.pc.hasReachablePenis()):
				addButton("Дойка руками", "Зачем отказываться от женских рук...", "milk_handseedmilk")
			else:
				addDisabledButton("Дойка руками", "Для этого тебе нужно освободить свой член...")
			
			addButton("Доение простаты", "Альтернативный метод, который даже не требует свободного доступа к твоему херу...", "milk_prostatemilking")
		else:
			addDisabledButton("Дойка руками", "Сейчас тебя не доят")
			addDisabledButton("Доение простаты", "Сейчас тебя не доят")
		addDisabledButton("Помпа", "не завершено")
		addButton("Проехали", "Вы передумали", "")

func sayTanksVolume():
	var storedFluids:Dictionary = GM.main.SCI.getStoredFluidsWithDefauls()
	
	sayn("Содержимое резервуаров с жидкостью:")
	for fluidID in storedFluids:
		var fluidAmount:float = storedFluids[fluidID]
		var fluidLimit:float = GM.main.SCI.getStoredFluidLimit(fluidID)
		var fluidName:String = "Неизвестная жидкость"
		
		var fluid:FluidBase = GlobalRegistry.getFluid(fluidID)
		if(fluid != null):
			fluidName = fluid.getVisibleName()
		
		sayn("- "+fluidName+": "+str(Util.roundF(fluidAmount, 1))+"/"+str(Util.roundF(fluidLimit, 1))+"ml")
	sayn("")

func _react(_action: String, _args):
	if(_action == "induce_lactation"):
		runScene("ElizaInducingLactation")
		endScene()
		return
	
	if(_action == "milk_handmilk"):
		runScene("ElizaHandMilking")
		endScene()
		return
		
	if(_action == "milk_handseedmilk"):
		runScene("ElizaHandSeedMilking")
		endScene()
		return
		
	if(_action == "milk_pumps"):
		runScene("ElizaMilkingPumps")
		endScene()
		return
		
	if(_action == "milk_prostatemilking"):
		runScene("ElizaProstateMilking")
		endScene()
		return
	
	if(_action == "startobedient"):
		runScene("ForcedChastityMedbayStartScene")
		endScene()
		return
	
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "startexperiments"):
		runScene("ElizaGetIntoMentalWard")
		endScene()
		return
	
	if(_action == "firsttimecryo"):
		setFlag("MedicalModule.Medical_FirstTimeHealedHappened", true)
		runScene("MedicalHealCryopodFirstTime")
		endScene()
		return
	
	if(_action == "cryopodsimple"):
		GM.pc.addCredits(-10)
		runScene("MedicalHealCryopodScene")
		endScene()
		return
	
	if(_action == "healinggel"):
		GM.pc.addCredits(-5)
		runScene("MedicalHealingGelScene")
		endScene()
		return
	
	if(_action == "startlabassist"):
		setFlag("ElizaModule.s0hap", true)
		runScene("Eliza0AskJobScene")
		endScene()
		return
		
	if(_action == "start_sex_menu"):
		runScene("ElizaSexMenuScene")
		endScene()
		return
		
	if(_action == "do_start_milking_scene_breasts"):
		setFlag("MedicalModule.Milked_Breasts", true)
		runScene(_args[0])
		endScene()
		return
		
	if(_action == "do_start_milking_scene_seed"):
		setFlag("MedicalModule.Milked_Penis", true)
		runScene(_args[0])
		endScene()
		return
		
	if(_action == "do_start_milking_scene_girlcum"):
		setFlag("MedicalModule.Milked_Pussy", true)
		runScene(_args[0])
		endScene()
		return
		
	if(_action == "do_start_milking_scene_quick"):
		setFlag("MedicalModule.Milked_Breasts", true)
		setFlag("MedicalModule.Milked_Penis", true)
		setFlag("MedicalModule.Milked_Pussy", true)
		runScene("ElizaQuickMilkingScene")
		return
	
	if(_action == "openTFMenu"):
		runScene("ElizaTFHerScene")
		return
	
	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["eliza"])
		return
	
	setState(_action)


func canBeMilked() -> bool:
	if(!GM.pc.hasBodypart(BodypartSlot.Breasts)):
		return false
	var breasts: BodypartBreasts = GM.pc.getBodypart(BodypartSlot.Breasts)
	var production: FluidProduction = breasts.getFluidProduction()
	if(production == null):
		return false
	return production.getFluidAmount() >= 300.0 || production.getFluidLevel() >= 0.4

func canBeSeedMilked() -> bool:
	if(!GM.pc.hasBodypart(BodypartSlot.Penis)):
		return false
	var penis: BodypartPenis = GM.pc.getBodypart(BodypartSlot.Penis)
	var production: FluidProduction = penis.getFluidProduction()
	if(production == null):
		return false
	return production.getFluidAmount() >= 100.0 || production.getFluidLevel() >= 0.8
