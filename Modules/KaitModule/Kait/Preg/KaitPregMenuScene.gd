extends SceneBase

func _init():
	sceneID = "KaitPregMenuScene"

func _run():
	if(state == ""):
		addCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		aimCameraAndSetLocName(GM.pc.getLocation())
		
		var _isPreg:bool = getCharacter("kait").isVisiblyPregnant()
		
		if(_isPreg):
			saynn("Что ты хочешь сделать с беременной Кейт?")
		else:
			saynn("Что ты хочешь сделать с кормящей Кейт?")

		var amGiveBirth:int = getFlag("KaitModule.kaitGaveBirths", 0)
		if (amGiveBirth == 1):
			saynn("Кейт родила один раз.")

		else:
			saynn("Кейт родила всего "+str(amGiveBirth)+" times.")
		
		if(_isPreg):
			if (!getFlag("KaitModule.kaitDidCuddle", false)):
				addButton("Обнимашки", "Обниматься с беременной Кейт и болтать о ней", "do_cuddle")
			else:
				addDisabledButton("Обнимашки", "Ты уже обнимался с Кейт во время этой беременности. Эта опция станет доступна во время её следующей.")
			if (getCharacter("kait").isHeavilyPregnant()):
				addButton("Помочь при родах", "Отвести Кейт в детскую, где она сможет родить", "do_help_givebirth")
			else:
				addDisabledButton("Помочь при родах", "Беременность Кейт еще не продвинулась достаточно далеко. Подожди третьего триместра.")
		if (amGiveBirth >= 1):
			if (getCharacter("kait").canBeMilked() && !getCharacter("kait").hasSoreNipples()):
				addButton("Подоить её", "Дои Кейт с помощью молокоотсоса или руками!", "do_milk_kait")
			else:
				addDisabledButton("Подоить её", "Кейт сейчас нельзя доить, дай ей немного времени!")
		else:
			addDisabledButton("Подоить её", "Кейт должна родить хотя бы один раз, прежде чем эта функция станет доступна во время её следующей беременности.")
		if (amGiveBirth >= 2):
			if (getCharacter("kait").canBeMilked() && !getCharacter("kait").hasSoreNipples()):
				addButton("Кормить грудью: ВКЛ", "Соси молоко из груди Кейт!", "do_feed_on_kait")
			else:
				addDisabledButton("Кормить грудью: ВКЛ", "Кейт сейчас не может кормить грудью, дай ей немного времени!")
		else:
			addDisabledButton("Кормить грудью: ВКЛ", "Кейт должна родить как минимум 2 раза, прежде чем эта функция станет доступна во время её следующей беременности.")
		addButton("Назад", "Вернуться в другое меню", "go_back")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_cuddle"):
		runScene("KaitPregCuddleScene")
		setFlag("KaitModule.kaitDidCuddle", true)
		return

	if(_action == "do_help_givebirth"):
		endScene()
		runScene("KaitHelpGiveBirthScene")
		return

	if(_action == "do_milk_kait"):
		runScene("KaitPregMilkPumpsScene")
		return

	if(_action == "do_feed_on_kait"):
		runScene("KaitPregBreastfeedOnScene")
		return

	if(_action == "go_back"):
		endScene()
		runScene("KaitTalkScene")
		return

	setState(_action)
