extends SceneBase

func _init():
	sceneID = "DomM4s3SaveKait"

func _run():
	if(state == ""):
		aimCameraAndSetLocName("medical_near_pccell")
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("Вы подходите к ряду запертых мягких камер.")

		saynn("[say=avy]Может, это они.[/say]")

		saynn("Вы не спеша заглядываете в узкие смотровые окошки каждой из них...")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_reveal")
	if(state == "kait_reveal"):
		addCharacter("kait", ["naked"])
		aimCameraAndSetLocName("medical_paddedcell_player")
		playAnimation(StageScene.SexStart, "start", {pc="pc", npc="kait"})
		saynn("Вот она! Это Кейт.")

		saynn("Массивная металлическая дверь заперта... но вы просто прикладываете бейдж медсестры к панели доступа.")

		saynn("Замок щелкает, и дверь приоткрывается ровно настолько, чтобы вы могли войти. Вы делаете шаг внутрь.")

		saynn("Внутри... крошечная комната, едва вмещающая одного человека. Все стены обиты мягким материалом. Кейт сидит в самом центре. На ней смирительная рубашка... из латекса... А на бедрах — громоздкий пояс целомудрия.")

		saynn("Заметив вас, она лениво поднимает на вас взгляд.")

		saynn("[say=kait]..мяу.. мяу-у~..[/say]")

		saynn("Эви рычит.")

		saynn("[say=avy]Твою мать, что эта сука с тобой сделала?[/say]")

		saynn("[say=kait]Мяу-у-у~. Ты такая прелесть-сть.[/say]")

		saynn("Её глаза полуприкрыты, зрачки расширены и не сфокусированы. Она медленно моргает, и на её мордочке расплывается милая улыбка.")

		saynn("[say=pc]Она её усыпила. Надо убираться отсюда, пока не поздно.[/say]")

		saynn("[say=avy]Ну... тогда хватай кошку. С этой грёбаной задроткой разберёмся как-нибудь в другой раз.[/say]")

		saynn("Ты наклоняешься и начинаешь поднимать Кейт. Когда ты это делаешь, она прижимается к тебе носом и довольно мурлычет.")

		saynn("[say=kait]Теплая-я~.[/say]")

		saynn("Как только ты поднимаешь снежного барса... тяжелая металлическая дверь захлопывается! Громкий лязг эхом разносится по коридорам.")

		saynn("Вы заперты внутри! Снаружи осталась только Эви. Ты видишь её сквозь узкую щель.")

		saynn("[say=avy]Какого хрена...[/say]")

		saynn("[say=pc]Значок?[/say]")

		saynn("Эйви пытается приложить его... но панель мигает красным.")

		saynn("[say=avy]Да он, блядь, не работает![/say]")

		saynn("[say=kait]Мяу-мяу... застряла... хе-хе...[/say]")

		saynn("Это не к добру.")

		saynn("[say=eliza]Не открывается, да~?[/say]")

		saynn("Это её голос...")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_eliza_intro")
	if(state == "avy_eliza_intro"):
		addCharacter("eliza")
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance()})
		aimCameraAndSetLocName("medical_near_pccell")
		saynn("Ты можешь лишь наблюдать через узкую щель в двери... но этого достаточно.")

		saynn("Элиза Куинн, во плоти, стоит у входа в крыло психиатрического отделения.")

		saynn("Эйви перестает тыкать значком в панель... и поворачивается к ней.")

		saynn("[say=avy]Ты. Просто. Сука.[/say]")

		saynn("[say=eliza]Буду честна: я надеялась загнать в ловушку вас обеих. Но ничего, с одной я тоже справлюсь.[/say]")

		saynn("Эви вскидывает кулаки, расставив задние лапы на ширину плеч.")

		saynn("[say=avy]Думаешь, ты такая умная, а? Твой идиотский план провалился. Надеюсь, тебе нравится боль, потому что сейчас ты познаешь её во всей красе.[/say]")

		saynn("Элиза держит в руках какой-то шприц.")

		saynn("[say=eliza]Может, я и правда люблю боль~.[/say]")

		saynn("Они вот-вот вступят в бой. А тебе остается только наблюдать.")

		saynn("[say=kait]Эви такая милашка~..[/say]")

		addButton("Смотреть", "Посмотреть, что Эви сделает дальше", "watch_start")
	if(state == "watch_start"):
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), attack=["punch", 0, 0, CombatAnimPlayer.ST_DODGING, ""]})
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), attack=["kick", 0, 0, CombatAnimPlayer.ST_KNOCKEDDOWN, ""]})
		saynn("Лисица делает первый ход. Она бросается вперед, нанося удар «супермен», ее кулак летит прямо в голову Элизы. Кошке удается вовремя уклониться, и удар лишь задевает плечо вместо того, чтобы раздробить челюсть.")

		saynn("[say=eliza]Неплохая попытка.[/say]")

		saynn("[say=avy]Лучше начинай умолять, сучка.[/say]")

		saynn("Ави не останавливается: она идет на продолжение атаки, нанося тяжелый хук, от которого Элиза уворачивается... но последний удар ногой все же настигает ее.")

		saynn("Элиза ахает и оседает на пол — ее ребра явно не в восторге от происходящего.")

		saynn("[say=avy]Что, уже не такая самодовольная?[/say]")

		saynn("Кошка кашляет, хватаясь за бок. Но затем она поднимает взгляд на Ави и улыбается.")

		saynn("[say=eliza]Гх... Бьешь ты сильно, тут не поспоришь.[/say]")

		saynn("Видя эту самодовольную ухмылку, Ави снова бросается в атаку, пытаясь нанести еще один удар ногой...")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_throws_something")
	if(state == "eliza_throws_something"):
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), attack=["throw", 1, CombatAnimPlayer.ST_KNOCKEDDOWN, 0, ""]})
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), statusUpdate=[0, 0]})
		saynn("Но прежде чем Ави успевает атаковать Элизу, доктор бросает ей под ноги флакон. Флакон разбивается, выпуская облако розового тумана. Ави влетает прямо в него, заходясь в кашле.")

		saynn("[say=avy]Уф.. опять эта херня..[/say]")

		saynn("Ави замирает, её шорты заметно вздулись.. сильнее, чем обычно. Пока лисица занята тем, что разгоняет дым, у кошки появляется шанс подняться.")

		saynn("[say=avy]Ты только сделаешь себе хуже потом, шлюха.[/say]")

		saynn("[say=eliza]Я прекрасно знаю, что делаю~.[/say]")

		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), attack=["shove",0,0,0, ""]})
		playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), attack=["WeaponSyringe",1,0,0, ""]})
		#playAnimation(StageScene.Combat, "", {pc="avy", npc="eliza", pcStance=getCharacter("avy").getCombatStance(), npcStance=getCharacter("eliza").getCombatStance(), statusUpdate=[CombatAnimPlayer.ST_KNOCKEDDOWN, 0]})
		saynn("Ави резко подается вперед и успевает подхватить кошку, прежде чем прижать её спиной к стене. Элиза морщится, пока Ави уже вовсю пытается раздеть доктора, стягивая с неё юбку и лабораторный халат.")

		saynn("Именно в этот момент Элиза вонзает шприц в бедро Ави.")

		saynn("[say=avy]Агх.. сука![/say]")

		saynn("Ави отшвыривает Элизу через всю комнату.. но той удается приземлиться на лапы, благодаря кошачьей ловкости.")

		saynn("Однако задние лапы Ави.. сейчас испытывают сильное напряжение. Что бы это ни было за лекарство, оно сделало Ави медленнее и слабее.")

		saynn("[say=eliza]Вы выглядите уставшей, пациентка. У меня есть как раз подходящая комната для вас~.[/say]")

		saynn("[say=avy]ЗАТКНИСЬ![/say]")

		saynn("Эви снова бросается в атаку... но на этот раз Элиза готова. Она уклоняется от медленного выпада и вонзает очередной шприц в плечо Эви. Затем еще один — в руку... она явно подготовилась.")

		saynn("[say=avy]БЛЯТЬ![/say]")

		saynn("[say=kait]..сука~..[/say]")

		saynn("Эви яростно рычит, отталкивая Элизу.. но, похоже, эффект уже достигнут.")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_got_rekt")
	if(state == "avy_got_rekt"):
		playAnimation(StageScene.Duo, "defeat", {npc="eliza", pc="avy", bodyState={leashedBy="eliza"}})
		saynn("Не в силах продолжать бой, Эви валится на пол.")

		saynn("[say=avy]Ненавижу ТЕБЯ.[/say]")

		saynn("Элиза усмехается. Она убирает все шприцы.. а затем подходит к лисичке.. и, почти не встретив сопротивления, защелкивает поводок на её ошейнике.")

		saynn("[say=avy]Не могу.. пошевелиться..[/say]")

		saynn("[say=eliza]Ты заслужила отличный «тайм-аут» в мягкой комнате, пациентка~.[/say]")

		saynn("Она смотрит на тебя сквозь узкую щель в окне.")

		saynn("[say=eliza]Полагаю, это другая комната. Иди сюда~.[/say]")

		saynn("Элиза приглашает Эви следовать за ней... но лисичка наотрез отказывается вставать... или двигаться... вообще хоть чем-то.")

		saynn("[say=eliza]Серьезно? Тебе нужен стимул побольше?[/say]")

		saynn("Свободной лапой она достает еще один шприц, опасно поднося его к шее Эви.")

		saynn("[say=avy]Я ни на дюйм не сдвинусь... пошла ты...[/say]")

		saynn("[say=eliza]Ух. Ладно.[/say]")

		saynn("Элиза убирает шприц и начинает резко дергать за поводок, буквально волоча бедняжку-лисичку по полу, отчего та начинает слегка задыхаться.")

		saynn("[say=eliza]Ты избила всех моих медсестер... ох... тяжелая девчонка... так что теперь мне приходится всё делать самой, ррр.[/say]")

		saynn("И вот они выходят из твоего... крайне ограниченного... поля зрения. Элиза, вероятно, заталкивает Эви в другую мягкую камеру, готовясь закрыть дверь.")

		saynn("[say=kait]Ави.. сейчас приляжет вздремнуть~..[/say]")

		saynn("Элиза со своими хитростями.. ей почти удалось выйти победительницей после всего, что случилось.. она даже умудрилась полностью избежать боя с тобой.")

		saynn("Ну и сука.")

		saynn("Похоже.. ты мало что можешь с этим поделать.")

		saynn("Ты заперт в мягкой комнате. Ави разделяет твою участь. Кейт всё еще дурачится в твоих руках. А Энс.. она даже не подозревает обо всём этом.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sudden_ferri")
	if(state == "sudden_ferri"):
		addCharacter("ferri")
		playAnimation(StageScene.Solo, "stand", {pc="ferri"})
		saynn("[say=ferri]Псс![/say]")

		saynn("Что?")

		saynn("Ты смотришь в узкое окошко двери.. и видишь кончики чьих-то рожек и кисточки на ушах.")

		saynn("Это Ферри! Она присела у двери, шепча тебе.")

		saynn("[say=ferri]..ты там?..[/say]")

		saynn("[say=kait]Ох, как же штырит~...[/say]")

		saynn("Ты закрываешь рот Кейт... она начинает лизать твои пальцы.")

		saynn("[say=pc]Тссс... да... Элиза в следующей... нам нужно как-то выбраться.[/say]")

		saynn("[say=ferri]..Я кое-что принесла... отойди от двери... подальше, насколько сможешь. И... закрой уши.[/say]")

		saynn("Ферри закрывает щель в двери...")

		saynn("Что она задумала? Трудно сказать... но ты слушаешь её.")

		saynn("Ты затаскиваешь Кейт в угол мягкой комнаты и закрываешь ей уши, готовясь к удару и крепко прижимая её к себе.")

		addButton("Продолжить", "Смотреть, что будет дальше", "boom_happens")
	if(state == "boom_happens"):
		aimCameraAndSetLocName("medical_paddedcell_player")
		playAnimation(StageScene.GivingBirth, "idle")
		saynn("Не проходит и минуты, как... БАБАХ!")

		saynn("Взрыв сотрясает весь коридор.")

		saynn("Дверь... содрогается в раме, металл стонет, петли лопаются. Пыль и обломки вырываются сквозь щели, заполняя мягкую комнату дымом.")

		saynn("В ушах звенит... высокий, резкий шум заглушает всё остальное. Кейт издает приглушенный писк. Ты крепко прижимаешь её к себе, вжимаясь в угол вместе с ней.")

		saynn("Мягкие стены поглощают часть ударной волны... но всю комнату всё равно трясет. Лампа над вами гаснет почти мгновенно.")

		saynn("Затем наступает тишина... если не считать звона в ушах.")

		saynn("Ты кашляешь и машешь руками, пытаясь разогнать пыль. Сквозь дым ты видишь дверь. Она всё еще стоит... но держится на честном слове.")

		addButton("Пни её!", "Пнуть дверь", "kick_the_door")
	if(state == "kick_the_door"):
		playAnimation(StageScene.Solo, "kick")
		saynn("Один мощный удар... и дверь с грохотом падает, поднимая в воздух еще больше пыли.")

		saynn("По крайней мере, система фильтрации воздуха снаружи, кажется, всё еще работает...")

		saynn("Ты хватаешь Кейт и начинаешь выводить её в коридор.")

		addButton("Выйти наружу", "Посмотреть, что происходит снаружи", "ferri_gets_bullied")
	if(state == "ferri_gets_bullied"):
		aimCameraAndSetLocName("medical_near_pccell")
		GM.pc.setLocation("medical_near_pccell")
		playAnimation(StageScene.SexCowgirlChoke, "tease", {pc="ferri", npc="eliza"})
		saynn("Ты усаживаешь Кейт на пол, подальше от выбитой двери. Повсюду разбросаны мелкие осколки стекла... должно быть, то, что раньше было химическими стаканами.")

		saynn("[say=eliza]Ты хоть понимаешь, ЧТО ты натворила, глупышка?! Знаешь, что я с ТОБОЙ сделаю за это?![/say]")

		saynn("Элиза Куинн сидит верхом на Ферри, сжимая ей горло. Обе перепачканы в пыли.")

		saynn("[say=ferri]П-п-прости-и-и... хкхх...[/say]")

		saynn("[say=eliza]Нет-нет-нет, одним «прости» тут не отделаешься. ТЕБЯ ждёт целый мир БОЛИ. Я буду тебя, блять, ТЕРЗАТЬ.[/say]")

		saynn("Ну и сумасшедшая сучка. Пожалуй, стоит вмешаться прямо сейчас.")

		saynn("[say=pc]Не задался денёк, доктор? А где же ваши манеры?[/say]")

		saynn("Кошка перестаёт душить бедную дракат... и медленно поднимается.")

		addButton("Продолжить", "Смотреть, что будет дальше", "about_to_fight_eliza")
	if(state == "about_to_fight_eliza"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Элиза смотрит на тебя с крайне злобным выражением лица.")

		saynn("[say=eliza]Мой день, значит... Мой день шёл просто идеально. Пока ты не ввалилась сюда и не разнесла моё медицинское крыло.[/say]")

		saynn("[say=pc]Тебе не обязательно было так поступать с Кейт.[/say]")

		saynn("Доктор закатывает глаза.")

		saynn("[say=eliza]Она это заслужила.[/say]")

		saynn("[say=pc]Конечно. Как и ты.[/say]")

		saynn("Элиза слегка наклоняет голову, её хвост коротко подергивается позади неё.")

		saynn("[say=eliza]Хм... Значит, вот оно как. Ты против меня.[/say]")

		saynn("[say=pc]Похоже на то.[/say]")

		saynn("Она лезет в карманы и подсумки, доставая шприцы и флаконы. Её глаза загораются азартом.")

		saynn("[say=eliza]Ладно. Тогда погнали~.[/say]")

		addButton("Драться", "Начать бой", "start_fight")
	if(state == "eliza_fight_lost"):
		playAnimation(StageScene.GivingBirth, "idle")
		aimCameraAndSetLocName("medical_paddedcell_player")
		saynn("Ты проиграла бой!")

		saynn("Элиза вводит тебе один из своих препаратов... и теперь всё перестает иметь значение. Ты чувствуешь приятное спокойствие.")

		saynn("Вы присоединяетесь к Кейт, Эви и Ферри в уцелевшей мягкой камере...")

		saynn("А теперь можно просто наслаждаться временем вместе, обнимаясь и отдыхая друг на друге. Так мило.")

		saynn("Вам не удалось завербовать Элизу Куинн. Похоже, придется попробовать еще раз как-нибудь в другой раз.")

		saynn("Миссия провалена!")

		addButton("Продолжить", "Прервать миссию", "stopthemission")
		addButton("Перезапустить", "Попробовать еще раз", "trymissionagain")
	if(state == "eliza_fight_won"):
		playAnimation(StageScene.SexFeetPlay, "pin", {npc="eliza"})
		saynn("Элиза проиграла!")

		saynn("Она осталась тяжело дышать на полу, не в силах продолжать бой.")

		saynn("[say=eliza]Ух.. дерьмо..[/say]")

		saynn("Она лежит на спине, пытаясь отползти от тебя, волоча задницу по полу.")

		saynn("Вскоре ты настигаешь её и прижимаешь к полу.")

		saynn("[say=pc]Куда-то собралась?[/say]")

		if (getFlag("ElizaModule.s2hap", false)):
			saynn("[say=eliza]Гх.. Да пошел ты.. Дать тебе доступ к моей лаборатории было ошибкой.[/say]")

			saynn("[say=pc]Та лаборатория нам была не нужна. У нас есть своя лаборатория и свой химик.[/say]")

		else:
			saynn("[say=eliza]Гх... Да пошли вы... Использовать мою же лабораторию против меня — это нечестно...[/say]")

			saynn("[say=pc]Нам не нужна была твоя лаборатория. У нас есть своя лаборатория и свой химик.[/say]")

		saynn("Говоря это, ты переводишь взгляд на Ферри. Она тоже лежит на полу, приходя в себя после того, как Элиза её придушила.")

		saynn("[say=pc]Ты как, Ферри?[/say]")

		saynn("[say=ferri]Вроде того...[/say]")

		saynn("Она медленно поднимается и подходит к тебе.")

		saynn("[say=pc]Думаю, и Эви, и Кейт под седативами. Мы можем что-нибудь сделать?[/say]")

		saynn("[say=ferri]Ну... У меня нет ничего, что могло бы помочь... м-м-м...[/say]")

		saynn("[say=kait]М-м-м-м~... Ферри такая мягкенькая~...[/say]")

		saynn("Ферри и впрямь не нашла бы у неё ничего лишнего... Ты переводишь взгляд на Элизу.")

		saynn("[say=pc]А она?[/say]")

		saynn("[say=eliza]Эй, я же поцарапаюсь![/say]")

		saynn("[say=pc]А если сделаешь это, я тебе пальцы переломаю. Давай, Ферри, обыщи её.[/say]")

		saynn("Элиза дуется и рычит... но позволяет лапам Ферри шарить по своим карманам.")

		saynn("[say=eliza]А я ведь правда думала, что ты хорошая девочка, Ферри.[/say]")

		saynn("[say=ferri]Я хорошая девочка для {pc.name}~. Ой, а это что такое?[/say]")

		saynn("Ферри находит пузырёк с таблетками, на котором написано «Антитоксин».")

		saynn("[say=kait]Ово~.[/say]")

		saynn("Дракатка прищуривается... и заставляет Кейт проглотить таблетку.")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_becomes_okay")
	if(state == "kait_becomes_okay"):
		playAnimation(StageScene.SexStart, "start", {pc="ferri", npc="kait"})
		saynn("Проходит всего около минуты, прежде чем Кейт начинает... возвращаться в свое нормальное состояние.")

		saynn("[say=kait]Ох.. голова раскалывается..[/say]")

		saynn("[say=ferri]Вы в порядке, мисс?[/say]")

		saynn("[say=kait]Нет, блять, не в порядке. Какого хера на мне этот смирительный халат?[/say]")

		saynn("[say=eliza]Это было для твоего же блага, глупая пациентка.[/say]")

		saynn("Ты сильнее прижимаешь кошечку к полу. Ферри тем временем отправляется в мягкую камеру к Эви, чтобы сделать ей инъекцию.")

		saynn("[say=kait]ТАК. Блять. Ты меня ждала! Ты знала, что я заглочу эту сраную наживку! Как?![/say]")

		saynn("[say=eliza]Знаешь, тебя не так уж сложно просчитать.[/say]")

		saynn("[say=kait]Херня! Это медсестра нас сдала?[/say]")

		saynn("[say=eliza]Эта милашка плохо умеет скрывать свои эмоции.[/say]")

		saynn("[say=kait]Ага, теперь понятно. Теперь я, блядь, всё вижу.[/say]")

		saynn("[say=pc]Расслабься, Кейт. Мы её взяли.[/say]")

		saynn("[say=eliza]И тебе всего лишь нужно было разнести половину медблока и избить всех моих медсестёр! Отличная работа![/say]")

		saynn("[say=kait]Она ещё не наша. Но сначала сними с меня эту ебучую херню![/say]")

		saynn("[say=avy]Почему? По-моему, тебе в ней идеально, Кейт. Я бы только ремень снял.[/say]")

		saynn("Похоже, Эви вернулась. Она потягивается, её мышцы всё ещё выглядят забитыми после случившегося.")

		saynn("[say=kait]Да пошла ты, Эви![/say]")

		saynn("[say=avy]Как грубо. И это после всего, что я сделала, чтобы спасти тебя.[/say]")

		saynn("Ты сама копаешься в карманах Элизы и находишь ключ с надписью «Кейт». Это наводит на мысль. Ты бросаешь ключ Эви.")

		saynn("[say=pc]Просто отстегни её. Думаю, у нас найдётся кандидат получше для этой смирительной рубашки.[/say]")

		saynn("[say=avy]Охх. А ведь ты можешь быть прав(а).[/say]")

		saynn("[say=eliza]Только посмей![/say]")

		saynn("«Посмею» — это еще слабо сказано.")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_gets_jacket")
	if(state == "eliza_gets_jacket"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcBodyState={leashedBy="pc"}})
		saynn("Спустя некоторое время... всё готово.")

		saynn("[say=pc]Сидит идеально.[/say]")

		saynn("Теперь на Элизе и смирительная рубашка, и пояс целомудрия... а еще какой-то ошейник, который принесла Эви. Кошка пытается вырваться, но все ремни затянуты намертво... от этого доктор лишь сильнее прижимает руки к себе. Ты пристегиваешь поводок к её новому ошейнику.")

		saynn("[say=eliza]Грр-р... Ты не понимаешь, что творишь![/say]")

		saynn("[say=pc]Повинуйся нам добровольно. И тогда, возможно, нам не придется прибегать к этому.[/say]")

		saynn("Она хмурится и скалится, обнажая клыки.")

		saynn("[say=eliza]Никогда! Тебе никогда меня не сломить![/say]")

		saynn("[say=pc]Посмотрим, как ты запоешь, когда мы с тобой закончим.[/say]")

		saynn("Ты просишь её надеть повязку на глаза и кляп. Ферри хватает её одежду и убирает её. Ты мало что можешь сделать с нанесённым ущербом... но, надеюсь, инженеры со всем разберутся.")

		saynn("[say=kait]Мне что, придётся ходить голой?! Где моя форма?![/say]")

		saynn("[say=avy]У нас её нет, киска. Так что, похоже, придётся выпустить наружу свою внутреннюю сучку-экспозиционистку.[/say]")

		saynn("[say=kait]Я не сучка![/say]")

		saynn("Кейт рычит... и просто прикрывается лапами и пушистым хвостом. Сойдёт.")

		saynn("Пора возвращаться в убежище.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_lobby_show")
	if(state == "back_lobby_show"):
		aimCameraAndSetLocName("med_lobbyne")
		playAnimation(StageScene.Duo, "walk", {pc="eliza", npcAction="walk", flipNPC=true, bodyState={leashedBy="pc"}})
		saynn("Ты возвращаешься в медицинское лобби... и не встречаешь никакого сопротивления. Похоже, медсёстры и вправду слишком напуганы, чтобы связываться с тобой.")

		saynn("Элиза то и дело врезается в стены, а потом ворчит — глупая кошка.")

		saynn("[say=pc]Я думала, ты уже к этому времени выучишь своё медкрыло наизусть.[/say]")

		saynn("В ответ слышится лишь ворчание, а её хвост раздражённо виляет.")

		addButton("Убежище", "Притащить кошачью к себе", "go_hideout")
	if(state == "go_hideout"):
		aimCameraAndSetLocName("hideout_breakroom")
		GM.pc.setLocation("hideout_near_break_room")
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcAction="kneel", npcBodyState={leashedBy="pc"}})
		saynn("Ты торжественно ведёшь Элизу в своё убежище! Путешествие проходит так же спокойно: кажется, никто не хочет связываться с вашей группой, хотя на вас и пялится добрая половина прохожих.")

		saynn("Специальная каморка уже ждёт Элизу. Ты заводишь её внутрь и приковываешь цепью к одной из труб. Повязка на глазах и кляп больше не нужны, так что ты их снимаешь.")

		saynn("[say=pc]Это не совсем мягкая комната, но сойдёт.[/say]")

		saynn("[say=eliza]Серьёзно? Уф... здесь так, блядь, грязно...[/say]")

		saynn("Она находит себе местечко и плюхается задом на пол, отчего пояс девственности громко лязгает.")

		saynn("[say=pc]Сиди смирно.[/say]")

		saynn("[say=eliza]Ты ещё пожалеешь об этом.[/say]")

		saynn("[say=pc]Ты это постоянно твердишь.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_back_stepout")
	if(state == "eliza_back_stepout"):
		playAnimation(StageScene.Duo, "stand", {pc="avy", npc="kait", npcBodyState={naked=true}})
		removeCharacter("eliza")
		aimCameraAndSetLocName("hideout_near_break_room")
		saynn("Закончив с Элизой, ты выходишь из её новой камеры.")

		saynn("[say=kait]Круто. Пойду поищу себе новую форму.[/say]")

		saynn("Кейт уже собиралась уходить... но Эйви перехватывает её за руку.")

		saynn("[say=avy]Мне кажется, ты кое-что забыла.[/say]")

		saynn("[say=kait]А? Разве?[/say]")

		saynn("Кейт пытается вырваться, но Эйви лишь сильнее сжимает хватку.")

		saynn("[say=avy]Мы, вообще-то, твою задницу спасли.[/say]")

		saynn("[say=kait]И что? Я бы сделала то же самое. Ну, может, не ради тебя — тебе бы не помешало разок-другой сходить к психологу.[/say]")

		saynn("Эйви вздыхает. Хвост Кейт виляет позади неё.")

		saynn("[say=avy]Ты хоть понимаешь, через что нам пришлось пройти, чтобы тебя вытащить? Маленькая благодарность бы не помешала.[/say]")

		saynn("[say=kait]А? Это какая-то ловушка? Пойду достану сраную форму, Эви.[/say]")

		addButton("Отпустить Кейт", "(Послушание Эви +) Сказать Эви, что Кейт не стоит нас благодарить", "let_kait_just_go")
		addButton("Принять сторону Эви", "(Послушание Кейт +) Немного благодарности ей не повредит", "make_kait_say_thanks")
	if(state == "let_kait_just_go"):
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		removeCharacter("kait")
		saynn("[say=pc]Кейт, иди за формой. Эви.[/say]")

		saynn("Эви хмурится... но всё же отпускает снежную леопардицу. Кейт быстро скрывается из виду.")

		saynn("[say=avy]Серьёзно? Ты её балуешь.[/say]")

		saynn("[say=pc]Забудь о гордости, Эви. Она и так достаточно настрадалась.[/say]")

		saynn("Лисица скрещивает руки на груди. Ферри всё ещё стоит рядом, не совсем понимая, что делать с одеждой Элизы. Вы указываете на один из ящиков.")

		saynn("[say=avy]Она сама во всём виновата, сама понимаешь.[/say]")

		saynn("[say=pc]Она поступила так, как считала правильным. На её месте я бы, наверное, сделала то же самое.[/say]")

		saynn("Раздражённый звук, после которого она закатила глаза.")

		saynn("[say=avy]Фу. Ты просто начала выделять любимчиков.[/say]")

		saynn("[say=pc]Мы — команда, Эви. Она бы сделала для тебя то же самое.[/say]")

		saynn("[say=avy]Не верю я во всё это. Эта шлюха меня ненавидит.[/say]")

		saynn("[say=pc]Никогда не задумывалась, почему?[/say]")

		saynn("Эви фыркает.")

		saynn("[say=pc]И она уже однажды тебя спасла, не забывай об этом.[/say]")

		saynn("[say=avy]Ну конечно. Как скажешь.[/say]")

		saynn("Эви заметно раздражена. Хотя, по правде говоря, она это заслужила.")

		saynn("[say=pc]Эви, хочу сказать тебе спасибо. Ты мне очень помогла. И Ферри, ты тоже спасла положение, спасибо тебе![/say]")

		saynn("Ферри слегка краснеет.")

		saynn("[say=ferri]Ладно.. мяв.. Думаю, я оставлю тебя в покое.[/say]")

		saynn("Ты киваешь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "all_left_only_avy")
	if(state == "make_kait_say_thanks"):
		saynn("[say=pc]Кейт. Забудь о гордости. Нам пришлось подорвать медблок, чтобы вытащить тебя. Ну, то есть Ферри пришлось. Она всех спасла.[/say]")

		saynn("Ферри слегка краснеет.")

		saynn("[say=kait]Ладно.. Спасибо, Ферри. Ты хорошая девочка.[/say]")

		saynn("Вы с Эви обе долго на неё смотрите...")

		saynn("[say=kait]Ладно-о. Спасибо, Ферри. Спасибо, {pc.name}. Спасибо.. Эви.. блрхрх-х..[/say]")

		saynn("На лице Эви играет милая самодовольная ухмылка.")

		saynn("[say=avy]Ладно. А теперь вставай на колени и доставь удовольствие каждому из нас своим языком.[/say]")

		saynn("[say=kait]Пфф, я так и знала, что это ловушка. Пошел ты, Эви![/say]")

		saynn("[say=avy]Да шучу я, глупая шлюшка. Иди собирай свои шмотки.[/say]")

		saynn("Эви отпускает руку Кейт, позволяя ей уйти.")

		saynn("[say=ferri]Я тебе еще нужна?..[/say]")

		saynn("[say=pc]Нет, пока ты свободна, Ферри. Ты молодец. Правда, очень молодец.[/say]")

		saynn("[say=ferri]Спасибо... мрр...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "all_left_only_avy")
	if(state == "all_left_only_avy"):
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		removeCharacter("ferri")
		removeCharacter("kait")
		saynn("Теперь остались только ты и Эви.")

		saynn("[say=pc]Итак. Теперь нам нужно завербовать Элизу.[/say]")

		saynn("[say=avy]Да, давай сломаем эту тупую сучку.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		GM.main.RCS.setCurrent("Eliza")
		return

	if(_action == "kait_reveal"):
		getCharacter("kait").getInventory().clearSlot(InventorySlot.Body)
		putOn("kait", "LatexStraitjacket")

	if(_action == "watch_start"):
		processTime(3*60)

	if(_action == "boom_happens"):
		processTime(2*60)

	if(_action == "start_fight"):
		runScene("FightScene", ["eliza"], "elizaFight")
		return

	if(_action == "stopthemission"):
		processTime(60*60*3)
		endScene()
		GM.pc.setLocation(GM.pc.getCellLocation())
		GM.main.MS.failCurrentMission()

	if(_action == "trymissionagain"):
		endScene()
		GM.main.MS.restartCurrentMission()
		return

	if(_action == "kait_becomes_okay"):
		processTime(2*60)
		getCharacter("kait").getInventory().clearSlot(InventorySlot.Body)
		putOn("kait", "LatexStraitjacket")

	if(_action == "eliza_gets_jacket"):
		processTime(3*60)
		getCharacter("eliza").getInventory().clearSlot(InventorySlot.Body)
		getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearTop)
		getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearBottom)
		putOff("kait", "LatexStraitjacket")
		putOn("eliza", "LatexStraitjacket")
		putOn("eliza", "oldcollar")

	if(_action == "back_lobby_show"):
		processTime(5*60)
		putOn("eliza", "blindfold")
		putOn("eliza", "ballgag")

	if(_action == "go_hideout"):
		processTime(5*60)
		putOff("eliza", "blindfold")
		putOff("eliza", "ballgag")

	if(_action == "eliza_back_stepout"):
		getCharacter("kait").resetEquipment()

	if(_action == "all_left_only_avy"):
		addMessage("Задача обновлена!")
	
	if(_action == "let_kait_just_go"):
		GM.main.MS.setDecision("kait", "letgo")

	if(_action == "make_kait_say_thanks"):
		GM.main.MS.setDecision("kait", "avy")

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "elizaFight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("eliza_fight_won")
			addExperienceToPlayer(50)
		else:
			setState("eliza_fight_lost")
			addExperienceToPlayer(5)
