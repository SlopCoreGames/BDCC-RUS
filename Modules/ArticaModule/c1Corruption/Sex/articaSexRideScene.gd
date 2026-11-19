extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var isAnal = false
var hasCumInStrapon = false
var hasArticaCumInStrapon = false
var isStraponFuck = false

func _init():
	sceneID = "articaSexRideScene"

func _run():
	if(state == ""):
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		if (isNaked):
			saynn("Вид "+str("desperate caged up drippy cock" if isCaged else "hard drippy canine cock")+" Артики.. так и манит сделать с ней что-нибудь!")

		else:
			saynn("Вид "+str("desperate caged up cock leaving wet spots on her shorts" if isCaged else "hard canine cock bulging out her shorts")+" Артики.. так и манит сделать с ней что-нибудь!")

		saynn("Ты прикусываешь губу, молча пялясь на эту белоснежную пушистку, которая не может унять дрожь в теле от нахлынувшей похоти. Ваши взгляды встречаются...")

		saynn("[say=artica]Д-да?..[/say]")

		saynn("[say=pc]Давай трахаться![/say]")

		saynn("Твоя рука резко выбрасывается вперед, ты хватаешь девушку за воротник и тянешь её в сторону своей камеры.")

		saynn("[say=artica]Ик!..[/say]")

		addButton("Камера", "Прижать пушистку к кровати", "in_cell")
	if(state == "in_cell"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.SexCowgirlAlt, "tease", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		saynn("Ты несешься к своей камере, таща за собой девчонку за воротник; она едва успевает перебирать задними лапками, чтобы не отставать.")

		if (!isNaked):
			saynn("Как только ты врываешься в свою маленькую личную камеру, твои руки грубо сдирают с пушистой шкурки одежду, прижимая её к кровати... а следом за этим твоё голое тело нависает сверху.")

		else:
			saynn("Как только ты врываешься в свою маленькую личную камеру, твои руки вжимают обнаженную пушистицу в кровать... а следом за этим твоё голое тело нависает сверху.")

		saynn("[say=artica]И-ик.. с-слишком бы-стро..[/say]")

		saynn("Когда ты усаживаешься верхом на бедра Артики... ты кожей чувствуешь исходящий от неё жар."+str(" caged up" if isCaged else "")+" член... её запах заставляет твою собственную похоть разгораться с каждым мгновением.")

		if (GM.pc.hasReachableVagina()):
			saynn("С хитрой ухмылкой ты дразнишь "+str("her chastity cage by grinding it with your pussy slightly" if isCaged else "her hard cyan shaft by sliding your pussy along it, spreading your juices")+".")

		else:
			saynn("С хитрой ухмылкой ты дразнишь "+str("her chastity cage by grinding it with your ass slightly" if isCaged else "her hard cyan shaft by lowering yourself onto the tip, making it prod your tailhole")+".")

		if (isCaged):
			saynn("[say=artica]Я.. я в-не то.. аах-х.. в-верхняя.. и м-мой ч-член всё равно з-заблокирован.. всё б-бесполезно..[/say]")

			addDisabledButton("В киску", "Артика в клетке!")
			addDisabledButton("В задницу", "Артика в клетке!")
			addButtonWithChecks("Выбрать страпон", "Надеть на Артику один из твоих страпонов!", "pick_strapon", [], [[ButtonChecks.HasStrapons]])
			addButton("Трение через девственность", "Тереться о её клетку", "chastity_ride")
		else:
			saynn("[say=artica]Я... я н-не то.. аах-х.. а.. топ..[/say]")

			addButtonWithChecks("В киску", "Скачи на этом леденце-хуе своей щелью", "ride_pussy", [], [[ButtonChecks.HasReachableVagina]])
			addButton("В задницу", "Скачи на этом леденце-хуе своей задницей", "ride_ass")
			addDisabledButton("Трение через девственность", "Для этого Артику нужно запереть в клетку")
		addButton("Проехали", "Прервать сцену", "endthescene")
	if(state == "chastity_ride"):
		playAnimation(StageScene.SexCowgirlAlt, "inside", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("[say=pc]Для меня это совсем не бесполезно~.[/say]")

		if (GM.pc.hasReachableVagina()):
			saynn("С игривой ухмылкой ты устраиваешься над её клеткой, твоя киска зависает прямо над ней. Медленно ты опускаешься на неё, позволяя пуху почувствовать жар, исходящий от твоих влажных складок.")

		else:
			saynn("С игривой ухмылкой ты устраиваешься над её клеткой, твоё {pc.analStretch} анусное отверстие зависает прямо над ней. Медленно ты опускаешься на неё, позволяя пуху почувствовать жар, исходящий от твоего любовного туннеля.")

		saynn("[say=artica]Ах..[/say]")

		saynn("[say=pc]Так весело дразнить тебя... когда ты вот так заперта...[/say]")

		saynn("Артика слегка ерзает, её член напряженно упирается в свои оковы, голубой кончик никак не может пролезть сквозь твердую металлическую клетку. А ты тем временем начинаешь медленно тереться своим "+str("pussy" if GM.pc.hasReachableVagina() else "asshole")+" о неё, оседлав этот пушистик...")

		saynn("[say=artica]Ах-ахх.. ах..[/say]")

		saynn("Хотя прямой стимуляции нет, Артика стонет, её бедра слегка подпрыгивают на кровати... Она та-а-ак хочет секса...")

		saynn("[say=artica]П-пожалуйста.. это.. с-слишком тяжело вы-терпеть.. ах..[/say]")

		saynn("Её пальцы на лапах поджимаются от предвкушения, она вцепляется в простыни... пока ты продолжаешь скакать на её запертом члене, позволяя металлическому наконечнику внутри твоей "+str("slick pussy slit.. letting your hot juices drip onto it and land on her sensitive flesh." if GM.pc.hasReachableVagina() else "needy fuckhole.. letting it spread your start slightly.")+"")

		saynn("[say=artica]Ннх-х!.. П-по-о-ожалуйста.. д-даа..[/say]")

		saynn("Бедняжка совсем растаяла.. а ты лишь улыбаешься.")

		saynn("[say=pc]Раз уж ты так жаждешь, кончай уже~. Кончай, как маленькая девка в девственной девайсе.[/say]")

		saynn("С судорожным вздохом оргазм накрывает Артику; её член пульсирует в тесной клетке, извергая струи спермы прямо ей на живот.. Она отчаянно извивается под тобой, с губ одна за другой срываются стоны.. а ты лишь тихонько хихикаешь.")

		saynn("[say=artica]Ах.. ах-х.. ах.. ахх..[/say]")

		saynn("[say=pc]Хорошая девочка.[/say]")

		saynn("Когда её милый, короткий оргазм подходит к концу, она остается тяжело дышать, а её тело всё еще содрогается от отголосков пика.")

		saynn("[say=artica]..б-боги..[/say]")

		saynn("Вы так и лежите в обнимку.. прежде чем ты помогаешь ей вернуться на её место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "pick_strapon"):
		saynn("Какой страпон ты хочешь надеть на Артику?")

		addStraponButtons()
		addButton("Назад", "Вы передумали", "in_cell")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_put_on_strapon_on_artica")
	if(state == "do_put_on_strapon_on_artica"):
		playAnimation(StageScene.SexCowgirlAlt, "tease", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("[say=pc]И я не планирую тебя разблокировать~.[/say]")

		saynn("Артика слегка наклоняет голову, её большие щенячьи глазки выражают замешательство. Но всё становится ясно, когда ты достаешь один из своих ремней для страпона..")

		if (GM.pc.canWearStrapon()):
			saynn("[say=artica]Т-ты... т-ты реально собираешься это н-надеть?..[/say]")

		else:
			saynn("[say=artica]Ч-что ты собираешься..[/say]")

		saynn("Твоя улыбка сияет, пока ты затягиваешь ремни гарнесса на бедрах Артики, натягивая страпон поверх её зажатого в клетку члена..")

		saynn("[say=artica]Н-но..[/say]")

		saynn("[say=pc]Просто представь, что это твой настоящий член~.[/say]")

		saynn("[say=artica]Я.. н-не.. д..о..лжна.. ах..[/say]")

		saynn("Ты плюешь на резиновый ствол, а затем уверенно проводишь по нему рукой, размазывая слюну по блестящей поверхности.. от чего Артика напрягается.")

		if (hasArticaCumInStrapon):
			saynn("[say=pc]Ты еще даже не знаешь, что самое интересное~.[/say]")

			saynn("[say=artica]М-м?..[/say]")

			saynn("Ты не собираешься говорить ей, чем набит этот страпон.. И уж тем более — откуда взялась эта начинка..")

		elif (hasCumInStrapon):
			saynn("[say=pc]Ты еще даже не знаешь, что самое интересное~.[/say]")

			saynn("[say=artica]М-м?..[/say]")

			saynn("Ты и не думаешь говорить ей, чем набит этот страпон...")

		saynn("Как именно ты хочешь оседлать страпон?")

		addButtonWithChecks("В киску", "Оседлать страпон киской", "do_ride_strapon_pussy", [], [[ButtonChecks.HasReachableVagina]])
		addButton("В задницу", "Оседлать страпон попой", "do_ride_strapon_ass")
	if(state == "do_ride_strapon_pussy"):
		playAnimation(StageScene.SexCowgirlAlt, "sex", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты наклоняешься вперед и берешь Артику за подбородок, заставляя её посмотреть на тебя.")

		saynn("[say=pc]Тсс~. Просто будь хорошей секс-игрушкой и стони, пока я на тебе скачу.[/say]")

		saynn("И с этими словами твоя свободная рука обхватывает резиновый член Артики... прежде чем направить его, пока ты медленно опускаешься на него, и острый кончик касается твоей "+str("wet folds and then spreading them" if !isAnal else "{pc.analStretch} anal ring and then spreading it")+".. игрушка медленно скользит внутрь тебя.")

		saynn("[say=pc]О да..[/say]")

		saynn("При виде этого щеки Артики заливаются румянцем... давление внутри её клетки целомудрия нарастает.")

		saynn("[say=artica]Э-это... по-пошло.. ах..[/say]")

		saynn("Ты прерываешь её, насаживаясь на этот приятный толстый член, позволяя ему войти в твою "+str("cunt" if !isAnal else "ass")+" и растянуть внутренние стенки. Приятно.. слишком приятно.. с твоих губ срывается милый стон, когда мышцы напрягаются, а твоя "+str("slit" if !isAnal else "fuckhole")+" крепко обхватывает этот резиновый член.")

		if (!isAnal):
			saynn("[say=pc]Классный член, Артика. Чувствуешь, как моя киска сжимается вокруг него~?[/say]")

		else:
			saynn("[say=pc]Классный член, Артика. Чувствуешь, как моя задница сжимается вокруг него~?[/say]")

		saynn("[say=artica]..д-да.. ах..[/say]")

		saynn("Пальцы ног Артики поджимаются от удовольствия, когда ты начинаешь скакать на ней, выгибая спину при каждом движении. Ощущение наполненности пробирает дрожью до самого позвоночника.. пока Артика извивается под тобой, твоя "+str("wet pussy" if !isAnal else "anal star")+" скользит вверх и вниз по игрушке.")

		if (GM.pc.isWearingChastityCage()):
			saynn("Этот страпон массирует твою "+str("pleasure spot" if !isAnal else "prostate")+" так приятно, что ты чувствуешь, как давление за твоей клеткой целомудрия стремительно растет.. Две запертые милашки развлекаются вместе..")

		elif (GM.pc.hasReachablePenis()):
			saynn("Этот страпон массирует твою "+str("pleasure spot" if !isAnal else "prostate")+" так приятно, что ты чувствуешь, как давление в твоем собственном члене стремительно растет..")

		addButton("Быстрее", "Скачи на ней быстрее", "ride_strapon_pussy_faster")
	if(state == "ride_strapon_pussy_faster"):
		playAnimation(StageScene.SexCowgirlAlt, "fast", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!isAnal):
			saynn("По мере роста страсти растет и твой темп: страпон Артики молотит прямо по твоей шейке матки, пока ты вколачиваешься в её бедра. Клетка за ремнями страпона подергивается..")

		else:
			saynn("По мере роста страсти растет и твой темп: страпон Артики проникает глубоко в твою {pc.masc} задницу, пока ты вколачиваешься в её бедра. Клетка за ремнями страпона подергивается..")

		saynn("[say=artica]С-с-слишком м-много!.. ахх-х.. Я в-всё.. ах.. ахх.. П-пожалуйста.."+str(" m-miss.." if GM.pc.getGender() == Gender.Female else "")+"[/say]")

		saynn("Вау.. пушинка реально вошла во вкус, визуальная стимуляция доводит её до безумия.. Она не перестает стонать, пока ты скачешь на резиновой игрушке, которая не имеет ничего общего с её настоящим членом, а её бедра инстинктивно вздрагивают навстречу твоим движениям..")

		saynn("Твои стоны сливаются с её стонами.. Ты вот-вот кончишь..")

		addButton("Кончить", "Пора кончать..", "ride_strapon_cum")
	if(state == "ride_strapon_cum"):
		playAnimation(StageScene.SexCowgirlAlt, "inside", {npc="pc", pc="artica", pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("С каждым движением Артика чувствует, как возбуждение нарастает всё сильнее и сильнее.. Пока она просто не перестает это терпеть.")

		saynn("[say=artica]Ааааххх!.. ахх.. ах.. ах.. боже..[/say]")

		saynn("Её тело сотрясают конвульсии удовольствия, её влажная, заброшенная киска извергает поток девичьей смазки на простыни.. её запертый в клетке член пульсирует.. она кончает, будучи вынужденной оставаться в чехле.. её растраченное семя уже просачивается из-под ремней страпона..")

		if (hasArticaCumInStrapon):
			saynn("В то же время твой собственный оргазм накрывает тебя, словно приливная волна. Твои ноги дрожат, когда ты принимаешь в себя весь резиновый ствол, а внутренние стенки твоей влажной и теплой "+str("pussy squirting and" if !isAnal else "love tunnel")+" ритмично сжимаются вокруг игрушки.. сжимаясь так сильно, что это заставляет игрушку наконец извергнуть содержимое прямо в тебя.. [b]Сперма Артики заливает твою "+str("womb" if !isAnal else "butt")+"[/b]!")

			if (GM.pc.isWearingChastityCage()):
				saynn("Струи {pc.cum} прорываются сквозь маленькое отверстие твоей клетки целомудрия, попадая на серый живот Артики, оставляя милые узоры и пачкая её мех.")

			elif (GM.pc.hasReachablePenis()):
				saynn("Струи {pc.cum} вырываются из твоего {pc.penis} и попадают на серый живот и грудь Артики, оставляя милые узоры и пачкая её мех.")

			if (!isAnal):
				saynn("[say=pc]Ах.. да.. д-дай мне всех своих щенков, Артика.. твой член наполняет меня твоей густой, мощной спермой..[/say]")

			else:
				saynn("[say=pc]Ах.. да.. смотри, Артика.. твой член наполняет меня твоей густой, мощной спермой..[/say]")

			saynn("Пушистая замечает, что часть спермы уже вытекает наружу.. Её глаза расширяются.")

			saynn("[say=artica]Нн-н.. н-но.. ах.. к-как.. ч-что..[/say]")

			saynn("[say=pc]Ах.. Помнишь, как я доила тебя~?[/say]")

			saynn("Артика тяжело дышит и часто моргает, её щеки, кажется, краснеют ещё сильнее.")

		elif (hasCumInStrapon):
			saynn("В то же время твой собственный оргазм накрывает тебя, словно приливная волна. Твои ноги дрожат, когда ты принимаешь в себя весь резиновый ствол, а внутренние стенки твоей влажной и теплой "+str("pussy squirting and" if !isAnal else "love tunnel")+" ритмично сжимая игрушку.. сжимая так сильно, что это заставляет игрушку наконец излить всё содержимое внутрь тебя.. [b]Чья-то сперма наводняет твою "+str("womb" if !isAnal else "butt")+"[/b]!")

			if (GM.pc.isWearingChastityCage()):
				saynn("Струи {pc.cum} прорываются сквозь маленькое отверстие твоей клетки целомудрия, попадая на серый живот Артики, оставляя милые узоры и пачкая её мех.")

			elif (GM.pc.hasReachablePenis()):
				saynn("Струи {pc.cum} вырываются из твоего {pc.penis} и попадают на серый живот и грудь Артики, оставляя милые узоры и пачкая её мех.")

			if (!isAnal):
				saynn("[say=pc]Ах.. да.. оплодотвори меня, Артика.. твой член наполняет меня густой, сильной спермой..[/say]")

			else:
				saynn("[say=pc]Ах.. да.. смотри, Артика.. твой член наполняет меня густой, сильной спермой..[/say]")

			saynn("Пушистая замечает, что часть спермы уже вытекает наружу.. Её глаза расширяются.")

			saynn("[say=artica]Нн-н.. н-но.. ах.. к-как.. ч-что..[/say]")

			saynn("[say=pc]Ах.. я только что набила её чьей-то спермой~. Не твоей, не волнуйся~.[/say]")

			saynn("Артика тяжело дышит и часто моргает, её щеки, кажется, краснеют ещё сильнее.")

		else:
			saynn("В то же время твой собственный оргазм накрывает тебя, словно приливная волна. Твои ноги дрожат, когда ты принимаешь в себя весь резиновый ствол, а внутренние стенки твоей влажной и теплой "+str("pussy squirting and" if !isAnal else "love tunnel")+" ритмично сжимая игрушку..")

			if (GM.pc.isWearingChastityCage()):
				saynn("Струи {pc.cum} прорываются сквозь маленькое отверстие твоей клетки целомудрия, попадая на серый живот Артики, оставляя милые узоры и пачкая её мех.")

			elif (GM.pc.hasReachablePenis()):
				saynn("Струи {pc.cum} вырываются из твоего {pc.penis} и попадают на серый живот и грудь Артики, оставляя милые узоры и пачкая её мех.")

			saynn("[say=pc]Ах.. да.. Хорошая девочка.. Так завелась, просто глядя, как я скачу на твоём члене~?[/say]")

			saynn("Пушистая замечает, что часть спермы уже вытекает наружу.. Её глаза расширяются.")

			saynn("[say=artica]Нх-х.. ах.. д-да..х.. хах..[/say]")

			saynn("[say=pc]Хах. Милота какая.[/say]")

			saynn("Артика тяжело дышит и часто моргает, её щеки, кажется, краснеют ещё сильнее.")

		addButton("Отдохнуть", "Просто провести время вместе", "just_rest")
		if (hasCumInStrapon || hasArticaCumInStrapon):
			addButton("Сесть на лицо", "Заставить Артику убрать за собой", "pussy_sit_on_face_strapon")
		else:
			addDisabledButton("Сесть на лицо", "Чтобы сделать это, нужно смазать страпон чьей-нибудь спермой... в том числе и спермой Артики...")
	if(state == "ride_pussy"):
		playAnimation(StageScene.SexCowgirlAlt, "sex", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты наклоняешься вперед и берешь Артику за подбородок, заставляя её посмотреть на тебя.")

		saynn("[say=pc]Тсс~. Просто будь хорошей секс-игрушкой и стони, пока я на тебе скачу.[/say]")

		saynn("И вот, твоя свободная рука обхватывает пальцами собачий член Артики... направляя его, пока ты медленно опускаешься на него, и острое головка касается твоей "+str("wet folds and then spreading them" if !isAnal else "{pc.analStretch} anal ring and then spreading it")+".. её член медленно скользит внутрь тебя.")

		saynn("[say=pc]О да..[/say]")

		saynn("[say=artica]Ах!.. т-ты такая.. т-теплая.. н-не слишком б-быстро, о-ока... ах![/say]")

		saynn("Ты прерываешь её, насаживаясь на этот приятный толстый член, позволяя ему войти в твою "+str("cunt" if !isAnal else "ass")+" и растянуть внутренние стенки. Приятно.. слишком приятно.. с твоих губ срывается милый стон, когда мышцы напрягаются, а твоя "+str("slit" if !isAnal else "fuckhole")+" крепко обхватывая этот член.")

		if (!isAnal):
			saynn("[say=pc]Классный член, Артика. Чувствуешь, как моя киска сжимается вокруг него~?[/say]")

		else:
			saynn("[say=pc]Классный член, Артика. Чувствуешь, как моя задница сжимается вокруг него~?[/say]")

		saynn("[say=artica]..д-да.. ах..[/say]")

		saynn("Пальцы ног Артики поджимаются от удовольствия, когда ты начинаешь скакать на ней, выгибая спину при каждом движении. Ощущение наполненности пробирает дрожью до самого позвоночника.. пока Артика извивается под тобой, твоя "+str("wet pussy" if !isAnal else "anal star")+" скользит вверх и вниз по её члену.")

		if (GM.pc.isWearingChastityCage()):
			saynn("Её член так приятно массирует твою "+str("pleasure spot" if !isAnal else "prostate")+" что ты чувствуешь, как давление за клеткой целомудрия стремительно растёт..")

		elif (GM.pc.hasReachablePenis()):
			saynn("Её член так приятно массирует твою "+str("pleasure spot" if !isAnal else "prostate")+" так приятно, что ты чувствуешь, как давление в твоем собственном члене стремительно растет..")

		addButton("Быстрее", "Скачи на ней быстрее", "ride_pussy_faster")
	if(state == "ride_pussy_faster"):
		playAnimation(StageScene.SexCowgirlAlt, "fast", {npc="pc", pc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!isAnal):
			saynn("С ростом страсти растёт и темп: член Артики молотит по твоей шейке матки, пока ты с силой вжимаешься в её бёдра.")

		else:
			saynn("С ростом страсти растёт и темп: член Артики проникает глубоко в твою {pc.masc} задницу, пока ты с силой вжимаешься в её бёдра.")

		saynn("[say=artica]С-с-слишком м-много!.. ахх-х.. Я в-всё.. ах.. ахх.. П-пожалуйста.."+str(" m-miss.." if GM.pc.getGender() == Gender.Female else "")+"[/say]")

		saynn("Узел Артики раздувается, делая основание её члена ещё толще.. настолько, что шар уже не влезает целиком, а лишь хлопает по твоей "+str("needy {pc.vaginaStretch} pussy folds" if !isAnal else "needy {pc.analStretch} ring")+".. Но ты продолжаешь пытаться, шаг за шагом растягиваясь всё сильнее..")

		saynn("[say=artica]О-он н-не.. ах.. н-не в-влезет.. ах![/say]")

		saynn("Звучит как вызов.")

		saynn("[say=pc]Я справлюсь![/say]")

		addButton("Принять узел", "Втисни его силой!", "ride_pussy_cum")
	if(state == "ride_pussy_cum"):
		playAnimation(StageScene.SexCowgirlAlt, "inside", {npc="pc", pc="artica", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Огромная синяя сфера Артики никак не хочет пролезать внутрь, как бы усердно ты ни двигалась..")

		saynn("[say=artica]Я.. с-сейчас.. ааах-хх-хняаа-хх!..[/say]")

		saynn("Но.. вдруг.. решительным толчком ты умудряешься почти на всю глубину вонзиться в её пульсирующий член; раздутая узел начинает проскальзывать внутрь, растягивая твой узкий вход до невероятной ширины, чтобы вместить весь этот объем.. Затем, последним рывком, узел наконец оказывается полностью внутри, намертво привязывая тебя к извивающейся и дрожащей девушке..")

		saynn("[say=pc]Ох, блядь~..[/say]")

		if (!isAnal):
			saynn("Ты издаешь страстный стон экстаза, пока член Артики пульсирует внутри тебя, наполняя твою матку до краев множеством порций густой, мощной спермы.. в то время как твоя киска судорожно сжимается вокруг её раздутого ствола, а собственный оргазм захлестывает чувства, заставляя ноги дрожать.")

		else:
			saynn("Ты издаешь страстный стон экстаза, пока член Артики пульсирует внутри тебя, наполняя твою задницу до краев множеством порций густой, мощной спермы.. в то время как твои внутренние стенки сжимаются вокруг её раздутого ствола, а собственный оргазм захлестывает чувства, заставляя ноги дрожать.")

		saynn("[say=artica]Ннхх-х!.. ааах-х..хх.. ахх..[/say]")

		saynn("Ого, Артика отчаянно вцепилась в простыни, всё её тело дико бьется в конвульсиях, а её похотливые глаза закатываются вверх, её"+str(" own" if !isAnal else "")+" киска извергает поток девичьих соков прямо на её бёдра..")

		if (GM.pc.isWearingChastityCage()):
			saynn("Но это ещё не всё, что пачкает пушистая малышка: твой зажатый в клетке член тоже кончает ей на серый живот, оставляя тонкие струйки семени на её меху.")

		elif (GM.pc.hasReachablePenis()):
			saynn("Но это ещё не всё, что пачкает пушистая малышка: твой собственный член тоже кончает ей на серый живот, оставляя густые струйки семени на её меху.")

		saynn("И ты, и она тяжело дышите.. чувство тесноты уже никуда не исчезает, ведь вы теперь буквально сцеплены друг с другом, а её разбухший член застрял внутри тебя..")

		saynn("[say=artica]Ах-х.. хх.. з-застрял..[/say]")

		saynn("[say=pc]Да.. Позволь мне согреть твой член, Артика.[/say]")

		saynn("[say=artica]К-к.. к-конечно.. ах..[/say]")

		saynn("Впрочем, у неё всё равно нет выбора.")

		addButton("Отдохнуть", "Просто проведите время вместе, пока узел не спадёт", "just_rest")
		addButton("Сесть на лицо", "Заставить Артику убрать за собой", "pussy_sit_on_face")
		addButton("Секс с узлом", "(Грубо) Молоко высыхает на яйцах Артики", "pussy_knot_fucking")
	if(state == "just_rest"):
		if (isStraponFuck):
			saynn("Вы лежите вот так, и страпон Артики всё еще внутри тебя. Ты подаешься вперед, устраиваясь поудобнее на"+str(" round pregnant" if getCharacter("artica").isVisiblyPregnant() else "")+"её груди... в то время как её девственная клетка всё еще едва заметно пульсирует, заставляя резиновый фаллос шевелиться внутри...")

			saynn("[say=artica]Ах..[/say]")

			var acceptCaged = getFlag("ArticaModule.cagedAcceptStage", 0)
			saynn("[say=pc]Бедняжка. Ты бы хотела, чтобы внутри тебя был твой настоящий член?[/say]")

			if (acceptCaged <= 1):
				saynn("[say=artica]Д-дааа...[/say]")

				saynn("[say=pc]Ну, жаль. Похоже, мне придется получше натренировать твой разум~.[/say]")

			elif (acceptCaged <= 2):
				saynn("[say=artica]М-может быть... Я д-даже не знаю...[/say]")

				saynn("[say=pc]Ну, жаль. Похоже, мне придется получше натренировать твой разум~.[/say]")

			else:
				saynn("[say=artica]Н-нет... М-мой ч-член... бесполезен... л-лучше оставить его з-запертым...[/say]")

				saynn("[say=pc]Оууу. Ты такая хорошая девочка.[/say]")

			saynn("Вы еще немного обнимаетесь, прежде чем ты наконец снимаешь с нее страпон... разумеется, оставляя клетку. После этого ты просто отпускаешь Артику.")

			saynn("[say=artica]Береги...[/say]")

		else:
			saynn("Раз делать больше нечего, вы решаете просто полежать вместе. Ты наклоняешься вперед и удобно устраиваешься на"+str(" round pregnant" if getCharacter("artica").isVisiblyPregnant() else "")+" груди Артики... пока ее узел всё еще едва заметно пульсирует внутри тебя.")

			saynn("[say=artica]Ах..[/say]")

			saynn("[say=pc]Не ерзай, глупышка. Ты снова возбуждаешься.[/say]")

			saynn("[say=artica]Я... ммхх... п-пытаюсь... ах...[/say]")

			saynn("Ты хихикаешь и слизываешь капли с ее губ.")

			saynn("[say=pc]Бедняжка.[/say]")

			saynn("И вот так вы проводите время... пока узел Артики не спадет достаточно, чтобы ты смог из него выбраться... Ее сперма тут же начинает хлестать из твоего использованного отверстия...")

			saynn("Ты вытираешь всё, что можешь, и отпускаешь Артику.")

			saynn("Её ноги всё ещё дрожат.")

			saynn("[say=artica]Б-берегись..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getbackstrapon")
	if(state == "pussy_knot_fucking"):
		playAnimation(StageScene.SexCowgirlChoke, "fast", {npc="pc", pc="artica", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Даже когда он внутри тебя на всю длину.. тебе всё равно мало..")

		saynn("[say=pc]Держись, секс-игрушка.. Поездка будет жесткой..[/say]")

		saynn("[say=artica]Что?.. А-ах!..[/say]")

		saynn("С решимостью в глазах, ты вкладываешь всю свою силу и рывком тянешь себя вверх.. с силой выдергивая жирный узел из твоей "+str("used pussy" if !isAnal else "stuffed ass")+", позволяя сперме хлынуть наружу.. Тело бедной пушистой зверушки напрягается под тобой, от этого резкого движения она начинает сильно извиваться.")

		saynn("[say=pc]Ах..[/say]")

		saynn("Но ты ещё не закончил.. вместо того чтобы полностью отстраниться, ты снова начинаешь опускаться на её член, пытаясь силой протолкнуть узел обратно внутрь.")

		saynn("[say=artica]По-подожди!.. н-не-е-ет.. п-пожалуйста!.. о-остановись!.. ах-х..[/say]")

		saynn("Артика на самом деле пытается отстраниться от тебя.. её лапы упираются в тебя, пытаясь оттолкнуть.. но это не оставляет тебе выбора..")

		saynn("[say=pc]Нгхх.. Заткнись и завяжи меня, сучка![/say]")

		saynn("Ты отшвыриваешь её руки и крепко сжимаешь её горло, вдавливая пушистую задницу в кровать и силой проталкивая её узел внутрь себя; жирная сфера снова проскальзывает сквозь твою "+str("stretched wide pussy folds" if !isAnal else "stretched wide asshole")+"!")

		saynn("[say=artica]Кх-х!..[/say]")

		saynn("Твои ноги дрожат, твоя измученная "+str("slit" if !isAnal else "tailhole")+" сильно сжимается вокруг члена, который только что вошел в тебя... но ты не останавливаешься, снова приподнимаясь, чтобы принять узел... снова и снова, с каждым разом прилагая всё меньше усилий, пока твоя "+str("pussy" if !isAnal else "anal ring")+" адаптируется к траху узлом...")

		saynn("Сопротивление Артики быстро угасает, её глаза закатываются. Её губы беззвучно хватают воздух, пока твоя рука всё ещё сжимает её горло, а её тело дрожит под тобой...")

		saynn("В твоей камере пахнет горячим сексом... ты продолжаешь скакать на этом узле, сама вгоняя его туда и обратно... пока член Артики снова не начинает пульсировать внутри тебя! Всей мощью ты обрушиваешься вниз, принимая её на всю длину... вслед за чем горячее, полное мужской силы семя Артики снова выплескивается "+str("inside your womb" if !isAnal else "deep inside you")+" , а её яички дико напрягаются, пока ты выжимаешь их досуха своей растянутой "+str("cunt" if !isAnal else "inner walls")+".")

		if (!isAnal):
			if (GM.pc.isVisiblyPregnant()):
				saynn("[say=pc]Д-да.. я уже беременна, но мне нужно больше.. Мне нужно всё до последней капли..[/say]")

			else:
				saynn("[say=pc]Д-да.. залей меня своими щенками.. Мне нужно всё..[/say]")

		else:
			saynn("[say=pc]Д-да.. залей меня до краев.. Мне нужно всё..[/say]")

		saynn("Артика пускает слюни, наслаждение полностью захватило её разум. Твоё собственное тело к этому моменту тоже начинает сдавать, все мышцы.. измотаны..")

		saynn("Ты находишь в себе силы в последний раз рвануть узел наружу.. после чего.. просто валишься на девушку сверху..")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_knotfuck")
	if(state == "after_knotfuck"):
		playAnimation(StageScene.Sleeping, "sleep", {npc="pc", pc="artica", bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("Спустя несколько часов..")

		saynn("Твоя кровать такая мягкая.. Почему она не всегда такая мягкая?")

		saynn("Ты открываешь глаза..")

		saynn("[say=artica]П-п-привет.. эм..[/say]")

		saynn("Голова немного побаливает.. ой.. прямо как твоё привыкшее к разрывам дышло..")

		saynn("[say=artica]Я.. я н-не знала, стоит ли.. п-пробуждать тебя..[/say]")

		saynn("Такая милая..")

		saynn("[say=artica]Т-тебе что-нибудь нужно?..[/say]")

		saynn("[say=pc]А.. нет.. всё в порядке.[/say]")

		saynn("[say=artica]Н-надеюсь, я была хорошей.. с-.. с-секс-игрушкой..[/say]")

		saynn("Ты чмокаешь её в губы и встаёшь.")

		saynn("[say=pc]Хах. Да.[/say]")

		saynn("Ты тоже помогаешь ей подняться.")

		saynn("[say=artica]Я б-буду.. на своём месте..[/say]")

		saynn("[say=pc]Угу.[/say]")

		if (!isNaked):
			saynn("Артика хватает свою форму и убегает..")

		else:
			saynn("Артика пару раз моргает... а затем убегает...")

		saynn("Хм.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "pussy_sit_on_face"):
		playAnimation(StageScene.SexFaceSitting, "sit", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!isStraponFuck):
			saynn("Ты ждешь немного, пока узел Артики не спадет достаточно сильно... прежде чем плавно соскользнуть с него... шлеп...")

		else:
			saynn("Ты ждешь немного, прежде чем плавно снять с себя этот страпон.")

		saynn("[say=artica]Ах... э-это было... о-очень интенсивно...[/say]")

		saynn("[say=pc]Я еще не закончила~.[/say]")

		saynn("Вид Артики, лежащей под тобой, тяжело дышащей и извивающейся... наводит на еще одну... еще более извращенную идею... С озорным блеском в глазах ты усаживаешься верхом ей на лицо, подставляя свою грязную, использованную "+str("pussy" if !isAnal else "asshole")+"..")

		saynn("[say=pc]Вылизывай, Артика.[/say]")

		saynn("[say=artica]Ой...[/say]")

		saynn("Девушка колеблется, ее щеки заливаются густым румянцем... в то время как "+str("someone's" if (!hasArticaCumInStrapon && hasCumInStrapon) else "her own")+" семя начинает капать ей на лицо. Ее голова зажата между твоих бедер... ей некуда деться.")

		saynn("[say=pc]Лижи, иначе я просто буду втирать это тебе в лицо~.[/say]")

		saynn("Что бы она ни делала, ей не устоять перед этим пьянящим ароматом... от него Артика невольно высовывает язык, чтобы дать тебе "+str("pussy" if !isAnal else "anal ring")+" осторожный маленький лизь, слизывая часть этого... вкуса.")

		saynn("[say=pc]Ммм~..[/say]")

		if (!isAnal):
			saynn("Твой тихий стон заставляет Артику пробовать всё больше этого коктейля из твоих соков и "+str("someone's" if (!hasArticaCumInStrapon && hasCumInStrapon) else "her own")+" спермы; её тело дрожит, пока язык проникает всё глубже, раздвигая чувствительные складки и слизывая всё до последней капли...")

		else:
			saynn("Твой тихий стон заставляет Артику пробовать всё больше "+str("someone's" if (!hasArticaCumInStrapon && hasCumInStrapon) else "her own")+" спермы; её тело дрожит, пока язык проникает всё глубже, обходя чувствительное кольцо и слизывая всё до последней капли...")

		saynn("[say=pc]Хорошая.. девочка.. ммм-х.. маленькая жрица спермы..[/say]")

		saynn("Её язык работает без устали, вычищая твою "+str("pussy" if !isAnal else "butt")+" и исследуя тебя изнутри. И всё это время её "+str("own cock is hard again, pre dripping off the tip.." if !isStraponFuck else "caged cock is trying to get hard in its metal prison again, pre dripping off the tip..")+"")

		saynn("[say=pc]А теперь глотай.[/say]")

		saynn("Артика показывает тебе свой рот, полный "+str("someone's" if (!hasArticaCumInStrapon && hasCumInStrapon) else "her own")+" спермы... затем закрывает его и сглатывает... после чего демонстрирует, насколько он теперь пуст.")

		saynn("[say=pc]Какая хорошая девочка.. Спасибо, Артика~.[/say]")

		saynn("[say=artica]Н-нет.. б-без проблем..[/say]")

		saynn("Ты помогаешь ей прийти в себя и отправляешь её обратно на место. А сам остаёшься, чтобы немного прибраться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getbackstrapon")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "do_put_on_strapon_on_artica", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_cell"):
		processTime(2*60)

	if(_action == "chastity_ride"):
		processTime(10*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		getCharacter("artica").cummedOnBy("artica")

	if(_action == "ride_ass"):
		isAnal = true
		setState("ride_pussy")
		return

	if(_action == "do_put_on_strapon_on_artica"):
		processTime(2*60)
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		var theFluids = strapon.getFluids()
		if(theFluids != null):
			if(theFluids.hasFluidTypeWithCharID("Cum", "artica")):
				hasArticaCumInStrapon = true
			if(theFluids.hasFluidType("Cum")):
				hasCumInStrapon = true
		isStraponFuck = true

	if(_action == "do_ride_strapon_ass"):
		isAnal = true
		setState("do_ride_strapon_pussy")
		return

	if(_action == "ride_pussy_faster"):
		processTime(5*60)

	if(_action == "ride_strapon_cum"):
		processTime(6*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		if(isAnal):
			GM.pc.gotAnusFuckedBy("artica")
			GM.pc.cummedInAnusBy("artica", FluidSource.Strapon)
		else:
			GM.pc.gotVaginaFuckedBy("artica")
			GM.pc.cummedInVaginaBy("artica", FluidSource.Strapon)
		getCharacter("artica").cummedOnBy("pc")
		GM.pc.orgasmFrom("artica")

	if(_action == "pussy_sit_on_face_strapon"):
		processTime(10*60)
		getModule("ArticaModule").triggerCorruption(0.01)
		if(isAnal):
			GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Anus, "artica", BodypartSlot.Head, 0.2, 20.0)
		else:
			GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Vagina, "artica", BodypartSlot.Head, 0.2, 20.0)
		setState("pussy_sit_on_face")
		return

	if(_action == "ride_pussy_cum"):
		processTime(6*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		if(isAnal):
			GM.pc.gotAnusFuckedBy("artica")
			GM.pc.cummedInAnusBy("artica")
		else:
			GM.pc.gotVaginaFuckedBy("artica")
			GM.pc.cummedInVaginaBy("artica")
		if(GM.pc.isWearingChastityCage() || GM.pc.hasReachablePenis()):
			getCharacter("artica").cummedOnBy("pc")
		GM.pc.orgasmFrom("artica")

	if(_action == "just_rest"):
		processTime(20*60)

	if(_action == "pussy_sit_on_face"):
		processTime(10*60)
		getModule("ArticaModule").triggerCorruption(0.01)
		if(isAnal):
			GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Anus, "artica", BodypartSlot.Head, 0.2, 20.0)
		else:
			GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Vagina, "artica", BodypartSlot.Head, 0.2, 20.0)

	if(_action == "pussy_knot_fucking"):
		processTime(10*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		if(!isAnal):
			GM.pc.gotVaginaFuckedBy("artica")
			GM.pc.cummedInVaginaBy("artica")
			GM.pc.doPainfullyStretchHole(BodypartSlot.Vagina, "artica")
		else:
			GM.pc.gotAnusFuckedBy("artica")
			GM.pc.cummedInAnusBy("artica")
			GM.pc.doPainfullyStretchHole(BodypartSlot.Anus, "artica")

	if(_action == "after_knotfuck"):
		processTime(3*60*60)

	if(_action == "endthescene_getbackstrapon"):
		if(getCharacter("artica").isWearingStrapon()):
			var strapon = getCharacter("artica").getWornStrapon()
			getCharacter("artica").getInventory().removeEquippedItem(strapon)
			GM.pc.getInventory().addItem(strapon)
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy
	data["isAnal"] = isAnal
	data["hasCumInStrapon"] = hasCumInStrapon
	data["hasArticaCumInStrapon"] = hasArticaCumInStrapon
	data["isStraponFuck"] = isStraponFuck

	return data

func loadData(data):
	.loadData(data)

	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
	isAnal = SAVE.loadVar(data, "isAnal", false)
	hasCumInStrapon = SAVE.loadVar(data, "hasCumInStrapon", false)
	hasArticaCumInStrapon = SAVE.loadVar(data, "hasArticaCumInStrapon", false)
	isStraponFuck = SAVE.loadVar(data, "isStraponFuck", false)
