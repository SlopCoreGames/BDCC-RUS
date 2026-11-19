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
			"This is a mental ward, you can't be here without a leash.",
			"You got lost? I can help you.",
			"You can't be here.",
			"Hey, you. Did you escape?",
			"Whacha doin’ there.",
		])+"[/say]")

		saynn("Её голос звучит женственно, и хотя она всего лишь медсестра, она выхватывает электрошокер. Она выглядит высокой и довольно подтянутой, как и большинство фелинок.")

		saynn("Она замирает на мгновение, готовясь к прыжку.")

		saynn("[say=nurse]"+RNG.pick([
			"Give up and I won't hurt you. Too much",
			"Get on the floor. I give you one chance.",
			"Don’t make me use my claws, just surrender.",
			"Time to teach you a lesson.",
		])+"[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Похоже, другого пути нет.", "fight")

	if(state == "lost_fight"):
		saynn("Ты проиграл медсестре. Не в силах продолжать бой, ты падаешь на колени в ожидании своей участи.")
		
		addButton("Продолжить", "Посмотреть, что будет", "getrestrained")

	if(state == "getrestrained"):
		saynn("Медсестра подходит к тебе. Она достает средства фиксации и пытается надеть их на тебя!")

		saynn("[say=nurse]"+RNG.pick([
			"Now get out of here.",
			"This will be a lesson for you. Now go away.",
			"Resisting will only make this worse for you.",
			"This is gonna serve as a punishment.",
		])+"[/say]")

		# (scene ends)

		addButton("Продолжить", "О нет", "endthescene")

	if(state == "won_fight"):
		saynn("Ты прижимаешь поверженную медсестру к полу. Кажется, она особо и не сопротивляется.")

		# (if has hands)
		if(!GM.pc.hasBlockedHands()):
			saynn("Ты используешь её же наручники, чтобы сковать её, делая её практически беспомощной.")

		saynn("[say=nurse]"+RNG.pick([
			"Nice moves. What’s your plan?",
			"Don’t leave me like this, inmate.",
			"A little kiss before you leave?",
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
			

