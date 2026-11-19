extends "res://Scenes/SceneBase.gd"

var bornChildAmount: int = 0
var bornChildString = ""
var receivedApple = false

func _init():
	sceneID = "NurseryTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["nurse"])):
		endScene()
		return
		
	if(GM.pc.hasPerk(Perk.FertilityProudMom) && !getFlag("MedicalModule.Nursery_hadFreeAppleFromPerkToday", false)):
		var theApple = GlobalRegistry.createItem("appleitem")
		theApple.setIsLegal(true)
		GM.pc.getInventory().addItem(theApple)
		addMessage("Вы получили яблоко")
		setFlag("MedicalModule.Nursery_hadFreeAppleFromPerkToday", true)
		receivedApple = true

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "sit", {pc = "nurse", npc="pc", npcAction="stand"})
		addCharacter("nurse")
		
	if(state == ""):
		if(!GM.main.getModuleFlag("MedicalModule", "Nursery_Introduced")):
			GM.main.setModuleFlag("MedicalModule", "Nursery_Introduced", true)
			
#			saynn("Вы подходите к медсестре, пытаясь привлечь её внимание. Она отрывает взгляд от экрана и смотрит на вас.")
			
			saynn("Вы подходите к столу медсестры; на маленькой именной табличке написано «Минетт».")

			saynn("[say=pc]Для чего эта комната?[/say]")

			saynn("Медсестра едва отрывается от работы за приёмным компьютером.")
			saynn("[say=nurse]Это детская, заключенная. Место для матерей из числа твоих сокамерниц.[/say]")
			saynn("Только тогда медсестра решает вас осмотреть, на мгновение встретившись с вами взглядом.")

			if(GM.pc.isHeavilyPregnant()):
				saynn("Затем она окидывает вас оценивающим взглядом и замечает ваш беременный живот.")
				saynn("[say=nurse]Да, тебе скоро тоже придется сюда приходить.[/say]")
				if(GM.pc.getInmateType() == InmateType.HighSec):
					saynn("[say=nurse]И, пожалуйста, сделай мне одолжение: не разгроми здесь всё, как это делают другие зэчки из Красного блока. Пожалуйста, и заранее спасибо.[/say]")
			elif(GM.pc.isVisiblyPregnant()):
				saynn("Затем она окидывает вас оценивающим взглядом и замечает ваш беременный живот.")
				
				saynn("[say=nurse]Для контрацепции ты уже опоздала, а для родов еще слишком рано. Загляни ко мне попозже.[/say]")
				if(GM.pc.getInmateType() == InmateType.HighSec):
					saynn("[say=nurse]И, пожалуйста, сделай мне одолжение: не разгроми здесь всё, как это делают другие зэчки из Красного блока. Пожалуйста, и заранее спасибо.[/say]")

			if(GM.pc.isReadyToGiveBirth()):
				saynn("Затем она окидывает вас оценивающим взглядом и замечает ваш беременный живот.")
				saynn("[say=nurse]Выглядишь так, будто вот-вот родишь. Если хочешь поскорее с этим покончить — только скажи.[/say]")
				if(GM.pc.getInmateType() == InmateType.HighSec):
					saynn("[say=nurse]И, пожалуйста, сделай мне одолжение: не разгроми здесь всё, как это делают другие зэчки из Красного блока. Пожалуйста, и заранее спасибо.[/say]")
			saynn("Ну что ж. Ты оглядываешься по сторонам. Это место больше похоже на вестибюль: у белых стен стоят несколько скамеек. Ты замечаешь кое-какие картинки, и все они явно нарисованы кем-то совсем юным. Помимо той двери, в которую ты вошла, здесь есть еще две.")

		else:
			var theMission3Out:String = GM.main.MS.getSpecificFlag("Mission3", "nurse", "")
			saynn("Ты снова подходишь к посту медсестры; на столе стоит всё та же табличка с именем «Минетт». Она отрывает взгляд от экрана и смотрит на тебя.")

			# (if player has the perk FertilityProudMom and didn't get an apple today)
			if(receivedApple):
				saynn("[say=nurse]О, привет! Твое имя в моем списке «хороших девочек». Я стараюсь, чтобы каждая мама из этого списка получала здесь хоть какие-то бонусы. На, держи.[/say]")
				saynn("Она достает откуда-то из-под стола свежее яблоко и протягивает тебе.")
			
			elif(GM.pc.isReadyToGiveBirth()):
				saynn("[say=nurse]Ты выглядишь готовой. Дай знать, если захочешь начать.[/say]")
			
			elif(GM.pc.isHeavilyPregnant()):
				saynn("[say=nurse]Пришла рожать?[/say]")
			
			# (if ready to give birth)
			elif(GM.pc.isVisiblyPregnant()):
				saynn("[say=nurse]Если нужна помощь с беременностью — обращайся.[/say]")
			
			#"letgo", "reward", "break"
			elif(theMission3Out == "letgo"):
				saynn("[say=nurse]О... привет. Тебе что-то нужно, заключенная?[/say]")
			elif(theMission3Out == "reward"):
				saynn("[say=nurse]Ох.. привет. Тебе что-то нужно?..[/say]")
			elif(theMission3Out == "break"):
				saynn("[say=nurse]Ох.. П-привет..[/say]")
				saynn("[say=pc]Расслабься, кошечка.[/say]")
			else:
				saynn("[say=nurse]Что-то нужно, заключенная?[/say]")
		
		
		addButton("Как это работает", "Спросить её, как всё устроено", "how_works")
		addButton("Работа здесь", "Спросить её, каково это — работать здесь.", "nursework")
		
		if(getModuleFlag("MedicalModule", "Nursery_AskedHowWorks", false)):
			if(!getModuleFlag("MedicalModule", "Nursery_AskedDatabase", false)):
				addButton("База данных", "Неужели с ними действительно нельзя взаимодействовать?", "children")
			else:
				addButton("База данных", "Взглянуть на своих деток", "database")
		
		if(GM.pc.isPregnant(true, false) && GM.pc.isVisiblyPregnant()):
			if(!GM.pc.isReadyToGiveBirth()):
				addButton("Стимулировать роды", "Попросить ускорить процесс", "induce_birth")
				addDisabledButton("Родить", "Для этого еще слишком рано")
			else:
				addDisabledButton("Стимулировать роды", "Ты уже можешь рожать")
				addButton("Родить", "Ты думаешь, что пора (если плод полностью развит)", "give_birth")
		else:
			addDisabledButton("Стимулировать роды", "Для этого нужно быть беременной")
			addDisabledButton("Родить", "Для этого нужно быть беременной")
		
		if(GM.pc.getInventory().hasAnyOffspringEggs()):
			addButton("Дать яйцеклетки", "Отдать все свои яйца потомства, чтобы их можно было внести в базу данных.", "give_eggs")
		else:
			addDisabledButton("Дать яйцеклетки", "У вас нет яиц потомства.")
		
		addButton("Уйти", "Пора идти", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["nurse"])

	if(state == "how_works"):
		setModuleFlag("MedicalModule", "Nursery_AskedHowWorks", true)
		
		saynn("[say=pc]Как всё это устроено?[/say]")

		saynn("Медсестра указывает на одну из дверей.")

		saynn("[say=nurse]Заключенные беременеют. Мы помогаем им чем можем, а когда приходит срок, они рожают вот через ту дверь.[/say]")

		saynn("[say=pc]А что происходит со всеми детьми?[/say]")

		saynn("[say=nurse]Заключенным нельзя контактировать с ними, пока они не отбыли срок и кто-нибудь не даст добро на встречу. Иначе слишком опасно. Не волнуйся, здесь им обеспечивают должный уход, детский сад, школу — всё необходимое.[/say]")

		saynn("Хм. Похоже, они продумали всю систему до мелочей.")

		saynn("[say=pc]А зачем вообще позволять заключенным беременеть? Разве это не чревато проблемами?[/say]")

		saynn("[say=nurse]Такова демографическая политика «АльфаКорп». К тому же, благодаря новейшей экспериментальной лекарственной терапии, всё проходит абсолютно безопасно.[/say]")

		# (if has any womb)

		saynn("Ты вопросительно приподнимаешь бровь.")

		saynn("[say=pc]Погоди. Но я не помню, чтобы проходил через какую-то терапию.[/say]")

		saynn("Медсестра смотрит на твой номер заключенного и начинает яростно стучать по своей старой щелкающей клавиатуре.")

		saynn("[say=nurse]Так, посмотрим... номер заключенного... {pc.inmateNumber}. Да, ты проходил процедуру во время приема. Ее проводил... доктор Куинн.[/say]")

		saynn("Ты помнишь, как тебе что-то вкололи. Но это было для другого. Неужели доктор Куинн тебе соврал?")

		saynn("[say=pc]И что [i]конкретно[/i] мне вкололи?[/say]")

		saynn("[say=nurse]Ну... мне вообще-то [i]не положено[/i] говорить такому заключенному, как ты... но, знаешь, учитывая количество безумных и агрессивных зэков, с которыми мне приходится иметь дело, когда они внезапно появляются и начинают орать о «недавней» драке или о том, что с ними происходит... это сильно усложняет мою работу.[/say]")
		saynn("[say=nurse]И так уж вышло, что я позволяю этой информации просочиться наружу в надежде, что это хоть немного облегчит мне жизнь...[/say]")
		
		saynn("Она жестом предлагает тебе наклониться ближе, чтобы быстро прошептать ответ на ухо.")
		
		saynn("[say=nurse]Тебе ввели один из экспериментальных вариантов фертильных препаратов от AlphaCorp. К тому моменту, как ты очнулся в свой первый день, действие должно было завершиться.[/say]")
		saynn("[say=nurse]Не переживай из-за того, что с тобой может случиться какая-то [i]совершенно[/i] дичь. Это даже полезно, если у тебя нет матки, да и весь персонал проходит такую же обработку при работе в глубоком космосе, как в этой тюрьме.[/say]")
		saynn("[say=nurse]То есть, это должно обеспечить колоссальную физическую защиту твоей утробы и любого потомства, которое ты произведешь, — до такой степени, что всё внутри тебя переживет любые ужасы, которые подкинет это место.[/say]")
		saynn("[say=nurse]И во-вторых, это изменит процесс развития плода: он будет расти со скоростью, установленной Корпоративным Медицинским Офицером. И хоть Корпорация полна идиотов, они достаточно умны, чтобы не позволять заключенным рожать когда попало. Как только кто-то почувствует ложные схватки, ему придется прийти сюда, чтобы вызвать настоящие.[/say]")
		
		if(GM.pc.hasPerk(Perk.StartNoHybrids)):
			saynn("[say=nurse]К тому же, ты одна из везунчиков, чья репродуктивная система среагировала на препарат, так что теперь ты больше никогда не сможешь родить гибрида.[/say]")

		saynn("Медсестра отстраняет тебя и возвращается к своему обычному голосу.")
		saynn("[say=nurse]На этом всё, заключенная.[/say]")

		saynn("Любопытно... Ты потираешь подбородок и смотришь на свой живот.")

		addButton("Продолжить", "Приятно", "")

	if(state == "nursework"):
		saynn("[say=pc]Так каково это — работать здесь?[/say]")
		saynn("Медсестра смотрит на тебя усталыми глазами, явно обдумывая, как лучше ответить на твой вопрос.")
		saynn("[say=nurse]Я работаю в отделении родовспоможения в тюрьме, где и так полно агрессивных и деградировавших заключенных. Многие из них с трудом переносят беременность. Тебе нужно больше подробностей, чтобы уловить суть?[/say]")
		saynn("[say=pc]Эх, нет, спасибо, я всё понимаю..[/say]")
		saynn("[say=nurse]Сюда заходят далеко не все, но могу тебе сказать: самые жуткие драки в этом месте случались именно здесь.[/say]")
		saynn("Медсестра возвращается к работе за компьютером, пока ты обдумываешь её слова...")

		addButton("Продолжить", "", "")
	if(state == "children"):
		setModuleFlag("MedicalModule", "Nursery_AskedDatabase", true)
		
		saynn("[say=pc]Неужели действительно нет способа проверить моих детей?[/say]")

		saynn("[say=nurse]Напрямую — нет. Каждый раз, когда ты или кто-то другой рожаете ребенка, мы вносим его в базу данных под твоим именем. Я могу показать тебе твои записи.[/say]")

		addButton("База данных", "Взглянуть на своих деток", "database")
		addButton("Нет, спасибо","Пожалуй, нет","")

	if(state == "database"):
		saynn("Ты просишь медсестру показать записи в базе данных. Она быстро нажимает несколько клавиш и разворачивает экран к тебе.")
		
		if(OPTIONS.getMaxKeepPCKids() > 0 || !OPTIONS.shouldOptimizeKids()):
			if(GM.CS.getChildren().size() == 0):
				sayn(" - Ничего не найдено, живо за размножение!")
			else:
				saynn("- Всего записей найдено: "+str(calculateAmount(true))+":")
				# (Your children here)
				
				var pcChilds := GM.CS.getChildrenRelatedTo("pc")
				outputChildrenRecords(pcChilds)
			
		var archivedAmount:int = GM.CS.getArchiveChildCountMotherOrFather("pc")
		if(archivedAmount <= 0 && !(OPTIONS.getMaxKeepPCKids() > 0 || !OPTIONS.shouldOptimizeKids())):
			sayn(" - Ничего не найдено, живо за размножение!")
		elif(archivedAmount > 0):
			sayn("")
			sayn("Архивные записи ("+str(archivedAmount)+"):")
			
			var resultTable:String = "[font=res://Fonts/normalconsolefont.tres][table=3][cell]Mother[/cell][cell]Father[/cell][cell]Amount[/cell]"
			
			for recordKey in GM.CS.archive:
				var splitData:Array = recordKey.split(";")
				if(splitData.size() < 2):
					continue
				var motherID:String = splitData[0]
				var fatherID:String = splitData[1]
				
				if(motherID == "pc" || fatherID == "pc"):
					var motherChar = getCharacter(motherID)
					var fatherChar = getCharacter(fatherID)
					var motherName:String = motherChar.getName() if motherChar != null else "unknown"
					var fatherName:String = fatherChar.getName() if fatherChar != null else "unknown"
					var kidAmount:int = GM.CS.archive[recordKey]
					
					resultTable += "[cell]"+motherName+"[/cell][cell]"+fatherName+"[/cell][cell]"+str(kidAmount)+"[/cell]"
					
			resultTable += "[/table][/font]"
			sayn(resultTable)
					
		var other:int = calculateAmount(false)
		if(other > 0):
			sayn("")
			saynn("- Найдены несвязанные записи "+str(other)+":")
		
			var theOtherChilds := GM.CS.getChildrenNotRelatedTo("pc")
			outputChildrenRecords(theOtherChilds)
			
		var archivedNPCAmount:int = GM.CS.getArchiveChildCountNonPC()
		if(archivedNPCAmount > 0):
			sayn("")
			sayn("Несвязанные архивные записи ("+str(archivedNPCAmount)+"):")
			
			var resultTable:String = "[font=res://Fonts/normalconsolefont.tres][table=3][cell]Mother[/cell][cell]Father[/cell][cell]Amount[/cell]"
			
			for recordKey in GM.CS.archive:
				var splitData:Array = recordKey.split(";")
				if(splitData.size() < 2):
					continue
				var motherID:String = splitData[0]
				var fatherID:String = splitData[1]
				
				if(motherID != "pc" && fatherID != "pc"):
					var motherChar = getCharacter(motherID)
					var fatherChar = getCharacter(fatherID)
					var motherName:String = motherChar.getName() if motherChar != null else "unknown"
					var fatherName:String = fatherChar.getName() if fatherChar != null else "unknown"
					var kidAmount:int = GM.CS.archive[recordKey]
					
					resultTable += "[cell]"+motherName+"[/cell][cell]"+fatherName+"[/cell][cell]"+str(kidAmount)+"[/cell]"
					
			resultTable += "[/table][/font]"
			sayn(resultTable)
			
		addButton("Продолжить", "Приятно", "")
		
		

	if(state == "induce_birth"):
		saynn("[say=pc]Есть ли способ ускорить беременность еще сильнее?[/say]")

		saynn("Медсестра кивает, отходит от своего стола и достает с пояса поводок для заключенных, после чего подходит к тебе, держа карабин открытым.")

		saynn("[say=nurse]Следуй за мной.[/say]")

		addButton("Следовать", "Посмотреть, куда она тебя приведет", "follow")

	if(state == "follow"):
		playAnimation(StageScene.Sleeping, "sleeping")
		saynn("Она пристегивает поводок к твоему ошейнику и ведет тебя к одной из дверей. Перед тобой открывается длинный коридор, соединяющий множество комнат. Медсестра заводит тебя в одну из них; она выглядит как обычная больничная палата: кровать, несколько источников света и какое-то оборудование.")

		saynn("Ты садишься на кровать, и медсестра пристегивает тебя поводком к ней. Затем она достает заряженный инъектор — он похож на огромную ручку, но с иглой.")

		saynn("[say=nurse]Это ускорит процессы в твоей утробе. Ты почувствуешь сильную усталость, поэтому тебя оставят здесь до завтра. После этого я приду и помогу тебе принять роды.[/say]")

		saynn("Звучит разумно. Ты склоняешь голову набок, позволяя ей сделать укол. Ой! Инъектор шипит, наполняя твою кровь каким-то неизвестным тебе препаратом.")

		saynn("[say=nurse]А теперь поспи немного. Не волнуйся, проведенная тобой терапия гарантирует, что ты не родишь без специальной стимуляции.[/say]")

		saynn("Медсестра помогает тебе устроиться поудобнее, надевая один из этих датчиков на палец, а другой обматывая вокруг твоего обнаженного живота. Она продолжает работу, но так как больше она к тебе не прикасается, ты быстро теряешь к ней интерес.")

		saynn("[say=nurse]Готово, хорошенько отдохни...[/say]")

		saynn("Это кажется тебе весьма сомнительным, но действие препарата уже ощущается. Ты ложишься на кровать и пытаешься вздремнуть. Там, внизу, становится очень жарко — такое чувство, будто матка высасывает из тебя всю энергию.")

		addButton("Спать", "Вздремнуть сейчас было бы просто идеально", "sleep")

	if(state == "sleep"):
		playAnimation(StageScene.GivingBirth, "idle", {bodyState={naked=true}})
		saynn("Ты засыпаешь в больничной койке. Она не самая удобная, но это лучше, чем ничего.")

		saynn("Добро пожаловать в "+str(GM.main.getDays())+" день твоего срока.")

		saynn("Когда ты открываешь глаза... ты видишь свой огромный живот. Твои глаза расширяются, когда ты начинаешь его исследовать, и ты удивленно моргаешь, ощущая его — ты поражена тем, как быстро всё это могло произойти. Отрицать очевидное невозможно: ты готова к родам. Тебе едва удается сесть.")

		saynn("Не зная, чем еще заняться, кроме как слушать писк кардиомониторов, ты просто обхватываешь свой огромный живот обеими руками и ждешь, когда придет очередная медсестра.")

		saynn("Пока ты ждешь, тупая боль в животе усиливается; ты просто терпишь её, пока в палату снова не входит та же медсестра.")
		
		saynn("[say=nurse]Снова здравствуй. Пора вставать, давай, я помогу.[/say]")

		addButton("Продолжить", "Пора давать жизнь", "startbirth")

	if(state == "give_birth"):
		saynn("[say=pc]Думаю, я готова.[/say]")

		saynn("Медсестра быстро осматривает твой живот и кивает.")

		saynn("[say=nurse]Ну что ж, иди за мной.[/say]")

		saynn("Она ведет тебя через одну из дверей в коридор, а затем в отдельное помещение.")

		addButton("Продолжить", "Пора давать жизнь", "startbirth")

	if(state == "startbirth"):
		playAnimation(StageScene.GivingBirth, "birth", {bodyState={naked=true}})
		
		saynn("С помощью медсестры ты входишь в родильный зал. Он просторный, а в центре стоит специальная кровать, сконструированная так, чтобы удерживать твои ноги разведенными. Пока к твоему ошейнику пристегивают страховочный ремень, туда и обратно снуют несколько медсестер, готовя всё необходимое. Ты ложишься и ждешь своей участи.")

		saynn("Как только подтверждается, что ты получила подходящее обезболивающее, старшая акушерка запускает процесс родов, позволяя всему идти своим чередом, пока завершаются последние приготовления и большинство остальных медсестер покидают зал.")
		
		saynn("Ты просто позволяешь им делать свою работу, лежа на кровати и делая глубокие вдохи, пока в твоем животе начинаются первые схватки." + (" Кто-то спрашивает, не стоит ли надеть на вас тяжелые фиксаторы, но другой человек отмахивается от этой мысли." if(GM.pc.getInmateType() == InmateType.HighSec) else "") )
		
		saynn("Когда начинаются воды, все окончательно распределяются по местам. Ты следуешь инструкциям старшей акушерки, пока природа берет свое. А под «природой» здесь подразумевается невероятная боль и дискомфорт.")
		
		saynn("Кажется, прошли целые часы, пока ты изо всех сил пыталась вытолкнуть свое потомство, постепенно растягиваясь изнутри... Жизнь определенно не сахар, и кажется, ты вот-вот потеряешь сознание от изнеможения...")
		
		# (if more than one child)
		if(bornChildAmount > 1):
			saynn("Но не всё так просто. Даже после рождения первого ребенка твой живот лишь слегка спал; ты всё еще чувствуешь схватки и протестующие движения оставшихся внутри плодов — очевидно, ты еще не закончила. Ты тяжело дышишь и стонешь, пока боль не утихает...")

		addButton("Продолжить", "Посмотреть, что будет", "continue1")

	if(state == "continue1"):
		playAnimation(StageScene.GivingBirth, "idle", {bodyState={naked=true}})
		
		var childStr = "child" + ("ren" if(bornChildAmount>1) else "")
		
		saynn("Ты родила "+str(bornChildAmount)+" "+childStr+"! Медсестра поздравляет тебя.")

		# (Who)
		sayn(bornChildString)

		saynn("Тебе удается провести с твоим(ей) "+childStr+" всего несколько минут, прежде чем придется уходить.")

		addButton("Уйти", "Пора идти", "endthescene")
	
	if(state == "give_eggs"):
		saynn("Ты отдаешь медсестре все свои яйца с потомством.")
		
		saynn(bornChildString)
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")
	
func calculateAmount(pcKids:bool = true) -> int:
	var amount:int = 0
	
	for ch in GM.CS.getChildren():
		var child: Child = ch
		if(pcKids && child.fatherID != "pc" && child.motherID != "pc"):
			continue
		if(!pcKids && (child.fatherID == "pc" || child.motherID == "pc")):
			continue
		amount += 1
	return amount

func outputChildrenRecords(_childs:Array):
	sayn(GM.CS.getChildBigReportString(_childs))

func _react(_action: String, _args):
	if(_action == "sleep"):
		GM.main.startNewDay()
		if(GM.pc.getMenstrualCycle() != null):
			GM.pc.getMenstrualCycle().speedUpPregnancy()
		GM.pc.afterSleepingInBed()
	
	if(_action == "startbirth"):
		var bornChildren = GM.pc.giveBirth()
		bornChildAmount = bornChildren.size()
		
		bornChildString = ""
		for child in bornChildren:
			var fatherObject = GlobalRegistry.getCharacter(child.fatherID)
			var fatherName = "unknown"
			if(fatherObject != null):
				fatherName = fatherObject.getName()
			
			bornChildString += child.name+" - "+"[color="+NpcGender.getColorString(child.gender)+"]"+ NpcGender.getVisibleName(child.gender)+"[/color]"+" - "+Util.getSpeciesName(child.species)+" - "+"Father: "+fatherName +" [color="+"#f0dd61"+"]"+child.bornFromMonozygotic+"[/color]" +"\n"
		processTime(60*60)
		
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "give_eggs"):
		processTime(10*60)
		var theEggs:Array = GM.pc.getInventory().getOffspringEggs()
		var allNewChilds:Array = []
		
		var pcFatherAm:int = 0
		var pcOtherAm:int = 0
		var addedAm:int = 0
		for theEgg in theEggs:
			if(!theEgg.egg):
				continue
			
			if(theEgg.egg.isPCFather()):
				pcFatherAm += 1
			else:
				pcOtherAm += 1
			var theChilds:Array = theEgg.egg.addSelfToNursery()
			if(!theChilds.empty()):
				allNewChilds.append_array(theChilds)
				addedAm += 1
			GM.pc.getInventory().removeItem(theEgg)
		
		bornChildString = GM.CS.getChildBigReportString(allNewChilds)
		
		addMessage(str(addedAm)+" egg"+("s" if addedAm != 1 else "")+" добавлен(а) в базу данных!")
		
		if(pcFatherAm > 0):
			GM.pc.addSkillExperience(Skill.Breeder, 10*pcFatherAm)
		if(pcOtherAm > 0):
			GM.pc.addSkillExperience(Skill.Fertility, 10*pcOtherAm)
		#return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["bornChildAmount"] = bornChildAmount
	data["bornChildString"] = bornChildString
	data["receivedApple"] = receivedApple
	
	return data
	
func loadData(data):
	.loadData(data)
	
	bornChildAmount = SAVE.loadVar(data, "bornChildAmount", 0)
	bornChildString = SAVE.loadVar(data, "bornChildString", "")
	receivedApple = SAVE.loadVar(data, "receivedApple", false)

func getSceneCreator():
	return "Rahi & AverageAce"
