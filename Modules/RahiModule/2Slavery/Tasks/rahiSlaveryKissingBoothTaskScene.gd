extends SceneBase

var chanceEasy = 0.0
var chanceMedium = 0.0
var chanceHard = 0.0
var success = false
var earnedCredits = 0
var npc_id = ""

func _init():
	sceneID = "rahiSlaveryKissingBoothTaskScene"

func _reactInit():
	var rahiModule = getModule("RahiModule")
	chanceEasy = rahiModule.getSkillSuccessChance("rahiSkillProstitution", 70, 95)
	chanceMedium = rahiModule.getSkillSuccessChance("rahiSkillProstitution", 30, 95)
	chanceHard = rahiModule.getSkillSuccessChance("rahiSkillProstitution", 2, 95)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npc_id

func _run():
	if(state == ""):
		addCharacter("rahi")
		saynn("Выберите уровень сложности задания «Будка поцелуев» для Рахи.")

		saynn("Легкий: "+str(Util.roundF(chanceEasy, 1))+"% шанс. Рахи предлагает только объятия за кредиты.")

		saynn("Средний: "+str(Util.roundF(chanceMedium, 1))+"% шанс. Рахи предлагает поцелуи и объятия за кредиты.")

		saynn("Тяжелый: "+str(Util.roundF(chanceHard, 1))+"% шанс. Рахи также предлагает оральный секс за кредиты.")

		addButton("Назад", "Выбрать другое задание", "endthescene")
		addButton("Легкий", "Рахи предлагает только объятия за кредиты", "easy_task")
		addButton("Средний", "Рахи предлагает поцелуи и объятия за кредиты", "medium_task")
		addButton("Сложный", "Рахи также предлагает оральный секс за кредиты", "hard_task")
	if(state == "easy_task"):
		saynn("Хотите посмотреть, как это сделает Рахи? Или можно сразу перейти к результату.")

		addButton("Вижу", "Посмотреть, как справится Рахи", "easy_see")
		addButton("Пропустить", "Перейти к результату", "skip")
	if(state == "skip"):
		saynn("Вы решаете остаться в камере и просто немного поваляться без дела.")

		if (success):
			saynn("Спустя некоторое время возвращается Рахи, и она выглядит счастливой. У неё всё получилось.")

			saynn("Она протягивает вам чип с вашей долей заработка Рахи.")

		else:
			saynn("Спустя некоторое время возвращается Рахи, и она выглядит очень грустной. Она просто не смогла заставить себя это сделать.")

			saynn("Она опускает голову.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "medium_task"):
		saynn("Хотите посмотреть, как это сделает Рахи? Или можно сразу перейти к результату.")

		addButton("Вижу", "Посмотреть, как справится Рахи", "medium_see")
		addButton("Пропустить", "Перейти к результату", "skip")
	if(state == "hard_task"):
		saynn("Хотите посмотреть, как это сделает Рахи? Или можно сразу перейти к результату.")

		addButton("Вижу", "Посмотреть, как справится Рахи", "hard_see")
		addButton("Пропустить", "Перейти к результату", "skip")
	if(state == "easy_see"):
		aimCameraAndSetLocName("main_hall_west")
		saynn("Вы объясняете Рахи, что она должна заработать вам немного кредитов, используя своё тело. Вы поясняете, что ей не обязательно заниматься сексом — достаточно продавать что-то простое, например, объятия.")

		saynn("Она понимающе кивает и выходит из камеры, направляясь в какое-то людное место. Вы идёте следом.")

		saynn("Рахи находит случайную картонную коробку и ставит её в одном из самых оживлённых мест тюрьмы. Достав чёрный маркер, она пишет на ней \"Объятия — 1 кредит\", после чего садится за неё и начинает ждать.")

		saynn("Не проходит и много времени, как кто-то появляется...")

		addButton("Продолжить", "Смотреть, что будет дальше", "easy_someone")
	if(state == "easy_someone"):
		playAnimation(StageScene.Hug, "hug", {pc="rahi", npc=npc_id})
		saynn("Одна из заключённых подходит к Рахи и спрашивает про самодельную лавочку. Рахи натягивает фальшивую добрую улыбку и всё ей объясняет.")

		saynn("[say=rahi]Она предлагает объятия за один кредит...[/say]")

		saynn("Заключенная посмеивается и оглядывается по сторонам. Затем {npc.he} бросает Рахи одну кредитную чип-карту.")

		saynn("[say=npc]Думаю, мне не помешало бы крепкое объятие.[/say]")

		if (success):
			saynn("Заметив кредитную чип-карту, Рахи с энтузиазмом обнимает {npc.him}, крепко обвивая лапами {npc.his} шею. Она сжимает {npc.him} так сильно, что заключенная кожей чувствует тепло и уют её тела.")

			saynn("Заключенная посмеивается и хлопает Рахи по спине.")

			saynn("[say=npc]Она стоит каждого кредита.[/say]")

			saynn("Рахи сияет от гордости и восторга.")

			saynn("Проходит время. Вы наблюдаете, как Рахи обнимает всё новых и новых заключенных.")

			addButton("Продолжить", "Смотреть, что будет дальше", "easy_outcome")
		else:
			saynn("Рахи видит кредитную чип-карту и вдруг выглядит озадаченной и обеспокоенной. Затем она переводит взгляд на вас... и на заключенную, чье терпение уже на исходе.")

			saynn("[say=rahi]Прости.. она не может..[/say]")

			saynn("{npc.He} качает {npc.his} головой и забирает {npc.his} чип обратно. Грустная Рахи подходит и вместо этого обнимает вас.")

			saynn("[say=rahi]Прости...[/say]")

			saynn("Мило. Но всё же. Рахи провалила своё задание.")

			addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "easy_outcome"):
		removeCharacter(npc_id)
		playAnimation(StageScene.Hug, "hug", {npc="rahi"})
		saynn("После того как все получат свои поцелуи от Рахи, она возвращается к тебе, выглядя счастливой. Она справилась.")

		saynn("Она протягивает тебе чип с твоей долей заработка Рахи. А затем и тебя обнимает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "medium_see"):
		aimCameraAndSetLocName("main_hall_west")
		saynn("Ты объясняешь Рахи, что она должна заработать тебе немного кредитов, используя своё тело. Ты поясняешь, что ей не обязательно заниматься сексом, но ты просишь нечто большее, чем просто объятия.")

		saynn("Она понимающе кивает и выходит из камеры, направляясь в какое-то людное место. Вы идёте следом.")

		saynn("Рахи находит случайную картонную коробку и ставит её в одном из самых людных мест тюрьмы. Она достаёт чёрный маркер и пишет на ней \"Поцелуи — 2 кредита. Объятия — 1 кредит\", после чего садится за неё и начинает ждать.")

		saynn("Вскоре начинают подтягиваться и остальные...")

		addButton("Продолжить", "Смотреть, что будет дальше", "medium_someone")
	if(state == "medium_someone"):
		playAnimation(StageScene.Solo, "stand", {pc="rahi"})
		if (!success):
			saynn("Один за другим начинают появляться заключённые. Они выстраиваются в небольшую очередь к самодельной «будке поцелуев» Рахи. Она видит все эти губы и щеки, которые ей придётся целовать... и начинает сильно нервничать.")

			saynn("Так сильно, что в итоге она не целует никого. Вместо этого она подбегает к тебе и крепко обнимает. Толпа, раздражённая нарушенными обещаниями, медленно расходится.")

			saynn("[say=rahi]Прости...[/say]")

			saynn("Она целует тебя в щеку. Мило. Но всё же. Рахи провалила своё задание.")

			addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
		else:
			var randVariant = RNG.pick([1,2,3,4,5,6,7])
			if (randVariant == 1):
				saynn("Пока она сидит в своей самодельной будке, мимо проходит один из заключённых. Увидев картонную коробку с надписями, он улыбается и направляется к Рахи.")

				saynn("Очевидно, он просит поцелуй. Рахи немного нервно кивает: одной мысли о заработке кредитов достаточно, чтобы вытолкнуть её из зоны комфорта.")

				saynn("Заключенный наклоняется, и Рахи отвечает ему навстречу, прижимая свои губы к его губам. Это был мягкий, нежный поцелуй, и Рахи не смогла сдержать легкого румянца, прежде чем отстраниться.")

				saynn("Заключенный вручает Рахи честно заработанные два кредита и отправляется дальше.")

			elif (randVariant == 2):
				saynn("Пока она сидит в своей самодельной будке, мимо проходит один из заключенных. Мужчина с добрым лицом. Заметив будку Рахи, он решает подойти к ней.")

				saynn("Когда он просит поцелуй, Рахи на мгновение колеблется, но затем наклоняется и оставляет на его щеке мягкий, утешающий поцелуй.")

				saynn("Лицо мужчины озаряется улыбкой; он протягивает Рахи чип с двумя кредитами, благодарный за этот короткий миг доброты.")

			elif (randVariant == 3):
				saynn("К самодельной будке для поцелуев подходит заключенная, выглядящая немного нервной и застенчивой.")

				saynn("Когда та просит поцелуй, Рахи чувствует её нерешительность и решает лишь быстро чмокнуть её в губы. Но когда их губы соприкасаются, Рахи ловит себя на желании задержаться подольше... растягивая этот момент столько, сколько возможно.")

				saynn("Заключенная вручает ей два кредита и быстро уходит.")

			elif (randVariant == 4):
				saynn("К самодельной будке Рахи подходит группа заключенных, явно настроенных на шалости. Каждый требует поцелуй, но платить они готовы лишь один раз, пользуясь тем, что на картонной коробке написано \"Поцелуи\". Рахи не сдается и отказывает им.")

				saynn("Но тут одна из заключенных хватает её за руку и притягивает к себе, пытаясь силой заставить поцеловать её.")

				saynn("Нужно действовать! Ты появляешься из ниоткуда и наносишь заключенному мощный удар, от которого тот разлетается по земле. Остальная толпа разбегается, оставляя тебя и Рахи наедине.")

				saynn("Рахи не удержалась и быстро чмокнула тебя в губы, прежде чем вернуться к работе.")

			elif (randVariant == 5):
				saynn("К самодельной лавке Рахи подходит застенчивый и нервный заключенный; кажется, он никогда раньше не делал ничего подобного.")

				saynn("Рахи чувствует его тревогу и решает сделать всё максимально нежно. Пока они обмениваются сладким поцелуем, ты видишь, как напряжение в теле мужчины постепенно уходит.")

				saynn("Когда всё заканчивается, он протягивает ей чип на два кредита и уходит, теперь шагая куда увереннее.")

			elif (randVariant == 6):
				saynn("Группа заключенных подходит к самодельной лавке поцелуев Рахи, хихикая и игриво подталкивая друг друга вперед.")

				saynn("Рахи не смогла сдержать улыбку, глядя на их нерешительность. Она наклоняется и целует одну из них в щеку, и в этот же миг её внезапно затягивает в общие объятия.")

				saynn("Девушки заливаются смехом и крепко обнимают её, прежде чем сунуть ей несколько кредитов и убежать.")

			elif (randVariant == 7):
				saynn("К самодельной лавке Рахи с суровым видом подходит один из охранников.")

				saynn("Но когда Рахи предлагает ему поцелуй, выражение его лица смягчается, и он наклоняется, чтобы слегка коснуться её губ своими.")

				saynn("Перед уходом он протягивает Рахи три кредита вместо двух.")

			saynn("Проходит время. Вы наблюдаете, как Рахи целует и обнимает всё новых заключенных, вмешиваясь лишь тогда, когда всё заходит слишком далеко.")

			addButton("Продолжить", "Смотреть, что будет дальше", "medium_outcome")
	if(state == "medium_outcome"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi"})
		saynn("Когда все получают свои поцелуи и объятия от Рахи, она возвращается к вам с сияющим лицом. У неё всё получилось.")

		saynn("Она протягивает вам чип с вашей долей заработка Рахи. А затем, обхватив вас лапками, она и сама вас целует.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "hard_see"):
		aimCameraAndSetLocName("main_hall_west")
		saynn("Вы объясняете Рахи, что она должна заработать вам немного кредитов, используя своё тело. Вы поясняете ей, что лучше всего для этого использовать рот.")

		saynn("Она понимающе кивает и выходит из камеры, направляясь в какое-то людное место. Вы идёте следом.")

		saynn("Рахи находит случайную картонную коробку и ставит её в одном из самых оживленных мест тюрьмы. Она достает черный маркер и пишет на ней \"Оральный секс — 3 кредита. Поцелуи — 2 кредита. Объятия — 1 кредит\", после чего садится за неё в ожидании клиентов.")

		saynn("Вскоре начинают подтягиваться и остальные...")

		addButton("Продолжить", "Смотреть, что будет дальше", "hard_someone")
	if(state == "hard_someone"):
		if (!success):
			playAnimation(StageScene.Duo, "kneel", {pc="rahi", npc=npc_id, npcBodyState={naked=true, hard=true}})
			saynn("Один за другим начинают подходить заключенные. Они выстраиваются в небольшую очередь к самодельной «будке для минета» Рахи. Она видит все члены, которые ей придется сосать, и все киски, которые ей придется лизать... и начинает сильно нервничать.")

			saynn("Она нервничает так сильно, что в итоге не обслуживает никого. Вместо этого она подбегает к вам и крепко обнимает. Толпа, раздраженная нарушенными обещаниями, медленно расходится.")

			saynn("[say=rahi]Прости...[/say]")

			saynn("Она целует тебя в щеку. Мило. Но всё же. Рахи провалила своё задание.")

			addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
		else:
			if (getCharacter(npc_id).hasPenis()):
				playAnimation(StageScene.SexOral, "sex", {npc="rahi", pc=npc_id, bodyState={exposedCrotch=true,hard=true}})
				saynn("Один из заключенных подходит к будке. {npc.He} читает прайс-лист, а затем выхватывает {npc.his} {npc.penis}, чем приводит Рахи в замешательство.")

				saynn("[say=rahi]Три кредита за отсос..[/say]")

				saynn("{npc.He} протягивает ей кредиты, и киска принимается за дело. Рахи размыкает губы и глубоко заглатывает член, обводя языком головку, отчего заключенная начинает стонать.")

				saynn("Киска продолжает сосать {npc.him} с постепенно нарастающей скоростью, нежно массируя лапками {npc.his} яички. Тем временем {npc.he} тянется вниз и ласкает её ушки, заставляя Рахи мурлыкать и стараться вдвое сильнее — она полна решимости довести {npc.him} до конч.")

				saynn("Наконец, заключенная достигает {npc.his} оргазма. {npc.He} стонет, пока член {npc.his} извергает струи {npc.cum} прямо в рот Рахи. Она отстраняется и жадно проглатывает каждую каплю {npc.his} семени, прежде чем показать {npc.him} свой пустой рот. Рахи вытирает губы, на которые тоже попало немного этой жижи.")

				saynn("Заключенная похлопывает Рахи по голове, после чего убирает {npc.his} член и уходит.")

			else:
				playAnimation(StageScene.SexOral, "lick", {npc="rahi", pc=npc_id, bodyState={exposedCrotch=true,hard=true}})
				saynn("Мимо проходит женщина и останавливается, чтобы оценить предложения Рахи. Девушка кажется весьма заинтересованной. Она подходит к киске и расспрашивает о доступных услугах.")

				saynn("Рахи объясняет варианты, и вариант с оральным сексом явно интригует девушку. Она спрашивает цену, хотя та написана на стенде, а затем соглашается и протягивает киске кредиты.")

				saynn("После этого девушка заходит за стенд и спускает шорты, открывая киску так, чтобы Рахи могла медленно наклониться и начать её вылизывать.")

				saynn("Пока умелый язык Рахи исследовал самые чувствительные зоны девушки, та начала стонать от удовольствия, ощущая, как стимулируется каждый дюйм её киски. Она кладет руку на голову Рахи и начинает вжиматься промежностью в её лицо, обильно смазывая его своим соком.")

				saynn("Девушка быстро приближается к оргазму... Вскоре её тело напрягается, а затем начинает дрожать и содрогаться, пока щель её киски осыпает кошечку потоками похотливого сока.")

			saynn("Время идет. Ты наблюдаешь, как Рахи делает минет, лижет киски, целует и обнимает других заключенных, вмешиваясь лишь тогда, когда всё заходит слишком далеко.")

			addButton("Продолжить", "Смотреть, что будет дальше", "hard_outcome")
	if(state == "hard_outcome"):
		removeCharacter(npc_id)
		playAnimation(StageScene.Duo, "stand", {npc="rahi"})
		saynn("Когда все получают от Рахи то, чего хотели, она возвращается к тебе — счастливая и удовлетворенная. Она справилась.")

		saynn("Она протягивает тебе чип с твоей долей заработка Рахи. А затем целует тебя в щеку, обвивая тебя своими лапками.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "easy_task"):
		if(RNG.chance(chanceEasy)):
			var prostitutionScore = getModule("RahiModule").getSkillScore("rahiSkillProstitution")
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillProstitution", 7)
			earnedCredits = 1 + RNG.randi_range(0, int(prostitutionScore/7))

	if(_action == "medium_task"):
		if(RNG.chance(chanceMedium)):
			var prostitutionScore = getModule("RahiModule").getSkillScore("rahiSkillProstitution")
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillProstitution", 12)
			earnedCredits = RNG.randi_range(1, 2) + RNG.randi_range(0, int(prostitutionScore/5))
		
		#getCharacter("rahi").getInventory().equipItem(GlobalRegistry.createItem("blindfold"))

	if(_action == "hard_task"):
		if(RNG.chance(chanceHard)):
			var prostitutionScore = getModule("RahiModule").getSkillScore("rahiSkillProstitution")
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillProstitution")
			earnedCredits = RNG.randi_range(2, 5)  + RNG.randi_range(0, int(prostitutionScore/5))

	if(_action == "skip"):
		processTime(30*60)
		if(earnedCredits == 1):
			addMessage("Вы получили 1 кредит")
		elif(earnedCredits > 1):
			addMessage("Вы получили "+str(earnedCredits)+" credits")
		if(earnedCredits > 0):
			GM.pc.addCredits(earnedCredits)

	if(_action == "stop_task"):
		#getCharacter("rahi").resetEquipment()
		endScene([success])
		return

	if(_action == "easy_someone"):
		processTime(20*60)
		npc_id = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {NpcGen.Level: 10})
		addCharacter(npc_id)

	if(_action == "easy_outcome"):
		processTime(10*60)
		if(earnedCredits == 1):
			addMessage("Вы получили 1 кредит")
		elif(earnedCredits > 1):
			addMessage("Вы получили "+str(earnedCredits)+" credits")
		if(earnedCredits > 0):
			GM.pc.addCredits(earnedCredits)

	if(_action == "medium_someone"):
		processTime(20*60)
		#npc_id = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], #InmateGenerator.new(), {NpcGen.Level: 10})
		#addCharacter(npc_id)

	if(_action == "medium_outcome"):
		processTime(10*60)
		if(earnedCredits == 1):
			addMessage("Вы получили 1 кредит")
		elif(earnedCredits > 1):
			addMessage("Вы получили "+str(earnedCredits)+" credits")
		if(earnedCredits > 0):
			GM.pc.addCredits(earnedCredits)

	if(_action == "hard_someone"):
		processTime(20*60)
		npc_id = InmateGenerator.new().generate({NpcGen.Gender: RNG.pick([NpcGender.Male, NpcGender.Male, NpcGender.Male, NpcGender.Female, NpcGender.Female, NpcGender.Female, NpcGender.Shemale, NpcGender.Herm]), NpcGen.Temporary: true, NpcGen.NoChastity: true}).getID()
		addCharacter(npc_id)
		if(success):
			if(getCharacter(npc_id).hasPenis()):
				getCharacter("rahi").cummedInMouthBy(npc_id)
			else:
				getCharacter("rahi").cummedInMouthBy(npc_id, FluidSource.Vagina)
				getCharacter("rahi").cummedOnBy(npc_id, FluidSource.Vagina, 0.5)

	if(_action == "hard_outcome"):
		processTime(10*60)
		if(earnedCredits == 1):
			addMessage("Вы получили 1 кредит")
		elif(earnedCredits > 1):
			addMessage("Вы получили "+str(earnedCredits)+" credits")
		if(earnedCredits > 0):
			GM.pc.addCredits(earnedCredits)

	setState(_action)

func saveData():
	var data = .saveData()

	data["chanceEasy"] = chanceEasy
	data["chanceMedium"] = chanceMedium
	data["chanceHard"] = chanceHard
	data["success"] = success
	data["earnedCredits"] = earnedCredits
	data["npc_id"] = npc_id

	return data

func loadData(data):
	.loadData(data)

	chanceEasy = SAVE.loadVar(data, "chanceEasy", 0.0)
	chanceMedium = SAVE.loadVar(data, "chanceMedium", 0.0)
	chanceHard = SAVE.loadVar(data, "chanceHard", 0.0)
	success = SAVE.loadVar(data, "success", false)
	earnedCredits = SAVE.loadVar(data, "earnedCredits", 0)
	npc_id = SAVE.loadVar(data, "npc_id", "")
