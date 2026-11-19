extends SceneBase

var usedStrapon = false
var defStrapon = false
var straponHasCum = false

func _init():
	sceneID = "KaitLoveRideYouScene"

func _run():
	if(state == ""):
		addCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("Здесь на редкость тихо. Ты невольно вздыхаешь. Уши Кейт тут же навостряются.")

		saynn("[say=kait]Все хорошо?[/say]")

		saynn("[say=pc]Да так. Просто... ну, ты понимаешь.[/say]")

		saynn("Ее любопытный взгляд сканирует тебя, а пушистый хвост слегка подергивается.")

		saynn("[say=kait]Даже не знаю, если честно. Говори как есть. Устала? Раздражена из-за Эви?[/say]")

		saynn("Ты пожимаешь плечами.")

		saynn("[say=pc]Не знаю. Может, просто хочу секса?[/say]")

		saynn("На ее лице расплывается легкая улыбка.")

		saynn("[say=kait]Да неужели~?[/say]")

		saynn("Внезапно она бросается к одному из стульев, подхватывает его и подставляет тебе под зад.")

		saynn("[say=pc]Кейт?[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "get_pushed_down")
	if(state == "get_pushed_down"):
		playAnimation(StageScene.SexChair, "start", {pc="pc", npc="kait"})
		saynn("[say=kait]Присаживайся! Живо![/say]")

		saynn("Внезапно она толкает тебя. На стуле нет никакой мягкой подушки... так что твоя задница приняла весь удар на себя.")

		saynn("[say=pc]Ой! Полегче, Кейт.[/say]")

		saynn("Она стоит рядом, возвышаясь над тобой с ухмылкой на лице. Её хвост мерно и гипнотически покачивается позади неё.")

		saynn("[say=kait]Мой косяк. Не знала, что ты такой... нежный~.[/say]")

		saynn("[say=pc]Я не нежный.[/say]")

		saynn("[say=kait]Да неужели? Значит, ты весь такой твердый и крепкий~?[/say]")

		if (GM.pc.hasReachablePenis()):
			saynn("[say=pc]Тоже так не думаю.[/say]")

		else:
			saynn("[say=pc]Тоже так не думаю. У меня даже нет..[/say]")

			saynn("Она перебивает тебя.")

			saynn("[say=kait]Знаю~. Я не дура.[/say]")

		saynn("Медленно она тянется к своей рубашке... её пальцы начинают расстегивать пуговицы, одну за другой. Когда между краями ткани больше ничего не остается, она плавно разводит их, освобождая свою скромную грудь.")

		if (GM.pc.hasReachablePenis()):
			saynn("[say=kait]А как насчет... сейчас?.. Так лучше?[/say]")

		else:
			saynn("[say=kait]Тебе нравятся эти?[/say]")

		saynn("Она стоит перед тобой, воровато облизывая губы.")

		if (GM.pc.hasReachablePenis()):
			saynn("[say=pc]Это помогает.[/say]")

		else:
			saynn("[say=pc]Возможно.[/say]")

		if (!GM.pc.hasReachablePenis()):
			addButton("Продолжить", "Смотреть, что будет дальше", "lap_pick_menu")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "kait_on_lap")
	if(state == "lap_pick_menu"):
		saynn("Выбери страпон, который Кейт наденет, когда будет скакать на тебе!")

		addButton("По умолчанию", "Использовать любой страпон, который есть у Кейт", "choose_strapon_def")
		addStraponButtons()
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "choose_strapon_pick")
	if(state == "kait_on_lap"):
		#if (!usedStrapon):
		playAnimation(StageScene.SexChair, "tease", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		#else:
		#	playAnimation(StageScene.SexChair, "tease", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		addCharacter("kait", ["naked"])
		saynn("Она стремительно сбрасывает шорты и футболку, после чего подходит ближе и усаживается к тебе на колени верхом.")

		saynn("[say=pc]Кейт...[/say]")

		saynn("Её лапа ложится тебе на лицо, закрывая рот.")

		saynn("[say=kait]Я сделаю всё... Просто расслабься и наслаждайся...[/say]")

		saynn("Ну... ты в надежных руках... так что почему бы и нет.")

		if (defStrapon):
			saynn("Ты опускаешь взгляд и смотришь, как она начинает затягивать страпон-ремень на твоем поясе. Ты не приносил свой, так что это наверняка её — с толстым шариком у основания.")

			saynn("[say=pc]Любишь узлы?[/say]")

			saynn("[say=kait]Тсс...[/say]")

			saynn("Она выливает немного лубриканта и затем своими лапами размазывает его по стержню.")

		elif (usedStrapon):
			saynn("Ты опускаешь взгляд и смотришь, как она начинает затягивать предоставленный тобой страпон-ремень на твоем поясе. Закончив с этим, она также выливает на него немного лубриканта... прежде чем размазать его лапами по стержню.")

			saynn("[say=kait]Приятно..[/say]")

		else:
			saynn("Ты опускаешь взгляд и видишь, как её лапа обхватывает твой {pc.penis}, делая несколько уверенных движений... пока он не станет твердым как камень... и не упрется в её пушистую промежность.")

		saynn("Обе её лапы теперь лежат на твоих плечах, пока она медленно двигает телом вверх-вниз, позволяя своим чувствительным губам касаться твоего"+str(" новый блестящий" if usedStrapon else "")+" члена. Кейт прикусывает губу, и из её груди вырывается тихое мурлыканье.")

		saynn("Она наклоняется ближе к твоему лицу, почти касаясь носами. Твои руки ложатся ей на бедра, пальцы погружаются в мягкий мех.")

		saynn("[say=kait]Ммм.. кажется, я уже готова к тебе..[/say]")

		saynn("Она нежно целует тебя.. а затем осыпает твою щеку чередой коротких поцелуев. Её голос переходит в теплый, приглушенный шепот..")

		saynn("[say=kait]И ты тоже готов..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_begins_riding")
	if(state == "kait_begins_riding"):
		#if (!usedStrapon):
		playAnimation(StageScene.SexChair, "sex", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		#else:
		#	playAnimation(StageScene.SexChair, "sex", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		saynn("Она приподнимается ровно настолько, чтобы её лапа могла направить кончик твоего "+str("cock" if !usedStrapon else "strapon")+" к самому входу. Как только её складки захватывают "+str("твой член" if !usedStrapon else "it")+", её взгляд намертво приковывается к твоему.")

		saynn("[say=kait]Посмотри на себя.. ты завел меня"+str(" тоже хочет" if !usedStrapon else " так возбуждена")+"..[/say]")

		saynn("Медленно, одним долгим.. тягучим.. движением, она насаживается на твой "+str("cock" if !usedStrapon else "резиновый член")+", позволяя своим влажным внутренним стенкам прочувствовать каждую бороздку "+str("you" if !usedStrapon else "твоя игрушка")+". К концу движения из её пасти вырывается короткий, сдавленный стон.")

		saynn("[say=kait]Ах.. так полно..[/say]")

		saynn("Она отрывает задние лапы от пола.. теперь она полностью опирается на твои колени, плотно обхватив тебя бедрами.")

		saynn("И затем.. она начинает двигаться.. не подпрыгивая, а именно втираясь.. медленно покачивая бедрами вперед-назад."+str(" Ты чувствуешь, как её горячая, жаждущая киска сжимается вокруг твоего члена." if !usedStrapon else " Ты не особо что-то чувствуешь... но вид просто потрясающий... ты видишь, как её жаждущая киска обхватывает твой резиновый ствол.")+"")

		saynn("[say=kait]Ннгх.. да.. вот так..[/say]")

		saynn("Ее лапы крепче вцепляются в твои плечи, когти слегка впиваются в кожу. При этом твои руки всё еще лежат на ее бедрах, поддерживая ее, хотя она в этом явно не нуждается.")

		saynn("Не прерываясь, она наклоняется для настоящего поцелуя.. куда более глубокого. Ее кошачий язычок проскальзывает между твоих зубов и находит твой, начиная с ним танцевать. Она закрывает глаза, полностью сосредоточившись на приятных ощущениях.. и снова слышится мурчание..")

		saynn("[say=kait]..мур-р-р~..[/say]")

		saynn("Когда вы отрываетесь друг от друга, вы оба запыхались, а ваши лбы всё еще соприкасаются. Взгляд Кейт кажется затуманенным.")

		saynn("[say=kait]Знаешь.. ты так хорошо ощущаешься внутри меня..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ride_faster")
	if(state == "ride_faster"):
		#if (!usedStrapon):
		playAnimation(StageScene.SexChair, "fast", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		#else:
		#	playAnimation(StageScene.SexChair, "fast", {pc="pc", npc="kait", bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		saynn("Она начинает двигаться быстрее, продолжая тереться о твой "+str("cock" if !usedStrapon else "toy")+", используя всё своё тело, чтобы раскачиваться на нём взад-вперед. Её тихое мурлыканье переходит в прерывистые стоны, а щеки заливает румянец.")

		saynn("[say=kait]Ммм.. ах.. хх.. ах..[/say]")

		saynn("Ты чувствуешь, как её киска становится ещё влажнее, от её секса исходит чистый жар. Её внутренние стенки начинают пульсировать.. время от времени сжимаясь вокруг тебя.")

		saynn("[say=kait]Ох.. хх.. кажется, я.. хах.. уже близко..[/say]")

		saynn("Она так тяжело дышит.. но когда ты пытаешься ответить ей толчками, она тут же останавливает тебя.")

		saynn("[say=kait]Нет.. дай мне.. я сама всё.. ммх.. сделаю..[/say]")

		saynn("И ты позволяешь ей.. Траханье Кайта становится ещё более неистовым.. более отчаянным. Всё её тело работает на то, чтобы доставить удовольствие вам обоим, "+str("трение — это" if !usedStrapon else "трение и давление — это")+" заставляя и тебя тихо тяжело дышать. Страстные стоны срываются с её губ..")

		saynn("[say=kait]Ах.. ах.. тебе так хорошо.. ах.. я сейчас.. я..[/say]")

		if (!usedStrapon):
			saynn("Ты тоже на пределе..")

		addButton("Продолжить", "Смотреть, что будет дальше", "ride_cum")
	if(state == "ride_cum"):
		if (!usedStrapon):
			playAnimation(StageScene.SexChair, "inside", {pc="pc", npc="kait", pcCum=true, bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		else:
			playAnimation(StageScene.SexChair, "inside", {pc="pc", npc="kait", pcCum=straponHasCum, bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
			#playAnimation(StageScene.SexChair, "inside", {pc="pc", npc="kait", pcCum=straponHasCum, bodyState={exposedCrotch=true,hard=true}, npcBodyState={naked=true}})
		saynn("Она не успевает договорить — её накрывает волна неистового наслаждения. Когти впиваются в твои плечи, всё её тело напрягается, спина выгибается, а из приоткрытого рта вырывается горячий стон любви.")

		saynn("[say=kait]Ааах-х-х..[/say]")

		if (!usedStrapon):
			saynn("Стенки её киски с силой сжимаются вокруг твоего члена, совершая мощные пульсирующие толчки. От невероятной тесноты её щелей тебя окончательно сносит с катушек.")

			saynn("[say=pc]Кейт...[/say]")

			saynn("[say=kait]Просто кончи в меня.. ммм-х..[/say]")

			saynn("Приятно получить разрешение.. но всё равно было уже слишком поздно. Твой {pc.penis} уже пульсирует внутри неё.. выплескивая густую, горячую {pc.cum} глубоко в её содрогающуюся киску.. заполняя её до краёв..")

			saynn("[say=kait]Ааах-х-х..[/say]")

			saynn("Она бессильно оседает на тебя, обнимая руками; её тело всё ещё дрожит от накатывающих волн экстаза, которые оставляют после себя легкие конвульсии, заставляя её подёргиваться вокруг твоего всё ещё пульсирующего члена. Её дыхание — короткое, горячее и прерывистое — обжигает твои губы, пока ты продолжаешь кончать в неё..")

			saynn("[say=kait]Так.. много..[/say]")

		else:
			saynn("Стенки её киски крепко обхватывают твой резиновый ствол, совершая мощные пульсирующие толчки. Зрелище настолько горячее, что тебе едва удаётся сдерживаться.")

			if (straponHasCum):
				saynn("[say=pc]Кейт...[/say]")

				saynn("[say=kait]Просто кончи в меня.. ммм-х..[/say]")

				saynn("Приятно получить добро... но всё равно было уже слишком поздно. Твой страпон сжало, он уже пульсировал внутри неё... вкачивая густую, горячую сперму глубоко в её содрогающуюся киску... наполняя её до краёв...")

				saynn("[say=kait]Ааах-х-х..[/say]")

				saynn("Она бессильно оседает на тебя, обнимая руками; её тело всё ещё дрожит от накатывающих волн экстаза, которые оставляют после себя легкие конвульсии, заставляя её подёргиваться вокруг твоего всё ещё пульсирующего члена. Её дыхание — короткое, горячее и прерывистое — обжигает твои губы, пока ты продолжаешь кончать в неё..")

				saynn("[say=kait]Так.. много..[/say]")

			else:
				saynn("[say=kait]Так х-хорошо..[/say]")

				saynn("Она бессильно оседает на тебя и обнимает руками; её тело всё ещё дрожит от накатывающих волн экстаза, которые отзываются мелкими конвульсиями, заставляя её подёргиваться на твоей резиновой игрушке. Её дыхание — короткое, горячее и прерывистое — щекочет твои губы, пока вы обнимаетесь...")

		if (!usedStrapon):
			saynn("Она не спешит слезать... просто остается так... насаженная на тебя. По мере того как её оргазм начинает угасать... угасает и твой. В её груди снова раздается низкое, довольное урчание...")

		else:
			saynn("Она не спешит слезать... просто остается так... насаженная на тебя. Её оргазм постепенно идет на спад. В её груди снова раздается низкое, довольное урчание...")

		saynn("[say=kait]Ха.. хах..[/say]")

		saynn("Она ластится к твоему лицу.")

		saynn("[say=kait]Это была.. отличная разминка..[/say]")

		saynn("Она бормочет это сонным и удовлетворенным голосом. Твои руки остаются на её бёдрах, нежно поглаживая мех.")

		saynn("Вы просто сидите так... наслаждаясь компанией друг друга... Кейт всё ещё на твоём "+str("cock" if !usedStrapon else "toy")+"внутри неё. В воздухе стоит густой запах секса..")

		saynn("[say=kait]..люблю тебя..[/say]")

		saynn("Оууу.")

		saynn("[say=pc]И я тебя люблю, Кейт.[/say]")

		saynn("Ты оставляешь легкий поцелуй на её губах. Она отвечает тебе взаимностью.")

		saynn("Ты остаешься в таком положении еще на какое-то время... пока...")

		saynn("[say=kait]..но становится уже не совсем комфортно..[/say]")

		saynn("Тогда лучше на этом и остановиться.")

		if (!usedStrapon || straponHasCum):
			saynn("Кейт постепенно приподнимается, стараясь прикрыть лапой свою набитую щель... чтобы ни капли не вытекло наружу.")

		else:
			saynn("Кейт постепенно приподнимается, стараясь прикрыть своей лапкой промокшую щель... она так сильно течет, что ей приходится это делать.")

		saynn("[say=kait]Думаю, мне не помешает немного освежиться в душе.."+str(" но всё же не внутри меня~." if (!usedStrapon || straponHasCum) else "")+"[/say]")

		saynn("Она натягивает одежду... и поспешно убегает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_remstrapon")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "choose_strapon_pick", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "kait_on_lap"):
		pullShortsDown("pc")

	if(_action == "choose_strapon_def"):
		usedStrapon = true
		defStrapon = true
		pullShortsDown("pc")
		putOn("pc", "StraponCanine")
		setState("kait_on_lap")
		return

	if(_action == "choose_strapon_pick"):
		usedStrapon = true
		defStrapon = false
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		var theFluids = strapon.getFluids()
		if(theFluids != null):
			if(theFluids.hasFluidType("Cum")):
				straponHasCum = true
				setFlag("KaitModule.gotKaitPregMaybe", true)
		pullShortsDown("pc")
		setState("kait_on_lap")
		return

	if(_action == "ride_cum"):
		getCharacter("kait").cummedInVaginaBy("pc", FluidSource.Penis if !usedStrapon else FluidSource.Strapon)
		GM.pc.orgasmFrom("kait")

	if(_action == "endthescene_remstrapon"):
		if(defStrapon):
			GM.pc.removeStrapon()
		elif(usedStrapon):
			GM.pc.unequipStrapon()
		fixUniform("pc")
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["usedStrapon"] = usedStrapon
	data["defStrapon"] = defStrapon
	data["straponHasCum"] = straponHasCum

	return data

func loadData(data):
	.loadData(data)

	usedStrapon = SAVE.loadVar(data, "usedStrapon", false)
	defStrapon = SAVE.loadVar(data, "defStrapon", false)
	straponHasCum = SAVE.loadVar(data, "straponHasCum", false)
