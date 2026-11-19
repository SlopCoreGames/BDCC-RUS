extends SceneBase

var isCorrupt = false
var isPure = false
var isNormal = false
var isVirgin = false
var npc1id = ""
var npc2id = ""

func _init():
	sceneID = "Ch7s2aAloneScene"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc1"):
		return npc1id
	if(_charID == "npc2"):
		return npc2id

func _run():
	if(state == ""):
		isCorrupt = getModule("TaviModule").isCorrupt()
		isPure = getModule("TaviModule").isPure()
		isNormal = (!isCorrupt && !isPure)
		isVirgin = getModule("TaviModule").isVirgin()
		playAnimation(StageScene.Solo, "stand")
		saynn("И вот ты здесь. Стоишь перед контрольно-пропускным пунктом. Нет смысла втягивать Тави — её могут снова схватить и подвергнуть пыткам. Да, именно так.")

		saynn("У тебя нет ни лазерных винтовок, ни блестящей брони для защиты. Только твои кулаки и жгучее желание выбраться из этого места. А может, ты просто хочешь заставить капитана заплатить за то, что он натворил? Важно ли это в конечном счете? Нет.")

		saynn("Будут ли они готовы? Возможно. Но это тебя не остановит. Пора действовать.")

		saynn("КПП... Лифт... Командный мостик... Кабинет капитана. Должно быть несложно.")

		addButton("КПП", "Пройти через главный вход", "checkpoint_firstguard")
	if(state == "checkpoint_firstguard"):
		aimCameraAndSetLocName("hall_checkpoint")
		playAnimation(StageScene.Duo, "stand", {npc=npc1id})
		saynn("Ты проходишь сквозь сенсорную решетку и молча смотришь на охранников.")

		saynn("[say=npc1]Шевелись, зэк! Не трать моё время.[/say]")

		saynn("Ты качаешь головой, принимая боевую стойку. Нападение может дать тебе преимущество в бою... но второй охранник тут же свалит тебя электрошокером.")

		saynn("[say=npc1]Нет? Решил лучше поцеловать мой грязный сапог? Ну ладно.[/say]")

		saynn("{npc1.He} жестом показывает другому охраннику просто понаблюдать, пока она достает свой электрошоковый дубинку {npc1.his} из крепления.")

		saynn("Пора драться.")

		addButton("Драться", "Начать бой", "fight1_npc")
	if(state == "lost_first_guards"):
		playAnimation(StageScene.Solo, "defeat")
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Потерпев поражение, вы падаете на колени.")

		saynn("Охранники смеются над вашей жалкой попыткой, а затем просто выбрасывают вас в главный зал.")

		saynn("Похоже, придется постараться получше. Или позволить Тави помочь вам.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "won_first_guard"):
		playAnimation(StageScene.Duo, "stand", {npc=npc2id})
		saynn("Как только первый охранник падает на пол, второй мгновенно хватает пульт {npc2.his} и наводит его на вас!")

		saynn("[say=npc2]Веселье окончено, заключенный. Пора поспать.[/say]")

		saynn("{npc2.He} нажимает на кнопку... но ничего не происходит.")

		saynn("[say=npc2]Да вы издеваетесь? Впрочем, неважно.[/say]")

		saynn("Охранник хватает оружие {npc2.his} и готовится к бою.")

		addButton("Драться", "Начать бой", "fight2_npc")
	if(state == "won_second_guard"):
		playAnimation(StageScene.Duo, "stand", {npc=npc2id, npcAction="defeat"})
		saynn("Оба охранника повержены. Это уже начало.")

		saynn("Ты забираешь у одного из них бейджик. Скорее всего, через пару минут он перестанет работать, но этого вполне достаточно, чтобы попасть на верхний этаж тюрьмы.")

		saynn("[say=risha]Куда-то собралась~?[/say]")

		saynn("Голос заставляет тебя остановиться.")

		addButton("Обернись", "Посмотреть, кто там", "risha_intro")
	if(state == "risha_intro"):
		addCharacter("risha")
		playAnimation(StageScene.Duo, "stand", {npc="risha"})
		saynn("Это Риша. Она оглядывается, выглядя слегка удивленной.")

		saynn("[say=pc]Да, наверх.[/say]")

		saynn("[say=risha]Одна? Без Тави?[/say]")

		saynn("Она медленно приближается к тебе. Позади тебя — закрытый лифт. А это значит... она загоняет тебя в угол.")

		saynn("[say=pc]А почему ты спрашиваешь? Боишься, что она устроит засаду? Тогда оглянись назад.[/say]")

		saynn("Риша не отвечает. Она лишь хихикает, медленно сокращая дистанцию с электрошокером в руке.")

		saynn("[say=risha]Мне просто было любопытно. Приказ Капа — остановить тебя. И мне, боюсь, приходится подчиняться. Без обид.[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Начать бой", "fight3_risha")
	if(state == "lost_risha"):
		playAnimation(StageScene.Duo, "defeat", {npc="risha"})
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Ты падаешь на колени перед Ришей. Это больно.")

		saynn("Кошка наклоняется к тебе ближе.")

		saynn("[say=risha]Хорошая попытка. Но ты явно еще не готов.[/say]")

		saynn("Она вышвыривает тебя и уходит. По крайней мере, она тебя не трахнула. Почему она тебя не трахнула?")

		saynn("Похоже, придется постараться получше. Или позволить Тави помочь вам.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "won_risha"):
		playAnimation(StageScene.Duo, "stand", {npc="risha", npcAction="defeat"})
		saynn("Риша шипит, когда падает на пол; её тяжелая броня теперь скорее тянет её вниз, чем защищает.")

		saynn("Твой старый жетон, кажется, больше не работает, поэтому ты крадешь жетон Риши.")

		saynn("[say=pc]Без обид.[/say]")

		saynn("[say=risha]Взаимно.[/say]")

		saynn("Она тяжело дышит. Сейчас не время с ней возиться... так что ты просто оставляешь её одну.")

		saynn("Когда ты направляешься к лифту, Риши там уже нет.")

		addButton("Лифт", "Войти", "alex_meet")
	if(state == "alex_meet"):
		removeCharacter("risha")
		addCharacter("alexrynard")
		aimCameraAndSetLocName("hall_elevator")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})
		saynn("Когда двери лифта открываются, ты видишь... Алекса. Он был поглощен каким-то случайным прототипом в своих руках, но тут же убирает его.")

		saynn("[say=alexrynard]Так и будешь стоять? Заходи.[/say]")

		saynn("Он не кажется... враждебным. Ты заходишь в лифт и прикладываешь бейдж к панели управления, выбирая командную палубу.")

		saynn("[say=alexrynard]Смело.[/say]")

		saynn("Двери закрываются с раздражающим скрежетом. Лифт начинает движение.")

		saynn("[say=alexrynard]Надо бы всё-таки смазать эти шестерёнки, а?[/say]")

		saynn("[say=pc]Ты что, не собираешься меня останавливать?[/say]")

		saynn("Лисичка пожимает плечами.")

		saynn("[say=alexrynard]Это не моя забота. Да и ты, похоже, уже всё решила. Хотя другие охранники попытаются тебя остановить.[/say]")

		saynn("[say=pc]Я знаю.[/say]")

		saynn("Вы стоите плечом к плечу. В тишине. Слышно лишь тихое гудение движущегося лифта.")

		saynn("[say=alexrynard]Этой тюрьме не помешало бы кое-что изменить.[/say]")

		saynn("[say=pc]Изменить?[/say]")

		saynn("[say=alexrynard]Улучшить. Обновить. Не знаю. Просто не разнеси её к чертям, ладно? Её строили хорошие люди. Будет жаль, если весь этот прогресс пойдет прахом.[/say]")

		saynn("[say=pc]Я попробую.[/say]")

		saynn("Он кивает.")

		saynn("Вскоре двери лифта открываются. Парень предпочитает остаться внутри, пока ты выходишь. У тебя возникает чувство, что ты движешься в правильном направлении.")

		addButton("Командная палуба", "Смотреть, что будет дальше", "nova_meet")
	if(state == "nova_meet"):
		removeCharacter("alexrynard")
		addCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {npc="nova"})
		aimCameraAndSetLocName("cd_near_split")
		saynn("Ты выходишь в коридор для богачей. Вполне логично, что капитан старается держаться от заключенных подальше — и физически, и ментально.")

		saynn("Ковры, картины, деревянная мебель. Резкий контраст с холодными, тускло освещенными камерами, которые ты почти успела назвать своим домом. И всё же, здесь нет... страсти. Ничто не цепляет взгляд.")

		saynn("Когда ты идешь по коридору, тебе на пути попадается Нова. Она преграждает тебе дорогу.")

		saynn("[say=nova]Ну вот. Мы здесь.[/say]")

		saynn("[say=pc]Мне нужен только капитан.[/say]")

		saynn("[say=nova]Мне даже нравилось всё то, что у нас было. Жаль, что всё сложилось не так. Но что ж, бывает.[/say]")

		saynn("Её лапа крепко сжимает шоковую дубинку. Её броня начинает светиться.")

		saynn("[say=nova]Приказ капитана — остановить тебя. Прости, милашка, но у меня нет выбора.[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Начать бой", "fight4_nova")
	if(state == "lost_nova"):
		playAnimation(StageScene.Solo, "defeat")
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Ты падаешь на колени, побежденная Новой. Она убирает дубинку и пристегивает поводок к твоему ошейнику.")

		saynn("[say=nova]Не сегодня, милашка.[/say]")

		saynn("После этого она просто приводит тебя обратно в главный зал. Невольно задумываешься, почему тебя вообще не наказывают. Такое ощущение, что им всем это осточертело — и тебе, и Тави.")

		saynn("Похоже, придется постараться получше. Или позволить Тави помочь вам.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "won_nova"):
		playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="defeat"})
		saynn("Нова кряхтит и падает на колени, не в силах продолжать бой.")

		saynn("[say=nova]Ой...[/say]")

		saynn("Не до разговоров. Кажется, ты уже совсем близко. Когда ты проходишь мимо неё, ты слышишь лишь это.")

		saynn("[say=nova]Удачи..[/say]")

		saynn("А? Ты не уверен, был ли это сарказм. Звучало довольно искренне.")

		saynn("[say=pc]Спасибо.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "walk_to_skar")
	if(state == "walk_to_skar"):
		removeCharacter("nova")
		playAnimation(StageScene.Solo, "walk")
		aimCameraAndSetLocName("cd_last_intersection")
		saynn("Ты идешь по бездушным коридорам, быстро приближаясь к источнику звука. Почему-то страха нет. Наверное, потому что ты уже всё для себя решил. Неизвестных больше не осталось. Никаких тайн, которые нужно разгадать. Всё, что тебе нужно — это действовать.")

		saynn("Когда ты подходишь к кабинету капитана, твой путь преграждает знакомая фигура...")

		addButton("Продолжить", "Смотреть, что будет дальше", "skar_block")
	if(state == "skar_block"):
		addCharacter("skar")
		playAnimation(StageScene.Duo, "stand", {npc="skar"})
		saynn("Скар, последний охранник на пути к капитану, прислонился к стене, скрестив свои протезы.")

		saynn("[say=pc]Можно?[/say]")

		saynn("Он медленно качает головой.")

		saynn("[say=pc]Я понимаю.[/say]")

		saynn("[say=skar]Правда?[/say]")

		saynn("[say=pc]В какой-то степени. Я понимаю — что. Но не совсем понимаю — почему. Почему ты всё еще сражаешься за него?[/say]")

		saynn("Он опускает взгляд.")

		saynn("[say=skar]Стабильность, полагаю.[/say]")

		saynn("[say=pc]Стабильность?[/say]")

		saynn("Он напрягает руки, и слышно, как в них работают сервоприводы. Его протез челюсти издает похожее тихое жужжание, когда он говорит.")

		saynn("[say=skar]С меня хватит... приключений... войн.[/say]")

		saynn("Он вздыхает и смотрит на тебя.")

		saynn("[say=skar]Я просто хочу прожить свою скучную жизнь. Не хочу, чтобы что-то менялось, для этого уже слишком поздно.[/say]")

		saynn("Хм. Это и есть настоящий Скар? Звучит так, будто он... выдохся.")

		saynn("[say=pc]Тогда почему ты дал нам шанс тогда?[/say]")

		saynn("Он пожимает плечами.")

		saynn("[say=skar]Не знаю. Капитан приказал подавить бунт, а не тебя. На тебя мне плевать.[/say]")

		saynn("Настоящий солдат: исполняет приказы, не беря на себя никакой ответственности. Хотя, может, в нём ещё теплится искра надежды.")

		saynn("[say=pc]Может, пришло время выбрать что-то самому? Ты уже делал это однажды, почему бы не повторить? Просто дай мне пройти.[/say]")

		saynn("Он качает головой и преграждает путь. Искра надежды гаснет. Поняв, что просто так тебе не пройти, вы оба готовитесь к бою.")

		addButton("Драться", "Начать бой", "fight5_skar")
	if(state == "skar_lost"):
		playAnimation(StageScene.Solo, "defeat")
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Когда ты терпишь поражение, Скар хватает тебя за воротник и тащит за собой.")

		saynn("Ты был так близок. Но, к сожалению, в этот раз тебе не повезло.")

		saynn("[say=skar]Это того не стоит. Ты всё равно ничего не сможешь изменить.[/say]")

		saynn("Даже не знаешь, как описать, насколько он ошибается.")

		saynn("Похоже, придется постараться получше. Или позволить Тави помочь вам.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "skar_won"):
		playAnimation(StageScene.Duo, "stand", {npc="skar", npcAction="defeat"})
		saynn("Скар кряхтит, тяжело рухнув на пол.")

		saynn("[say=skar]Ух... Это того не стоит. Ты всё равно ничего не сможешь изменить.[/say]")

		saynn("[say=pc]Будь таких, как ты, поменьше, возможно, всё было бы проще. Но я не собираюсь сдаваться, несмотря ни на что.[/say]")

		saynn("Укрепленная дверь — последний барьер перед кабинетом капитана. Ты крадешь жетон Скар и пытаешься воспользоваться им... но дверь наотрез отказывается открываться.")

		saynn("[say=pc]Похоже, он уже даже собственным охранникам не доверяет.[/say]")

		saynn("Что ж... Ты вроде как застрял здесь. И вдруг...")

		saynn("[say=tavi]Соскучился по мне~?[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "tavi_joins")
	if(state == "tavi_joins"):
		addCharacter("tavi")
		playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=isCorrupt}})
		saynn("Это голос Тави. Она подходит к двери и начинает изучать панель управления.")

		saynn("[say=pc]Как ты здесь оказался?[/say]")

		saynn("Тави улыбается. Она поддевает когтем внешнюю крышку, обнажая защищенную проводку.")

		saynn("[say=tavi]Риша рассказала мне."+str(" Она сказала, что ей нравится, какой сексуальной я теперь выгляжу~." if isCorrupt else " Сестрички ведь должны помогать друг другу, верно~?")+"[/say]")

		saynn("Она не может до конца понять, за что отвечает каждый провод... Поэтому она крадет шоковую дубинку Скар и засовывает её прямо в панель, отчего из неё начинают во все стороны сыпаться искры.")

		saynn("[say=tavi]Как же мне не быть здесь, рядом с тобой? Я хочу помочь тебе, хозяин.[/say]")

		saynn("Дверь беспрестанно мигает. Запорные механизмы то срабатывают, то отпускают... И вот, когда по нужному проводу проходит импульс, дверь открывается.")

		saynn("[say=tavi]Вот почему мне больше нравится взламывать софт. И программы, и людей~. Это даже не вызов.[/say]")

		saynn("И теперь... остается только войти. Вы с Тави переглядываетесь.")

		saynn("[say=pc]Готова?[/say]")

		if (isCorrupt):
			saynn("[say=tavi]Ждала этого всю свою жизнь~. И бить вполсилы не стану.[/say]")

		else:
			saynn("[say=tavi]Ждала этого всю свою жизнь.[/say]")

		addButton("Войти", "Посмотреть, что там у капитана", "start_captain_scene")
func taviSpeak(corruptSpeak, pureSpeak):
	if(isCorrupt):
		return corruptSpeak
	if(isPure):
		return pureSpeak
	return corruptSpeak


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "checkpoint_firstguard"):
		processTime(2*60)
		npc1id = GuardGenerator.new().generate({NpcGen.Level: 30, NpcGen.Temporary: true}).getID()
		npc2id = GuardGenerator.new().generate({NpcGen.Level: 30, NpcGen.Temporary: true}).getID()
		addCharacter(npc1id)
		addCharacter(npc2id)

	if(_action == "fight1_npc"):
		runScene("FightScene", [npc1id], "fight1_npc")
		return

	if(_action == "fight2_npc"):
		runScene("FightScene", [npc2id], "fight2_npc")
		return

	if(_action == "risha_intro"):
		removeCharacter(npc1id)
		removeCharacter(npc2id)

	if(_action == "fight3_risha"):
		runScene("FightScene", ["risha"], "fight3_risha")
		return

	if(_action == "nova_meet"):
		processTime(3*60)

	if(_action == "fight4_nova"):
		runScene("FightScene", ["novaArena"], "fight4_nova")
		return

	if(_action == "walk_to_skar"):
		processTime(3*60)

	if(_action == "fight5_skar"):
		runScene("FightScene", ["skar"], "fight5_skar")
		return

	if(_action == "tavi_joins"):
		addExperienceToPlayer(300)

	if(_action == "start_captain_scene"):
		setFlag("TaviModule.Ch7CaptainSceneHappened", true)
		runScene("Ch7s3CaptainScene")
		endScene()
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "fight1_npc"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_first_guard")
		else:
			setState("lost_first_guards")
			addExperienceToPlayer(5)

	if(_tag == "fight2_npc"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_second_guard")
		else:
			setState("lost_first_guards")
			addExperienceToPlayer(5)

	if(_tag == "fight3_risha"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_risha")
		else:
			setState("lost_risha")
			addExperienceToPlayer(5)

	if(_tag == "fight4_nova"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_nova")
		else:
			setState("lost_nova")
			addExperienceToPlayer(5)

	if(_tag == "fight5_skar"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("skar_won")
		else:
			setState("skar_lost")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()

	data["isCorrupt"] = isCorrupt
	data["isPure"] = isPure
	data["isNormal"] = isNormal
	data["isVirgin"] = isVirgin
	data["npc1id"] = npc1id
	data["npc2id"] = npc2id

	return data

func loadData(data):
	.loadData(data)

	isCorrupt = SAVE.loadVar(data, "isCorrupt", false)
	isPure = SAVE.loadVar(data, "isPure", false)
	isNormal = SAVE.loadVar(data, "isNormal", false)
	isVirgin = SAVE.loadVar(data, "isVirgin", false)
	npc1id = SAVE.loadVar(data, "npc1id", "")
	npc2id = SAVE.loadVar(data, "npc2id", "")
