extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "CaughtOffLimitsByNovaScene"

func _run():
	if(state == ""):
		addCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="stand"})
		
	if(state == ""):
		GM.main.setModuleFlag("NovaModule", "Nova_SawPC", true)
		
		saynn("Позади слышны чьи-то шаги, похоже на тяжелые сапоги. Ты решаешь спрятаться за ближайшей стеной в надежде, что тебя не заметят. Слышится женский голос.")

		saynn("[say=nova]Я знаю, что ты там. Можешь выходить.[/say]")

		saynn("Похоже, игра окончена. Ты вздыхаешь и показываешься стражнику; она выглядит весьма удивленной.")

		saynn("[say=nova]Ого, неужели в этот раз действительно сработало? Да шучу я~[/say]")

		saynn("Перед тобой хаски: рост около 1,7 метра, серая шерсть, короткие серые волосы с несколькими ярко-голубыми прядями. Стоячие уши, длинная собачья морда, желтые глаза. Тело подтянутое, с заметным рельефом мышц. Сзади виден свернутый хвост, характерный для большинства хаски. Форма говорит о том, что она стражник; на ней какая-то легкая силовая броня, которая не особо скрывает ее пышную грудь и бугорок между ног, хотя последний прикрыт короткой черной юбкой. На жетоне написано: Нова.")

		saynn("Она держит руку на электрошоковой дубинке, готовая схватить тебя и применить её в любой момент.")

		saynn("[say=nova]Ну-у-у~. Заключенный номер {pc.inmateNumber}... Что ты тут забыл?[/say]")

		addButton("Заблудился", "Солгать, что попал сюда случайно", "got_lost")
		addButton("Сдаться", "Сдаться Хаски", "submit")
		addButton("Атаковать", "Сразиться с хаски", "attack")

	if(state == "got_lost"):
		saynn("[say=pc]Тюрьма довольно большая, я просто заблудилась.[/say]")

		saynn("Ты пожимаешь плечами, стараясь выглядеть туповатым. Нова слышит это и начинает сокращать дистанцию.")

		saynn("[say=nova]Ну надо же~. И ты что, не заметил все эти разметки «только для персонала» на полу? Нужно быть совсем слепым, чтобы их пропустить.[/say]")

		saynn("Она уже почти может дотянуться до тебя рукой, но замирает, преграждая путь к выходу. Нова хитро улыбается.")

		saynn("[say=nova]Но мне кажется, что твои слова — сплошная ложь~. А я не люблю, когда мне врут~[/say]")

		saynn("Ты пытаешься отступить, но Нова тут же перехватывает твое движение словами.")

		saynn("[say=nova]Плохая идея~. Стоит мне нажать одну кнопку, и через секунду ты будешь вылизывать пол.[/say]")

		saynn("Похоже, побег не вариант.")

		addButton("Подчиниться", "Сдаться Хаски", "submit")
		addButton("Атаковать", "Сразиться с хаски", "attack")

	if(state == "submit"):
		saynn("Ты поднимаешь руки, показывая, что не замышляешь ничего плохого.")

		saynn("[say=pc]Поймала меня.[/say]")

		saynn("Нова усмехается и подходит к тебе, несколько раз слегка хлопая ладонью по твоим щекам.")

		saynn("[say=pc]Ой. А теперь можешь просто показать мне дорогу?[/say]")

		saynn("[say=nova]Не так быстро. Разворачивайся, прислонись к стене, и я проведу небольшой обыск, чтобы убедиться, что ты не таскаешь с собой ничего незаконного~.[/say]")

		# (options are Fine, Offer self, Attack)

		addButton("Ладно", "Подчиниться обыску", "submittosearch")
		addButton("Предложить себя", "Похоже, у Новы есть член, может, стоит этим воспользоваться?", "offer_self")
		addButton("Атаковать", "Сразиться с хаски", "attack")

	if(state == "submittosearch"):
#		playAnimation(StageScene.SexStanding, "tease", {
#			pc="nova",npc="pc",
#			bodyState={},
#			npcBodyState={},
#		})
		playAnimation(StageScene.Search, "stand", {pc="pc", npc="nova"})
		
		saynn("Ты делаешь, как она говорит: подходишь к ближайшей стене и наклоняешься вперед, ожидая обыска.")

		# (if girl)
		if(GM.pc.getGender() != Gender.Male):
			saynn("[say=nova]Хорошая девочка~ А теперь стой смирно, пока я с тобой вожусь.[/say]")
		else:
			# (if boy)
			saynn("[say=nova]Хороший мальчик~ А теперь стой смирно, пока я с тобой вожусь.[/say]")

		saynn("Нова останавливается позади и кладет руки на тебя.")

		if(!GM.pc.isFullyNaked()):
			saynn("Она начинает с очевидного: её ладони скользят по твоей верхней одежде сверху вниз. Она проверяет спину, грудь, подмышки, пояс, бедра и ноги, стараясь залезть во все возможные карманы.")
		else:
			saynn("Даже когда ты голая, она всё равно проводит лапами по изгибам твоего тела, проверяя всё подряд: подмышки, спину, грудь и нижнюю часть тела. Нова также приседает, чтобы провести визуальный осмотр.")

		# (if has something)
		if(GM.pc.hasIllegalItems()):
			saynn("[say=nova]Охх~ Это я заберу себе. Ну и контрабанда у тебя тут припрятана, милашка~[/say]")
		else:
			# (if found nothing)
			saynn("Кажется, Нова ничего не отбирает. Она также слегка похлопывает тебя по голове.")

			saynn("[say=nova]Очень хорошо~[/say]")

		# (if has non-flat breasts):
		if(GM.pc.hasNonFlatBreasts()):
			saynn("Её лапы ложатся на твою грудь, пальцы медленно очерчивают круги, прощупывая твои холмики. Ты думаешь, что это часть процедуры, но затем руки Новы переходят к откровенному лапанью; ты невольно стонешь, когда она сжимает и тискает твою грудь. Такое чувство, будто она пытается тебя подоить.")

			saynn("[say=nova]Кто-то кажется немного возбужденным~[/say]")
		# (endif)
		
		saynn("Руки Новы скользят вниз по твоей спине, а затем сжимают твою задницу. Ты ахаешь, но позволяешь ей продолжать. Она дает тебе крепкий шлепок, проверяя, насколько ты упругая, отчего ты инстинктивно дергаешься. Но она притягивает тебя обратно и силой разводит твои ноги.")

		saynn("[say=nova]Стой смирно~, непослушная заключенная.[/say]")

		saynn("Ты подаешься вперед и выпячиваешь задницу перед ней, пока она продолжает над тобой колдовать.")

		saynn("[say=nova]Я плохая девчонка. Я проказничала. Я заслуживаю наказания. Скажи это~[/say]")

		saynn("Ты пытаешься возразить, но тут же получаешь очередной звонкий шлепок, вырывающий из тебя болезненный стон.")

		saynn("[say=pc]Ах.. Да, я плохая девчонка.. Я проказничала..[/say]")

		saynn("[say=nova]О да, еще как~[/say]")

		saynn("Она осыпает тебя шлепками один за другим; твоя задница так и ходит ходуном, а на коже проступают яркие пятна. Ты начинаешь тяжело дышать, а ноги начинают дрожать.")

		saynn("[say=pc]Я заслуживаю наказания![/say]")

		saynn("[say=nova]Вот так, ну что, не слишком больно?[/say]")

		if(GM.pc.hasPenis()):
			if(GM.pc.isWearingChastityCage()):
				saynn("Затем Нова приседает позади тебя и кладет руку тебе в пах, ощупывая твою девственность — клетка, кажется, уже подтекает предэякулятом, — и твои яйца. Это чертовски возбуждает.")
			else:
				saynn("Затем Нова приседает позади тебя и кладет руку тебе в пах, ощупывая твой твердый член, из которого, кажется, сочится предэякулят, и твои яйца. Это чертовски возбуждает.")

			if(GM.pc.hasReachableVagina()):
				saynn("Затем лапа Новы скользит вниз к твоей мокрой щелке и тоже задевает её, ощущая влагу; ты вздрагиваешь и пытаешься скрыть стоны, когда Нова находит твой клитор и начинает его тереть.")

			saynn("[say=nova]Какая милая маленькая шлюшка~[/say]")

		elif(GM.pc.hasReachableVagina()):
			saynn("Затем Нова приседает позади тебя и прижимает руку к твоей промежности. Ты возбуждена, и охранница это чувствует. Твоя киска мокрая даже сквозь униформу; ты вздрагиваешь и пытаешься скрыть стоны, когда Нова находит твой клитор и начинает его тереть.")

			saynn("[say=nova]Какая милая маленькая шлюшка~[/say]")

		saynn("То, что она делает, кажется очень унизительным, но в то же время это дико тебя заводит. Наконец, Нова напоследок сжимает твою задницу, прежде чем встать.")

		saynn("[say=nova]А теперь иди. И не попадайся мне здесь больше~[/say]")

		addButton("Уйти", "Пожалуй, не самое худшее, что случалось с тобой", "endthesceneStealItems")

	if(state == "offer_self"):
		saynn("[say=pc]Разве это имеет значение? Как насчет того, чтобы отпустить меня, если я предложу тебе что-то взамен?[/say]")

		saynn("Нова предвкушающе хмыкает и чешет подбородок, разглядывая тебя, в то время как другой лапой она теребит свою юбку, дразня свой бугорок.")

		# (Probably gonna be random between sucking cock and fucking)

		saynn("[say=nova]А ведь я сегодня чертовски возбуждена~. Отсоси мне, и тогда посмотрим. Если сделаешь это хорошо, я, пожалуй, закрою на это глаза~.[/say]")

		# (options are Agree or Attack)

		addButton("Согласиться", "Отсосать у Новы", "agree_to_suck")
		addButton("Атаковать", "Сразиться с хаски", "attack")


		

	if(state == "attack"):
		saynn("[say=pc]Тебе стоит просто отпустить меня. Это действительно будет в твоих же интересах.[/say]")

		saynn("Нова замечает твой вызывающий тон и делает шаг назад; она достает классический электрошокер, а синие линии на её броне начинают светиться. Она улыбается.")

		saynn("[say=nova]Заставь меня~[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Начать бой", "fight")
		
	if(state == "lost_fight"):
		saynn("Поверженный, ты лежишь на холодном полу. Сил на борьбу больше не осталось.")

		# (random big punishment starts here, it could be Nova fucking you or locking restraints onto you or bringing you to the punishment area and locking into stocks or something)
		
		addButton("Наказание", "Ну что ж, пора получить наказание", "punishment")


	if(state == "won_fight"):
		saynn("Нова падает на колени, бросив электрошокер на пол. Её броня полностью разрядилась и больше не защищает её; она тяжело дышит и сверлит тебя взглядом.")

		saynn("[say=nova]Ну ты и шлюха...[/say]")

	if(state == "won_fight_lust"):
		saynn("Нова так завелась, что рухнула на колени и начала ласкать себя прямо у тебя на глазах. В её глазах читается неприкрытое желание.")

		saynn("[say=nova]Хафф.. Ты не можешь просто вот так меня оставить..[/say]")

		# (Player is wanted by guards)

	# (Humiliate Nova, Fuck Nova, Ride Nova, Leave)
	if(state == "won_fight" || state == "won_fight_lust"):
		addButton("Уйти", "Ничего не делать", "endthescene")
		addButtonWithChecks("Унизить Нову", "Использовать её электродубинку, чтобы поиздеваться над ней", "humiliateAngel", [], [ButtonChecks.NotHandsBlocked])
		addButtonWithChecks("Оседлать Нову", "Использовать член герма для своего удовольствия", "rideSubbyAngel", [], [ButtonChecks.HasReachableVagina])
		addButtonWithChecks("Трахнуть Нову", "Она же герм, так почему бы не использовать её киску?", "fuckSubbyAngel", [], [ButtonChecks.HasReachablePenis])

	if(state == "punishment"):
		saynn("Нова подходит к тебе и придавливает на месте своим бронированным сапогом. Затем она приседает перед тобой и пристегивает поводок к твоему ошейнику.")

		saynn("[say=nova]Ну, ты хотя бы попытался. Тебе стоит сменить имидж — роль шлюхи тебе идет куда больше.[/say]")

		saynn("Ты тяжело дышишь, обидевшись на её грубые слова.")

		saynn("[say=pc]И что ты теперь будешь делать?[/say]")

		saynn("[say=nova]Вот увидишь~[/say]")

		if(!GM.pc.isFullyNaked()):
			saynn("Нова начинает стягивать с тебя одежду. Ты замечаешь это и пытаешься сопротивляться, но она явно сильнее тебя. Вскоре все твои интимные места оказываются на виду.")

			saynn("[say=pc]Эй![/say]")

		# (if not restrained)
		if(!GM.pc.hasBoundArms()):
			saynn("Она перехватывает твои руки и резко заводит их за спину, после чего сковывает их тяжелыми металлическими наручниками.")

			saynn("[say=nova]Это гарантирует, что ты не натворишь глупостей~[/say]")

		# (else)
		else:
			saynn("[say=nova]Ох, мне даже не пришлось тебя сдерживать. Хорошо~[/say]")

		saynn("Нова встает и начинает тянуть за поводок, приглашая тебя последовать за ней. Из-за наручников это довольно непростая задача, но ошейник, сдавливающий горло, служит отличной мотивацией. Тебе удается встать на колени без помощи рук, а затем подняться на ноги. Нова ухмыляется и отвешивает тебе шлепок по голой заднице. Твои причиндалы полностью выставлены напоказ, и ты даже не можешь прикрыться — это кажется унизительным.")

		saynn("[say=pc]Так легко задирать заключенных..[/say]")

		saynn("[say=nova]Все, что тебе нужно было делать — это слушаться~. Но ничего, время, проведенное в колодках, должно наладить твое поведение~[/say]")

		saynn("Затем Нова начинает водить тебя по тюремному блоку, сильнее дергая за поводок каждый раз, когда ты останавливаешься или медлишь. Ты идешь позади нее, низко опустив голову. Ты пытаешься избежать взглядов других заключенных: кто-то хихикает, кто-то разглядывает тебя, наверняка представляя секс с тобой, а кто-то просто молча наблюдает.")


		saynn(RNG.pick(["[sayMale]Let me try that mouth![/sayMale]", "[sayMale]I’m gonna be first[/sayMale]", "[sayMale]Look, what a slave![/sayMale]"]))

		if(RNG.chance(50)):
			saynn("К вам подходит другой охранник — высокая дева, похожая на рысь с бирюзовой шерстью. Она крепко шлепает вас по заднице и посмеивается.")

			saynn("[say=risha]Такой пригодный для разведения...[/say]")

		addButton("Продолжить", "Вы на поводке", "beleashedtostocks")

	if(state == "beleashedtostocks"):
		saynn("Наконец вы доходите до главной платформы, где расположены все устройства для публичных наказаний. Вы поднимаетесь по лестнице и следуете за хаски к одному из колодок; заключенные вокруг с удовольствием наблюдают за шоу. Нова открывает перед вами заслонки и указывает внутрь.")

		saynn("[say=nova]Залезай туда~[/say]")

		saynn("Вы колеблетесь. Но, похоже, выбора нет: вы наклоняетесь вперед и продеваете шею в центральное отверстие. Затем Нова отпирает ваши наручники и фиксирует руки там, где нужно, после чего закрывает и запирает колодки, оставляя вас совершенно беспомощным. Вы проверяете их на прочность и понимаете, что не можете пошевелить даже шеей — вы зажаты в крайне компрометирующей позе, где ваши интимные места видны каждому встречному. Колодки представляют собой разборную металлическую раму с резиновой подкладкой снизу и цепями, которыми Нова пользуется, чтобы раздвинуть ваши ноги еще шире.")

		# (if only has cock)
		if(GM.pc.hasPenis() && !GM.pc.hasReachableVagina()):
			if(GM.pc.isWearingChastityCage()):
				saynn("Нова кладет руку на ваши яйца и слегка сжимает их. Затем она трет кончик вашей клетки целомудрия, пытаясь вызвать эрекцию. После этого она облизывает палец и прощупывает ваш задний проход. Ей удается просунуть палец внутрь и нащупать простату, отчего вы начинаете течь предэякулятом.")
			else:
				saynn("Нова кладет руку на твои яйца и слегка сжимает их. Затем она ласкает головку твоего члена, поглаживая его до тех пор, пока он не станет твердым. Она также облизывает один из своих пальцев и просовывает его в твою задницу. Ей удается просунуть палец внутрь, и когда она нащупывает твою простату, у тебя начинает сочиться предэякулят.")

			saynn("[say=nova]Надеюсь, тебе нравится быть жопошлепкой~. Готовься, тебя будут многократно использовать.[/say]")

		# (if has vagina)
		
		if(!GM.pc.hasPenis() && GM.pc.hasReachableVagina()):
			saynn("Нова кладет руку на твою обнаженную щель и начинает ее тереть; она проводит пальцем по твоим чувствительным губкам, а затем раздвигает их и отвешивает тебе звонкую пощелину.")

			saynn("[say=nova]Надеюсь, тебе нравится, когда тебя трахают без резины~. Готовься, тебя будут многократно использовать.[/say]")

		# (if has both)
		if(GM.pc.hasPenis() && GM.pc.hasReachableVagina()):
			if(GM.pc.isWearingChastityCage()):
				saynn("Нова кладет руку на твои яйца и слегка сжимает их, затем она ласкает и твой зажатый в клетку член, и твою киску, пока ты не возбудишься и не начнешь умолять о ласке. Ей также удается просунуть один из своих пальцев в твою задницу, где она начинает тыкать в твою простату, заставляя тебя сочиться предэякулятом.")
			else:
				saynn("Нова кладет руку на твои яйца и слегка сжимает их, затем она ласкает и твой член, и твою киску, пока ты не возбудишься и не начнешь умолять о ласке. Ей также удается просунуть один из своих пальцев в твою задницу, где она начинает тыкать в твою простату, заставляя тебя сочиться предэякулятом.")

			saynn("[say=nova]Твой член, скорее всего, будет бесполезен, а вот киска и задница будут в деле на полную катушку~[/say]")

		saynn("Нова в последний раз окидывает тебя взглядом и оставляет тебя одного в колодках.")

		saynn("[say=nova]Надеюсь, я о тебе не забуду~[/say]")

		# (Scene ends, punished in stocks scene starts)
		addButton("Продолжить", "Ты в колодках", "startstocks")


		

func _react(_action: String, _args):

	if(_action == "submittosearch"):
		GM.pc.addLust(20)
		
		for item in GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")
		for item in GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")

	if(_action == "humiliateAngel"):
		runScene("HumiliateNovaScene")
		GM.main.setModuleFlag("NovaModule", "Nova_GotHumiliatedByPC", true)
		endScene()
		return
		
	if(_action == "rideSubbyAngel"):
		runScene("RideSubbyNovaScene")
		GM.main.setModuleFlag("NovaModule", "Nova_GotHumiliatedByPC", true)
		endScene()
		return
		
	if(_action == "fuckSubbyAngel"):
		runScene("FuckSubbyNovaScene")
		GM.main.setModuleFlag("NovaModule", "Nova_GotHumiliatedByPC", true)
		endScene()
		return
		
	if(_action == "agree_to_suck"):
		if(GM.pc.freeMouthDeleteAll()):
			addMessage("Nova was nice enough to remove your gag before this")
		runScene("SuckNovaCockScene")
		endScene()
		return

	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "endthesceneStealItems"):
		GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
		GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		
		endScene()
		return
		
	if(_action == "fight"):
		runScene("FightScene", ["nova"], "novafight")
	
	if(_action == "beleashedtostocks"):
		runScene("ParadedOnALeashScene", ["nova", GM.pc.getLocation(), "main_punishment_spot", [
			"I love parading bratty cuties around~",
			"Everyone's looking at you~",
			"I like leashes, don't you?",
			"Just giving my cutie some walkies~",
			"Stocks are waiting, let's hurry~",
			"Did you thought this would happen before stealing?",
			"This is gonna be such a good lesson for you~",
			"I'm walking you like you're a pet~",
		]])
	
	if(_action == "startstocks"):
		#runScene("StocksPunishmentScene", ["nova"])
		endScene()
		GM.main.IS.startInteraction("InStocks", {inmate="pc"})
		return
		
	if(_action == "punishment"):
		GM.pc.getInventory().unequipSlotUnlessRestraint(InventorySlot.Body)
		GM.pc.getInventory().unequipSlotUnlessRestraint(InventorySlot.UnderwearBottom)
		GM.pc.getInventory().unequipSlotUnlessRestraint(InventorySlot.UnderwearTop)
	
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "novafight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		var wonHow = _result[1]
		
		if(battlestate == "win"):
			if(wonHow == "lust"):
				setState("won_fight_lust")
			else:
				setState("won_fight")
			addExperienceToPlayer(30)
		else:
			setState("lost_fight")
			addExperienceToPlayer(5)

func getDevCommentary():
	return "Probably one of the first.. encounter scenes.. that I wrote. Has one of the most earliest lewd scenes too in the game ^^. So if they suck - thats why x3. Before, the idea was to have every encounter type have many scenes like this one.. with a unique character and stuff.. But after writing one such scene I was like.. nope x3 we doing something simpler or we doin nothing!"

func hasDevCommentary():
	return true
