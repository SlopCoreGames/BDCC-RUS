extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "BulldogTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["bulldog"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("bulldog")
		playAnimation(StageScene.Duo, "stand", {npc="bulldog"})

	if(state == ""):
		saynn("Ты стоишь перед мужиком, который выглядит как ходячая стена. Он преграждает путь к какому-то особому техническому люку.")

		addButton("Заплатить", "Заплатить мужику кредитами", "trypay")
		addButton("Запугивание", "Попробовать подраться с ним. Это будет очень тяжелый бой", "intimidate")
		if(!getFlag("FightClubModule.BulldogSeduced")):
			addButtonWithChecks("Секс?", "Предложить заплатить своим телом. Будет очень жестко...", "секс?", [], [[ButtonChecks.StatCheck, Stat.Sexiness, 5]])
		else:
			addDisabledButton("Секс?", "Ты его уже соблазнила...")
		addButton("Уйти", "Тебе не хочется разговаривать", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["bulldog"])

	if(state == "pay"):
		saynn("[say=pc]Сколько там было?[/say]")

		saynn("Мужик становится еще ворчливее.")

		saynn("[say=bulldog]Пятнадцать кредитов.[/say]")
		
		if(GM.pc.getCredits() >= 15):
			addButton("Заплатить 15 кредитов", "Отдать ему свои кровно заработанные кредиты", "pay_15_credits")
		else:
			addDisabledButton("Заплатить 15 кредитов", "У тебя не так много..")
		addButton("Не-а", "Ты не хочешь платить", "")

	if(state == "pay_15_credits"):
		saynn("Ты достаешь кредитный чип с 15 кредитами и протягиваешь его парню. Он быстро проверяет его и убирает.")

		saynn("[say=pc]И что теперь?[/say]")

		saynn("Парень ухмыляется и разворачивается. Затем он начинает колотить по люку в каком-то определенном ритме: три медленных удара и два быстрых.")

		saynn("Спустя несколько секунд люк открывается, и парень наконец-то пропускает тебя внутрь.")

		addButton("Войти", "Посмотреть, что это за место", "walk_in")

	if(state == "pay_5"):
		# (after seducing)

		saynn("[say=pc]Значит.. это стоило два кредита, не так ли?[/say]")

		saynn("Парень усмехается.")

		saynn("[say=bulldog]Не наглей. Вход стоит пять кредитов.[/say]")

		if(GM.pc.getCredits() >= 5):
			addButton("Заплатить 5 кредитов", "Отдать ему свои кровно заработанные кредиты", "pay_5_credits")
		else:
			addDisabledButton("Заплатить 5 кредитов", "У тебя не так много..")
		addButton("Не-а", "Ты не хочешь платить", "")

	if(state == "pay_5_credits"):
		saynn("Вы достаете кредитный чип на 5 кредитов и протягиваете его парню. Он быстро проверяет его и убирает.")

		saynn("[say=pc]И что теперь?[/say]")

		saynn("Парень ухмыляется и разворачивается. Затем он начинает колотить по люку в каком-то определенном ритме: три медленных удара и два быстрых.")

		saynn("Спустя несколько секунд люк открывается, и парень наконец-то пропускает тебя внутрь.")

		addButton("Войти", "Посмотреть, что это за место", "walk_in")


	if(state == "intimidate"):
		saynn("[say=pc]Как насчет того, чтобы вместо этого я надрал тебе задницу?[/say]")

		saynn("Булдог разминает плечи и сплевывает в сторону.")

		saynn("[say=bulldog]Может, хватит на меня лаять и перейдем сразу к делу?[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Погнали", "startfight")

	if(state == "if_won"):
		saynn("Поверженный, Булдог рычит, повалившись на пол.")

		saynn("[say=pc]Ну что? Я достоин или тебе нужно еще разок всыпать?[/say]")

		saynn("Парень кашляет и тихо посмеивается над твоими словами; его голос звучит очень хрипло.")

		saynn("[say=bulldog]Ты явно чего-то стоишь.[/say]")

		saynn("Он откидывается назад и тянется к техническому люку. Он стучит по нему пять раз: три медленных и два быстрых. Через несколько секунд дверь открывается, пропуская тебя внутрь. Наконец-то.")

		# (scene ends)

		addButton("Войти", "Посмотреть, что это за место", "walk_in")

	if(state == "if_lost"):
		saynn("Ты проигрываешь бой и падаешь на колени.")

		saynn("[say=bulldog]Это было глупо.[/say]")

		saynn("Ты слишком слаб, чтобы продолжать. Он хватает тебя за воротник и мощным рывком отшвыривает в сторону.")

		# (scene ends)
		addButton("Продолжить", "Ow", "getthrownout")


func _react(_action: String, _args):
	if(_action == "walk_in"):
		processTime(3*60)
		setFlag("FightClubModule.BulldogBypassed", true)
		GM.pc.setLocation("fight_entrance")
		endScene()
		runScene("FightClubIntroScene")
		return
	
	if(_action == "pay_15_credits"):
		GM.pc.addCredits(-15)
	if(_action == "pay_5_credits"):
		GM.pc.addCredits(-5)
	
	if(_action == "sex?"):
		runScene("BulldogSexScene")
		setFlag("FightClubModule.BulldogSeduced", true)
		endScene()
		return
	
	if(_action == "trypay"):
		if(!getFlag("FightClubModule.BulldogSeduced")):
			setState("pay")
		else:
			setState("pay_5")
		return
	
	if(_action == "startfight"):
		runScene("FightScene", ["bulldog"], "bulldogfight")
	
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "getthrownout"):
		GM.pc.setLocation("gym_yoga")
		endScene()
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "bulldogfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			setFlag("FightClubModule.BulldogBeatenUp", true)
			addExperienceToPlayer(50)
		else:
			setState("if_lost")
			#addExperienceToPlayer(5)
