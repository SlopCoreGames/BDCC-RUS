extends SceneBase

var corruption = 0.0
var isNaked = false
var isCaged = false
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var pickedReplayEvent = ""

func _init():
	sceneID = "articaTalkScene"

func _run():
	if(state == ""):
		addCharacter("artica")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		corruption = getModule("ArticaModule").getCorruption()
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		if (getModule("ArticaModule").isLusty() || getFlag("ArticaModule.LQArticaGotBrainwashed")):
			saynn("Артика заметно ерзает и покачивается, её щеки слегка покраснели."+str(" Её тяжелый живот сильно выпирает вперед, она ласково поддерживает его и поглаживает своими лапами..." if getCharacter("artica").isVisiblyPregnant() else "")+""+str(" Её глаза сияют похотью и вечным послушанием, пока она смотрит на тебя..." if getFlag("ArticaModule.LQArticaGotBrainwashed") else "")+"")

		else:
			if (nakedAndShy):
				saynn("Артика старается прикрыться как можно сильнее, её нагота заставляет её краснеть."+str(" Её тяжелый живот сильно выпирает вперед — очевидно, внутри целый выводок..." if getCharacter("artica").isVisiblyPregnant() else "")+"")

			elif (isNaked):
				saynn("Артика покачивается, как обычно, её лапки почти не скрывают интимные места, позволяя любому разглядеть их... Включая тебя."+str(" Её тяжелый живот сильно выпирает вперед — очевидно, внутри целый выводок..." if getCharacter("artica").isVisiblyPregnant() else "")+"")

			else:
				saynn("Артика постоянно в движении, она редко замирает дольше чем на пару секунд."+str(" Её тяжелый живот сильно выпирает вперед, она нежно поглаживает его лапами..." if getCharacter("artica").isVisiblyPregnant() else "")+"")

		saynn("[say=artica]"+str(getModule("ArticaModule").getReaction())+"[/say]")

		saynn("Порча: "+str(Util.roundF(corruption*100.0, 1))+"%")

		addButton("Поговорить", "Поболтать о всяком", "talk_menu")
		addButton("Подразнить", "Заняться чем-то полупошлым", "tease_menu")
		if (getModule("ArticaModule").isLusty() || getFlag("ArticaModule.LQArticaGotBrainwashed")):
			addButton("Секс", "Посмотреть, на какие извращения она способна", "sex_menu")
		else:
			addDisabledButton("Секс", "Артика недостаточно возбуждена")
		if (getCharacter("artica").hasEffect(StatusEffect.HasBodyWritings) || getCharacter("artica").hasEffect(StatusEffect.CoveredInCum)):
			addButton("Душ", "Подожди, пока Артика сама пойдет в душ...", "start_showers")
		else:
			addDisabledButton("Душ", "Артика не пойдет в душ, пока не испачкается")
		if (getModule("ArticaModule").hasAnyWaitScenesLeft()):
			if (getModule("ArticaModule").isLusty() || getFlag("ArticaModule.LQArticaGotBrainwashed")):
				if (getModule("ArticaModule").canTriggerWaitScene()):
					saynn("Если подождать, Артика сама что-нибудь предпримет...")

					addButton("Погоди...", "Посмотреть, что сделает Артика, если оставить её одну", "trigger_wait")
				else:
					addDisabledButton("Погоди...", "Условия для начала следующей сцены не выполнены!\n"+getModule("ArticaModule").getBlockingReqs())
			else:
				addDisabledButton("Погоди...", "Если сделать это сейчас, ничего не произойдет. Можно попробовать возбудить Артику, чтобы подтолкнуть её к исследованию станции")
		if (getFlag("ArticaModule.LQArticaGotDreamCatcher") || getFlag("ArticaModule.LQArticaGotBrainwashed")):
			addButton("Воспоминания", "Пересмотреть одну из старых пошлых сцен", "replay_menu")
			addButton("Покормить", "Покормить Артику", "feedmenu")
		addButton("Уйти", "Пора идти", "endthescene")
		if (getFlag("ArticaModule.TentaclesPcHasFlower") && !getFlag("ArticaModule.TentaclesArticaHasFlower")):
			addButton("Цветок!", "Отдать Артике цветок, который она ищет", "do_give_flower")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["artica"])
	if(state == "ask_lilac"):
		saynn("[say=pc]Так почему ты сиреневая? Что ты сделала, чтобы заслужить такой цвет?[/say]")

		if (getFlag("ArticaModule.LQArticaGotBrainwashed")):
			saynn("[say=artica]Эм.. я д-даже не помню толком.. Знаю только, что.. я твоя шлюшка-игрушка.. Остальное не важно.. ха-ха..[/say]")

			saynn("Артика тихонько мурлычет, прижимаясь носом к твоей щеке.")

		elif (getFlag("ArticaModule.LQArticaGotDreamCatcher")):
			saynn("[say=artica]Та корпорация.. АльфаКорп?.. Она вторглась на мою планету.. Разрушила хрупкий баланс.. Не знаю почему..[/say]")

			saynn("Артика опускает взгляд на свое тело..")

			saynn("[say=artica]И тогда я.. стала писать слова поддержки.. на своем теле.. повсюду.. Я не собиралась с кем-то с-сражаться.. Но и просто н-ничего не делать тоже не хотела.. И тогда я.. попыталась заставить всех м-меня заметить..[/say]")

			saynn("Это тоже способ донести свое послание..")

			saynn("[say=artica]Я н-надеялась, что помогла другим йогауни не сдаваться.. но в-вскоре меня поймали..[/say]")

			saynn("[say=pc]Похоже на обычное непристойное поведение на публике.[/say]")

			saynn("[say=artica]М... может быть... н-но они были ко мне очень жестоки... Ч-что-то там про... создание прецедента...[/say]")

			saynn("Логично.")

		else:
			saynn("[say=artica]Я... эм... это долгая история... на нашу планету напали...[/say]")

			saynn("Артика смотрит на свои лапы.")

			saynn("[say=artica]Я н-не могла по-настоящему сражаться... но... н-ничего не делать тоже б-было плохо... И-именно этого они и х-хотели... О-они хотели убедить нас, что в скором времени всё б-будет хорошо...[/say]")

			saynn("Похоже на АльфаКорп, как и всегда.")

			saynn("[say=artica]Я знала, что мы должны сопротивляться, если хотим остаться теми Йогауни, кем мы являемся... Я... я н-не знаю... Я д-делала всё, что могла... Я... эм... я р-распространяла весть... весть, которая им н-не нравилась...[/say]")

			saynn("Хм.")

			saynn("[say=pc]И всё же... Каковы твои преступления? Тебя обвинили в чем-то сексуальном, верно?[/say]")

			saynn("Артика опускает взгляд и чешет за ухом.")

			saynn("[say=artica]Д... д-да...[/say]")

			saynn("Похоже, тебе её так просто не разговорить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_gym"):
		saynn("[say=pc]Любишь ходить в спортзал?[/say]")

		if (getFlag("ArticaModule.LQArticaGotBrainwashed")):
			saynn("[say=artica]Я.. я п-просто хотела стать достаточно гибкой, чтобы иметь возможность сосать свой собственный член..[/say]")

			saynn("Вау. Какая смелая пушинка.")

			saynn("[say=artica]Чтобы я могла у-ублажать себя в перерывах между тем, как ты меня трахаешь.. ха-ха..[/say]")

		else:
			saynn("[say=artica]Я? Не особо.. нет.. а почему ты спрашиваешь?..[/say]")

			saynn("Хах. Интересно.")

			saynn("[say=pc]Без причины.[/say]")

			saynn("[say=artica]Иногда я выходила на охоту.. Но чаще всего я была самой медленной пушинкой.. П-постоянно терялась..[/say]")

			saynn("Племенной образ жизни, значит.")

			saynn("[say=pc]На что похожа твоя прошлая жизнь по сравнению с.. этим?[/say]")

			saynn("Артика пожимает плечами.")

			saynn("[say=artica]Я скучаю по своему племени... но... д-да... здесь всё о-очень по-другому..[/say]")

			if (getFlag("ArticaModule.eventSelfsuck", 0) >= 2):
				saynn("[say=pc]Кажется, я догадываюсь, зачем ты ходила в спортзал, Артика~.[/say]")

				saynn("Она густо краснеет.")

				saynn("[say=artica]Ой...[/say]")

				saynn("Вы гладите её по голове, пытаясь утешить.")

				saynn("[say=pc]Можешь продолжать попытки, мне понравилось то, что я увидела.[/say]")

				saynn("Она тихонько мурлычет...")

				if (getFlag("ArticaModule.LQArticaGotDreamCatcher")):
					saynn("[say=artica]Д-да.. я просто хотела.. ну, знаешь.. стать более гибкой.. М-мне было очень любопытно, каков на вкус м-мой член..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_mommy"):
		saynn("[say=pc]Что ты чувствуешь.. теперь, когда ты мамочка?[/say]")

		var gaveBirthAmount = getFlag("ArticaModule.gaveBirthTimes", 0)
		saynn("[say=artica]В первый раз было.. с-страшно.. и больно.. но медсёстры были ко мне н-нежны..[/say]")

		saynn("Артика смотрит на свой живот..")

		saynn("[say=artica]Они дали мне немного покормить моих щенков.. это было странно.. но как-то даже приятно..[/say]")

		if (gaveBirthAmount >= 2):
			saynn("[say=pc]Но это ведь не в первый раз.[/say]")

			saynn("[say=artica]Д-да.. К-кажется, это будет не в последний раз.. ха-ха..[/say]")

		if (gaveBirthAmount >= 4):
			saynn("Она чешет себя за ушком.")

			saynn("[say=artica]Странно ли это з-звучит.. ч-что я хочу еще..[/say]")

			saynn("[say=pc]Вовсе нет. Ты отличная мамочка, Артика.[/say]")

			saynn("Она счастливо мурлычет и прижимается щекой к твоей, радостно виляя хвостом.")

		if (gaveBirthAmount >= 7):
			saynn("[say=artica]С-спасибо.. з-за то, ч-что столько раз д-делал мамочке с-секс.. Я т-так люблю быть твоей маленькой шлюшечкой-бродкой..[/say]")

			saynn("Оу-у, какая милашка.")

		if (gaveBirthAmount >= 10):
			saynn("Похоже, она хочет добавить что-то еще к своей последней фразе...")

			saynn("[say=artica]Я прямо.. настоящая сучка, жаждущая щенков.. ня-ах.. Я х-хочу, чтобы меня всегда набивали с-спермой.. Хочу, ч-чтобы меня осеменяли.. снова и снова..[/say]")

			saynn("Ты реально перепахал ей мозги, а.. Похоже, она теперь только и мечтает, что о беременности.. Можешь собой гордиться, ты это сделал!")

		saynn("Ты вспоминаешь, что Артика рожала.. именно "+str(gaveBirthAmount)+" "+str("times" if gaveBirthAmount  != 1 else "time")+".")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_sizequeen"):
		saynn("[say=pc]Ты бы назвала себя.. фанаткой больших размеров?[/say]")

		saynn("[say=artica]Ф-фанаткой раз-размеров? Э-это еще что такое..[/say]")

		saynn("[say=pc]Ну, понимаешь, любительница всего огромного.[/say]")

		saynn("Артика чешет подбородок.")

		saynn("[say=artica]Я н-не то чтобы ф-фанатка ч-чего-то там..[/say]")

		if (getFlag("ArticaModule.eventDildo", 0) >= 2):
			saynn("[say=pc]Да уж, это было бы сильным преувеличением.. ха-ха..[/say]")

			saynn("Артика мгновенно понимает, что ты имеешь в виду.. её щеки вспыхивают огнем..")

		if (getFlag("ArticaModule.eventDildo", 0) >= 3):
			saynn("[say=artica]Н-наверное.. тогда.. д-да.. м-может и так..[/say]")

			saynn("Ты наклоняешь голову набок.")

			saynn("[say=pc]Что это было?[/say]")

			saynn("[say=artica]Э-это считается, если это моё... ммм...[/say]")

			saynn("[say=pc]Определенно считается, Артика.[/say]")

			saynn("[say=artica]..хах..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_tentacles"):
		saynn("[say=pc]Тебя интересуют... щупальца... Артика?[/say]")

		saynn("Артика моргает и покашливает.")

		saynn("[say=artica]Щупальца?..[/say]")

		saynn("[say=pc]Да, щупальца, длинные гибкие отростки.[/say]")

		saynn("Она чешет затылок.")

		saynn("[say=artica]Ну... когда я была молода... я потерялась и наткнулась на одно мистическое существо... у н-него были э-эти самые...[/say]")

		saynn("[say=pc]Так... ты...?[/say]")

		saynn("Она густо краснеет...")

		if (getFlag("ArticaModule.eventTentacles", 0) >= 3):
			saynn("[say=artica]Эм.. Просто..[/say]")

			saynn("[say=pc]Да ладно тебе. Я видела твой животик, он не был похож на беременный~.[/say]")

			saynn("Она закрывает лицо руками.")

			saynn("[say=artica]Ой.. Я..[/say]")

			saynn("Она говорит очень тихо.")

			saynn("[say=artica]..к-кажется..[/say]")

			saynn("Какая скромница. Но ты ведь видела, ты знаешь всю правду.")

			if (getFlag("ArticaModule.gaveBirthToEggs")):
				saynn("[say=artica]Я н-нашла н-немного..[/say]")

				saynn("«Нашла», значит? Интересный выбор слов.")

				saynn("[say=artica]И это п-правда.. м-меня набило.. какими-то.. яйцами..[/say]")

				saynn("[say=pc]Должно быть, ощущения были хреновые, а~?[/say]")

				saynn("[say=artica]Ты в-все сам видел.. С-столько и-икри.. ик.. Кажется, я п-правда кончила, п-просто пока они там лежали..[/say]")

				saynn("[say=pc]Ты просто шлюха для щупалец, Артика~.[/say]")

				saynn("[say=artica]..ха-ха.. д-да.. п-пожалуй..[/say]")

		else:
			saynn("[say=artica]Ну.. Просто.. заворожило..[/say]")

			saynn("Интересно...")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "talk_menu"):
		saynn("О чем хочешь поговорить?")

		addButton("Сирень", "Спросить, почему Артика — сирень", "ask_lilac")
		if (getFlag("ArticaModule.eventSelfsuck", 0) >= 1):
			addButton("Тренажерный зал", "Спросить Артику, любит ли она заниматься спортом", "ask_gym")
		else:
			addDisabledButton("Тренажерный зал", "Тебе пока нет смысла об этом спрашивать...")
		if (getFlag("ArticaModule.gaveBirthTimes", 0) > 0):
			addButton("Мамочка", "Спросить Артику о том, каково это — быть мамочкой", "ask_mommy")
		else:
			addDisabledButton("Мамочка", "Артика еще ни разу не рожала... пока что...")
		if (getFlag("ArticaModule.eventDildo", 0) >= 1):
			addButton("Размерщица", "Спросить Артику, не помешана ли она на размерах", "ask_sizequeen")
		else:
			addDisabledButton("Размерщица", "Тебе пока нет смысла об этом спрашивать...")
		if (getFlag("ArticaModule.eventTentacles", 0) >= 2):
			addButton("Тентакли", "Спросить Артику, нравятся ли ей щупальца", "ask_tentacles")
		else:
			addDisabledButton("Тентакли", "Тебе пока нет смысла об этом спрашивать...")
		if (getFlag("ArticaModule.eventPortalPanties", 0) >= 2):
			addButton("Портальные трусики", "Попросить Артику надеть или снять портальные трусики", "toggle_portal_panties")
		else:
			addDisabledButton("Портальные трусики", "У Артики пока нет портальных трусиков... Пусть побродит по станции, может, она их где-нибудь найдет")
		addButton("Назад", "Хватит болтать", "")
	if(state == "toggle_portal_panties"):
		if (getFlag("ArticaModule.wearsPortalPanties", false)):
			saynn("[say=pc]Те трусики, что у тебя есть... Можно взглянуть?[/say]")

			saynn("Уши Артики нервно дергаются, а щеки слегка краснеют. Она достает фиолетовые трусики и протягивает их тебе. На вид они самые обычные, с милым красным сердечком... но с внутренней стороны на них спрятаны несколько тонких металлических колец с закрытыми отверстиями...")

			saynn("[say=artica]Вот..[/say]")

			saynn("[say=pc]Можешь их надеть?[/say]")

			saynn("[say=artica]Ох.. эм.. Прямо сюда?[/say]")

			saynn("Ты уверенно киваешь, заставляя пушистую девчонку покраснеть еще сильнее.")

			saynn("[say=artica]Хорошо..[/say]")

			if (isNaked):
				saynn("Артика осторожно шагает в трусики и натягивает их, поправляя так, чтобы они удобно сели на бедра; холодные портальные кольца, касающиеся её чувствительных мест, кажется, её совсем не беспокоят..")

			else:
				saynn("Артика стягивает шорты, обнажая перед тобой свою интимную зону.. Затем она осторожно шагает в трусики и натягивает их, поправляя так, чтобы они удобно сели на бедра. Холодные портальные кольца, касающиеся её чувствительных мест, кажется, её совсем не беспокоят..")

			saynn("[say=artica]Вот..[/say]")

			saynn("[say=pc]Спасибо, Артика.[/say]")

			saynn("Она мило тебе улыбается.")

		else:
			saynn("[say=pc]Артика, сними свои портальные трусики.[/say]")

			saynn("Она кивает.")

			saynn("[say=artica]Конечно..[/say]")

			saynn("Артика снимает свои фиолетовые трусики и убирает их. С порталами на сегодня хватит веселья.")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "replay_menu"):
		saynn("Выбери событие, которое хочешь увидеть снова.")

		addEventReplayButtons()
		if (false):
			addButton("Ошибка", "Тебе не стоит этого видеть", "do_pick_replay_event")
		addButton("Назад", "Вы передумали", "")
	if(state == "do_pick_replay_event"):
		saynn("Какую сцену из этого события ты хочешь увидеть снова?")

		addEventReplaySceneButtons()
		if (false):
			addButton("Ошибка", "Тебе не стоит этого видеть", "do_start_replay_scene")
		addButton("Назад", "Вы передумали", "replay_menu")
	if(state == "trigger_wait"):
		playAnimation(StageScene.Solo, "stand", {pc="artica"})
		var firstTimeWait = getFlag("ArticaModule.firstTimeWait", false)
		if (!firstTimeWait):
			setFlag("ArticaModule.firstTimeWait", true)
			saynn("Артика внимательно оглядывается по сторонам... У тебя возникает чувство, что она хочет что-то сделать... сама... но врожденная застенчивость мешает ей сказать тебе об этом прямо.")

			saynn("И ты оставляешь её в покое. Ты находишь место, откуда можно за ней наблюдать... и просто ждешь.")

			saynn("И не проходит и нескольких минут, как Артика отправляется куда-то — желание исследовать тюрьму переполняет её.")

		else:
			saynn("Поведение Артики явно дает понять, что она хочет еще больше изучить станцию самостоятельно.")

			saynn("И ты оставляешь её в покое. Ты находишь место, откуда можно за ней наблюдать... и просто ждешь. Вскоре Артика начинает куда-то направляться...")

		addButton("Следовать", "Посмотреть, что будет делать Артика", "start_corruption_event")
	if(state == "sex_menu"):
		saynn("Артика возбуждена. Как ты хочешь это решить?")

		addButton("Оплодотворить её", "Попробовать зачать щенков", "sex_breed")
		addButton("Оседлать её", "У Артики классный член... почему бы не оседлать его?", "sex_ride")
		if (corruption >= 0.2):
			addButton("Павджоб", "Доведи Артику до оргазма одними лишь ступнями", "sex_pawjob")
		else:
			addDisabledButton("Павджоб", "Чтобы Артика согласилась на это, уровень её развращённости должен быть выше 20%")
		if (corruption >= 0.3):
			addButtonWithChecks("Верёвки!", "Используй верёвки, чтобы подвесить Артику над полом... а затем оторвись по полной (Требуется верёвочная сбруя!)", "sex_ropes", [], [[ButtonChecks.HasItemWithTag, ItemTag.RopeHarness]])
		else:
			addDisabledButton("Верёвки!", "Чтобы Артика согласилась, её развращённость должна быть выше 30%... а также... приготовь верёвочную сбрую")
		if (corruption >= 0.5):
			if (!isCaged):
				addButton("Взаимный лапотрах", "Помогите друг другу своими лапками", "sex_mutualpawjob")
			else:
				addDisabledButton("Взаимный лапотрах", "Для этой сцены Артика не должна быть в клетке. Прости!")
		else:
			addDisabledButton("Взаимный лапотрах", "Чтобы Артика стала достаточно извращённой для этого, её уровень развращённости должен быть выше 50%!")
		if (corruption >= 0.8):
			addButtonWithChecks("Веселье с гипновизором...", "Немного покопайся в мозгах у Артики... Для этого тебе понадобится гипновизор", "sex_hypnovisorfun", [], [[ButtonChecks.HasItemWithTag, ItemTag.Hypnovisor]])
		else:
			addDisabledButton("Веселье с гипновизором...", "Уровень развращенности Артики должен быть выше 80%, чтобы она стала достаточно похотливой для этого... и не забудь взять гипновизор!")
		if (getFlag("ArticaModule.LQArticaGotDreamCatcher")):
			addButton("Пригласить Рахи...", "Дать Рахи и Артике заняться чем-нибудь пошленьким вместе...", "do_invite_rahi")
		addButton("Назад", "Проехали", "")
	if(state == "tease_menu"):
		saynn("Что ты хочешь сделать?")

		addButton("Столовая", "(Лапоигры) Пригласить Артику поесть", "do_tease_canteen")
		addButton("Твоя камера", "Пригласить Артику к себе в камеру", "do_tease_cell")
		if (corruption >= 0.25):
			addButton("Лапать её", "Небрежно лапать Артику на людях", "do_grope")
		else:
			addDisabledButton("Лапать её", "Уровень развращенности Артики должен быть не менее 25%, чтобы ты мог бесцеремонно лапать её на людях")
		if (corruption >= 0.5):
			addButton("Грязные словечки", "Завести Артику одним лишь словом", "do_dirtylanguage")
		else:
			addDisabledButton("Грязные словечки", "Уровень развращенности Артики должен быть не менее 50%, чтобы ты мог возбудить её одними лишь словами")
		addButton("Назад", "Назад в предыдущее меню", "")
	if(state == "do_dirtylanguage"):
		playAnimation(StageScene.Grope, "tease", {pc="artica", npc="pc", bodyState={hard=true}})
		var isPregnant = getCharacter("artica").isVisiblyPregnant()
		saynn("Ты наклоняешься ближе к Артике, заставляя её чувствовать твоё горячее дыхание у самого уха.")

		var theTopic = RNG.pick(["naked", "whore", "paws"])
		#if (isCaged && RNG.chance(40)):
		#	theTopic = "chastity"
		if (isPregnant && RNG.chance(30)):
			theTopic = "preg"
		if (!isPregnant && RNG.chance(30) && GM.pc.hasReachablePenis()):
			theTopic = "breed"
		if (theTopic == "naked"):
			saynn("[say=pc]Ты такая красивая, когда голая, Артика.[/say]")

			saynn("Артика тут же опускает взгляд, а её хвост обвивается вокруг ноги.")

			saynn("[say=pc]Мне просто.. так.. нравится.. смотреть на твои сиськи.. на твой член.. на твою киску.. когда всё это выставлено напоказ для меня.[/say]")

			saynn(""+str("Сейчас она не раздета... но сквозь рубашку всё равно видно, как её соски становятся твердыми и возбужденными" if !isNaked else "Ты замечаешь, как её соски твердеют и приподнимаются, когда ты это говоришь...")+"")

			saynn("[say=artica]Мм-м.. с-спасибо.. за к-комплимент..[/say]")

			saynn("[say=pc]Ты такая послушная зверушка. Всегда готова выставить свое тело напоказ для меня.[/say]")

			if (!isNaked):
				saynn("Ее дыхание становится глубже, "+str("что-то дергается в её шортах" if isCaged else "её шорты раздуваются")+"..")

			else:
				saynn("Ее дыхание становится глубже, "+str("её запертый в клетку член становится таким милым и сочащимся смазкой" if isCaged else "её член слегка выглядывает из препуция, кончик уже сочится предэякулятом...")+"")

			saynn("[say=artica]Д-да.. д-да.. Я.. я.. обожаю.. обожаю быть такой.. э-экзальтированной маленькой шлюшкой-экспонатом..[/say]")

			saynn("Так мило слышать, как она это говорит.")

			saynn("[say=pc]Хорошая девочка.[/say]")

			saynn("Ее подбородок опущен.. но ее"+str(" naked" if isNaked else "")+" грудь вздымается, а задница соблазнительно покачивается, пока лапки скользят по белому меху на боках.")

		elif (theTopic == "whore"):
			saynn("[say=pc]Ты такая покорная, Артика. Всегда готова раздвинуть ноги для меня.. или вообще для любого.. кто захочет тебя использовать."+str(". Всегда готова подставить мне свой член, чтобы я с ним поиграл~." if GM.pc.hasVagina() else "")+"[/say]")

			saynn("От твоих слов она часто хлопает ресницами, а ее щеки заливаются густым румянцем, когда она встает на цыпочки.")

			saynn("[say=pc]Правда?[/say]")

			saynn("[say=artica]Я.. ну.. м-может быть..[/say]")

			saynn("Ты её совсем не трогаешь... но твой взгляд буквально впивается в неё, заставляя белый пушок на её теле подёргиваться.."+str(" в то время как её соски под рубашкой становятся заметно возбужденными." if !isNaked else " в то время как её соски становятся заметно твердыми и острыми...")+"")

			saynn("[say=pc]Может быть? Да ладно тебе, ты можешь лучше.[/say]")

			saynn("Её голос дрожит.")

			saynn("[say=artica]Я.. я обожаю быть.. с-секс-игрушкой..[/say]")

			saynn("Ого, какие смелые слова.")

			saynn("[say=pc]Что ещё? Рассказывай.[/say]")

			saynn("[say=artica]Я.. я.. просто клячка.. игрушка.. Я-я х-хочу, чтобы меня и-использовали.. с-силой..[/say]")

			saynn("Её застенчивый голос в сочетании с грязными словами, которые она произносит... возбуждает даже тебя.")

			saynn("[say=pc]Хорошая девочка.[/say]")

		elif (theTopic == "paws"):
			saynn("[say=pc]Тебе нравятся лапки..[/say]")

			saynn("Артика опускает взгляд, медленно переминаясь с ноги на ногу..")

			saynn("[say=artica]Я.. эм.. н-не понимаю, о ч-чем ты г-говоришь..[/say]")

			saynn("[say=pc]Да неужели? Сказать, что они тебе не нравятся — значит соврать, и ты это прекрасно знаешь~.[/say]")

			saynn("[say=artica]Я.. я.. я лапкозависимая шлюшка..[/say]")

			saynn("Ого, как смело.")

			saynn("[say=artica]Мне н-нравится их ощущение.. их м-мягкость.. тепло.. Мне нравится, как они пахнут..[/say]")

			saynn("Она слышно сглатывает.")

			saynn("[say=artica]Я.. л-люблю.. сосать пальцы на лапах.. а-а.. лизать подушечки.. а.. аа.. и.. и когда мой член ласкают задними лапами..[/say]")

			if (isNaked):
				saynn("Она сглатывает снова.. и снова.. но во рту всё равно скапливается слюна.."+str(" Её запертый в клетку член подергивается в своей тесной маленькой тюрьме..." if isCaged else " Её член быстро выходит из препуция и становится эрегированным...")+"")

			else:
				saynn("Она сглатывает снова.. и снова.. но во рту всё равно скапливается слюна.."+str(" Что-то в её шортах подергивается..." if isCaged else " Её шорты быстро надуваются, на ткани уже появилось влажное пятно...")+"")

			saynn("[say=artica]Я-я.. огромная.. шлюшка.. по лапкам.. л-люблю, когда на меня наступают.. с-сосать.. лизать.. ах.. п-пожалуйста.. хх-хх..[/say]")

			saynn("Ты улыбаешься, пока Артика тихонько посапывает..")

			saynn("[say=artica]Ах.. хх-х.. ах.. в-вот и всё..[/say]")

			saynn("Она сказала более чем достаточно.")

		elif (theTopic == "preg"):
			saynn("[say=pc]Ты прямо светишься, Артика. Беременность тебе к лицу.[/say]")

			saynn("Её взгляд опустился вниз, на её округлившийся живот.")

			saynn("[say=artica]Т-спасибо.. Я такая.. о-оплодотворенная.. Г-готова вынашивать помёт за по-помётом..[/say]")

			saynn("Ты улыбаешься, пока она нежно обнимает саму себя.")

			saynn("[say=artica]Я.. м-маленькая сучка для разведения.. с-созданная, ч-чтобы плодиться и н-носить щенят.. и к-котят.. и.. и.. а-а.. ах.. хах..[/say]")

			saynn("[say=pc]Мелкая носильщица мусора.[/say]")

			saynn("Её глаза.. такие похотливые..")

			saynn("[say=artica]Я... я хочу нести всё"+str(" your" if GM.pc.hasReachablePenis() else "")+" щенки.. ч-чтобы наполняли меня"+str(" your" if GM.pc.hasReachablePenis() else "")+" семенем.. снова и снова..[/say]")

			saynn("Её робкий язычок произносит очень грязные вещи..")

			saynn("[say=artica]Я такая.. такая с-спермобак.. просто к-кокслив.. свинья для осеменения.. м-мясная дырка.. с-сосуд для семени.. сучка-щенок..[/say]")

			saynn("Ого.. она может говорить это бесконечно.. и бесконечно..")

		elif (theTopic == "breed"):
			if (getCharacter("artica").isInHeat()):
				saynn("[say=pc]Ты сегодня прямо сияешь, Артика. Снова чувствуешь этот жар?[/say]")

			else:
				saynn("[say=pc]Тебе ведь нравится, когда тебя осеменяют, да~?[/say]")

			saynn("Когда ты это говоришь, её хвост начинает вилять из стороны в сторону.")

			saynn("[say=artica]Я.. д-да.. я н-не могу п-перестать д-думать об э-этом..[/say]")

			saynn("[say=pc]О чём именно?[/say]")

			saynn("Она прикусывает губу.")

			saynn("[say=artica]Н-насчет.. т-того, что меня б-бродят.. Насчет о-ощущений,"+str(" your" if GM.pc.hasReachablePenis() else "")+"когда член внутри меня.. наполняет меня с-семенем..[/say]")

			saynn("Запах её меха.. сейчас так возбуждает.")

			saynn("[say=pc]Тебе ведь это нравится, да? Когда тебя наполняют, когда чувствуешь, как теплая сперма заливает твою киску.[/say]")

			saynn("Она жадно кивает.")

			saynn("[say=artica]Я.. я.. я д-даже не знаю.. Я.. я к-кажется, мне это н-нравится.. М-мне н-нравится, к-когда меня п-трахают огромные члены, к-когда чувствую, как они р-раздвигают меня.. р-разрывают мои д-дырочки.. н-наполняя мой ж-живот этой.. т-толстой, м-мужской спермой.. ахх-х..[/say]")

			if (isNaked):
				saynn("Она дрожит, её "+str("запертый член бешено пульсирует внутри... её киска настолько жаждет секса, что она уже заливает пол смазкой." if isCaged else "собачий член выходит из препуция и бешено пульсирует... её киска настолько жаждет секса, что она уже заливает пол смазкой.")+"")

			else:
				saynn("Она дрожит, её "+str("запертый в шортах член бешено пульсирует... её киска так жаждет его, что на ткани расплывается огромное мокрое пятно." if isCaged else "собачий член бешено пульсирует в её шортах... её киска так изголодалась, что на ткани расплывается огромное мокрое пятно.")+"")

			saynn("[say=artica]Я.. я.. грязная с-спермотека.. П-п.. ах.. шлюха для б-брэдинга, которая жаждет ч-члена.. к-которая умоляет, ч-чтобы её н-наполнили спермой.. Я.. я.. л-люблю, когда меня используют.. трахают.. о-оплодотворяют.. любым с-способом, к-какой захочешь..[/say]")

			saynn("Ты улыбаешься, наблюдая за тем, как извивается эта бедная, жаждущая пушистка.")

			saynn("[say=pc]Хорошая девочка.[/say]")

		saynn("Разогнать её похоть теперь проще простого, либидо Артики, кажется, зашкаливает..")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "do_grope"):
		playAnimation(StageScene.Grope, "grope", {pc="artica", npc="pc", bodyState={hard=true}})
		var isPregnant = getCharacter("artica").isVisiblyPregnant()
		var acceptCaged = getFlag("ArticaModule.cagedAcceptStage", 0)
		if (isPregnant):
			saynn("Вид беременной Артики... ты просто не можешь удержаться, чтобы не сделать это первым..")

			saynn("Без лишних предупреждений, твои руки"+str(" расстегивают пуговицы на её рубашке и распахивают её. Затем они" if !isNaked else "")+" ложатся на её раздутые сиськи и обхватывают их; её тёмно-бирюзовые соски начинают сочиться молоком даже от малейшего нажатия.")

			saynn("[say=artica]Ааах..[/say]")

			saynn("[say=pc]У тебя сочные сиськи, Артика..[/say]")

			saynn("[say=artica]С-спасибо.. о-они просто.. ну, ты з-знаешь.. от в-вскармливания.. Ахх-х~..[/say]")

			saynn("Ты крепко сжимаешь её лактирующие груди, вызывая целые брызги грудного молока! Ты по-настоящему заводишь её: Артика выгибает спину, пока тонкие струйки молока стекают по её соскам.")

			saynn("[say=pc]Я знаю.[/say]")

			saynn("После этого твои руки скользят ниже и ложатся на её беременный живот. Ты начинаешь нежно его поглаживать.")

			saynn("[say=pc]Этого хватит, чтобы прокормить кучу щенков.. Таких, как те, что ты носишь в себе.[/say]")

			saynn("[say=artica]Ннхх-х.. ах.. д-да.. ха-ха.. ах.. Я т-такая.. производительница щенков..[/say]")

		else:
			saynn("Без лишних предупреждений, твои руки"+str(" расстегивают пуговицы на её рубашке и распахивают её. Затем они" if !isNaked else "")+" приземляются на {artica.breasts} Артики, и ты обхватываешь их ладонями, подчеркивая их форму."+str(" когда вы это делаете, из её темно-бирюзовых сосков просачиваются одинокие капли молока..." if getCharacter("artica").canBeMilked() else "")+"")

			saynn("[say=artica]Ой...[/say]")

			saynn("Она оглядывается по сторонам, проверяя, не смотрит ли кто-нибудь, пока ты небрежно тискаешь её сиськи.")

			saynn("[say=pc]Боишься, что кто-то увидит? Или, может... ты хочешь, чтобы тебя заметили?[/say]")

			saynn("Одна рука остается на её сосках, дразня их и играя с изысканными фиолетовыми пирсингами, которые носит эта девчонка... в то время как другая скользит вниз вдоль живота... очерчивая пупок... прежде чем обхватить и внезапно потянуть"+str(" спускают её шорты, высоко задрав хвост" if !isNaked else " на её хвосте")+", обнажая пушистую задницу Артики перед любыми случайными прохожими. Её хвост пытается поджаться... но ты держишь его высоко и используешь вторую руку, чтобы раздвинуть её ягодицы, следя за тем, чтобы её тугой анус и"+str(" сочащаяся слизью киска" if getCharacter("artica").hasEffect(StatusEffect.HasCumInsideVagina) else "влажная, изголодавшаяся киска")+" были хорошо видны.")

			saynn("[say=artica]Ах!..[/say]")

			saynn("[say=pc]Не нравится? Ну так укуси меня тогда![/say]")

			saynn("[say=artica]Ик.. Я-я знаю, ч-что кусаться — не лучшая идея...[/say]")

			if (isVerySlut):
				saynn("Мимо проходят случайные заключенные, пялясь в дырочки Артики. От этого она начинает... жадно течь... пух в твоих руках буквально извивается, пока ты ласкаешь её задницу.")

				saynn("[say=pc]Хорошая шлюшка.[/say]")

			else:
				saynn("Мимо проходят случайные заключенные... пялясь на дырки Артики. От этого она опускает взгляд и... просто терпит их насмешливые взгляды.")

				saynn("[say=pc]Хорошая девочка.[/say]")

		if (!isCaged):
			if (isLusty):
				saynn("Пушинка краснеет... а её член всё больше и больше высовывается из чехла. Он стал довольно твердым от того, как сильно ты её дразнишь...")

			else:
				saynn("Пушинка краснеет... а её твердый член всё сильнее пульсирует. Кажется, от любого прикосновения он вот-вот сорвется...")

		else:
			if (isLusty):
				saynn("Пушинка краснеет... а её член пульсирует внутри клетки целомудрия... Кажется, любое прикосновение может спровоцировать эрекцию; её голубой ствол оказывает огромное давление на металл.")

			else:
				saynn("Пушинка краснеет... а её член всё отчаяннее пытается выбраться из чехла... но терпит неудачу, так как металл удерживает его внутри, оставляя снаружи лишь сочащуюся смазкой головку.")

			if (acceptCaged <= 1):
				saynn("[say=artica]К-клетка... хх-больно немного.. м-может, тебе с-стоит..[/say]")

				saynn("[say=pc]Ты что, указываешь мне, что делать?[/say]")

				saynn("[say=artica]Н-нет.. конечно н-нет.. нхх.. боги..[/say]")

				saynn("Ты отпускаешь её задницу и вместо этого обхватываешь её пушистые яички, нежно сжимая их.")

				saynn("[say=pc]Эта штука будет на тебе, пока я не скажу иначе.[/say]")

				saynn("Может, тебе стоит как-нибудь затащить эту пушистую в свою камеру и научить её получать удовольствие не только от своего члена...")

			elif (acceptCaged <= 2):
				saynn("[say=artica]К-клетка.. с-сидит так туго..[/say]")

				saynn("[say=pc]Ты жалуешься? Думаешь, мне стоит тебя расстегнуть?[/say]")

				saynn("[say=artica]Н-нет.. Т-тебе решать..[/say]")

				saynn("Ты отпускаешь её задницу и вместо этого обхватываешь её пушистые яички, нежно сжимая их.")

				saynn("[say=pc]Умница.[/say]")

				saynn("Похоже, ей нужно еще немного потренироваться, чтобы меньше зависеть от своего члена.")

			else:
				saynn("[say=artica]М-мой бесполезный.. ч-член.. ах..[/say]")

				saynn("[say=pc]Так оно и есть.[/say]")

				saynn("[say=artica]Я.. просто шлюшка-игрушка.. нх-х..[/say]")

		saynn("Ты умудрился довести пушистую до пика за считанные секунды... хорошо...")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
func getDebugActions():
	return [
	{
	"id": "setCorruption",
	"name": "Установить уровень разврата",
	"args": [
	{
	"id": "corruption",
	"name": "Уровень (0-100)",
	"type": "number",
	"value": 100,
	},
	],
	},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "setCorruption"):
		setFlag("ArticaModule.corruption", clamp(_args["corruption"]/100.0, 0.0, 1.0))
		corruption = getModule("ArticaModule").getCorruption()

func addEventReplayButtons():
	var replayScenes = getModule("ArticaModule").getReplayMenuScenes()
	for eventID in replayScenes:
		addButton(replayScenes[eventID]["name"], "Выбрать это событие", "do_pick_replay_event", [eventID])

func addEventReplaySceneButtons():
	var replayScenes = getModule("ArticaModule").getReplayMenuScenes()
	for sceneInfo in replayScenes[pickedReplayEvent]["scenes"]:
		if(sceneInfo["canstart"]):
			addButton(sceneInfo["name"], sceneInfo["desc"], "do_start_replay_scene", [sceneInfo["scene"]])
		else:
			addDisabledButton(sceneInfo["name"], sceneInfo["desc"])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "start_showers"):
		endScene()
		runScene("articaShowerScene")
		return

	if(_action == "do_give_flower"):
		setFlag("ArticaModule.TentaclesArticaHasFlower", true)
		runScene("articaEventTentacles1dot5Scene")
		return

	if(_action == "toggle_portal_panties"):
		setFlag("ArticaModule.wearsPortalPanties", !getFlag("ArticaModule.wearsPortalPanties", false))
		getCharacter("artica").getInventory().clearSlot(InventorySlot.UnderwearBottom)
		getCharacter("artica").resetEquipment(true, true, true)

	if(_action == "do_pick_replay_event"):
		if(_args.size() > 0):
			pickedReplayEvent = _args[0]

	if(_action == "do_start_replay_scene"):
		runScene(_args[0])
		endScene()
		return

	if(_action == "start_corruption_event"):
		var nextSceneInfo = getModule("ArticaModule").getNextWaitSceneInfo()
		
		var nextSceneID = nextSceneInfo[0]
		var flagToIncrease = nextSceneInfo[1]
		
		increaseFlag("ArticaModule."+flagToIncrease)
		
		addExperienceToPlayer(50)
		
		endScene()
		runScene(nextSceneID)
		return

	if(_action == "sex_breed"):
		endScene()
		runScene("articaSexBreedScene")
		return

	if(_action == "sex_ride"):
		endScene()
		runScene("articaSexRideScene")
		return

	if(_action == "sex_pawjob"):
		endScene()
		runScene("articaSexPawjobScene")
		return

	if(_action == "sex_ropes"):
		endScene()
		runScene("articaSexRopesScene")
		return

	if(_action == "sex_mutualpawjob"):
		endScene()
		runScene("articaSexMutualPawjobScene")
		return

	if(_action == "sex_hypnovisorfun"):
		endScene()
		runScene("articaSexHypnovisorScene")
		return

	if(_action == "do_invite_rahi"):
		endScene()
		runScene("articaPlusRahiScene")
		return

	if(_action == "do_tease_canteen"):
		runScene("articaCanteenTeaseScene")
		endScene()
		return

	if(_action == "do_tease_cell"):
		runScene("articaCellTeaseScene")
		endScene()
		return

	if(_action == "do_grope"):
		processTime(2*60)
		getModule("ArticaModule").makeLusty()

	if(_action == "do_dirtylanguage"):
		processTime(2*60)
		getModule("ArticaModule").makeLusty()

	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["artica"])
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["corruption"] = corruption
	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy
	data["pickedReplayEvent"] = pickedReplayEvent

	return data

func loadData(data):
	.loadData(data)

	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
	pickedReplayEvent = SAVE.loadVar(data, "pickedReplayEvent", "")
