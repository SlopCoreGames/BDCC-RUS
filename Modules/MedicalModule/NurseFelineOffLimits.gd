extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "NurseFelineOffLimits"

func _run():
	if(state == ""):
		addCharacter("nurse")
		playAnimation(StageScene.Duo, "stand", {npc="nurse"})

	if(state == ""):
		saynn("Ты натыкаешься на медсестру. Ты пытаешься спрятаться, но уже слишком поздно.")

		saynn("[say=nurse]"+RNG.pick([
			"Это психиатрическое отделение, здесь нельзя находиться без поводка.",
			"Заблудился? Я могу тебе помочь.",
			"Тебе здесь не место.",
			"Эй, ты! Ты что, сбежал?",
			"Ну и чем это ты тут занимаешься?",
		])+"[/say]")

		saynn("Её голос звучит женственно, и хотя она всего лишь медсестра, она выхватывает электрошокер. Она выглядит высокой и довольно подтянутой, как и большинство фелинок.")

		saynn("Она замирает на мгновение, готовясь к прыжку.")

		saynn("[say=nurse]"+RNG.pick([
			"Сдавайся, и я не буду причинять тебе боль. Ну, слишком сильно.",
			"На пол! Даю тебе один шанс.",
			"Не заставляй меня выпускать когти, просто сдавайся.",
			"Пора преподать тебе урок.",
		])+"[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Похоже, другого пути нет.", "fight")

	if(state == "lost_fight"):
		saynn("Ты проиграл медсестре. Не в силах продолжать бой, ты падаешь на колени в ожидании своей участи.")
		
		addButton("Продолжить", "Посмотреть, что будет", "getrestrained")

	if(state == "getrestrained"):
		saynn("Медсестра подходит к тебе. Она достает средства фиксации и пытается надеть их на тебя!")

		saynn("[say=nurse]"+RNG.pick([
			"А теперь — брысь отсюда.",
			"Это будет тебе уроком. А теперь проваливай.",
			"Сопротивление сделает только хуже.",
			"Это послужит тебе наказанием.",
		])+"[/say]")

		# (scene ends)

		addButton("Продолжить", "О нет", "endthescene")

	if(state == "won_fight"):
		saynn("Ты прижимаешь поверженную медсестру к полу. Кажется, она особо и не сопротивляется.")

		# (if has hands)
		if(!GM.pc.hasBlockedHands()):
			saynn("Ты используешь её же наручники, чтобы сковать её, делая её практически беспомощной.")

		saynn("[say=nurse]"+RNG.pick([
			"Хорошие движения. Какой у тебя план?",
			"Не оставляй меня так, заключенная.",
			"Маленький поцелуй перед уходом?",
		])+"[/say]")

		addButton("Оставь её в покое", "Просто обчисти её и свали, пока тебя не заметили", "endthescene")

	if(state == "catchEscapedPC"):
		saynn("Медсестра прижимает тебя к полу.")

		saynn("[say=nurse]Думал, что сможешь сбежать, сучка?[/say]")

		saynn("Она силой натягивает на тебя смирительную рубашку! Ты пытаешься сопротивляться, но уже слишком поздно.")

		saynn("[say=nurse]Не так быстро, ты идешь со мной.[/say]")

		saynn("Она сажает тебя на поводок и ведет к Элизе. Доктор, похоже, не в восторге от твоего появления.")

		addButton("О нет", "Побег провалился", "oh_no")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "fight"):
		runScene("FightScene", ["nurse"], "nursefight")
	
	if(_action == "getrestrained"):
		for item in GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(1, 2)):
			addMessage(item.getForcedOnMessage())
	
	if(_action == "oh_no"):
		runScene("ElizaCaughtEscapedPC")
		endScene()
		return
	
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag == "nursefight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_fight")
			addExperienceToPlayer(30)
		else:
			addExperienceToPlayer(5)
			
			if(getModuleFlag("MedicalModule", "Mental_PlayerEscaped", false)):
				setState("catchEscapedPC")
			else:
				setState("lost_fight")
			

