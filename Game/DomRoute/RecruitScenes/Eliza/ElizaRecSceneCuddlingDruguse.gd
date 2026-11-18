extends RecruitSceneBase

func _init():
	sceneID = "ElizaRecSceneCuddlingDruguse"

func _reactInit():
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.Body)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearTop)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearBottom)
	putOn("eliza", "LatexStraitjacket")
	putOn("eliza", "oldcollar")

func _run():
	if(state == ""):
		addCharacter("eliza", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("У Элизы в карманах припрятано какое-то... вещество... Любопытно. Ты приносишь его с собой в камеру.")

		saynn("Ты смотришь на Элизу Куинн. Она стоит неподвижно, её ошейник привязан к трубе над головой, что почти лишает её свободы движений. Она даже не может сесть на стоящий здесь стул.")

		saynn("Её сиськи всё так же обнажены... а взгляд всё такой же яростный.")

		saynn("[say=pc]"+str(ch1("...", "Hey there, Quinn.", "You look like one of us. Little slut."))+"[/say]")

		saynn("[say=eliza]Гррр-р..[/say]")

		saynn("Её хвост раздражённо виляет. Она пытается вырваться из смирительной рубашки, отчего блестящий материал начинает скрипеть.")

		saynn("[say=pc]"+str(ch1("...", "Relax, slut. I'm not gonna hurt you yet.", "What's the matter? Cat got your tongue?"))+"[/say]")

		saynn("Ты подходишь к трубе и тянешься к ней, чтобы немного ослабить цепь. Затем ты обнимаешь Элизу и тянешь её вниз, на пол!")

		addButton("Обнять её", "Давай обнимашки!", "do_cuddle")
	if(state == "do_cuddle"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="eliza"})
		saynn("Она пытается вырваться, но ты сильнее.")

		saynn("[say=eliza]Какого чёрта ты творишь?[/say]")

		saynn("Ты обхватываешь её руками, так что теперь её обнимают сразу две пары рук.")

		saynn("[say=pc]"+str(ch1("...", "Shut up and take it, cuddle-slut.", "Shush, cuddle-slut."))+"[/say]")

		saynn("Она ерзает, но ты крепко её прижимаешь. Примерно через минуту она перестает сопротивляться и сдается.")

		saynn("[say=eliza]Повсюду какая-то грязь, просто отстой![/say]")

		saynn("[say=pc]"+str(ch1("...", "You're not above us, pussy cat. I know that you're using something.", "You're just as filthy, cat. I know that you're using."))+"[/say]")

		saynn("Когда твоя рука достает крошечный прозрачный пакетик с каким-то содержимым, уши Элизы навостряются.")

		saynn("[say=eliza]..ты где это взял?[/say]")

		saynn("[say=pc]"+str(ch1("...", "You're dumb, your stash wasn't hard to find.", "You're a druggie, Eliza."))+"[/say]")

		saynn("Она старается не смотреть на него, но ты раз за разом подносишь его к самому её лицу.")

		saynn("[say=eliza]Это же... это просто кошачья мята... Это... для моих пациентов-котиков![/say]")

		saynn("Кошачья мята, значит? Пациенты... ну-ну, посмотрим.")

		saynn("Ты открываешь пакетик. Воздух наполняется тонким мятным ароматом. Когда ты подносишь его к носу Элизы, у неё не остается иного выбора, кроме как вдохнуть запах.")

		saynn("Её изумрудные глаза на мгновение расширяются... а затем зрачки заливают почти всю радужку. Её тело обмякает, всё напряжение уходит.")

		saynn("[say=eliza]..ммм.. рр-р..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_rubs_against_you")
	if(state == "eliza_rubs_against_you"):
		playAnimation(StageScene.Cuddling, "squirm", {pc="pc", npc="eliza"})
		saynn("В её груди начинает зарождаться низкое, рокочущее мурчание. Она едва заметно начинает тереться о тебя. Её хвост плавно покачивается из стороны в сторону.")

		saynn("[say=pc]"+str(ch1("...", "Good little slut.", "See? Not so tough now, are you, bitch?"))+"[/say]")

		saynn("Она откидывается назад и прижимается носом к твоей щеке, мурча всё громче. Время от времени она сует мордочку в пакет с кошачьей мятой, чтобы сделать очередной вдох, который снова погружает её в это кайфовое состояние.")

		saynn("[say=eliza]Мрр-р~.. мяу..[/say]")

		saynn("В твоих руках она — просто нуждающаяся, обдолбанная кошка. Приятно наблюдать за тем, как она мяукает и мурлычет. Кажется, она даже не против, когда твои руки ложатся на её обнаженную грудь, просто замирая там. Ты кожей чувствуешь исходящую от неё вибрацию.")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_effect")
	if(state == "after_effect"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="eliza"})
		saynn("Ты долго держишь её так, просто позволяя кошачьей мяте делать своё дело.")

		saynn("В конце концов эффект начинает ослабевать. Туман в глазах Элизы рассеивается. Она моргает... а затем снова пытается отстраниться, а её щеки пылают красным.")

		saynn("[say=eliza]Забудь, что это было![/say]")

		saynn("[say=pc]"+str(ch1("There is more if you submit.", "That was just a taste. Submit if you want more.", "Imagine feeling that good every day. Be a good pet, and you'll get more."))+"[/say]")

		saynn("Элиза лишь вздыхает.")

		saynn("[say=eliza]Серьёзно? Всё будет точно так же, как раньше, только теперь ещё и с ошейником на шее. Ого, супер, просто прелесть![/say]")

		saynn("Она говорит это с максимально возможным уровнем сарказма.")

		saynn("Ну, что ж.")

		saynn("Ты встаёшь и оставляешь её в покое.")

		saynn("[say=eliza]Оставить пакет?..[/say]")

		saynn("Ты ничего не говоришь.")

		saynn("[say=eliza]Ну и хрен с тобой тогда![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
