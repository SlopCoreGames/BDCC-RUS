extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AlexRynardPantiesQuestReturnFleshlightsScene"

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})

	if(state == ""):
		# (You return him the things. Foxy thanks you and gives some credits)

		# (He asks if you wanna keep the panties too.)

		saynn("Ты с громким стуком ставишь флешлайты на стол Фокси.")

		saynn("[say=pc]Вот.[/say]")

		saynn("Фокси вскидывает бровь, переводя взгляд с тебя на секс-игрушки.")

		saynn("[say=alexrynard]Нашла их?[/say]")

		saynn("[say=pc]Еще бы! Благодаря тебе-то.[/say]")

		saynn("Он хватает один из них и начинает копаться в его внутренностях, отверткой щелкая каким-то скрытым переключателем.")

		saynn("[say=alexrynard]Вот, разблокировал.[/say]")

		saynn("[say=pc]Ты даже не представляешь, через что мне пришлось пройти.[/say]")

		saynn("[say=alexrynard]На самом деле, представляю. Ты забыла, что за ними ведется наблюдение. Собранные данные уже стали весьма ценными для отдела исследований и разработок.[/say]")

		saynn("Ты невольно хмуришься. Значит ли это, что они следили за каждым твоим половым актом и при этом ничего не предпринимали?")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue")

	if(state == "continue"):
		saynn("[say=pc]И что теперь?[/say]")

		saynn("[say=alexrynard]Можешь оставить их себе, если хочешь. Это всё равно грубый прототип, он уже выполнил свою задачу.[/say]")

		saynn("Ты тянешь за свои трусики, и кажется, что они больше не «приклеены» к твоей промежности.")

		addButton("Оставь их себе", "Они тебе вроде как нравятся", "keep_them")
		addButton("Снимай их", "(Конец контента с портальными трусиками) Отдай ему портальные трусики", "take_them_off")


	if(state == "keep_them"):
		# (You ask to keep the panties. He agrees but says that there might be more tests then)

		# (You shrug and secretly excited about that)

		saynn("Ты слегка покачиваешь {pc.masc} бедрами из стороны в сторону, держась за края трусиков.")

		saynn("[say=pc]Думаю, они могут остаться у меня.[/say]")

		saynn("Парень пожимает плечами.")

		saynn("[say=alexrynard]Ладно, без проблем. Только тогда тебя могут потестить ещё сильнее.[/say]")

		saynn("[say=pc]Тесты прошли не так уж плохо. По крайней мере, теперь я могу снять их сама.[/say]")

		saynn("[say=alexrynard]Мы можем снова «потерять» флешлайты. Сама знаешь, ученые бывают очень забывчивыми.[/say]")

		saynn("Он звучит очень хитро, даже улыбается. Ты вздыхаешь и просто уходишь, хотя твои щеки слегка розовеют — возможно, именно на это он и рассчитывает.")

		# (scene ends, quest ends)
		addButton("Продолжить", "Это было легко", "endthescene")

	if(state == "take_them_off"):
		# (You take off the panties and give them to him. He says that it was fun watching some tests)

		# (You blush and walk away)

		saynn("Ты снимаешь портативные трусики и оставляешь их на рабочем столе. Фокси лишь пожимает плечами.")

		saynn("[say=alexrynard]По крайней мере, наблюдать за этим было забавно.[/say]")

		saynn("Ты дуешь губы и краснеешь от его слов. Ты заметила, что все камеры наблюдения практически не сводили с тебя глаз.")

		saynn("[say=alexrynard]Я отдам прототип в медицинское крыло, там он может пригодиться.[/say]")

		saynn("Вместо ответа ты решаешь просто оставить его в покое. Наконец-то свободна.")

		# (scene ends, quest ends)

		addButton("Продолжить", "Это было легко", "endthescene")


func _react(_action: String, _args):
	if(_action in ["take_them_off", "keep_them"]):
		addMessage("Квест выполнен!")
		addExperienceToPlayer(50)
	
	if(_action == "take_them_off"):
		setFlag("PortalPantiesModule.Panties_FleshlightsReturnedPanties", true)
		var item:ItemBase = GM.pc.getInventory().getEquippedItem(InventorySlot.UnderwearBottom)
		if(item && item.id == "PortalPanties"):
			item.destroyMe()
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

