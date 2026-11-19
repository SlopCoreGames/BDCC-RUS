extends "res://Scenes/SceneBase.gd"

var howMuchMilked = 0.0

func _init():
	sceneID = "ElizaHandMilking"

func _run():
	if(state == ""):
		addCharacter("eliza")
		
	if(state == ""):
		# (if milking level low)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 1):
			saynn("[say=pc]М-м... Самый простой способ? У меня не так много опыта.[/say]")

		# (if milking level medium)
		elif(GM.pc.getSkillLevel(Skill.Milking) <= 4):
			saynn("[say=pc]Я хочу, чтобы ты подоила меня своей рукой.[/say]")

		# (if high)
		else:
			saynn("[say=pc]Моя грудь слишком расперта, дои меня, как настоящую корову, му-у![/say]")

		saynn("[say=eliza]Ну что ж. Тогда иди за мной~[/say]")

		saynn("Элиза отходит от стойки и приближается к тебе. Затем она пристегивает поводок к твоему ошейнику и ведет тебя по стерильным коридорам; ты замечаешь вокруг множество медсестер и врачей, а также нескольких охранников. В глубине души ты чувствуешь предвкушение того, что будет дальше.")

		addButton("Следовать", "Посмотреть, куда она тебя приведет", "follow")

	if(state == "follow"):
		aimCamera("med_milkingroom")
		setLocationName("Milking heaven")
		playAnimation(StageScene.Duo, "stand", {npc="eliza", bodyState={exposedChest=true}})
		
		saynn("Она приводит тебя в помещение, которое можно назвать только райским местом для дойки. Ты замечаешь огромный резервуар для хранения молока и немало специальных доильных станок — не для животных, а для людей. Элиза направляет тебя в один из свободных станков. Сам станок представляет собой набор металлических труб, предназначенных для фиксации коровы; Элиза обматывает твой поводок вокруг одной из них.")

		# (if clothed)
		if(!GM.pc.isFullyNaked()):
			saynn("[say=eliza]Вот так. Очевидно, мне понадобится доступ к твоей груди.[/say]")

			saynn("Она {pc.undressMessageS}. Затем она берет табурет и емкость для молока. Она садится прямо перед тобой.")
		# (if naked)
		else:
			saynn("[say=eliza]Вот и всё. Даже раздевать тебя не пришлось — какая подготовленная корова.[/say]")

			saynn("Она берет табурет и емкость для молока, а затем садится прямо перед тобой.")

		saynn("Элиза внимательно осматривает твою обнаженную грудь, а затем проводит ладонями по твоим {pc.breasts}, полным молока.")

		saynn("[say=eliza]Знаешь, исследования показывают, что если во время процесса мычать, молоко становится вкуснее~.[/say]")

		# (if low milking)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 1):
			saynn("[say=pc]Не уверена, что это работает именно так...[/say]")

			saynn("[say=eliza]Оууу. Но зато весело~[/say]")

		# (if medium milking)
		elif(GM.pc.getSkillLevel(Skill.Milking) <= 4):
			saynn("[say=pc]Эм... Му?[/say]")

			saynn("[say=eliza]Да, старайся получше, как послушная коровка.[/say]")
		else:
		# (if high milking)

			saynn("Ты активно двигаешь торсом и восторженно мычишь для доктора.")

			saynn("[say=pc]Му! Му-у-у![/say]")

			saynn("[say=eliza]Вот теперь ты настоящая коровка.[/say]")

		addButton("Дать подоить", "Время для самого веселого", "be_milked")

	if(state == "be_milked"):
		saynn("Ты хватаешься за металлическую перекладину перед собой и замираешь, слегка наклонившись вперед и выпячивая свои {pc.breasts}. Элиза начинает с нежного ощупывания, заставляя их подпрыгивать и колыхаться. Она обводит кончиками пальцев твои ареолы и растирает каждый сосок; ты чувствуешь, как они твердеют. Элиза сжимает один из них между пальцами, и наружу брызжет немного {pc.milk}.")

		saynn("[say=eliza]Очень хорошо~.[/say]")

		# (if high milking)
		if(GM.pc.getSkillLevel(Skill.Milking) > 4):
			saynn("[say=pc]Му-у![/say]")

		saynn("Это приятно; Элиза начинает разминать твою грудь, словно котенок, ласкающий мамочку. Ты приоткрываешь губы и тихо стонешь. Затем Элиза усиливает нажим, сжимая твои молочные железы, и наблюдает, как из них брызжет еще больше {pc.milk}! Она старается поймать большую часть струи в контейнер для молока.")

		# (if low milking)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 1):
			saynn("[say=pc]Так странно это делать...[/say]")

			saynn("[say=eliza]Но ведь приятно, правда? Просто отдайся этому. Коровам не нужно думать, им нужно только сосредоточиться на удовольствии~[/say]")
		elif(GM.pc.getSkillLevel(Skill.Milking) <= 4):
		# (if medium milking)

			saynn("[say=pc]Му-у-у...[/say]")

			saynn("[say=eliza]Да, сосредоточься на том, как тебя доят.[/say]")

		# (if high milking)
		else:
			saynn("[say=pc]Му~![/say]")

			saynn("[say=eliza]Никаких мыслей, никаких проблем, только дойка. Такая хорошая коровка.[/say]")

		saynn("Её руки продолжают доить тебя, нежно разминая и массируя твои {pc.breasts}, а затем переходя к крепким сжиманиям, выжимая всё больше {pc.milk}. Ты чувствуешь возбуждение; стоять в стойле и быть доеным, словно какое-то животное, кажется невероятным. Руки доктора выжимают всё больше и больше {pc.milk} из твоих желез, ты громко стонешь, пока уровень молока в контейнере неуклонно растёт.")

		# (if has vagina)
		if(GM.pc.hasVagina()):
			saynn("Ты чувствуешь дикое возбуждение, твоя киска такая мокрая, что кажется, будто ты можешь кончить в любую секунду даже без стимуляции... Но ты не кончаешь... Ты ловишь эту волну, и постоянное удовольствие от дойки медленно развращает твой разум...")

		addButton("Сдаться полностью", "Му-у...", "give_in_completely")

	if(state == "give_in_completely"):
		saynn("Элиза продолжает доить тебя в стойле, а ты стоишь смирно для неё, твои {pc.breasts}")

		# (if had > 4 liters)
		if(howMuchMilked >= 2500.0):
			saynn("Проходит как минимум час, и контейнер для молока практически полон.")

			saynn("[say=eliza]Отлично~. Это сделает мой кофе куда вкуснее.[/say]")

		# (if had > 2 liters)
		elif(howMuchMilked >= 900.0):
			saynn("Проходит как минимум час, и контейнер для молока заполнен примерно наполовину.")

			saynn("[say=eliza]Неплохо. Мы всегда можем подоить тебя ещё как-нибудь в другой раз.[/say]")

		# (if had > 1 liters)
		elif(howMuchMilked >= 400.0):
			saynn("Проходит как минимум час, и контейнер для молока заполнен меньше чем наполовину, но это всё равно результат.")

			saynn("[say=eliza]Около литра. Может, нам стоит сделать твои вымена побольше~[/say]")

		# (else)
		else:
			saynn("Проходит как минимум час, и уровень молока в контейнере заметно падает.")

			saynn("[say=eliza]Хм. Обязательно подожди какое-то время, ты была почти сухой.[/say]")

		saynn("Элиза что-то говорит, но тебе трудно сосредоточиться — в голове только молоко... Доктор замечает твой отсутствующий взгляд и посмеивается.")

		saynn("[say=pc]Му-у..[/say]")

		saynn("[say=eliza]Ну ладно, давай я тебе помогу~[/say]")

		# (if clothed)
		if(!GM.pc.isFullyNaked()):
			saynn("Она надевает на тебя одежду и берет поводок. Затем она выводит тебя из стойла.")

		# (else)
		else:
			saynn("Она берет твой поводок и выводит тебя из стойла.")

		addButton("Следовать", "Какая же ты послушная коровка", "follow1")

	if(state == "follow1"):
		aimCamera("med_nearmilking")
		setLocationName("Corridor")
		GM.pc.setLocation("med_nearmilking")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
		saynn("Элиза выводит тебя из доильного зала в главный коридор.")

		saynn("[say=eliza]Уверена, ты найдешь дорогу назад. Возвращайся скорее~[/say]")

		# (scene ends)
		addButton("Продолжить", "Пора идти", "endthescene")
		


func _react(_action: String, _args):
	if(_action == "follow"):
		runScene("ParadedOnALeashScene", ["eliza", GM.pc.getLocation(), "med_milkingroom", [
			"Almost there, inmate",
			"Feeling excited? You should be~",
			"Thanks for participating in our program, inmate",
			"We have the best milking equipment and staff here~",
			"The leash is for your own safety, really~",
		]])
	
	if(_action == "give_in_completely"):
		setModuleFlag("MedicalModule", "Med_wasMilkedToday", true)
		processTime(60*60)
		howMuchMilked = GM.pc.milk()
		GM.pc.addLust(40)
		
		increaseModuleFlag("MedicalModule", "Med_milkMilked", howMuchMilked)
		increaseModuleFlag("MedicalModule", "Med_milkedMilkTimes")
		GM.main.SCI.handleBountyFluid(GM.pc.getFluidType(FluidSource.Breasts), howMuchMilked)
		
		addMessage(str(round(howMuchMilked / 10.0)*10.0)+" ml of milk was milked from your breasts")

		GM.pc.addSkillExperience(Skill.Milking, 60, "eliza_handmilking")
		
		if(howMuchMilked >= 400.0):
			var credits = Util.maxi(1, int(floor(sqrt(howMuchMilked / 100.0) / 2.0)))
			GM.pc.addCredits(credits)
			addMessage("You received "+str(credits)+" work "+Util.multipleOrSingularEnding(credits, "credit")+"!")

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["howMuchMilked"] = howMuchMilked
	
	return data
	
func loadData(data):
	.loadData(data)
	
	howMuchMilked = SAVE.loadVar(data, "howMuchMilked", 0.0)
