extends SceneBase

var askedDatapad = false
var askedFreq = false
var askedGrenades = false

func _init():
	sceneID = "Ch5s1PlanningScene"

func _reactInit():
	GM.pc.removeAllRestraints()

func _run():
	if(state == ""):
		addCharacter("tavi")
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		saynn("Когда ты медленно открываешь глаза... у тебя невольно вырывается вздох: Тави с жутковатой улыбкой на лице во все глаза пялится на тебя.")

		saynn("[say=pc]Ч-что за херня, Тави...[/say]")

		saynn("Ты всё ещё в постели. Тави ещё какое-то время нависает над тобой, но затем выпрямляется и тихонько посмеивается.")

		saynn("[say=tavi]Что? Я не подглядывала за тем, как ты спишь. Ну, даже если и так... наблюдать за своими питомцами — это же нормально, ясно?[/say]")

		saynn("Ты медленно поднимаешься и протираешь глаза.")

		saynn("[say=tavi]У меня есть план.[/say]")

		addButton("Опять?", "Да какой на этот раз?", "another_one")
		addButton("План?", "Спросить про план", "ask_plan")
	if(state == "another_one"):
		saynn("[say=pc]Еще один? Послушай, Тави... или мисс Тави, как бы там ни было...[/say]")

		saynn("Она щелкает тебя по носу.")

		saynn("[say=tavi]Твоя «мисс», именно так.[/say]")

		saynn("Высокая кошка наклоняется ближе, на её лице почти нет эмоций, кроме легкой улыбки. От её пристального взгляда по твоей спине пробегает дрожь. Но затем Тави вздыхает и опускает подбородок.")

		saynn("[say=tavi]И я не справлюсь без тебя.[/say]")

		saynn("Тави протягивает лапу и слегка тянет тебя за воротник. Он всё еще плотно сидит на шее... слишком плотно... Улыбка исчезает.")

		saynn("[say=tavi]Я просто... не хочу, чтобы другие были как я... У меня никогда не было выбора, кем мне быть... Даже нормального детства не было... Мы все заслуживаем хотя бы малейшей возможности выбирать, милашка...[/say]")

		saynn("С этим трудно спорить.")

		saynn("[say=pc]А что, если кому-то нравится не иметь выбора?[/say]")

		saynn("[say=tavi]Тогда это их выбор, милашка.[/say]")

		saynn("На лице Тави снова играет та самая легкая улыбка, как и всегда.")

		saynn("[say=tavi]Хочешь послушать, что я придумала? Мне кажется, этот план — лучший из всех..[/say]")

		addButton("Конечно", "Выслушать план Тави", "ask_plan")
	if(state == "ask_plan"):
		playAnimation(StageScene.Duo, "sit", {npc="tavi"})
		saynn("[say=pc]Ну, давай, излагай..[/say]")

		saynn("Тави оглядывается по сторонам, проверяя, нет ли кого рядом, а затем предлагает тебе присесть.")

		saynn("[say=tavi]Нам нужно... просто навестить капитана.[/say]")

		saynn("Ты слегка покашливаешь. Она что, предлагает самоубийственную миссию?")

		saynn("[say=pc]Разве это не был наш самый первый план?[/say]")

		saynn("Тави кивает и посмеивается.")

		saynn("[say=tavi]Но теперь мы знаем больше. Обо всём.[/say]")

		saynn("[say=pc]Даже не знаю, Тави...[/say]")

		saynn("Ты пытаешься встать, но Тави удерживает тебя на месте, вцепившись в воротник. Эта штука всё так же плотно сидит на твоей шее, как и прежде...")

		saynn("[say=tavi]Эти ошейники — наша самая большая слабость.[/say]")

		saynn("[say=pc]Да, они могут ударить нас током в любой момент.[/say]")

		saynn("Тави подмигивает.")

		saynn("[say=tavi]Не смогут, если мы заглушим сигнал блюспейса.[/say]")

		saynn("Хм. И правда, пока передатчик не работает, они не смогут тебя ударить.")

		saynn("[say=pc]Капитан, скорее всего, усилил охрану возле передатчика. Они будут нас ждать.[/say]")

		saynn("[say=tavi]К тому нам прикасаться не обязательно~. Всё, что нам нужно — это кристалл блюспейса покрупнее того, что в наших ошейниках. Знаешь, где можно раздобыть такой~?[/say]")

		saynn("Хм. Не так уж много вещей используют блюспейс... Единственное, что приходит на ум, это...")

		saynn("[say=pc]Датапады.[/say]")

		saynn("Тави похлопывает тебя по голове.")

		saynn("[say=tavi]Именно. Нам понадобится один датапад... Частота блюспейса для ошейников... И пара гранат.[/say]")

		saynn("Ты приподнимаешь бровь и склоняешь голову набок. Тави замечает твое замешательство и хихикает.")

		saynn("[say=tavi]Не обычные гранаты. Афродизиаковые. Охранники используют маленькие, но я знаю, что есть прототип с большим радиусом действия.[/say]")

		saynn("Интересный список.")

		saynn("[say=tavi]Сможешь раздобыть это для меня, милашка?[/say]")

		addAskButtons()
	if(state == "ask_datapad"):
		askedDatapad = true
		saynn("[say=pc]Где мне достать рабочий датапад? Прошлый долго не протянул.[/say]")

		saynn("Тави задумчиво потирает подбородок.")

		saynn("[say=tavi]Технически... нам не нужен целый датапад... Я могу сделать небольшой глушитель сигнала, используя кристалл и кое-какие электронные детали. Так что просто найди любой, в любом состоянии. А насчет того, где...[/say]")

		saynn("Кошка уставилась в потолок вашей камеры, погрузившись в еще более глубокие раздумья.")

		saynn("[say=tavi]Можешь попробовать избить охранников, пока не найдешь нужного... или...[/say]")

		saynn("На лице Тави расплывается широкая улыбка.")

		saynn("[say=tavi]Или можешь найти Нову. Я почти уверена, что у неё есть один.[/say]")

		saynn("Нова? Та самая хаски, что унизила Тави? Интересно.")

		saynn("[say=tavi]Конечно, просто так она тебе его не отдаст.[/say]")

		saynn("Тави наклоняется ближе к вашему уху.")

		saynn("[say=tavi]Но не стесняйся, будь с ней чуть пожестче. Этой сучке только в радость, поверь мне.[/say]")

		saynn("Тави снова выпрямляется, всё так же широко улыбаясь.")

		saynn("[say=tavi]Кстати, в датападах есть камеры~. Может пригодиться, чтобы она не вздумала на тебя охотиться.[/say]")

		addAskButtons()
	if(state == "ask_freq"):
		askedFreq = true
		saynn("[say=pc]Частота ошейника? Где мне её достать?[/say]")

		saynn("[say=tavi]Проверь компьютеры в инженерном отсеке. Я видела её, когда мы пытались связаться с Синдикатом... Но точно не помню... Это просто набор букв и цифр.[/say]")

		if (askedGrenades):
			saynn("Значит, и гранаты, и частота где-то в инженерном... Хорошо. Так даже проще.")

		else:
			saynn("Точно. Инженерный...")

		addAskButtons()
	if(state == "ask_grenades"):
		askedGrenades = true
		saynn("[say=pc]Зачем тебе эти гранаты? И где мне их найти?[/say]")

		saynn("[say=tavi]Они идеально подойдут, чтобы устроить небольшую... панику. Вот увидишь. А насчёт того, где...[/say]")

		saynn("Тави что-то напевает под нос и трет свою кошачью мордочку.")

		saynn("[say=tavi]Раз это всё ещё прототип... значит, оно должно быть где-то в инженерном. Тебе придётся поискать их, милашка.[/say]")

		if (askedFreq):
			saynn("Значит, и гранаты, и частота где-то в инженерном... Хорошо. Так даже проще.")

		else:
			saynn("Точно. Инженерный...")

		addAskButtons()
		if (false):
			addButton("Ничего", "Тебе не стоит этого видеть", "accept_task")
	if(state == "accept_task"):
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		saynn("[say=pc]Ладно, я постараюсь всё это разузнать.[/say]")

		saynn("Когда ты поднимаешься, Тави подходит ближе и начинает чесать тебя за ушком. Такой простой жест... Но её кошачьи когти всегда приносят такое удовольствие...")

		saynn("[say=tavi]Какой послушный питомец...[/say]")

		saynn("[say=pc]Но неужели ты не можешь мне помочь, мисс Тави?..[/say]")

		saynn("[say=tavi]Боюсь, что нет. Мне не стоит приближаться к Нове после... того случая. Да и инженерное дело... к этому моменту ты знаешь об этом лучше меня...[/say]")

		saynn("Справедливо. Ты подставляешься под её почесушки.")

		saynn("[say=pc]А как же Кейт... Я говорил с ней, и...[/say]")

		saynn("Она перебивает тебя.")

		saynn("[say=tavi]С этой проблемой уже покончено, милашка?[/say]")

		saynn("Ты тихо киваешь.")

		saynn("[say=tavi]Тогда пока не беспокойся о ней, она нам не помешает.[/say]")

		saynn("Тави крепко обнимает тебя и готовится выйти из камеры. У самого выхода она останавливается и смотрит на тебя.")

		saynn("[say=tavi]Мы уже близко. Я прямо чувствую это. В этот раз всё будет иначе.[/say]")

		saynn("Кошка выходит из твоей камеры. А это значит... тебе тоже пора выдвигаться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addAskButtons():
	if(!askedDatapad):
		addButton("Датапад?", "Спросить, где достать датапад", "ask_datapad")
	if(!askedFreq):
		addButton("Частота?", "Спросить, где узнать частоту блюспейса", "ask_freq")
	if(!askedGrenades):
		addButton("Гранаты?", "Спросить, где достать гранаты", "ask_grenades")
	if(askedDatapad && askedFreq && askedGrenades):
		addButton("Продолжить", "Смотреть, что будет дальше", "accept_task")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "another_one"):
		processTime(3*60)

	if(_action == "ask_plan"):
		processTime(3*60)

	if(_action == "accept_task"):
		processTime(10*60)
		addMessage("Tasks added!")

	setState(_action)

func saveData():
	var data = .saveData()

	data["askedDatapad"] = askedDatapad
	data["askedFreq"] = askedFreq
	data["askedGrenades"] = askedGrenades

	return data

func loadData(data):
	.loadData(data)

	askedDatapad = SAVE.loadVar(data, "askedDatapad", false)
	askedFreq = SAVE.loadVar(data, "askedFreq", false)
	askedGrenades = SAVE.loadVar(data, "askedGrenades", false)

func getDevCommentary():
	return "This scene.. It just shows that Tavi is a bit strange x3. She is not yandere no. But she doesn't exactly know how to act normal. She is doing her best though x3.\n\nWhy did Tavi make so many plans and why did all of them fail? Well, it's a complicated topic, heh. Obviously I wanted to make the game take longer than 20 minutes to complete x3. And if you actually think about it, you and Tavi do make some progress each time ^^. You learn more about the prison, the captain, the staff, Tavi, the world.\n\nIs the world that I'm showing that deep though? I mean.. I went pretty generic with it x3. Megacorporation vs evil group that tries to destroy it. The point of AlphaCorp is that all of the power is in one person's hands. Since the Alpha x3. And Syndicate.. is made out of a few families. Dictatorship vs Oligarchy basically.. Strong vision vs Strong bond. What about democracy?? We're constantly trying to make democracy work but someone always abuses it, sabotaging the voting process or eliminating other candidates. I'm not saying democracy is bad, I think it's great.. Let people choose what they want. But modern tech proved that we are fooled too easily ;-;. And that will only get worse in the future.\n\nSorry about the politics rant x3. I'm not really a political person. I just wanna be happy ;-;"

func hasDevCommentary():
	return true
