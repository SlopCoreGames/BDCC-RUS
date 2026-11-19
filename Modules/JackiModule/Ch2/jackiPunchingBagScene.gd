extends SceneBase

var anger = 0.0
var corruption = 0.0
var lust = 0.0
var hasUnderwear = false
var buttScore = 0
var soundScore = 0

func _init():
	sceneID = "jackiPunchingBagScene"

func _reactInit():
	getCharacter("jacki").resetEquipment()

func _run():
	if(state == ""):
		anger = getFlag("JackiModule.jackiAnger", 0.0)
		corruption = getFlag("JackiModule.jackiCorruption", 0.0)
		lust = getFlag("JackiModule.jackiLust", 0.0)
		hasUnderwear = getModule("JackiModule").shouldUnderwear()
		buttScore = getModule("JackiModule").getSkillScore("jackiSkillButtslut")
		soundScore = getModule("JackiModule").getSkillScore("jackiSkillSounding")
		saynn("Хм. Тебе показалось, что это Джеки. Но нет. На её обычном месте пусто. Коврик для йоги не занят.")

		saynn("Заставляет задуматься, не решила ли она сегодня взять перерыв...")

		addButton("Осмотреться", "Может, что-то здесь поможет тебе разгадать эту тайну.", "risha_bullies_jacki")
	if(state == "risha_bullies_jacki"):
		aimCameraAndSetLocName("gym_nearbathroom")
		GM.pc.setLocation("gym_nearbathroom")
		addCharacter("jacki", ["naked"])
		addCharacter("risha")
		playAnimation(StageScene.HangingDuo, "idle", {npc="risha", pc="jacki", bodyState={naked=true}})
		saynn("О, вот и она. Ты видишь Джеки в другом углу спортзала... Кажется, там же и Риша, стражница-рысь.")

		saynn("[say=risha]То есть ты хочешь сказать, что ты не боксёрская груша? Потому что, клянусь, ты выглядишь именно так.[/say]")

		saynn("[say=jacki]Вовсе нет![/say]")

		saynn("Одна из боксёрских груш валяется на полу, а Джеки заняла её место: она висит на крюке, предназначенном для груши, а её лапы скованы наручниками. Она тоже голая — её пыльная форма брошена на пол.")

		saynn("[say=risha]Пфф. У тебя не хватит мышц, чтобы не быть ею. Либо мышц, либо пизды.[/say]")

		saynn("Риша выпускает когти, цепляется за девственность-пирсинг Джеки и с силой дергает за него. Джеки тут же начинает скулить, явно от боли.")

		addButton("Вмешаться", "Заставить эту суку перестать мучить Джеки", "intervene")
		addButton("Просто наблюдай", "Да какая разница. С этой рысью лучше не связываться.", "justwatch")
	if(state == "justwatch"):
		playAnimation(StageScene.HangingSex, "tease", {npc="risha", pc="jacki", bodyState={naked=true}})
		saynn("Тебе лишние проблемы с охраной ни к чему. Что бы здесь ни случилось, это всё равно проблемы Джеки.")

		saynn("Чем дольше Риша тянет за пирсинг, тем сильнее дрожит Джеки и тем отчетливее на её лице проступает дискомфорт.")

		saynn("[say=risha]Говори же. А то я могу случайно всё это вырвать~.[/say]")

		saynn("[say=jacki]Нгх-х-х... ф-ф-ф...[/say]")

		saynn("Джеки запрокидывает голову и тяжело дышит, поджимая пальцы ног.")

		saynn("[say=jacki]От-твали... Д-делай это... Ты только п-поможешь мне...[/say]")

		saynn("Риша наклоняет голову и замирает на секунду... лишь для того, чтобы дернуть за кольцо в клиторе, используя колокольчик, прикрепленный к нему маленькой цепочкой. От этого Джеки издает болезненный вопль, а её ноги начинают дрожать.")

		saynn("[say=risha]Ты не понимаешь... Это только первый шаг. Я не уйду, пока эта киска не начнет течь от спермы.[/say]")

		saynn("[say=jacki]Х-хх-а!..[/say]")

		saynn("Джеки терпит эту боль столько, сколько может... Вокруг них начинает собираться небольшая толпа заключенных.")

		saynn("[say=risha]И, похоже, я буду не единственной~.[/say]")

		saynn("[say=jacki]Х-хорошо!.. Я всего лишь тюремная сучка. У меня нет имени, т-только номер![/say]")

		saynn("[say=risha]Хм. А как насчет меня?[/say]")

		saynn("Риша немного ослабляет хватку на пирсинге Джеки.")

		saynn("[say=jacki]Прости за грубость. Правда, блядь, прости..[/say]")

		saynn("Риша улыбается и начинает убирать ладонь от промежности Джеки... напоследок отвесив звонкий шлепок по её зажатым губкам киски. Каждая обладательница пизды в толпе вздрагивает, когда Джеки издает душераздирающий крик, а её истерзанная щель к этому моменту уже выглядит ярко-красной.")

		saynn("[say=risha]Так-то лучше. Не забывай этот урок, мутантка. Тебе повезло, что за одну жизнь я уже успела разодрать достаточно шлюх.[/say]")

		saynn("Риша прекращает пытку Джеки... и просто уходит, оставляя волчицу всё еще в наручниках.")

		addButton("Продолжить", "Смотреть, что будет дальше", "justwatch_rishaleft")
	if(state == "justwatch_rishaleft"):
		removeCharacter("risha")
		playAnimation(StageScene.HangingDuo, "idle", {npc="pc", pc="jacki", bodyState={naked=true}})
		saynn("Некоторые заключенные проявляют к Джеки большой интерес. Но, увидев, насколько сильно разворочена её щель, решают держаться от неё подальше.")

		saynn("И вот... жизнь идет своим чередом. Толпа расходится, заключенные возвращаются к привычной рутине: кто-то делает зарядку, кто-то жмет веса, а Джеки так и остается висеть.")

		saynn("Когда толпа заметно редеет, Джеки замечает тебя... Похоже, пора действовать.")

		addButton("Освободить её", "Снять наручники с Джеки, увидев, что произошло", "justwatch_free")
		addButton("Уйти", "Да и хрен с ним", "justwatch_leave")
	if(state == "justwatch_leave"):
		saynn("После прямого зрительного контакта с Джеки... ты решаешь просто уйти.")

		if (anger > -0.1):
			saynn("[say=jacki]Фух... ублюдок...[/say]")

		else:
			saynn("[say=jacki]Эй... а я думала, мы друзья...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endscene_removerestraints")
	if(state == "justwatch_free"):
		playAnimation(StageScene.Duo, "stand", {npc="jacki"})
		saynn("Ну что ж, ты решаешь освободить волчицу, отцепляя её от крюка. Она быстро хватает свою пыльную одежду и натягивает её. С её губ срывается стон дискомфорта, когда ткань шорт касается её киски.")

		if (anger > -0.1):
			saynn("[say=jacki]Долго же ты...[/say]")

			saynn("[say=pc]И что, мне не стоило вмешиваться?[/say]")

			saynn("[say=jacki]Хафф...[/say]")

			saynn("Она быстро уходит, прижимая ладонь к промежности.")

		else:
			saynn("[say=jacki]Спасибо..[/say]")

			saynn("[say=pc]Ты в порядке?[/say]")

			saynn("Джеки пожимает плечами.")

			saynn("[say=jacki]Думаю, мне пора к врачу.[/say]")

			saynn("[say=pc]Давай, сходи.[/say]")

			saynn("Она быстро уходит, прижимая ладонь к промежности.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "intervene"):
		playAnimation(StageScene.Duo, "shove", {npc="risha"})
		saynn("Ты отталкиваешь Ришу от Джеки. Она.. крупная.. но эффект неожиданности помогает.")

		saynn("[say=pc]Отъебись.[/say]")

		saynn("Рыси удается удержаться на ногах. Она поворачивается к тебе, и её красные глаза ярко вспыхивают.")

		saynn("[say=risha]Ха. Вы что, любовники на одну ночь или типа того?[/say]")

		saynn("[say=pc]Это не твоя забота. Я сказала тебе съебаться нахуй.[/say]")

		saynn("Риша улыбается, её лапа сжимает электрошокер.")

		saynn("[say=risha]А я хочу сделать это своей заботой~. Ну что, потанцуем? Если победишь — так и быть, съебусь~.[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Начать бой", "fight_risha")
		if (getFlag("JackiModule.Jacki_ch2GotEnslaved")):
			addButton("Пропустить бой", "(Воспоминания) Пропустить бой и притвориться, что ты победил", "won_risha")
	if(state == "lost_risha"):
		playAnimation(StageScene.Duo, "defeat", {npc="risha"})
		saynn("Потерпев поражение, ты падаешь на колени перед Ришей.")

		saynn("[say=risha]И это всё? Слабачок~.[/say]")

		saynn("Легко говорить, когда на тебе броня.")

		saynn("Риша подходит к тебе и похлопывает по голове.")

		saynn("[say=risha]Но попытка была неплохой. Как насчёт такого...[/say]")

		saynn("Риша улыбается, оглядывая собравшуюся толпу.")

		saynn("[say=risha]Расцелуй мои сапоги. И, может быть, я даже освобожу твою девку. Её щель мне всё равно нахер не сдалась.[/say]")

		addButton("Поцеловать сапог", "Сделать, как она говорит", "lost_kiss")
		addButton("Отказаться", "Неееееть", "lost_nokiss")
	if(state == "lost_kiss"):
		playAnimation(StageScene.SexFeetPlay, "head", {pc="risha", npc="pc"})
		saynn("Тебе кажется, это выгодная сделка. Ты низко наклоняешься, любуясь грязными сапогами Риши... а затем нежно чмокаешь один из них.")

		saynn("[say=risha]Ого. Посмотрите на него. Готов на всё ради {pc.his} леди.[/say]")

		saynn("Внезапно Риша упирается сапогом тебе в грудь, прижимая к земле. Затем она прижимает его к твоей щеке, размазывая по ней грязь.")

		saynn("[say=risha]Видишь это, зэк? Твой «белый рыцарь» готов на любые жертвы. Продолжай быть таким послушным ковриком для {pc.himHer}, милашка~.[/say]")

		saynn("Джеки фыркает на Ришу.")

		saynn("[say=jacki]Довольно.[/say]")

		saynn("[say=risha]Конечно~.[/say]")

		saynn("Риша убирает сапог от твоего лица и подходит к Джеки.")

		saynn("[say=risha]Запомни это на случай, если снова захочешь ослушаться.[/say]")

		saynn("Джеки опускает взгляд, пока Риша снимает с неё наручники.")

		saynn("[say=risha]Развлекайся~.[/say]")

		saynn("И вот так просто она уходит.")

		addButton("Продолжить", "Смотреть, что будет дальше", "lost_kiss_after")
	if(state == "lost_kiss_after"):
		removeCharacter("risha")
		playAnimation(StageScene.Duo, "stand", {npc="jacki"})
		saynn("Джеки быстро натягивает свою запыленную одежду.")

		if (anger > -0.1):
			saynn("[say=jacki]Так... почему ты мне помогла?[/say]")

			saynn("Ты пожимаешь плечами.")

			saynn("[say=jacki]Фух... забудь. Спасибо, ладно?[/say]")

			saynn("В воздухе мгновенно повисает неловкость. И Джеки просто уходит.")

		else:
			saynn("[say=jacki]Ты в порядке?..[/say]")

			saynn("[say=pc]Да, вроде того.[/say]")

			saynn("Джеки смахивает грязь с твоего лица.")

			saynn("[say=jacki]Ну... спасибо. Тебе не обязательно было это делать.[/say]")

			saynn("[say=pc]Я знаю.[/say]")

			saynn("Она одаривает тебя милой доброй улыбкой и просто возвращается на своё место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lost_nokiss"):
		playAnimation(StageScene.Duo, "kneel", {npc="risha", bodyState={naked=true}})
		saynn("Вместо этого ты отказываешься и плюёшь Рише на сапоги.")

		saynn("[say=risha]Смело. Вы двое достойны друг друга.[/say]")

		saynn("Внезапно Риша хватает тебя, раздевает и скрепляет твои запястья наручниками.")

		saynn("[say=risha]И именно поэтому...[/say]")

		saynn("Она начинает тянуть тебя вверх, заставляя встать на ноги. Ты ей не помогаешь... но рыси хватает сил, чтобы всё равно тебя поднять...")

		addButton("Продолжить", "Смотреть, что будет дальше", "lost_nokiss_hang")
	if(state == "lost_nokiss_hang"):
		playAnimation(StageScene.HangingDuo, "idle", {npc="risha", pc="pc", bodyState={naked=true}})
		saynn("[say=risha]...ты присоединишься к ней.[/say]")

		saynn("Риша высоко поднимает твои руки и цепляет тебя на тот же крюк, что и Джеки, так что ваши обнажённые тела оказываются прижаты друг к другу.")

		saynn("Затем кошечка толкает одного из вас, отчего вы сталкиваетесь телами еще сильнее.")

		saynn("[say=jacki]Ой![/say]")

		saynn("[say=risha]Наслаждайтесь~.[/say]")

		saynn("И вот так просто Риша уходит, оставляя вас двоих наедине.")

		addButton("Продолжить", "Смотреть, что будет дальше", "lost_nokiss_hang_together")
	if(state == "lost_nokiss_hang_together"):
		playAnimation(StageScene.HangingSolo, "idle", {bodyState={naked=true}})
		if (anger > -0.1):
			saynn("И теперь вы оба висите вместе... Некоторые заключенные замечают вас и хихикают.")

			saynn("[say=jacki]Ну и... какой план?[/say]")

			saynn("[say=pc]План?[/say]")

			saynn("[say=jacki]Да, нам нужно как-то выбраться. Не хочу проводить с тобой больше времени, чем необходимо.[/say]")

			saynn("Довольно грубо. Вы пытаетесь дернуть наручники, но на то, чтобы освободиться, потребуется время...")

			saynn("Внезапно Джеки обхватывает вашу талию ногами и начинает карабкаться по вам, совершая быстрые толчки бедрами.")

			saynn("[say=pc]Эй.[/say]")

			saynn("[say=jacki]Что за...[/say]")

			saynn("Ты чувствуешь, как её девственные пирсинги трутся о твою обнажённую кожу... точно так же, как она чувствует, как её киска трётся о тебя...")

			saynn("В конце концов ей удаётся поднять руки достаточно высоко, чтобы вытащить их из крюка. Её лапы всё ещё в наручниках, поэтому она соскальзывает с тебя, снова обхватывая тебя ногами.")

			saynn("После этого она отворачивается, собираясь уйти...")

			saynn("[say=jacki]Гр-р... ладно![/say]")

			saynn("Она разворачивается и тоже помогает тебе: используя свои скованные лапы, она подталкивает тебя вверх, чтобы ты тоже смог освободить руки.")

			saynn("[say=jacki]На. Это моя благодарность.[/say]")

			saynn("И вот, Джаки хватает свою одежду и уходит.")

		else:
			saynn("И теперь вы оба висите вместе... Некоторые заключенные замечают вас и хихикают.")

			saynn("[say=jacki]Ну, это неловко...[/say]")

			saynn("[say=pc]Да уж, вроде того... Есть способы свалить отсюда?[/say]")

			saynn("[say=jacki]Если бы он был, я бы уже... ах. Но теперь у меня есть ты.[/say]")

			saynn("[say=pc]Ты всегда так делала.[/say]")

			saynn("Джеки краснеет...")

			saynn("[say=jacki]Это... не то, что я имела в виду... рррф. Может, я попробую залезть на тебя, чтобы освободить руки.[/say]")

			saynn("[say=pc]Конечно. Что угодно.[/say]")

			saynn("[say=jacki]Единственная проблема в том... что мне придется использовать ноги.[/say]")

			saynn("[say=pc]В смысле... ну да?[/say]")

			saynn("Ты понимаешь, что она имела в виду, только когда она начинает это делать. Джеки обхватывает твою талию ногами и начинает карабкаться на тебя, совершая при этом быстрые толчки бедрами. Ты чувствуешь, как её пирсинг в девственной деве трется о твою обнаженную кожу... точно так же, как она чувствует, как её киска трется о тебя... Довольно похотливо.")

			saynn("В конце концов, ей удается поднять руки достаточно высоко, чтобы вытащить их из крюка. Её лапы всё еще в наручниках, поэтому она соскальзывает с тебя, всё еще обнимая тебя ногами и руками. Довольно мило.")

			saynn("[say=pc]Теперь я понимаю, что ты имела в виду.[/say]")

			saynn("После этого Джеки изо всех сил тянет тебя вверх, помогая тебе освободить руки от крюка.")

			saynn("[say=jacki]Вот так..[/say]")

			saynn("Она быстро натягивает свою запыленную одежду.")

			saynn("[say=jacki]Спасибо. Ты меня выручила.[/say]")

			saynn("И далеко не в первый раз ей приходилось, чтобы её спасали...")

			saynn("[say=pc]Не стоит благодарности.[/say]")

			saynn("Затем Джеки кивает и возвращается на своё место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endscene_removerestraints")
	if(state == "won_risha"):
		playAnimation(StageScene.Duo, "stand", {npc="risha", npcAction="defeat"})
		saynn("Потерпев поражение, Риша падает на колени. Ты отпихиваешь её оружие ногой, чтобы она не совершила внезапную атаку.")

		saynn("[say=risha]Хах.. Ладно, в этот раз вы двое можете насладиться компанией друг друга.[/say]")

		saynn("Ты мог бы помучить Ришу подольше... но Джеки уже ждёт тебя.")

		saynn("[say=pc]А теперь — вон отсюда.[/say]")

		saynn("Риша медленно поднимается и берет свое оружие, прежде чем убрать его в кобуру.")

		saynn("[say=risha]В море полно рыбешек.[/say]")

		saynn("[say=pc]Угу.[/say]")

		saynn("И вот Риша оставляет тебя и Джеки наедине.")

		addButton("Джеки", "Посмотри на неё", "look_at_jacki")
	if(state == "look_at_jacki"):
		removeCharacter("risha")
		playAnimation(StageScene.HangingDuo, "idle", {npc="pc", pc="jacki", bodyState={naked=true}})
		saynn("Джеки висит, подвешенная за скованные лапы, ее пальцы ног едва касаются земли. Она обнажена... что выставляет напоказ ее густой рыжеватый кустик между ног. Кустик, скрывающий щель киски. Щель, стянутую пирсингом целомудрия, который удерживает ее лепестки вместе.")

		if (anger > -0.1):
			saynn("[say=jacki]Не знаю, почему ты решил спасти меня после всего, что ты натворил. Но... спасибо?[/say]")

			saynn("Хмм...")

		else:
			saynn("[say=jacki]Это было близко... Спасибо, что спас меня.[/say]")

			saynn("Хмм...")

		addButton("Расковать ее", "По-настоящему спасти Джеки", "actually_save_jacki")
		if (anger > -0.1):
			if (GM.pc.hasReachablePenis()):
				addButtonWithChecks("Использовать ее", "(Анально) Джеки там такая уязвимая. Может, стоит продолжить то, на чем остановилась Риша?", "do_betray_fuck", [], [ButtonChecks.HasReachablePenis])
			else:
				addButtonWithChecks("Использовать ее", "(Анально) Джеки там такая уязвимая. Может, стоит продолжить то, на чем остановилась Риша?", "do_betray_strapon_pick", [], [ButtonChecks.HasStraponAndCanWear])
		else:
			if (GM.pc.hasReachablePenis()):
				addButtonWithChecks("Предать её", "(Анально) Джеки там такая уязвимая. Может, стоит продолжить то, на чем остановилась Риша?", "do_betray_fuck", [], [ButtonChecks.HasReachablePenis])
			else:
				addButtonWithChecks("Предать её", "(Анально) Джеки там такая уязвимая. Может, стоит продолжить то, на чем остановилась Риша?", "do_betray_strapon_pick", [], [ButtonChecks.HasStraponAndCanWear])
	if(state == "actually_save_jacki"):
		playAnimation(StageScene.Duo, "stand", {npc="jacki"})
		if (anger > -0.1):
			saynn("Вы с Джеки не то чтобы лучшие друзья... но что-то заставило тебя всё равно решить спасти её.")

		else:
			saynn("Вы с Джеки кореша, так что ты, само собой, собираешься её спасти.")

		saynn("[say=pc]Погоди-ка.[/say]")

		saynn("Ты обхватываешь Джеки руками и приподнимаешь её, позволяя ей с относительной легкостью снять скованные лапы с крюка. Затем ты осторожно опускаешь её на землю.")

		saynn("Джеки тут же прикрывается, а затем поспешно натягивает свою запыленную одежду.")

		saynn("[say=jacki]Еще раз спасибо...[/say]")

		if (anger > -0.1):
			saynn("Какая добрая волчица. Она прикрывает покрасневшее лицо и быстро уходит.")

		else:
			saynn("Какая добрая волчица. Она тепло обнимает тебя, прежде чем прикрыть покрасневшее лицо и уйти.")

			saynn("[say=jacki]Я буду на своём месте..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_betray_fuck"):
		playAnimation(StageScene.HangingSex, "tease", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		if (anger > -0.1):
			saynn("Она думает, ты сделал это, чтобы спасти её? Хах. Какая глупая волчица. Ты бесшумно выставляешь свой {pc.penis} и подходишь к ней сзади. Джеки быстро понимает твои намерения, когда ты хватаешь её за хвост и резко задираешь его вверх, чтобы добраться до её {jackiButt} задницы.")

			saynn("[say=jacki]Эй.. Погоди. Я могу предложить тебе что-нибудь другое. Кредиты?[/say]")

			saynn("Она предложила тебе всё, чего ты только мог пожелать. Пора брать своё. Ты быстро нацеливаешь свой член на её сжимающееся отверстие, и твоя предэякуляция втирается в её анус, пока ты прощупываешь его.")

			saynn("[say=jacki]Это уже не смешно.. П-прекрати.. Пожалуйста?[/say]")

			saynn("[say=pc] Заткнись, шлюха.[/say]")

		else:
			saynn("Спасти её было бы таким героическим поступком. Но ты не герой. Ты просто делаешь то, что хочешь. Пока ты бесшумно подкрадываешься к Джеки сзади и выставляешь свой {pc.penis}, она начинает изображать беспокойство.")

			saynn("[say=jacki]Эм.. Что ты делаешь?[/say]")

			saynn("Она пытается оглянуться, но поднятые руки ей мешают. Кажется, она понимает твои намерения, когда ты хватаешь её за хвост и резко задираешь его вверх, чтобы добраться до её {jackiButt} задницы.")

			saynn("[say=jacki]Эй.. Это.. это моя задница.[/say]")

			saynn("Именно так. Ты быстро нацеливаешь свой член на её сжимающееся отверстие, и твоя предэякуляция втирается в её анус, пока ты прощупываешь его.")

			saynn("[say=jacki]Это уже не смешно.. П-прекрати.. Пожалуйста?[/say]")

			saynn("[say=pc] Заткнись, шлюха.[/say]")

		addButton("Растянуть её", "Трахнуть Джеки", "do_betray_fuck_stretch")
	if(state == "do_betray_fuck_stretch"):
		playAnimation(StageScene.HangingSex, "sex", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Сучка плотно сжимает задницу... поэтому ты обхватываешь её рукой и тянешь за этот красный куст лобковых волос, заставляя Джеки взвыть от боли, а её анус так сильно пульсирует, что ты внезапно всаживаешь туда свой член, широко растягивая её анальное кольцо!")

		saynn("[say=jacki]А-ах!.. Б-блядь.. Помогите! Кто-нибудь![/say]")

		saynn("Вокруг полно заключенных... но все они просто наблюдают за шоу. Похоже, никто не хочет связываться с тобой после того, как ты отделал того охранника. Хорошо.")

		saynn("Ты хватаешь Джеки за морду и затыкаешь ей рот, начиная трахать её в задницу; ты то полностью выходишь, то снова с силой вбиваешь свой член глубоко в её неохотное отверстие, а твоя предэякуляция делает её внутренние стенки скользкими.")

		saynn("[say=pc]Тебе никто не поможет. Так что лучше привыкай к тому, что твою задницу будут трахать.[/say]")

		saynn("[say=jacki]Нх-х..[/say]")

		saynn("Девушка всё ещё пытается сопротивляться и даже укусить... но ремни удерживают её тело, не давая пошевелиться. А на попытки укусить ты лишь отвечаешь крепкими шлепками по её заднице. Кажется, от каждого удара её анус снова начинает пульсировать вокруг твоего члена... и это чертовски приятно.")

		addButton("Быстрее", "Раздолбать ей анус", "do_betray_fuck_faster")
	if(state == "do_betray_fuck_faster"):
		playAnimation(StageScene.HangingSex, "fast", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты вколачиваешь свой член в её задницу всё быстрее и сильнее, пока бедная волчица впадает в отчаяние. Её {jackiButt} дырка уже выглядит раздраженной от твоей грубости и нехватки смазки. Но это не твоя проблема...")

		saynn("[say=jacki]Моя жопа.. С-слишком много.. нхх..[/say]")

		saynn("Джеки запрокидывает голову и громко скулит, пока её анус начинает судорожно сжимать твой член. Её тело дрожит, а хвост дёргается в конвульсиях. Похоже, сучка кончает. И это подгоняет тебя к собственному оргазму; ты кряхтишь и рычишь прямо в ухо волчице, которая, кажется, окончательно перестала сопротивляться.")

		saynn("После всего этого... ты никак не сможешь вытащиться вовремя...")

		addButton("Кончить внутрь", "Натрахать ей задницу", "do_betray_fuck_cuminside")
	if(state == "do_betray_fuck_cuminside"):
		playAnimation(StageScene.HangingSex, "inside", {npc="pc", pc="jacki", pcCum=true, npcCum=true, bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты вгоняешь свой член глубоко внутрь, создавая заметный бугорок на подтянутом животе Джеки... и этот бугорок начинает раздуваться ещё сильнее, пока ты кончаешь в неё, наполняя её нутро своим {pc.cum} и окрашивая всё внутри в белый цвет.")

		saynn("[say=jacki]Ах-х.. блядь.. моя жопа.. хафф..[/say]")

		saynn("[say=pc]Хорошая маленькая шлюшка.[/say]")

		saynn("Использовав девчонку, ты выходишь, позволяя её набитому анусу пульсировать и источать твою сперму.")

		saynn("[say=pc]Твоя жопа — это всё, что у тебя есть.[/say]")

		saynn("Джеки опускает голову, едва сопротивляясь.")

		saynn("[say=jacki]..так грубо..[/say]")

		addButton("Освободить её", "Пожалуй, стоит помочь ей сейчас", "do_betray_afterfuck_free")
		addButton("Просто уйти", "Да хрен с ним. Выберется как-нибудь сама", "do_betray_afterfuck_nofree")
	if(state == "do_betray_afterfuck_nofree"):
		playAnimation(StageScene.Solo, "stand")
		saynn("Когда вы уже собираетесь уходить... Джеки понимает, что вы не планируете её освобождать. Но всё, что вы слышите — это слабое, покорное...")

		saynn("[say=jacki]Эй... эй![/say]")

		saynn("..которое явно недостаточно, чтобы передумать.")

		saynn("Хотя трахалась она знатно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_betray_afterfuck_free"):
		playAnimation(StageScene.Duo, "stand", {npc="jacki"})
		saynn("А, чёрт с ним! Вы осторожно обхватываете Джеки за талию и приподнимаете её так, чтобы она смогла расстегнуть свои скованные лапки. Затем вы аккуратно опускаете её на землю.")

		saynn("Джеки быстро хватает одежду и прикрывается.")

		saynn("[say=jacki]Я... пойду... спасибо...[/say]")

		saynn("И после этого она быстро убегает. Погодите. Она что, реально сказала «спасибо»?")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_betray_strapon_pick"):
		saynn("Выберите страпон, которым хотите оттрахать Джеки в зад?")

		addButton("Проехали", "Вы передумали", "won_risha")
		addStraponButtons()
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_betray_strapon")
	if(state == "do_betray_strapon"):
		playAnimation(StageScene.HangingSex, "tease", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		if (anger > -0.1):
			saynn("Она думает, что ты сделал это ради её спасения? Хах. Какая глупая волчица. Ты молча надеваешь страпон и подходишь к ней сзади. Джеки быстро понимает твои намерения, когда ты хватаешь её за хвост и резко задираешь его вверх, чтобы добраться до её {jackiButt} задницы.")

			saynn("[say=jacki]Эй.. Погоди. Я могу предложить тебе что-нибудь другое. Кредиты?[/say]")

			saynn("Она предложила тебе всё, чего ты только пожелаешь. Пришло время взять своё. Ты быстро плюёшь на свой новый резиновый ствол и приставляешь его к её сжимающемуся отверстию; слюна втирается в её анальное кольцо, пока игрушка прощупывает его.")

			saynn("[say=jacki]Это уже не смешно.. П-прекрати.. Пожалуйста?[/say]")

			saynn("[say=pc] Заткнись, шлюха.[/say]")

		else:
			saynn("Спасти её было бы поистине героическим поступком. Но ты не герой. Ты просто делаешь то, что хочешь. Пока ты бесшумно подкрадываешься к Джеки и закрепляешь страпон на талии, она начинает изображать беспокойство.")

			saynn("[say=jacki]Эм.. Что ты делаешь?[/say]")

			saynn("Она пытается оглянуться, но поднятые руки ей мешают. Кажется, она понимает твои намерения, когда ты хватаешь её за хвост и резко задираешь его вверх, чтобы добраться до её {jackiButt} задницы.")

			saynn("[say=jacki]Эй.. Это.. это моя задница.[/say]")

			saynn("Именно так. Ты быстро плюёшь на свой новый резиновый ствол и приставляешь его к её сжимающемуся отверстию; твоя предэякуляция втирается в её анальное кольцо, пока ты прощупываешь его.")

			saynn("[say=jacki]Это уже не смешно.. П-прекрати.. Пожалуйста?[/say]")

			saynn("[say=pc] Заткнись, шлюха.[/say]")

		addButton("Растянуть её", "Трахнуть Джеки", "do_betray_strapon_stretch")
	if(state == "do_betray_strapon_stretch"):
		playAnimation(StageScene.HangingSex, "sex", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Шлюшка плотно сжимает задницу... поэтому ты обхватываешь её рукой и тянешь за этот красный куст лобковых волос, заставляя Джеки взвыть от боли; её анус пульсирует так сильно, что ты можешь резко вогнать страпон внутрь, широко растягивая её анальное кольцо!")

		saynn("[say=jacki]А-ах!.. Б-блядь.. Помогите! Кто-нибудь![/say]")

		saynn("Вокруг полно заключенных... но все они просто наблюдают за шоу. Похоже, никто не хочет связываться с тобой после того, как ты отделал того охранника. Хорошо.")

		saynn("Ты хватаешь Джеки за морду и заставляешь её замолчать, начиная трахать её в задницу; ты то и дело выдергиваешь свой фаллоимитатор, чтобы снова глубоко вогнать его в её неохотное отверстие, а твоя слюна делает её внутренние стенки скользкими.")

		saynn("[say=pc]Тебе никто не поможет. Так что лучше привыкай к тому, что твою задницу будут трахать.[/say]")

		saynn("[say=jacki]Нх-х..[/say]")

		saynn("Девушка всё ещё пытается сопротивляться и даже кусаться... но ремни удерживают её тело, делая его послушным для тебя. А на каждый укус ты отвечаешь крепким шлепком по её заднице. Кажется, от каждого удара её анус снова начинает пульсировать вокруг твоего резинового члена...")

		addButton("Быстрее", "Раздолбать ей анус", "do_betray_strapon_faster")
	if(state == "do_betray_strapon_faster"):
		playAnimation(StageScene.HangingSex, "fast", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты вколачиваешь свой член в её задницу всё быстрее и сильнее, пока бедная волчица впадает в отчаяние. Её {jackiButt} дырка уже выглядит раздраженной от твоей грубости и нехватки смазки. Но это не твоя проблема...")

		saynn("[say=jacki]Моя жопа.. С-слишком много.. нхх..[/say]")

		saynn("Джеки запрокидывает голову и громко скулит, пока её анус начинает плотно сжимать твой резиновый ствол. Её тело дрожит, хвост судорожно дёргается. Похоже, сучка кончает. Ты сам не получаешь особого удовольствия... но всё равно хрипишь и рычишь на ухо волчице, которая, кажется, окончательно сдалась.")

		saynn("После всего этого... ты никак не сможешь вытащиться вовремя...")

		addButton("Глубже", "Натрахать ей задницу", "do_betray_strapon_cuminside")
	if(state == "do_betray_strapon_cuminside"):
		playAnimation(StageScene.HangingSex, "inside", {npc="pc", pc="jacki", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты с силой вталкиваешь страпон глубоко внутрь, отчего на подтянутом животе Джеки проступает заметный бугорок... Это резкое движение заставляет её застонать и начать активно извиваться, а её тело снова пробивает дрожь.")

		saynn("[say=jacki]Ах-х.. блядь.. моя жопа.. хафф..[/say]")

		saynn("[say=pc]Хорошая маленькая шлюшка.[/say]")

		saynn("После того как ты трахнул эту девчонку страпоном, ты наконец вытаскиваешь его, позволяя её набитому анусу пульсировать.")

		saynn("[say=pc]Твоя жопа — это всё, что у тебя есть.[/say]")

		saynn("Джеки опускает голову, едва сопротивляясь.")

		saynn("[say=jacki]..так грубо..[/say]")

		addButton("Освободить её", "Пожалуй, стоит помочь ей сейчас", "do_betray_afterfuck_free")
		addButton("Просто уйти", "Да хрен с ним. Выберется как-нибудь сама", "do_betray_afterfuck_nofree")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "do_betray_strapon", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "risha_bullies_jacki"):
		processTime(5*60)
		getCharacter("jacki").getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmatewristcuffs"))

	if(_action == "intervene"):
		processTime(10*60)

	if(_action == "justwatch"):
		processTime(5*60)

	if(_action == "justwatch_rishaleft"):
		processTime(3*60)

	if(_action == "justwatch_free"):
		getModule("JackiModule").addAnger(-5)
		getModule("JackiModule").makeJackiBusy()
		getCharacter("jacki").removeAllRestraints()

	if(_action == "justwatch_leave"):
		getModule("JackiModule").addAnger(100)
		getModule("JackiModule").makeJackiBusy()

	if(_action == "endscene_removerestraints"):
		getCharacter("jacki").removeAllRestraints()
		endScene()
		return

	if(_action == "fight_risha"):
		runScene("FightScene", ["risha"], "risha_fight")
		return

	if(_action == "lost_kiss"):
		processTime(3*60)

	if(_action == "lost_nokiss"):
		processTime(5*60)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmatewristcuffs"))

	if(_action == "lost_kiss_after"):
		processTime(10*60)
		getModule("JackiModule").addAnger(-10)
		getCharacter("jacki").removeAllRestraints()

	if(_action == "lost_nokiss_hang"):
		processTime(3*60)

	if(_action == "lost_nokiss_hang_together"):
		processTime(10*60)
		getModule("JackiModule").addLust(2)
		getModule("JackiModule").addAnger(-5)

	if(_action == "look_at_jacki"):
		processTime(5*60)

	if(_action == "actually_save_jacki"):
		getModule("JackiModule").addAnger(-30)
		getCharacter("jacki").removeAllRestraints()

	if(_action == "do_betray_fuck_stretch"):
		if(!getModule("JackiModule").doBetray()):
			getModule("JackiModule").addAnger(40)
		getModule("JackiModule").advanceSkill("jackiSkillButtslut")
		getModule("JackiModule").makeJackiBusy()

	if(_action == "do_betray_fuck_faster"):
		processTime(5*60)

	if(_action == "do_betray_fuck_cuminside"):
		processTime(6*60)
		getModule("JackiModule").addCorruption(2)
		getCharacter("jacki").cummedInAnusBy("pc")
		GM.pc.orgasmFrom("jacki")

	if(_action == "do_betray_afterfuck_free"):
		processTime(5*60)
		GM.pc.unequipStrapon()
		getCharacter("jacki").removeAllRestraints()
		getModule("JackiModule").addAnger(-2)

	if(_action == "do_betray_afterfuck_nofree"):
		processTime(5*60)
		GM.pc.unequipStrapon()
		getCharacter("jacki").removeAllRestraints()

	if(_action == "do_betray_strapon"):
		processTime(5*60)
		var strapon = _args[0]
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)

	if(_action == "do_betray_strapon_stretch"):
		if(!getModule("JackiModule").doBetray()):
			getModule("JackiModule").addAnger(40)
		getModule("JackiModule").advanceSkill("jackiSkillButtslut")
		getModule("JackiModule").makeJackiBusy()

	if(_action == "do_betray_strapon_faster"):
		processTime(5*60)

	if(_action == "do_betray_strapon_cuminside"):
		processTime(6*60)
		getModule("JackiModule").addCorruption(2)
		getCharacter("jacki").cummedInAnusBy("pc", FluidSource.Strapon)
		GM.pc.orgasmFrom("jacki")

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "risha_fight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_risha")
			addExperienceToPlayer(50)
		else:
			setState("lost_risha")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()

	data["anger"] = anger
	data["corruption"] = corruption
	data["lust"] = lust
	data["hasUnderwear"] = hasUnderwear
	data["buttScore"] = buttScore
	data["soundScore"] = soundScore

	return data

func loadData(data):
	.loadData(data)

	anger = SAVE.loadVar(data, "anger", 0.0)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	lust = SAVE.loadVar(data, "lust", 0.0)
	hasUnderwear = SAVE.loadVar(data, "hasUnderwear", false)
	buttScore = SAVE.loadVar(data, "buttScore", 0)
	soundScore = SAVE.loadVar(data, "soundScore", 0)
