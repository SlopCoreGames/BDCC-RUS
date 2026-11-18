extends SceneBase

func _init():
	sceneID = "DrugDenKidlat5Scene"

func _run():
	if(state == ""):
		addCharacter("kidlat", ["naked"])
		playAnimation(StageScene.Duo, "stand", {npc="kidlat", further=true, kidlatBox=true, npcBodyState={naked=true}})
		saynn("Ключи достаются нелегко... но стоит освободить Кидлат, кто знает, сколько она уже торчит в этих кандалах.")

		saynn("Когда ты делаешь шаг к ней... она слышит это... и начинает пятиться.")

		saynn("[say=kidlat]Эй... э-э... тебе что-то нужно? Давай договоримся, а? Мяу![/say]")

		saynn("Кандалы на её лодыжках сильно сковывают движения... так что ты легко настигаешь её и хватаешь за воротник, сжимая в другой руке ключ.")

		saynn("[say=kidlat]Ой!..[/say]")

		saynn("Её грудь слегка подпрыгивает, пока она тяжело дышит у тебя в руках...")

		addButton(" Открыть", "Разобрать оковы", "do_unlock")
	if(state == "do_unlock"):
		playAnimation(StageScene.Duo, "stand", {npc="kidlat", further=true, kidlatBox=true, npcBodyState={naked=true}})
		saynn("Резкий щелчок ключа в замке мягким эхом разносится по туннелю.")

		saynn("[say=kidlat]Что за чертовщина!..[/say]")

		saynn("Один за другим кандалы спадают с запястий и лодыжек Кидлат. Холодная металлическая тяжесть соскальзывает с её меха, оставляя на месте синяки. Когда ты отпираешь последнюю скобу, ключ ломается пополам... Какими же хрупкими они бывают...")

		saynn("[say=kidlat]Сорри, если это был твой заначка![/say]")

		saynn("Она замирает, когда твои руки тянутся к повязке на глазах и снимают её.")

		saynn("Несмотря на темноту, её глазам всё равно нужно привыкнуть — она часто моргает... но наконец она видит тебя. Сначала на её лице отражается крайнее удивление... но затем губы дрожат в неуверенной улыбке.")

		saynn("[say=kidlat]Ох, черт возьми, это ты![/say]")

		saynn("Её ушки слегка прижимаются к голове, а на щеках проступает румянец.")

		saynn("[say=kidlat]Не думала, что именно ты застанет меня в таком виде, дорогуша.[/say]")

		saynn("Она нервно посмеивается, потирая следы на запястьях. Её грудь вздымается и опускается с каждым глубоким вдохом, пока напряжение медленно покидает её тело.")

		saynn("[say=kidlat]Ну, и в чем дело? Тебе что-то нужно?..[/say]")

		saynn("[say=pc]А?[/say]")

		saynn("Она пожимает плечами.")

		saynn("[say=kidlat]Никто не помогает просто так, не желая чего-то взамен, милый. Не глупи. Чем я тебе за это задолжала?.. У меня есть кредиты... или что-нибудь еще...[/say]")

		saynn("Ты лишь пожимаешь плечами в ответ.")

		saynn("[say=pc]Расслабься, Кидлат. Мне просто захотелось тебя спасти.[/say]")

		saynn("Ее глаза слегка расширились.")

		saynn("[say=kidlat]Серьезно? Тебе совсем ничего не нужно? После всего этого? Ты странная. Не такая странная, как я, но всё же.[/say]")

		saynn("На мгновение Кидлат замирает, голая, покусывая нижнюю губу.")

		addButton("Продолжить", "Смотреть, что будет дальше", "a_hug")
	if(state == "a_hug"):
		playAnimation(StageScene.Hug, "hug", {npc="kidlat", npcBodyState={naked=true}})
		saynn("Без предупреждения она делает шаг вперед и обхватывает тебя лапами. Ее мех приятно щекочет кожу...")

		saynn("[say=kidlat]Я всё еще в долгу перед тобой, любовь моя![/say]")

		saynn("Она позволяет этому моменту продлиться еще немного... ее мурлыканье щекочет ухо, а пушистый хвост нежно касается твоей ноги.")

		saynn("[say=kidlat]Обещаю, в следующий раз я найду для тебя еще больше всякого добра. Я перерою здесь каждый закоулок![/say]")

		saynn("[say=pc]Только будь осторожнее со спрятанными заначками.[/say]")

		saynn("Она посмеивается.")

		saynn("[say=kidlat]Я — само воплощение безрассудства! Знаешь, жизнь ведь одна![/say]")

		saynn("Ты киваешь.")

		saynn("Теплые объятия... посреди холодного технического туннеля... Ничто не вечно.")

		saynn("[say=kidlat]Хорошо, что моя форма всё еще лежит в ящике.[/say]")

		saynn("[say=pc]Эм, ты что, тут голышом исследовала?[/say]")

		saynn("[say=kidlat]Э-э... это секрет.[/say]")

		saynn("Ну и кошка.")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_browsing_shop")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_unlock"):
		setFlag("DrugDenModule.Kidlat5Hap", true)
		getCharacter("kidlat").resetEquipment()

	if(_action == "a_hug"):
		addMessage("Kidlat will now sell 4 items instead of 3. Task updated!")
		setFlag("DrugDenModule.KidlatCustomShopGreet", "I don't have more to sell right now.. 'cause I was cuffed.. duh..")

	if(_action == "start_browsing_shop"):
		#getModule("DrugDenModule").regenerateKidlatItems()
		runScene("DrugDenKidlatShopScene")
		endScene()

	setState(_action)
