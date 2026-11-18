extends RecruitSceneBase

func _init():
	sceneID = "ElizaRecSceneCuddlingBreathplay"

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
		saynn("Ты заходишь в камеру и смотришь на Элизу Куинн. Она стоит неподвижно, её ошейник привязан к трубе над головой, что почти лишает её свободы движений. Она не может даже сесть на стоящий здесь стул.")

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

		saynn("Она извивается, но ты держишь её крепко. Она кажется довольно строптивой, и тут тебе приходит в голову идея. Одна твоя рука начинает скользить по её телу, по латексу, лаская её обнажённую грудь... прежде чем добраться до шеи. Ты хватаешь её, и твои пальцы ложатся на её горло, чуть выше ошейника.")

		saynn("[say=eliza]Ах...[/say]")

		saynn("Ты сжимаешь. Не сильно. Просто создаешь давление, чтобы она почувствовала, что контроль ускользает из её рук. Она вздрагивает, и её дыхание прерывается.")

		saynn("[say=eliza]Пикантно..[/say]")

		saynn("[say=pc]"+str(ch1("...", "Shut up.", "Quiet, pet."))+"[/say]")

		saynn("Её рот слегка приоткрывается, вырывается короткий вздох. Её тело... которое до этого было совсем напряженным... начинает расслабляться в твоих руках.")

		saynn("[say=eliza]..ммхх..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_rubs_against_you")
	if(state == "eliza_rubs_against_you"):
		playAnimation(StageScene.Cuddling, "squirm", {pc="pc", npc="eliza"})
		saynn("Даже когда ты усиливаешь давление на её горло, она не пытается отстраниться... она просто терпит, а её тело отчаянно пытается протолкнуть воздух в легкие через сжатую гортань.")

		saynn("Ты душишь её... и наблюдаешь за тем, как её соски твердеют от этого процесса.")

		saynn("Ты заходишь дальше, сжимая руку всё крепче, пока она совсем не перестает дышать. Её глаза полузакрываются, а изо рта вырывается совершенно беззвучный стон.")

		saynn("[say=pc]"+str(ch1("...", "Fucking slut.", "Didn't expect you to be this slutty."))+"[/say]")

		saynn("Её щеки начинают пылать красным. Взгляд постепенно теряет фокус. Любое сопротивление исчезло уже давным-давно.")

		saynn("Примерно через двадцать секунд ты чувствуешь, что она становится совсем слабой. Пожалуй, сейчас самое время остановиться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_all")
	if(state == "after_all"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="eliza"})
		saynn("Ты разжимаешь пальцы на её горле... и наблюдаешь, как Элиза жадно ловит ртом воздух, пытаясь сделать глубокий вдох.")

		saynn("Она часто моргает, и туман в её глазах постепенно рассеивается.")

		saynn("[say=pc]"+str(ch1("Submit.", "You liked it. Submit, whore.", "You're a mess, Quinn. A hot, wet mess. Submit to me."))+"[/say]")

		saynn("Она всё ещё занята... дыханием. Её румянец медленно начинает спадать.")

		saynn("[say=eliza]Ты.. думал, что легкого удушения.. хватит, чтобы сломить меня?.. Х-ххах..[/say]")

		saynn("Похоже, она всё ещё бунтует.")

		saynn("Плевать.")

		saynn("Ты встаёшь и оставляешь её в покое.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
