extends SceneBase

var isCorrupt = false
var isPure = false
var isNormal = false
var isVirgin = false
var hasMark = false
var hasMilk = false
var isEfficient = false
var beganLactating = false
var breastPumpID = ""

func _init():
	sceneID = "Ch6TaviMilkingScene"

func _run():
	if(state == ""):
		addCharacter("tavi")
		isCorrupt = getModule("TaviModule").isCorrupt()
		isPure = getModule("TaviModule").isPure()
		isNormal = (!isCorrupt && !isPure)
		isVirgin = getModule("TaviModule").isVirgin()
		hasMark = getModule("TaviModule").hasWombMark()
		hasMilk = getCharacter("tavi").canBeMilked()
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		if (hasMilk):
			saynn("Похоже, у Тави началось молоко, и ты всерьез задумываешься о том, чтобы подоить свою питомицу.")

			saynn("Вопрос лишь в том, как именно ты хочешь это сделать?")

			saynn("Кошка замечает твой взгляд на своей груди и скрещивает руки, подчеркивая свои {tavi.breasts} и прикусывая губу.")

			saynn("[say=tavi]"+str(taviSpeak("Like 'em?.. You made them like that.", "They keep itching when full.. Wanna change that?", "I think I know why you are staring.."))+"[/say]")

			if (getCharacter("tavi").hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				addDisabledButton("Дойка руками", "Дать Тави отдохнуть. Её соски всё ещё болят")
				addDisabledButton("Кормление грудью", "Дать Тави отдохнуть. Её соски всё ещё болят")
				addDisabledButton("Молокоотсос", "Дать Тави отдохнуть. Её соски всё ещё болят")
			else:
				addButton("Дойка руками", "Доить грудь Тави руками", "lact_handmilking")
				addButton("Кормление грудью", "Сосать грудь Тави ртом", "lact_breastfeeding")
				if (GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump).size() > 0):
					addButton("Молокоотсос", "Использовать один из ваших молокоотсосов на груди Тави", "lact_pump_pick")
				else:
					addDisabledButton("Молокоотсос", "У вас нет молокоотсосов")
		else:
			saynn("Тави вроде бы не лактирует, так что доить её особо не получается.")

			saynn("Но ведь можно всё равно попробовать, верно? Может, если не сдаваться, случится что-нибудь эдакое...")

			saynn("Кошка ловит ваш взгляд на своей груди и слегка наклоняет голову.")

			saynn("[say=tavi]"+str(taviSpeak("Something is wrong? Want me to undress?..", "Your stare makes me wet alone, what's up with that?", "You like staring at me.."))+"[/say]")

			var lastGrope = getFlag("TaviModule.Ch6TaviLastGropeHow", "")
			if (lastGrope == "grope"):
				saynn("Вы помните, как в прошлый раз ощупывали грудь Тави, пытаясь вызвать у неё лактацию. [b]Вы почти уверены, что сейчас стоит попробовать что-то другое, чтобы добиться большего эффекта.[/b]")

			elif (lastGrope == "suck"):
				saynn("Вы помните, как в прошлый раз сосали грудь Тави, пытаясь вызвать у неё лактацию. [b]Вы почти уверены, что сейчас стоит попробовать что-то другое, чтобы добиться большего эффекта.[/b]")

			elif (lastGrope == "pump"):
				saynn("Вы помните, как в прошлый раз использовали молокоотсос на груди Тави, пытаясь вызвать у неё лактацию. [b]Вы почти уверены, что сейчас стоит попробовать что-то другое, чтобы добиться большего эффекта.[/b]")

			addButton("Ощупать Тави", "Сжимать грудь Тави, чтобы вызвать лактацию", "nolact_grope")
			if (getCharacter("tavi").hasEffect(StatusEffect.SoreNipplesAfterMilking)):
				addDisabledButton("Сосать соски", "Дать Тави отдохнуть, её соски всё ещё болят")
				addDisabledButton("Молокоотсос", "Дать Тави отдохнуть, её соски всё ещё болят")
			else:
				addButton("Сосать соски", "Уделить особое внимание соскам Тави", "nolact_suck")
				if (GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump).size() > 0):
					addButton("Молокоотсос", "Использовать один из ваших молокоотсосов на груди Тави", "nolact_pump_pick")
				else:
					addDisabledButton("Молокоотсос", "У вас нет молокоотсосов")
		addButton("Отмена", "Вы передумали", "cancel_activity")
	if(state == "nolact_grope"):
		playAnimation(StageScene.BreastGroping, "tease", {npc="tavi", npcBodyState={naked=true}})
		saynn("Ты можешь просто подойти к ней и начать ласкать... но можно сделать это чуть более интимно.")

		saynn("Тави довольно мурлычет, когда ты притягиваешь её к себе для объятий. Мягкий гул оживленной космической станции будто затихает, пока ты обнимаешь свою питомицу.")

		saynn("[say=tavi]Приятно..[/say]")

		saynn("[say=pc]Я могу сделать ещё лучше.[/say]")

		saynn("Пока вы обнимаетесь, твои руки тянутся к рубашке Тави и осторожно расстегивают её, пуговицу за пуговицей... пока её грудь не оказывается на виду. Кажется, она тебе доверяет, но её пальцы всё ещё прикрывают её зеленые упругие соски, словно защищая их.")

		saynn("[say=tavi]И что ты собираешься делать?..[/say]")

		saynn("Твои губы оставляют легкий поцелуй на шее Тави. А затем еще один. Твоя питомица склоняет голову набок, подставляясь под твои ласки. Из её горла вырывается мягкое мурлыканье.")

		saynn("[say=pc]Просто хочу доставить тебе удовольствие.[/say]")

		saynn("Чувствуя твою нежность, Тави теряет бдительность и позволяет твоим рукам исследовать изгибы её тела, прорисовывая нежные узоры на её роскошном фиолетовом меху.")

		addButton("Продолжить", "Смотреть, что будет дальше", "nolact_grope_act")
	if(state == "nolact_grope_act"):
		playAnimation(StageScene.BreastGroping, "grope", {npc="tavi", npcBodyState={naked=true}})
		saynn("Тави удовлетворенно вздыхает. Самое время сделать ей легкий массаж.")

		saynn("Движимый любопытством, ты направляешь пальцы к {tavi.breasts} Тави и обхватываешь их ладонями, ощущая их вес, пока большие пальцы нежно поглаживают соски.")

		saynn("[say=tavi]A-..h..[/say]")

		saynn("Дыхание Тави на секунду перехватывает, когда твои действия разжигают в ней искру возбуждения. Её соски твердеют от твоих прикосновений, и она слегка прогибает спину, выпячивая грудь вперед.")

		saynn("[say=pc]Приятно, правда?[/say]")

		saynn("Не дожидаясь ответа, ты начинаешь разминать и мягко массировать её грудь, уделяя особое внимание соскам. Твои прикосновения мягкие и деликатные... но достаточно уверенные, чтобы попытаться стимулировать молочные железы Тави к выработке молока...")

		saynn("Камеру наполняют тихие стоны — тело Тави откликается на то, как ты ласкаешь её грудь. Ощущения пробегают по ней волнами, заставляя её бедра инстинктивно двигаться, а тело — прижиматься к твоему в поисках еще большего контакта.")

		if (!beganLactating):
			saynn("Несмотря на усилия, из сосков Тави не пробилось ни единой капли молока. Тем не менее, прогресс определенно есть: её грудь стала заметно чувствительнее.")

		else:
			saynn("От неожиданности у Тави вырывается короткий вздох. Из её сосков начинают капать маленькие капельки тёплого молока, оставляя за собой белые дорожки.")

			saynn("[say=tavi]Ах.. Что это..[/say]")

			saynn("[say=pc]У тебя лактация, Тави.[/say]")

			saynn("Похоже, твои старания окупились. [b]Соски Тави стимулировали настолько, что они начали вырабатывать молоко![/b]")

		saynn("После всего этого ты ещё немного обнимаешь Тави, помогая ей прийти в себя.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "nolact_suck"):
		playAnimation(StageScene.BreastFeeding, "tease", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Ты помогаешь Тави лечь на спину; на её лице читается смесь любопытства и предвкушения.")

		saynn("Мягко ты устраиваешься над ней, расстегивая её рубашку пуговицу за пуговицей. Тави с интересом наблюдает за тобой, а от твоих смелых действий она начинает слегка краснеть.")

		saynn("[say=pc]Я буду нежным.[/say]")

		saynn("[say=tavi]Настолько нежным, насколько захочешь..[/say]")

		saynn("Наконец, ты обнажаешь пышную грудь Тави. Она прикусывает губу и слегка отводит взгляд, не в силах выдержать твой собственнический взор. Сначала она снова скрещивает руки под грудью... но это лишь заставляет её соски сильнее затвердеть. Тебе не терпится начать.")

		addButton("Присосаться", "Начинает лизать соски Тави", "nolact_suck_do")
	if(state == "nolact_suck_do"):
		playAnimation(StageScene.BreastFeeding, "feed", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Пришло время главного события. Ты наклоняешься ближе к её груди и слегка приоткрываешь рот. Твои губы касаются её левого соска, прежде чем язык начинает ритмично и чувственно вылизывать это чувствительное место. От этого Тави резко втягивает воздух, её соски твердеют, а тело отзывается легкой дрожью.")

		saynn("[say=tavi]Мм-м..[/say]")

		saynn("После этого твои губы смыкаются вокруг соска. И вот ты начинаешь не просто лизать, а сосать его. Пальцы Тави зарываются в твои волосы, поглаживая и мягко подталкивая тебя продолжать. Из её уст вырываются тихие, нежные стоны, пока ты подражаешь голодному котенку, жаждущему молока.")

		saynn("Твои исследования продолжаются на её правом соске. На этот раз ты знакомишься с Тави через легкие покусывания. Когда твои зубы находят этот маленький твердый сосок и нежно сжимают его, по телу Тави проносятся искры удовольствия, заставляя её выгнуться в спине и дышать всё чаще.")

		saynn("[say=tavi]Ах!..[/say]")

		if (!beganLactating):
			saynn("Ты продолжаешь сосать и покусывать соски Тави, вызывая у неё всё новые и новые волны наслаждения. Но, несмотря на усилия, из её груди не пробивается ни единой капли молока. Тем не менее, прогресс определённо есть: её грудь стала заметно чувствительнее.")

		else:
			saynn("От неожиданности у Тави вырывается короткий вздох. Из её сосков начинают капать маленькие капельки тёплого молока, оставляя за собой белые дорожки.")

			saynn("[say=tavi]Ах.. Что это..[/say]")

			saynn("[say=pc]У тебя лактация, Тави.[/say]")

			saynn("Похоже, твои старания окупились. [b]Соски Тави были достаточно стимулированы, чтобы начать вырабатывать молоко![/b] И, конечно же, ты снова приникаешь к её соскам, чтобы попробовать молоко на вкус. Оно теплое, с приятным сладковатым послевкусием... но сейчас ты можешь собрать лишь немного. Лучше дать её железам наполниться получше.")

		saynn("После всего этого ты ещё немного обнимаешь Тави, помогая ей прийти в себя.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "nolact_pump_pick"):
		saynn("Выбери, какой молокоотсос ты хочешь использовать на Тави.")

		addPumpButtons("nolact_pump")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "nolact_pump")
	if(state == "nolact_pump"):
		playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
		saynn("Щеки Тави заливаются румянцем, когда она видит в твоих руках набор молокоотсосов.")

		saynn("[say=tavi]Но я не..[/say]")

		saynn("[say=pc]Все в порядке, Тави. Я делаю это не ради того, чтобы по-настоящему сцедить из тебя молоко.[/say]")

		saynn("Тави тихо кивает и расстегивает рубашку, выставляя напоказ свою {tavi.breasts}. Ты на мгновение замираешь, любуясь её формами, прежде чем осторожно приставить молокоотсосы к её нежным зеленым соскам, следя за тем, чтобы они плотно прилегали.")

		saynn("Пора их включать...")

		addButton("Помпы", "Включить", "nolact_pump_do")
	if(state == "nolact_pump_do"):
		playAnimation(StageScene.Cuddling, "squirm", {npc="tavi", npcBodyState={naked=true}})
		saynn("Ты переключаешь каждый молокоотсос на слабый режим и просто наблюдаешь.")

		saynn("Кошка глубоко вдыхает, когда устройства на её груди начинают мягко всасывать кожу, и её соски мгновенно твердеют от стимуляции.")

		saynn("[say=tavi]Они тянут... так приятно.[/say]")

		saynn("Пока насосы продолжают свои ритмичные движения, ты устраиваешься на кровати Тави и притягиваешь её к себе, чтобы обняться. Ты кладешь подбородок ей на плечо и смотришь вниз, на её твердые соски, которые тщетно подвергаются стягиванию... Но наблюдать за тем, как они светятся и набухают под неустанной стимуляцией, всё еще чертовски горячо.")

		saynn("[say=tavi]Нгх-х..[/say]")

		if (!beganLactating):
			saynn("Хотя от этого у Тави еще не пошло молоко, ты чувствуешь, что добился заметного прогресса. Её тело откликается на тренировки: грудь становится всё чувствительнее... а киска — всё более влажной.")

			saynn("Спустя некоторое время ты выключаешь насосы и осторожно снимаешь их с груди Тави, стараясь при этом успокоить её соски нежными поглаживаниями и ласками.")

		else:
			saynn("Кажется, спустя какое-то время тело Тави наконец поддается упорной стимуляции. Её накрывает внезапное ощущение тепла. Она тихо ахает, и её глаза широко распахиваются от удивления.")

			saynn("[say=tavi]Кажется, я..[/say]")

			saynn("Ты быстро понимаешь, что происходит, и выключаешь насосы. В пластиковых стаканчиках, которые раньше были пустыми, теперь виднеется несколько драгоценных капель молока — знак того, что [b]Тави начала лактировать[/b].")

			saynn("[say=pc]У тебя появилось молоко. Такая хорошая девочка.[/say]")

			saynn("Тави мурлычет и прижимается к тебе всем телом. Ты решаешь не перегружать её молочные железы и вместо этого аккуратно снимаешь насосы. Лучше дать её груди накопить больше молока перед следующим доением.")

		addButton("Продолжить", "Смотреть, что будет дальше", "removepumpandend")
	if(state == "lact_handmilking"):
		playAnimation(StageScene.BreastGroping, "tease", {npc="tavi", npcBodyState={naked=true}})
		saynn("Грудь Тави полна сладкого молока — настолько, что она начинает чувствовать легкий зуд. Так почему бы тебе не помочь ей?")

		saynn("Ты уютно устраиваешься на кровати Тави и притягиваешь её к себе, кладя руки на её рубашку и расстегивая пуговицы.")

		saynn("[say=tavi]Ты что...[/say]")

		saynn("[say=pc]Скоро увидишь. Поверь, тебе понравится.[/say]")

		saynn("Ты кладешь подбородок ей на плечо и смотришь вниз, видя её {tavi.breasts} во всей красе; её соски выглядят припухшими и имеют более темный оттенок, чем обычно. У Тави перехватывает дыхание от предвкушения, когда твои ладони ложатся на её грудь, а пальцы заставляют её тело пробирать дрожь.")

		saynn("Пора начинать...")

		addButton("Доить Тави", "Сжимать её грудь", "lact_handmilking_do")
	if(state == "lact_handmilking_do"):
		playAnimation(StageScene.BreastGroping, "grope", {npc="tavi", npcBodyState={naked=true}})
		saynn("И вот ты начинаешь осторожно разминать грудь Тави, с разной силой надавливая пальцами на разные точки. Тави закрывает глаза, когда волна ощущений начинает накрывать её.")

		saynn("Ты внимательно следишь за её реакцией, пока твои пальцы скользят к её темным ареолам, а затем слегка сжимают их, заставляя кошечку издать милый стон.")

		saynn("[say=tavi]Ах...[/say]")

		saynn("Наконец ты чувствуешь, как её тёплое молоко стекает по твоим пальцам. Маленькие струйки брызжут из её сосков, пока ты продолжаешь разминать и тискать её грудь. Кажется, Тави там, между ног, становится всё мокрее — она то и дело трется бедрами друг о друга.")

		saynn("[say=tavi]У меня течёт молоко...[/say]")

		saynn("Ты слизываешь немного молока с пальцев. Оно такое сладкое, что тебе невозможно наесться.")

		saynn("[say=pc]Да, это так.[/say]")

		saynn("Её дыхание учащается, когда твои прикосновения становятся всё смелее. Ты чередуешь нежные ласки с крепкими сжиманиями, выжимая всё больше и больше её сладкого нектара... которого, кажется, у неё предостаточно.")

		saynn("Но нужно же когда-то остановиться. Спустя несколько минут дойки Тави, ты начинаешь замедляться.")

		saynn("[say=tavi]Ты останавливаешься?..[/say]")

		saynn("[say=pc]Ага, не хочу тебя слишком сильно изматывать.[/say]")

		saynn("[say=tavi]...почему нет?[/say]")

		saynn("Хмм...")

		addButton("Хватит", "Дойка окончена", "lact_handmilking_enough")
		addButton("Доить больше", "Выдоить Тави до последней капли", "lact_handmilking_more")
	if(state == "lact_handmilking_enough"):
		playAnimation(StageScene.BreastGroping, "tease", {npc="tavi", npcBodyState={naked=true}})
		saynn("Вы целуете Тави в шею и даете ей попробовать её собственное молоко.")

		saynn("[say=pc]Потому что от этого у тебя всё разболится.[/say]")

		saynn("Кошка слизывает молоко и мурлычет, словно довольный котенок.")

		saynn("[say=tavi]Справедливо.[/say]")

		saynn("И вот вы проводите время, просто обнимаясь; грудь Тави кажется уже не такой тяжелой, как прежде.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lact_handmilking_more"):
		saynn("В самом деле, почему бы и нет. Если Тави просит добавки, она её получит. Но только если будет слушаться.")

		saynn("[say=pc]Попробуй попросить получше.[/say]")

		saynn("Сначала Тави наклоняет голову набок. Но видя, что ваши руки не двигаются, она фыркает.")

		saynn("[say=tavi]Пожалуйста, не останавливайся?..[/say]")

		saynn("Это уже что-то..")

		saynn("[say=tavi]Выдои мои сиськи досуха.. Выжми из них всё молоко до последней капли..[/say]")

		saynn("Ого. Ты не теряешь времени даром. Твои руки снова возвращаются к набухшей груди Тави, разминая и сжимая её ещё сильнее, чем прежде, каким-то образом находя в ней ещё больше молока. Кошка стонет и извивается под твоими уверенными прикосновениями, а её тело дрожит от этого странного рода наслаждения.")

		saynn("[say=tavi]Какая же я шлюха.."+str(" Pregnant and being milked.." if getCharacter("tavi").isVisiblyPregnant() else "")+"[/say]")

		saynn("И вот её молоко течёт всё свободнее, наполняя комнату сладким ароматом, который смешивается с запахом её возбуждения. Кажется, что процесс дойки и унижения с каждой секундой подталкивает её всё ближе и ближе к самому краю.")

		saynn("[say=pc]Шлюха с огромными лактирующими вымями.[/say]")

		saynn("Ты внимательно наблюдаешь за тем, как Тави приближается к оргазму. Её стоны становятся невероятно страстными, когда ты сжимаешь оба её набухших соска, вызывая маленькие фонтанчики молока... и тут это случается.")

		saynn("[say=tavi]Блядь.. д-да..[/say]")

		saynn("Мощный оргазм прошибает Тави, её тело судорожно извивается под твоими руками, а киска заливает кровать прозрачными соками. Внутри неё накопилось столько давления... Грудь Тави извергает всё произведённое молоко... пока не остаётся совсем ничего... на данный момент.")

		saynn("Кошечка осталась дрожать, задыхаясь, а её простыни выглядели мокрыми от обоих — и от её грудного молока, и от девичьей кончины.")

		saynn("[say=tavi]Это было так охеренно приятно..[/say]")

		saynn("[say=pc]Скоро тебе захочется еще.[/say]")

		saynn("[say=tavi]Наверное..[/say]")

		saynn("Тави отдыхает в твоих объятиях, её воспаленные соски заметно покраснели.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lact_breastfeeding"):
		playAnimation(StageScene.BreastFeeding, "tease", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Почему-то ты начинаешь чувствовать настоящий.. голод.. просто глядя на грудь Тави. Её молочные железы, должно быть, уже наполнились до краев.. Настолько, что соски начинают зудеть. Так почему бы не решить обе проблемы разом?")

		saynn("Ты приглашаешь свою питомицу лечь на кровать и садишься рядом, протягивая руки к её рубашке и медленно расстегивая пуговицы.")

		saynn("[say=tavi]Ты что собираешься..[/say]")

		saynn("[say=pc]Доверься мне.[/say]")

		saynn("Когда ты обнажаешь её {tavi.breasts}, она краснеет и пытается прикрыться, пряча свои набухшие соски, которые стали заметно темнее обычного. На её лице читается смесь предвкушения и желания, поэтому она не сопротивляется, когда ты осторожно убираешь её лапки от груди.")

		saynn("Во рту сразу становится влажно, стоит лишь увидеть одинокие капли молока, стекающие по её соскам. Твои руки нежно обхватывают её ноющие груди. Пора..")

		addButton("Сосать", "Сосать соски Тави", "lact_breastfeeding_do")
	if(state == "lact_breastfeeding_do"):
		playAnimation(StageScene.BreastFeeding, "feed", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Тави вздрагивает от неожиданности, когда ты прижимаешься к её груди. Но затем по её телу пробегает дрожь удовольствия, когда твои губы касаются одного из её сосков и обхватывают его. Ты начинаешь сосать его, пытаясь вытянуть сладкий нектар... и вскоре на твоём языке разливается вкус её кремового молока.")

		saynn("[say=tavi]Ах.. в-вау..[/say]")

		saynn("Ты жадно слизываешь её молоко, пока Тави выгибает спину, открывая тебе полный доступ к своей груди, а её лапа ложится тебе на голову, поглаживая волосы.")

		saynn("Но просто сосать мало: одна твоя рука блуждает по пушистому телу Тави, прежде чем нащупать грудь, которую ты сейчас пьешь, и начать её разминать... почти как котята делают с матерью. Дыхание Тави становится глубоким, когда всё больше её молока попадает тебе на язык.")

		saynn("[say=tavi]Хороший.. котенок..[/say]")

		saynn("Она что, только что назвала тебя так? Ну и ладно. Ты переходишь к другому соску и тоже начинаешь его сосать, время от времени слегка прикусывая его зубами, заставляя молоко брызгать струйками.")

		saynn("Тави больше не может сидеть смирно; она извивается под твоими прикосновениями, теряясь в эйфории. Она тихо стонет, а её рука всё сильнее и нежнее перебирает твои волосы.")

		saynn("Спустя некоторое время ты решаешь остановиться, отпускаешь сосок и облизываешь губы. Послевкусие великолепное — молоко Тави — это настоящее наслаждение.")

		saynn("[say=tavi]Тебе.. понравилось?[/say]")

		saynn("[say=pc]Очевидно.[/say]")

		saynn("[say=tavi]Тогда.. почему мы остановились?..[/say]")

		saynn("Тави сжимает одну из своих грудей, из-за чего вокруг ареол и сосков брызжет еще больше струек молока.")

		saynn("То, как она на тебя смотрит.. кажется, будто она хочет заботиться о тебе.. вскармливать тебя.")

		addButton("Хватит", "Ты бы не хотел причинять Тави боль", "lact_breastfeeding_enough")
		addButton("Еще", "Почему бы не позволить ей покормить тебя еще?", "lact_breastfeeding_more")
	if(state == "lact_breastfeeding_enough"):
		playAnimation(StageScene.BreastFeeding, "tease", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("[say=pc]Я бы не хотел слишком сильно тебя давить.[/say]")

		saynn("Тави издает тихий вздох и понимающе кивает.")

		saynn("[say=tavi]Наверное, ты прав.[/say]")

		saynn("Слить молоко из её груди можно и в другой раз.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lact_breastfeeding_more"):
		playAnimation(StageScene.BreastFeeding, "teasealt", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Ну, раз Тави сама предлагает, почему бы и нет. Но как только ты снова начинаешь тянуться к её соскам, она внезапно останавливает тебя.")

		saynn("[say=tavi]Можно мне... можно мне побыть твоей мамочкой?.. Только сейчас..[/say]")

		saynn("Это... любопытное предложение. Похоже, Тави это чертовски нравится.")

		saynn("Почему бы и нет? В этом нет ничего плохого. Стоит тебе кивнуть, как Тави внезапно берет всё в свои руки: она заставляет тебя лечь на кровать, а сама усаживается сверху, глядя на тебя нежным, полным обожания взглядом.")

		saynn("[say=tavi]Не бойся..[/say]")

		saynn("Теперь её грудь прямо перед твоими глазами — полностью обнаженная, блестящая от капелек молока, медленно стекающих по соскам.")

		saynn("[say=tavi]Просто позволь мне позаботиться о тебе..[/say]")

		saynn("Нежным движением Тави берет твою голову в свои ладони, медленно поднося её к своим темно-зеленым соскам.")

		addButton("Сосать", "Позволить Тави выкормить тебя грудью", "lact_breastfeeding_mommy")
	if(state == "lact_breastfeeding_mommy"):
		playAnimation(StageScene.BreastFeeding, "feedalt", {pc="tavi", npc="pc", bodyState={naked=true}})
		saynn("Тебе не нужно лишних приглашений: твои губы находят один из её сочных сосков, а язык начинает танцевать по чувствительной плоти. Ты посасываешь сосок, и вскоре снова начинаешь чувствовать вкус её сладкого молока.")

		saynn("[say=tavi]Хорошо.. продолжай..[/say]")

		saynn("Её голос звучит нежно и любяще, пока она ласково поглаживает тебя и мурлычет на ухо. Твои ладони обхватывают её грудь снизу, разминая её и ускоряя приток молока.")

		saynn("[say=tavi]Такой милашка..[/say]")

		saynn("Она перестает мурлыкать и вместо этого начинает тихонько напевать успокаивающую мелодию. Нельзя отрицать, что это.. приятно.. — когда о тебе кто-то заботится. Тави тоже это чувствует.. погоди.. Она что.. плачет?.. По её щекам скатываются несколько слезинок, пока она кормит тебя. Похоже, этот момент стал для неё очень эмоциональным.")

		saynn("Ты продолжаешь посасывать её грудь, иногда переходя с одного соска на другой. Спустя несколько минут поток молока наконец начинает замедляться. Когда ты отрываешься от её груди, она поспешно смахивает слезы.")

		saynn("[say=tavi]Оу. Тебе понравилось?[/say]")

		saynn("Ты тихо киваешь, и Тави нежно целует тебя в лоб.")

		saynn("[say=tavi]Мне тоже.. Наверное, слишком сильно..[/say]")

		saynn("Это было.. так душевно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lact_pump_pick"):
		saynn("Выбери, какой молокоотсос ты хочешь использовать на Тави.")

		addPumpButtons("lact_pump")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "lact_pump")
	if(state == "lact_pump"):
		playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
		saynn("Даже сквозь рубашку заметны впечатляющие соски Тави. Сейчас они, должно быть, тяжелые от молока, поэтому ты решаешь помочь ей избавиться от этой ноши самым эффективным способом.")

		saynn("Но когда ты достаешь набор молокоотсосов, она густо краснеет.")

		saynn("[say=tavi]Я не...[/say]")

		saynn("[say=pc]Не корова? Но будет весело. Поверь мне.[/say]")

		saynn("Тави на мгновение избегает твоего взгляда, о чем-то задумавшись. Но тяжесть и зуд в груди заставляют её принять твою сторону. Тави начинает расстегивать рубашку, выставляя свои {tavi.breasts} напоказ.")

		saynn("И вот ты осторожно прикладываешь каждый молокоотсос к её налитым темным соскам; присоски легко присасываются, выкачивая воздух и создавая отрицательное давление.")

		saynn("Тави смотрит на них своими милыми глазками, не зная, как реагировать на то, что её собираются использовать вот так.")

		saynn("Пора включать.")

		addButton("Помпы", "Включить молокоотсосы", "lact_pump_on")
	if(state == "lact_pump_on"):
		playAnimation(StageScene.Cuddling, "squirm", {npc="tavi", npcBodyState={naked=true}})
		saynn("Ты щелкаешь переключателями, и приборы оживают с тихим гулом. У Тави перехватывает дыхание, когда она начинает чувствовать ритмичное всасывание. Молока пока нет, но по тому, как натягиваются её соски, легко понять, с какой силой работают насосы.")

		saynn("Она едва держится на ногах, поэтому ты притягиваешь её к себе, чтобы обняться и попытаться отвлечь от её тяжелых мыслей.")

		saynn("[say=pc]Видишь? Всё не так уж плохо.[/say]")

		saynn("[say=tavi]Ммм-ммм.. м-м.. ах..[/say]")

		saynn("Тави тихо стонет в твоих объятиях, пока из её темно-зелёных сосков начинает сочиться молоко. По всей ареоле проступают маленькие белые капли, которые затем стекают по её чувствительной коже и собираются в аккуратную бутылочку.")

		saynn("[say=pc]Хорошо.. Чем меньше ты беспокоишься, тем вкуснее будет молоко.. Так что постарайся не переживать..[/say]")

		saynn("Ты кладешь голову ей на плечо и наблюдаешь за тем, как молокоPump медленно вытягивает жидкость из её округлых грудей. В это время твои руки ложатся ей на"+str(" pregnant" if getCharacter("tavi").isVisiblyPregnant() else "")+"живот и нежно поглаживают его.")

		saynn("[say=tavi]Ах-х.. х-х..[/say]")

		saynn("[say=pc]Тебе даже не нужно особо думать.. Просто сиди здесь.. И наслаждайся тем, что ты послушная коровка.. Приятно, правда?[/say]")

		saynn("По мере того как молоко продолжает выкачиваться из груди Тави, её стоны становятся всё более милыми. Она явно возбуждена и трет бедра друг о друга. Её тело извивается, прижимаясь к тебе. Поскольку она так и не ответила на твой вопрос, ты подносишь губы к самому её уху и шепчешь, в то время как твои руки так и норовят выключить насосы.")

		saynn("[say=pc]Приятно, коровка?[/say]")

		saynn("[say=tavi]Д-да.. х.. х.. П-пожалуйста..[/say]")

		saynn("Похоже, она уже близко. Хочешь подстегнуть её или остановиться и заставить её помучиться от нереализованного желания?")

		addButton("Хватит", "На этот раз дойки достаточно", "lact_pump_enough")
		addButton("Доить больше", "Дать насосам выкачать из Тави всё до последней капли", "lact_pump_more")
	if(state == "lact_pump_enough"):
		saynn("Ты всё равно решаешь остановиться и выключаешь насосы.")

		saynn("[say=tavi]Хафф.. ффф..[/say]")

		saynn("[say=pc]Прости, Тави. Твои соски уже совсем садят.[/say]")

		saynn("Она ерзает в твоих объятиях, но не сопротивляется. Чувствительность, вероятно, постепенно возвращается к ней. Когда ты осторожно снимаешь насосы с её груди, она выгибает спину от резкого перепада давления.")

		saynn("[say=tavi]Ах...[/say]")

		saynn("[say=pc]Хорошая кошечка.[/say]")

		saynn("Ты даёшь кошечке заслуженный отдых.")

		addButton("Продолжить", "Смотреть, что будет дальше", "removepumpandend")
	if(state == "lact_pump_more"):
		saynn("И вот ты переключаешь насосы на максимальную мощность, давая им волю. Тихий гул, который они издавали, мгновенно сменяется отчетливыми звуками всасывания. Из груди Тави вырываются страстные стоны... а поток молока заметно усиливается.")

		saynn("[say=tavi]Ах!..[/say]")

		saynn("[say=pc]Расслабься, моя маленькая коровка. Не сдерживайся... Доить тебя так приятно... Так приятно, что ты ведь будешь мычать для меня, правда?[/say]")

		saynn("С блаженным выражением лица она начинает издавать тихое, низкое мычание, и её милый голосок смешивается с механическим шумом, заполняя комнату.")

		saynn("[say=tavi]Му-у-у...[/say]")

		saynn("Никакого сопротивления — Тави просто покоится в твоих руках... пока насосы вытягивают всё молоко из её груди. Её мычание сливается со стонами, она стремительно приближается к пику...")

		saynn("[say=pc]Кончай, как послушная коровка... Просто от того, что тебя доят...[/say]")

		saynn("Она запрокидывает голову и широко раскрывает губы, издавая громкое, протяжное мычание, в то время как её соски внезапно начинают брызгать молоком почти без остановки. Тело Тави сильно извивается, а её киска оставляет огромное мокрое пятно на простынях, состоящее целиком из её соков.")

		saynn("Даже после оргазма молокоотсосы продолжают свою работу, вытягивая каждую последнюю каплю сладкого молока Тави, пока её вымя не опустеет полностью.")

		saynn("[say=tavi]...му...[/say]")

		saynn("С последним удовлетворенным мычанием ты выключаешь насосы и позволяешь Тави расслабиться. Кажется, после этой сессии она совсем улетела в облака. Поэтому ты просто обнимаешь её и шепчешь ей на ушко всякие нежности.")

		saynn("[say=pc]Хорошая кошечка.. очень хорошая..[/say]")

		saynn("[say=tavi]Мяу..[/say]")

		saynn("В конце концов она приходит в себя.")

		addButton("Продолжить", "Смотреть, что будет дальше", "removepumpandend")
func taviSpeak(normalSpeak, corruptSpeak, pureSpeak):
	if(isCorrupt):
		return corruptSpeak
	if(isPure):
		return pureSpeak
	return normalSpeak

func addPumpButtons(go_id):
	var pumps = GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump)
	for pump in pumps:
		addButton(pump.getVisibleName(), pump.getVisibleDescription(), go_id, [pump])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "lact_handmilking"):
		processTime(2*60)

	if(_action == "lact_breastfeeding"):
		processTime(3*60)

	if(_action == "nolact_grope"):
		processTime(3*60)
		if(getFlag("TaviModule.Ch6TaviLastGropeHow", "") != "grope"):
			isEfficient = true
		setFlag("TaviModule.Ch6TaviLastGropeHow", "grope")

	if(_action == "nolact_suck"):
		processTime(3*60)
		if(getFlag("TaviModule.Ch6TaviLastGropeHow", "") != "suck"):
			isEfficient = true
		setFlag("TaviModule.Ch6TaviLastGropeHow", "suck")

	if(_action == "nolact_pump_pick"):
		if(getFlag("TaviModule.Ch6TaviLastGropeHow", "") != "pump"):
			isEfficient = true
		setFlag("TaviModule.Ch6TaviLastGropeHow", "pump")

	if(_action == "cancel_activity"):
		increaseFlag("TaviModule.Ch6Tiredness", -1)
		endScene()
		return

	if(_action == "nolact_grope_act"):
		processTime(18*60)
		var progress = getFlag("TaviModule.Ch6TaviLactationProgress", 0)
		if(isEfficient):
			progress += RNG.randi_range(20, 30)
		else:
			progress += RNG.randi_range(3, 10)
		setFlag("TaviModule.Ch6TaviLactationProgress", progress)
		if(progress >= 100 && RNG.chance(progress / 2)):
			beganLactating = true
			getCharacter("tavi").induceLactation()
			setFlag("TaviModule.Ch6TaviLactationProgress", 0)
		processTime(2*60)
		GM.pc.addSkillExperience(Skill.Milking, 10)

	if(_action == "nolact_suck_do"):
		processTime(18*60)
		var progress = getFlag("TaviModule.Ch6TaviLactationProgress", 0)
		if(isEfficient):
			progress += RNG.randi_range(20, 40)
		else:
			progress += RNG.randi_range(3, 10)
		setFlag("TaviModule.Ch6TaviLactationProgress", progress)
		if(progress >= 100 && RNG.chance(progress / 2)):
			beganLactating = true
			getCharacter("tavi").induceLactation()
			setFlag("TaviModule.Ch6TaviLactationProgress", 0)
		processTime(2*60)
		getCharacter("tavi").addEffect(StatusEffect.SoreNipplesAfterMilking)
		GM.pc.addSkillExperience(Skill.Milking, 20)

	if(_action == "nolact_pump"):
		var pump = _args[0]
		breastPumpID = pump.getUniqueID()
		GM.pc.getInventory().removeItem(pump)
		getCharacter("tavi").getInventory().forceEquipStoreOther(pump)

	if(_action == "nolact_pump_do"):
		processTime(18*60)
		var progress = getFlag("TaviModule.Ch6TaviLactationProgress", 0)
		if(isEfficient):
			progress += RNG.randi_range(50, 60)
		else:
			progress += RNG.randi_range(20, 30)
		setFlag("TaviModule.Ch6TaviLactationProgress", progress)
		if(progress >= 100 && RNG.chance(progress / 2)):
			beganLactating = true
			getCharacter("tavi").induceLactation()
			setFlag("TaviModule.Ch6TaviLactationProgress", 0)
		processTime(2*60)
		getCharacter("tavi").addEffect(StatusEffect.SoreNipplesAfterMilking)
		GM.pc.addSkillExperience(Skill.Milking, 20)

	if(_action == "removepumpandend"):
		var pump = getCharacter("tavi").getInventory().getItemByUniqueID(breastPumpID)
		if(pump != null):
			getCharacter("tavi").getInventory().removeEquippedItem(pump)
			GM.pc.getInventory().addItem(pump)
		endScene()
		return

	if(_action == "lact_handmilking_do"):
		processTime(10*60)
		var milkAmount = getCharacter("tavi").milk(RNG.randf_range(0.2,0.3))
		GM.pc.addSkillExperience(Skill.Milking, 20)
		
		addMessage("You milked Tavi for "+str(Util.roundF(milkAmount, 1))+" ml of milk")

	if(_action == "lact_handmilking_enough"):
		processTime(2*60)
		getModule("TaviModule").addCorruption(-2)

	if(_action == "lact_handmilking_more"):
		processTime(10*60)
		var milkAmount = getCharacter("tavi").milk()
		GM.pc.addSkillExperience(Skill.Milking, 10)
		
		addMessage("You milked Tavi for "+str(Util.roundF(milkAmount, 1))+" ml of milk")
		getModule("TaviModule").addCorruption(2)

	if(_action == "lact_breastfeeding_do"):
		processTime(10*60)
		GM.pc.breastFedBy("tavi", 0.4)
		GM.pc.addPain(-100)
		GM.pc.addStamina(100)
		GM.pc.addSkillExperience(Skill.Milking, 10)

	if(_action == "lact_breastfeeding_enough"):
		processTime(2*60)
		getModule("TaviModule").addCorruption(-2)

	if(_action == "lact_breastfeeding_more"):
		processTime(2*60)

	if(_action == "lact_breastfeeding_mommy"):
		processTime(10*60)
		getModule("TaviModule").addCorruption(2)
		GM.pc.breastFedBy("tavi")
		GM.pc.addPain(-100)
		GM.pc.addStamina(100)
		GM.pc.addSkillExperience(Skill.Milking, 10)

	if(_action == "lact_pump"):
		var pump = _args[0]
		breastPumpID = pump.getUniqueID()
		GM.pc.getInventory().removeItem(pump)
		getCharacter("tavi").getInventory().forceEquipStoreOther(pump)

	if(_action == "lact_pump_on"):
		processTime(6*60)
		var pump = getCharacter("tavi").getInventory().getItemByUniqueID(breastPumpID)
		getCharacter("tavi").stimulateLactation()
		var howMuchTransferred = getCharacter("tavi").getBodypart(BodypartSlot.Breasts).getFluids().transferTo(pump, 0.6)
		addMessage("The pump managed to milk Tavi's breasts for "+str(Util.roundF(howMuchTransferred))+" ml")
		GM.pc.addSkillExperience(Skill.Milking, 30)
		getCharacter("tavi").addEffect(StatusEffect.SoreNipplesAfterMilking)
		getCharacter("tavi").updateAppearance()

	if(_action == "lact_pump_enough"):
		processTime(2*60)
		getModule("TaviModule").addCorruption(-2)

	if(_action == "lact_pump_more"):
		processTime(6*60)
		var pump = getCharacter("tavi").getInventory().getItemByUniqueID(breastPumpID)
		getCharacter("tavi").stimulateLactation()
		var howMuchTransferred = getCharacter("tavi").getBodypart(BodypartSlot.Breasts).getFluids().transferTo(pump, 1.0)
		addMessage("The pump managed to milk Tavi's breasts for "+str(Util.roundF(howMuchTransferred))+" ml")
		GM.pc.addSkillExperience(Skill.Milking, 10)
		getCharacter("tavi").addEffect(StatusEffect.SoreNipplesAfterMilking)
		getCharacter("tavi").updateAppearance()
		getModule("TaviModule").addCorruption(2)

	setState(_action)

func saveData():
	var data = .saveData()

	data["isCorrupt"] = isCorrupt
	data["isPure"] = isPure
	data["isNormal"] = isNormal
	data["isVirgin"] = isVirgin
	data["hasMark"] = hasMark
	data["hasMilk"] = hasMilk
	data["isEfficient"] = isEfficient
	data["beganLactating"] = beganLactating
	data["breastPumpID"] = breastPumpID

	return data

func loadData(data):
	.loadData(data)

	isCorrupt = SAVE.loadVar(data, "isCorrupt", false)
	isPure = SAVE.loadVar(data, "isPure", false)
	isNormal = SAVE.loadVar(data, "isNormal", false)
	isVirgin = SAVE.loadVar(data, "isVirgin", false)
	hasMark = SAVE.loadVar(data, "hasMark", false)
	hasMilk = SAVE.loadVar(data, "hasMilk", false)
	isEfficient = SAVE.loadVar(data, "isEfficient", false)
	beganLactating = SAVE.loadVar(data, "beganLactating", false)
	breastPumpID = SAVE.loadVar(data, "breastPumpID", "")
