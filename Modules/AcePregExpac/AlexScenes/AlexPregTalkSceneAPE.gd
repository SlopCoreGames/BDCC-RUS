extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AlexPregTalkSceneAPE"

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})
		
		saynn("Что ты хочешь сказать Алексу?")
		
		if(GM.pc.isVisiblyPregnant() && (getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1))):
			if(GM.pc.isPregnantFrom("alexrynard")):
				addButton("Станешь отцом", "Сказать Алексу, что он станет отцом", "alexfatherreveal")
			else:
				addDisabledButton("Станешь отцом", "Ты не беременна от него")
#less clutter on the button screen
		
		if(GM.pc.isVisiblyPregnant() && (!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1))):
			addButton("Обнимашки", "Получить эмоциональную поддержку от Алекса", "alexpregcuddle")
		elif(!GM.pc.isVisiblyPregnant()):
			addDisabledButton("Обнимашки", "Ты не беременна")
		
		if((!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1))):
			addButton("Перекусить?", "Алекс — сотрудник, у него наверняка найдется что-нибудь съедобное. Пусть даже совсем чуть-чуть.", "AlexSnackStart")
		
		if(GM.pc.isLactating() && (!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 0)) && !GM.pc.hasEffect(StatusEffect.SoreNipplesAfterMilking)):
			addButton("Молоко", "Попробовать, поможет ли Алекс сцедить твою грудь.", "AlexPCMilking")
		elif(GM.pc.hasEffect(StatusEffect.SoreNipplesAfterMilking)) && (!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1)):
			addDisabledButton("Молоко", "Соски болят, дай им отдохнуть.")
		elif(!GM.pc.isLactating()) && (!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1)):
			addDisabledButton("Молоко", "Тебя нельзя сцедить")
#
#		if(GM.pc.isReadyToGiveBirth() && (!getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1))):
#			addButton("Роды", "Взять Алекс с собой, чтобы она помогла тебе при родах", "StartBirthAlex")
#		elif(!GM.pc.isReadyToGiveBirth() && (getModuleFlag("AcePregExpac", "Alex_ToldIsFather", 1))):
#			addDisabledButton("Роды", "Ты еще не готова рожать.")
#		else:
#			addDisabledButton("мод сломался", "скрипт сломался")
#		addButton("Уйти", "У тебя ничего не было", "endthescene")

		addButton("Проехали", "Назад в главное меню разговора", "returntonormal")
#ACEPREGEXPAC
#if someone has breedable Alex mod I added a little thing
#maybe like 7 people will find it but if it gets them by surprise then it was worth it.
#Fucking *with* people can be just as fun as fucking them regularly
#I wanna do a thing with worldbuilding where if you do alex's storyline changes the talk scenes and that'll conflict with this, but we'll get to that when we do
		if(getCharacter("alexrynard").isVisiblyPregnant()):
				addButton("Он что, беременный?", "Ты почти уверен, что это что-то новенькое.", "pregnancysecret")
	
	if(state == "alexfatherreveal"):
		playAnimation(StageScene.Hug, "hug", {pc="alexrynard", npc="pc"})
		
		saynn("Ну, тогда лучше сказать ему прямо сейчас.")
		
		saynn("[say=pc]Эй, Алекс?[/say]")
		
		saynn("Алекс что-то мямлит в ответ и поворачивается к тебе.")
		
		saynn("[say=pc]Тебе стоит знать... Ты станешь отцом...[/say]")
		
		saynn("Глаза Алекса округляются от шока.")
		
		saynn("[say=alexrynard]Погоди, серьезно?![/say]")
		
		saynn("Ты киваешь, демонстрируя ему свой живот.")
		
		saynn("Алекс просто стоит, застыв в полушоке с приоткрытым ртом. Он лихорадочно всматривается в тебя, пытаясь уловить хоть малейший признак лжи. Но не находит его.")
		
		saynn("Не зная, как повести себя в этой тишине, ты подходишь к нему вплотную и кладешь руку ему на плечо.")
		
		saynn("[say=pc]Ты в порядке?[/say]")
		
		saynn("[say=alexrynard]Да, я просто...[/say]")
		
		saynn("[say=alexrynard]Рожать детей в тюрьме посреди чертовой пустоты — это невероятно безрассудно...[/say]")
		
		saynn("[say=alexrynard]Я просто никогда не думал...[/say]")
		
		saynn("Нервно переминаясь с ноги на ногу, Алекс со вздохом качает головой.")
		
		saynn("[say=alexrynard]Из меня вышел бы паршивый отец.[/say]")
		
		saynn("[say=pc]И я даже не смогу увидеть своих детей...[/say]")
		
		saynn("[say=alexrynard]Я тоже не смогу. У меня судимость. Я хожу без ошейника, но медсестры до сих пор ни разу не пускали меня в детскую.[/say]")
		
		saynn("[say=pc]Значит, мы в одной лодке.[/say]")
		
		saynn("Вы двое просто сидите в тишине какое-то время. Алекс обхватил голову руками, погрузившись в свои мысли.")
		
		saynn("[say=alexrynard]...Мне бы так не хотелось просто отдать своих детей в ясли... а там бог знает, куда их денут дальше...[/say]")
		
		saynn("Не зная, что сказать, вы просто подходите и обнимаете лиса. Он отвечает вам взаимностью.")
		
		saynn("[say=alexrynard]...Спасибо...[/say]")
		
		saynn("Он кладет голову вам на плечо, слова излишни. Затем вы высвобождаетесь из его объятий.")
		
		saynn("[say=pc]Что ты теперь будешь делать?[/say]")
		
		saynn("[say=alexrynard]Многое не решишь. Но... я не собираюсь оставлять тебя ни с чем. Я смогу поддерживать тебя, пока ты беременна, а дальше... не знаю... но я обязательно что-нибудь придумаю...[/say]")
		
		saynn("[say=pc]Это уже что-то...[/say]")
		
		saynn("Вы просто обнимаете друг друга, пока напряжение постепенно спадает.")
		
		saynn("В конце концов Алекс всё же возвращается в свою мастерскую, а предложение поддержать тебя всё ещё крутится у него в голове...")
		
		
		setModuleFlag("AcePregExpac", "Alex_ToldIsFather", 0)
		
		addButton("Продолжить", "Ну, могло быть и хуже...", "endthescene")

	if(state == "pregnancysecret"):
		saynn("[say=pc]Так, эм... Ты что... беременна?[/say]")
		
		saynn("[say=alexrynard]Ты про ту тяжесть, что давит и на мой разум, и на мой позвоночник? Ту самую, которую я пытаюсь игнорировать, чтобы не сойти с ума? Ту самую, которую ты мне, скорее всего, и подкинул, потому что пару лет назад я точно не помню, чтобы у меня была такая «чудесная» способность...[/say]")
		
		saynn("...")
		
		saynn("[say=alexrynard]Не-а.[/say]")
		
		addButton("Продолжить", ":)", "")

	if(state == "alexpregcuddle"):
		saynn("Ты подходишь к Алексу и ждешь подходящего момента, чтобы спросить.")

		saynn("[say=pc]Можно тебя немного потискать?[/say]")
		
		if (GM.pc.hasEffect(StatusEffect.CoveredInCum)):
			saynn("Алекс замечает, в каком ты беспорядке, и вздыхает.")

			saynn("[say=alexrynard]Сначала приведи себя в порядок. Ты вся какая-то грязная.[/say]")

			saynn("Пфф, какой облом. Похоже, сначала придется сходить в душ.")

			addButton("Ну и ладно", "Стоило попробовать", "endthescene")
		else:
			saynn("Алекс быстро оценивающим взглядом осматривает тебя и твой наряд, после чего кивает.")

			saynn("[say=alexrynard]Конечно. Пошли развлечемся.[/say]")
		
		addButton("Следовать", "Посмотреть, куда он тебя приведет", "cuddlestart")
		
		
#cuddle scene feels stoopid. idk how to put it but it do.
#I believe all the scenes I wrote are trash
#hopefully it's just the curse instead of actually just being terrible
	if(state == "cuddlestart"):
		aimCameraAndSetLocName("eng_breakroom")
		playAnimation(StageScene.Cuddling, "idle", {pc="alexrynard", npc="pc",bodyState={underwear=true}, npcBodyState={underwear=true}})
		saynn("Знакомая комната отдыха персонала. Здесь произошло столько всего...")
		
		saynn("[say=alexrynard]Сегодня не должно быть слишком много народу. Будем здесь одни...[/say]")
		
		saynn("Алекс откидывается на диване, раскинув руки, и приглашает тебя сесть между его ног.")
		
		saynn("Когда ты садишься, Алекс притягивает тебя к себе.")
		
		saynn("Ты прислоняешься к нему спиной, и его руки находят тебя: одна ложится на бедро, а другая проскальзывает под твою {pc.breasts}")
		
		saynn("Кажется, можно наконец расслабиться и забыть обо всем... Ты закрываешь глаза и выгибаешь спину.")
		
		saynn("[say=alexrynard]Эй, не забывай, что я здесь...[/say]")
		
		saynn("Ты лишь посмеиваешься и тянешься назад, чтобы ткнуть лисичку в носик.")
		
		saynn("Промах. Алекс может просто подвинуться, чтобы ты промахнулся. Не совсем честно, но ты и сам особо не стараешься, так что какая разница?")
		
		saynn("[say=pc]Ладно, хорошо...[/say]")
		
		saynn("Ты снова уютно устраиваешься в объятиях Алекса с наглой ухмылкой на лице, пока он кладет одну руку тебе на живот.")
		
		saynn("Когда тебя ничто не беспокоит и ты так расслаблен... время идет, ты уже почти засыпаешь... самое время вздремнуть.")
		
		if(RNG.chance(50) && GM.pc.isHeavilyPregnant()):
			saynn("[say=alexrynard]Кажется, я только что почувствовал, как оно шевельнулось...[/say]")
		elif(GM.pc.isHeavilyPregnant()):
			saynn("[say=alexrynard]Ума не приложу, как ты таскаешь всё это в себе целый день...[/say]")
		else:
			saynn("[say=alexrynard]Как ты держишься?[/say]")
		
		saynn("В ответ ты ничего не говоришь, лишь сильнее прижимаешься к телу Алекса, надеясь, что он поймет намек...")
		
		saynn("...")
		
		saynn("...")
		
		addButton("Сон", "Ззз...", "WakeUpScene")
		
	if(state == "WakeUpScene"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="alexrynard", npc="pc", bodyState={underwear=true}, npcBodyState={underwear=true}})
		saynn("...?")
		
		saynn("Когда ты просыпаешься, руки Алекса всё так же лениво покоятся на тебе... похоже, он последовал за тобой в твой сон...")
		
		saynn("Постепенно фокусируя взгляд, ты наконец замечаешь настенные часы. Прошло около 4 часов...")
		
		saynn("Ну... Бля... Ты уже проснулась... но Алекс такой теплый и уютный... так и не хочется вставать...")
		
		saynn("Ты пытаешься закрыть глаза и уснуть снова, но все эти мелкие раздражающие реалии жизни давят на разум. Например, полное отсутствие одеяла и то, как неудобно твой заключенный ошейник впивается тебе в шею...")
		
		saynn("...")
		
		saynn("Черт возьми.")
		
		saynn("С сожалением ты высвобождаешься из ленивых объятий спящего Алекса. Алекс же, в свою очередь, просто переворачивается на диване во сне, как только его бдительная миссия по обнимашкам завершена.")
		
		saynn("Хорошенько потянувшись, ты направляешься обратно к мастерской Алекса...")
		
		addButton("Продолжить", "Это было мило.", "endcuddle")
		
	
	if(state == "AlexSnackStart"):
		saynn("[say=pc]У тебя случайно не найдется чего-нибудь перекусить? Мне уже осточертела эта серая жижа в столовой.[/say]")
		
		saynn("[say=alexrynard]Только то, что в торговом автомате... Погоди, а зачем тебе?[/say]")
		
		saynn("[say=pc]Детям хочется еды получше...[/say]")
		
		if(!GM.pc.isVisiblyPregnant()):
			saynn("Алекс медленно обводит взглядом твое тело.")
			saynn("[say=alexrynard]Ты ведь даже не беременна.[/say]")
			saynn("[say=pc]...Ну пожалуйста?[/say]")
			saynn("Со вздохом Алекс молча открывает дверь и жестом приглашает тебя следовать за ним.")
			saynn("Он слишком привыкает к тебе...")
			saynn("Тебе даже не пришлось ничего выдумывать...")
		else:
			saynn("[say=alexrynard]Думаю, я смогу что-нибудь такое приготовить. Пошли.[/say]")
			saynn("Дверь в знакомую комнату отдыха открывается, и ты идешь следом с улыбкой, которая кажется слишком широкой для такого простого события.")
			
		addButton("Продолжить", "Наконец-то, блядь, нормальная еда.", "AlexSnacks")
	
	if(state == "AlexSnacks"):
		aimCameraAndSetLocName("eng_breakroom")
		playAnimation(StageScene.Duo, "sit", {pc="pc", npc="alexrynard",})
		saynn("Это снова та самая знакомая комната отдыха; ты занимаешь место за одним из столов в кухонной зоне, пока Алекс подходит к торговому автомату со снеками, притаившемуся в углу.")
		
		saynn("[say=alexrynard]Хочешь чего-нибудь конкретного?[/say]")
		
		saynn("Странно, ведь с тех пор как ты оказался в этой изолированной, приукрашенной консервной банке, тебе постоянно хотелось настоящей еды вместо серой слизи. Но теперь, когда ты здесь, ты даже не знаешь, чего именно. Выбор слишком велик...")
		
		saynn("[say=pc]Удиви меня.[/say]")
		
		saynn("Алекс кивает и выбирает что-нибудь для тебя, прикладывая свою ID-карту к автомату.")
		
		saynn("[say=pc]Разве этот автомат не принимает обычные деньги, а не тюремные кредиты?[/say]")
		
		saynn("[say=alexrynard]Вообще-то принимает, но мы взломали эту хреновину давным-давно. Теперь он работает просто по ID.[/say]")
		
		saynn("Схватив перекус, он подходит к тебе и протягивает его.")
		
		saynn("Даже как-то грустно, что ты так радуешься обычному перекусу... Ну да ладно. Халявная еда — это всегда хорошо.")
		
		addButton("Продолжить", "Смотри, что у меня есть.", "snacks_random")
		
	if(state == "snacks_random"):
		if(RNG.chance(25)):
			saynn("Это шоколадный батончик. Глазам не верится, но это правда. Он прямо перед тобой.")
			
			saynn("Ты смотришь на Алекса, пытаясь понять, не розыгрыш ли это, но его неловкий взгляд подтверждает: он и вправду отдает его тебе.")
			
			saynn("Забирая батончик, ты начинаешь разворачивать его, толком не заботясь о том, какой там шоколад. На данном этапе жизни тебе будет плевать, даже если там куча орехов.")
			
			saynn("Для заключенной вкус просто божественный. Ты пытаешься смаковать каждый кусочек, но тело словно живет своей жизнью, заставляя тебя поглощать его слишком быстро.")
			
			saynn("Не успеваешь оглянуться, как он исчез. Несмотря на всепоглощающую печаль, ты кладешь голову на стол с сияющей улыбкой — ведь сахар здесь такая редкая роскошь.")
			
			saynn("[say=alexrynard]Вижу, тебе понравилось.[/say]")
			
			saynn("[say=pc]Это было лучшее, что у меня было за всю неделю.[/say]")
			
			saynn("Алекс протягивает руку и несколько раз похлопывает тебя по спине.")
			
			saynn("[say=alexrynard]Ну, мне пора возвращаться. Ты знаешь, где выход и где меня искать.[/say]")
			
			saynn("Лисица направляется обратно в коридор, а ты просто откидываешься на спинку стула,"+str(" holding your pregnant belly" if GM.pc.isVisiblyPregnant() else "")+" с признаться, глупой улыбкой на лице, а на языке всё ещё ощущается фантомный привкус сахара.")
			
			saynn("Тебе нужно будет сделать что-нибудь приятное для этой лисицы, когда представится случай...")
			
		#I had an idea and then I lost it so fuck it this one sucks i guess
		elif(RNG.chance(50)):
			saynn("Это пачка чипсов; марка тебе незнакома, но ты уверен, что они такие же, как все остальные.")
			
			saynn("Алекс садится рядом, пока ты открываешь пачку и откусываешь кусочек.")
			
			saynn("На самом деле довольно вкусно; ты принимаешься за следующие три, пока Алекс потягивает воду.")
			
			saynn("[say=alexrynard]Полагаю, тебе нравится?[/say]")
			
			saynn("[say=pc]Больше, чем ты можешь себе представить.[/say]")
			
			saynn("Лисица прижимается к тебе всем телом, пока ты уплетаешь чипсы.")
			
			saynn("[say=alexrynard]Нам нужно устроить еще один такой киновечер.[/say]")
			
			saynn("[say=pc]Согласна.[/say]")
			
			saynn("Ты доедаешь пачку чипсов, прижавшись к Алексу.")
			
			saynn("В конце концов Алекс возвращается в свою мастерскую, а ты решаешь не идти за ним.")
			
		else:
			saynn("Это обычный питательный батончик. Из тех, что люди покупают для удовольствия, а не те безвкусные брикеты массового производства, что пылятся в коробках на кораблях на случай голода.") 
			
			saynn("Да к черту всё, ты его берешь.")
			
			saynn("Лис садится рядом, пока ты возишься с упаковкой и откусываешь кусочек.")
			
			saynn("Вкус довольно пресный, но всё равно в разы лучше столовской пасты. Этого достаточно, чтобы пробудить воспоминания о временах до твоего заключения.")
			
			saynn("В основном это были медленные, рутинные периоды, когда ты ничем особо не занималась.")
			
			saynn("Их было немного, но ты была [b]свободна[/b].")
			
			saynn("Ты так погрузилась в свои мысли, что даже не заметила, как уплела этот маленький батончик.")
			
			saynn("Ты чувствуешь руку Алекс на своей спине.")
			
			saynn("[say=alexrynard]Ты в порядке? Не думала, что ты можешь так зависнуть над обычным энергетическим батончиком...[/say]")
			
			saynn("[say=pc]Да так... Просто вспоминаю то, как это — быть на свободе. Наверное.[/say]")
			
			saynn("[say=alexrynard]Простые радости... Ладно, мне пора возвращаться к работе. Оставлю тебя предаваться воспоминаниям. Выход ты знаешь.[/say]")
			
			saynn("Лис делает, как и обещал, и выходит через открытую дверь обратно в свою мастерскую.")
		
		addButton("Продолжить", "Это было приятно.", "snacks_ending")
	
#debating adding a partial stamina recharge like eating in the cafeteria
#I cant figure it out without the player just repeating it infinitely for free stamina
#Im a lazy programmer if I even program at all
	if(state == "snacks_ending"):
		removeCharacter("alexrynard")
		saynn("Тебе остается сидеть в комнате отдыха в одиночестве еще минуту, чтобы прийти в себя.")
		
		saynn("Когда ты готова, ты встаешь из-за стола и потягиваешься.")
		
		if(GM.pc.isHeavilyPregnant()):
			saynn("Внутри твоего беременного живота что-то шевелится. И продолжает двигаться, пока ты растягиваешься.")
			
			saynn("Прижимая руки к животу, ты пытаешься устроиться поудобнее, пока всё внутри постепенно успокаивается.")
			
			saynn("[say=pc]По крайней мере, перекус тебе понравился...[/say]")
			
			saynn("Ну что ж, пора возвращаться к повседневной рутине.")
		
		elif(GM.pc.isVisiblyPregnant()):
			saynn("Твои руки невольно скользят к округлившемуся животу, поправляя его, чтобы найти более удобное положение.")
			
			saynn("Похоже, особого толку это не принесло, но, по крайней мере, тебе стало полегче.")
			
			saynn("Ну что ж, пора возвращаться к повседневной рутине.")
		
		else:
			saynn("Хорошая разминка спины помогает окончательно вернуться в реальность.")
			
			saynn("Ну что ж, пора возвращаться к повседневной рутине.")
	
		addButton("Продолжить", "Погнали дальше.", "leavebreakroom")
	
	
	if(state == "AlexPCMilking"):
		if(getModuleFlag("AcePregExpac", "Alex_TimesMilkingPlayer", "0")):
			saynn("Это будет непросто: похоже, Алекс не в восторге от лактации.")
			
			saynn("Ты не совсем понимаешь, как к нему подступиться с этим вопросом...")
			
			saynn("[say=pc]Эй, Алекс, как думаешь, ты мог бы мне помочь?[/say]")
			
			saynn("Лис едва отрывает взгляд от того, над чем сейчас работает.")
			
			saynn("[say=alexrynard]А... Ну да, что такое?[/say]")
			
			if(GM.pc.isVisiblyPregnant()):
				saynn("[say=pc]Из-за этой беременности у меня началось молоко, и грудь от этого жутко ноет. Думаешь, ты мог бы мне помочь?[/say]")
			else:
				saynn("[say=pc]У меня началось молоко, и мне не помешала бы помощь, чтобы с этим справиться.[/say]")
			
			saynn("Этот вопрос застает лиса врасплох; он начинает неуклюже возиться, и отвертка выскальзывает из его рук, срывая резьбу.")
			
			saynn("[say=alexrynard]ОХ, я... э-э...[/say]")
			
			saynn("Алекс проверяет, не сломалось ли что-нибудь, а затем поворачивается к тебе.")
			
			saynn("[say=alexrynard]Слушай, тебе лучше попросить об этом Элизу.[/say]")
			
			saynn("[say=alexrynard]Меня не особо прет лактация, так что я понятия не имею, что с этим делать.[/say]")
			
			saynn("По его взгляду понятно: убедить его не получится, по крайней мере, пока что.")
			
			addMessage("This content isn't done. Sorry about that -Ace")
			
			increaseModuleFlag("AcePregExpac", "Alex_TimesMilkingPlayer", 1)
			
			addButton("Блин, блин.", "Пора идти", "endthescene")
#
# ACEPREGEXPAC - I want a slow build for this scene, but dont have the time to code it all down before I release the patch
# kinda like how you have to bother Alex to build a relationship with him, you have to bother Alex to get him to try lactation stuff
# once the flag hits 20 or something, you get the tiddy suck scene.
#
#		addButton("Руки", "позволить Алексу доить тебя руками", "AlexHandMilk")
#
#		if(getModuleFlag("AcePregExpac", "Alex_FirstTimeMilkingPlayer", true)):
#			addButton("Рот", "позволить Алексу сосать твои сиськи", "AlexTitSuck")
#		else:
#			addDisabledButton("Рот", "Алекс не уверен насчет этого, может, сначала стоит попробовать что-то другое.")
#		addButtonWithChecks("Помпы", "Используй молокоотсос.", "AlexPumpMilk", [], [ButtonChecks.HasBreastPump])

#	if(state == "AlexHandMilk"):
#		saynn("placeholder")
#
#		addButton("Отладка","endthescene")
func _react(_action: String, _args):
	
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "returntonormal"):
		endScene()
		runScene("AlexRynardTalkScene")
		return

	if(_action == "endcuddle"):
		processTime(60*60*4)
		endScene()
		return
		
	if(_action == "leavebreakroom"):
		processTime(60*30)
		GM.pc.setLocation("eng_bay_nearbreakroom")
		endScene()
		return
		
	setState(_action)

func getDevCommentary():
	return "Hello fuckers. This isn't my first devlog but its the one most people are gonna see. Unfortunately I have forgotten most of my past rantings so you're gonna have to find the other dev commentary for them. So instead I will just leave it at 1. Alex is good boy and needs more love and 2. I am aware most of the content he isnt done. Give it time. While you wait Join the BDCC discord and ping me to tell me how much my writing sucks. Or is great. I mean you've probably seen my mod descriptions I couldn't get more insane. BDCC Skibidi Toilet Species Mod confirmed 37th of Febtoberuary."
