extends RecruitSceneBase

var straponUsed = false
var vagVariant = false

func _init():
	sceneID = "FerriRecSceneOralDeny"

func _reactInit():
	putOn("ferri", "inmatewristcuffs")
	putOn("ferri", "basketmuzzle")

func _run():
	if(state == ""):
		addCharacter("ferri", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		straponUsed = (extra("strapon", "") != "") && (extra("variant", "") == "strapon")
		vagVariant = (extra("variant", "") == "vaginal")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={naked=true}})
		saynn("Ты просишь команду принести кольцевой кляп... и кое-что еще, более необычное. Кейт удивленно приподнимает бровь, но протягивает тебе маленькую розовую игрушку — виброяйцо — и рулон скотча.")

		saynn("И вот ты входишь в камеру. Ферри всё еще здесь: голая, в наручниках, с намордником и на поводке, привязанном к трубе.")

		saynn("Её голубые глаза впиваются в тебя в ту же секунду, как ты переступаешь порог.")

		saynn("[say=ferri]Наконец-то. Ну ты и тянешь, вредина... Развяжи меня уже![/say]")

		saynn("Ты поднимаешь кольцевой кляп. Её зрачки сужаются.")

		saynn("[say=ferri]Мяу?! Да ни за что! Я не собираюсь совать эту хрень в рот![/say]")

		saynn("[say=pc]"+str(ch1("You don't get to say no.", "You'll wear what I give you.", "Open up, silly kitten."))+"[/say]")

		saynn("[say=ferri]Я тебе все пальцы откушу![/say]")

		saynn("С нынешним намордником ей это вряд ли удастся — металлическая корзина сдерживает клыки. Но намордник всё равно придется чем-то заменить.")

		saynn("Ты хватаешь Ферри за рога. Она взвизгивает, и по её спине пробегает дрожь, когда ты крепко сжимаешь их.")

		saynn("[say=ferri]М-мяу... не надо... не трогай их...[/say]")

		saynn("Верно. Это играет тебе на руку.")

		saynn("[say=pc]"+str(ch1("Then behave.", "Too late for that.", "You're so sensitive. Cute."))+"[/say]")

		saynn("Пока Ферри корчится от того, что ты трешь её рога, ты срываешь с неё намордник и запихиваешь кольцо-кляп ей в зубы. Она пытается выплюнуть его, но ты туго затягиваешь ремешок на затылке.")

		saynn("[say=ferri]Я.. не.. х-хороша.. хфф..[/say]")

		saynn("Это всё, что ей удается выдавить, прежде чем ты окончательно затыкаешь ей рот.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_start")
	if(state == "pp_start"):
		playAnimation(StageScene.ChairOral, "tease", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Её челюсть теперь зафиксирована в открытом положении, а в уголках губ уже скапливается слюна.")

		saynn("Ты опускаешься на колени и раздвигаешь её бедра. Она пытается свести их, но ты просто силой разводишь их в стороны.")

		saynn("[say=ferri]Мммф?![/say]")

		saynn("Ты прижимаешь маленький розовый вибропулю к её клитору, а затем приклеиваешь её к промежности с помощью скотча. Игрушка покоится прямо на её чувствительном бугорке. Пульт теперь у тебя в руке.")

		saynn("[say=ferri]Мммф..[/say]")

		saynn("[say=pc]"+str(ch1("Shh. It's just a little helper.", "You'll thank me later.", "Don't worry, silly kitten."))+"[/say]")

		saynn("Ты нажимаешь на кнопку.")

		saynn("Игрушка начинает жужжать у неё между ног!")

		saynn("Ферри вздрагивает, из-под кляпа вырывается приглушённый писк, а её бёдра дёргаются.")

		saynn("После этого ты садишься в кресло, которое стояло здесь всегда, и подтягиваешь Ферри к себе за поводок.")

		if (straponUsed):
			saynn("Ты также быстро закрепляешь на талии порно-ремень, резиновый наконечник которого уже завис у самых губ Ферри.")

		elif (vagVariant):
			saynn("Твоя киска уже на виду, влажная и ждущая.")

		else:
			saynn("Твой {pc.penis} уже наготове, полутвёрдый, покоится совсем рядом с губами Ферри.")

		saynn("[say=pc]"+str(ch1("You know what to do.", "Don't keep me waiting, slut.", "Get to work, worthless."))+"[/say]")

		saynn("Ферри свирепо смотрит на тебя снизу вверх, но её хвост нервно дёргается. Она медленно наклоняется вперёд.")

		saynn("Ты хватаешь её за один из рогов. Пожалуй, стоит её подбодрить.")

		if (straponUsed):
			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		elif (!vagVariant):
			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "vag_fuck")
	if(state == "pp_fuck"):
		playAnimation(StageScene.ChairOral, "suck", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ферри пропускает кончик твоего "+str("member" if !straponUsed else "shiny member")+" сквозь кольцо кляпа и начинает его сосать."+str(" You don't feel a single thing.. but it looks pretty hot." if straponUsed else "")+"")

		saynn("Ты немного прибавляешь мощность игрушки, и она начинает жужжать громче.")

		saynn("[say=ferri]Мрррф![/say]")

		saynn("Она пытается дернуться в сторону, но твоя рука быстро возвращает её назад. Её язык инстинктивно обвивает твой"+str(" rubber" if straponUsed else "")+"член.")

		saynn("[say=pc]"+str(ch1("That's it. Keep sucking.", "Don't stop. Use that tongue, little slut.", "Good slut. So obedient."))+"[/say]")

		saynn("Ты медленно поглаживаешь её рога, заставляя её тело пробирать дрожь. Её бедра начинают двигаться в такт, пока игрушка усердно работает над её клитором.")

		saynn("Она кивает головой, принимая тебя всё глубже; слюна стекает по твоему стволу, а её хвост закручивается.")

		saynn("Ты наблюдаешь за её лицом. Дыхание становится чаще, отчаяннее, а бёдра уже непроизвольно сжимаются.")

		saynn("[say=ferri]Хфф.. хфф.. ммнгх..[/say]")

		saynn("Ты видишь, что она уже на пределе. И тогда ты щелкаешь пультом, выключая жужжание.")

		saynn("[say=ferri]Ммм?..[/say]")

		saynn("Она отстраняется, тяжело дыша носом, её глаза широко распахнуты от гнева.")

		saynn("[say=pc]"+str(ch1("Too fast, kitty. Too fast.", "I decide when you cum. Not yet.", "You don't get to cum. Not until I allow it."))+"[/say]")

		saynn("Ферри тихо рычит.")

		saynn("[say=pc]"+str(ch1("Back to work.", "Don't make me wait, slut.", "You want the vibrations back? Then earn them, you stupid cunt."))+"[/say]")

		saynn("Она сверлит тебя взглядом, но снова склоняет голову, принимая твой "+str("cock" if !straponUsed else "strapon")+" на этот раз глубже. Более агрессивно. Её язык плотно прижимается к нижней стороне.")

		saynn("Ты нажимаешь на кнопку пульта.")

		saynn("[say=ferri]Ннгх-..[/say]")

		saynn("Она стонет, обхватив твой член, пока вибрация бьёт прямо в её клитор. Ты гладишь её рога всё быстрее и грубее.")

		saynn("Её бёдра судорожно двигаются в воздухе. С подбородка стекает слюна.")

		saynn("Вскоре её тело снова напрягается, а хвост становится жёстким. Именно в этот момент ты снова выключаешь игрушку.")

		saynn("[say=ferri]Хафф-ф-ф![/say]")

		saynn("Она отрывается от твоего "+str("cock" if !straponUsed else "rubber shaft")+" и скулит... тонким, жалким, отчаянным звуком.")

		saynn("[say=pc]"+str(ch1("No, kitty.", "Not yet.", "Begging already? How cute."))+"[/say]")

		saynn("Ее глаза блестят от слез, а киска насквозь промокла. Видно, как она лоснится между ее бедер, а розовый шарик все еще приклеен к ее голубому клитору.")

		saynn("[say=pc]"+str(ch1("Don't stop sucking if you wanna cum.", "Keep sucking if you wanna cum.", "Keep sucking if you wanna cum, silly."))+"[/say]")

		saynn("Ферри лихорадочно кивает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_fast")
	if(state == "pp_fast"):
		playAnimation(StageScene.ChairOral, "suckfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Она снова бросается на твой"+str(" shiny" if straponUsed else "")+" член, заглатывая его до самого основания. Ее горло судорожно сжимается вокруг тебя; она давится, но полна решимости.")

		saynn("Ты щелкаешь пультом и лениво продолжаешь поглаживать ее рога.")

		saynn("[say=ferri]Хрррнммхх..[/say]")

		saynn("Ее бедра дико дергаются. Вибрация теперь на полной мощности... клитор получает мощную стимуляцию. А ты тем временем продолжаешь водить пальцами по бороздкам ее рогов.")

		saynn("[say=pc]"+str(ch1("That's it. Take all of it.", "Don't stop. Don't you dare stop.", "Suck. Suck like the desperate kitten you are."))+"[/say]")

		saynn("Все тело Ферри дрожит. Ее хвост бешено мечет из стороны в сторону. На подбородке смешиваются слезы и слюна.")

		saynn("Её стоны переходят в неистовое, влажное хлюпанье вокруг твоего члена.")

		saynn("Она вот-вот кончит."+str(" And so are you." if !straponUsed else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_cum")
	if(state == "pp_cum"):
		playAnimation(StageScene.ChairOral, "suckinside", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Почувствовав невероятную жестокость, ты выключаешь игрушку.")

		saynn("[say=ferri]Х-Хафф![/say]")

		saynn("И прежде чем она успевает отстраниться, ты хватаешь её за рога и вжимаешь лицом в свой "+str("cock" if !straponUsed else "shiny shaft")+", заталкивая его глубоко ей в глотку.")

		saynn("[say=ferri]ГХХХК-![/say]")

		saynn("Она давится и бьётся в своих путах... но сбежать не может. Ты мощно всаживаешь таз ей в рот, а твои руки грубо вжимают её лицо в твою плоть!")

		if (!straponUsed):
			saynn("[say=pc]"+str(ch1("You don't get to cum. But I do.", "Get denied, slut. Take it. Take all of it.", "No cumming for stupid brats. Swallow. Now."))+"[/say]")

			saynn("Её горло судорожно сжимается... Твой оргазм накрывает мгновенно. Член начинает пульсировать, выстреливая густыми порциями {pc.cum} прямо ей в глотку. У неё нет выбора — ей приходится всё проглатывать, захлёбываясь и задыхаясь, пока из глаз текут слёзы.")

			saynn("[say=ferri]Глоть.. глоть.. ннгх..[/say]")

			saynn("Ты держишь её так до последней судороги, пока твои яйца не опустеют.")

		else:
			saynn("[say=pc]"+str(ch1("You don't get to cum. Just choke.", "Get denied, slut. Just choke on this.", "No cumming for stupid brats. Choke on this instead."))+"[/say]")

			saynn("Её горло сильно сжимается... Она действительно задыхается и давится твоей игрушкой, из глаз текут слёзы. Ты почти ничего не чувствуешь, но выглядит это чертовски горячо.")

			saynn("[say=ferri]Гхх.. гхх.. ннгх..[/say]")

			saynn("Ты держишь её так, пока она окончательно не теряет контроль.")

		saynn("Затем ты отпускаешь её рога и отталкиваешь её назад.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_pullout")
	if(state == "pp_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Ферри валится на спину, жадно хватая ртом воздух. Слюна"+str(" and your seed are" if !straponUsed else " is")+"капает с её губ. Её тело дрожит после стольких отказов, киска насквозь промокла от её соков, игрушка медленно соскальзывает, а пластырь уже совсем размок.")

		saynn("Ты берешь корзинный намордник и заменяешь им кольцо-кляп. Её клыки цокают о металл. Её тело постепенно остывает."+str(" You take off your strapon harness.." if straponUsed else "")+"")

		saynn("[say=ferri]Ты.. СТАЯ!.. Ах ты сучка.. хафф-ф.. Ненавижу тебя..[/say]")

		saynn("Её голос слабый и охрипший.")

		saynn("[say=pc]"+str(ch1("Obey and you might get what you want.", "Obey and you might get what you want, whore.", "Obey and you might get what you want, worthless."))+"[/say]")

		saynn("Ты подбираешь игрушку с пола и выходишь из камеры, чтобы посмотреть на реакцию Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "vag_fuck"):
		playAnimation(StageScene.ChairOral, "lick", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Язык Ферри замирает у входа в твою киску. Её дыхание горячее и прерывистое. Из-за кольцевой кляпы её рот широко раскрыт.")

		saynn("Ты нажимаешь на кнопку пульта. Пуля-вибратор между её ног оживает, стимулируя клитор.")

		saynn("[say=ferri]Ннгх..[/say]")

		saynn("Она вздрагивает, её бёдра резко дёргаются вперёд. Наконец, её язык проскальзывает сквозь кольцо и проводит по твоей щели.")

		saynn("[say=pc]"+str(ch1("That's it. Lick.", "Use that tongue, kitten.", "Don't make me wait."))+"[/say]")

		saynn("Ты используешь её рог, чтобы притянуть её лицо ближе. Её нос касается твоего клитора. Она резко втягивает воздух.")

		saynn("Затем она начинает лизать твою щель... делая влажные мазки от входа до капюшона. Из-за кляпы всё получается грязно: слюна и твоя смазка смешиваются, стекая по её подбородку.")

		saynn("[say=ferri]Мррф.. лкк.. лкк..[/say]")

		saynn("Ты откидываешься назад, раздвигая ноги шире. Игрушка вибрирует у её лица, заставляя её скулить прямо в твою щель. Её бёдра двигаются в воздухе, пытаясь поймать вибрацию.")

		saynn("[say=pc]"+str(ch1("Good girl. Keep going.", "Faster. Use the whole tongue.", "You like the taste, don't you, slut?"))+"[/say]")

		saynn("Хвост Ферри непроизвольно виляет. Она зарывается лицом ещё глубже, её язык проникает внутрь тебя, изгибаясь, чтобы ласкать стенки влагалища.")

		saynn("Ты медленно поглаживаешь её рога, чувствуя, как она вздрагивает от каждого прикосновения.")

		saynn("[say=ferri]Ммм.. мммпф![/say]")

		saynn("Её бёдра начинают слегка подрагивать. Она уже близко — это видно по тому, как напрягаются её бёдра и как отчаянно звучат её приглушённые стоны.")

		saynn("Ты нажимаешь на кнопку пульта, обрывая жужжание.")

		saynn("[say=ferri]Хнг?![/say]")

		saynn("Она отстраняется, жадно хватая ртом воздух через нос; её глаза широко распахнуты и полны мольбы.")

		saynn("[say=pc]"+str(ch1("Not yet.", "I decide when you cum.", "You don't get to cum that easily."))+"[/say]")

		saynn("Ферри тихо рычит.")

		saynn("[say=pc]"+str(ch1("Back to work.", "Keep licking if you want the vibration back.", "You want to cum? Earn it, worthless."))+"[/say]")

		saynn("Она бросает на тебя сердитый взгляд, но снова склоняет голову, вновь погружая язык в твою влажную киску. На этот раз она действует агрессивнее, облизывая клитор круговыми движениями и быстро дразня его кончиком языка.")

		saynn("Ты снова нажимаешь на кнопку пульта.")

		saynn("[say=ferri]Нннх..![/say]")

		saynn("Всё её тело содрогается. Её язык продолжает ласкать твою щель, вырывая из тебя страстные стоны. Ты сильнее сжимаешь её рога, прижимая её лицо к своей киске. Это чертовски приятно.")

		saynn("Её бёдра мечутся в воздухе, словно у суки в течке. Слюна и твоё возбуждение размазываются по её морде.")

		saynn("Вскоре её тело снова напрягается, а хвост становится жёстким. Ты выключаешь игрушку.")

		saynn("[say=ferri]Хфф-ф-ф![/say]")

		saynn("Она отстраняется, и влатная нить слюны и твоих соков соединяет её губы с твоей киской. Она скулит, издавая громкие, разочарованные звуки.")

		saynn("[say=pc]"+str(ch1("No, kitty.", "Not yet.", "Begging already? How cute."))+"[/say]")

		saynn("Её глаза намокают, а киска пропитана насквозь. Розовая пуля всё ещё приклеена к её клитору.")

		saynn("[say=pc]"+str(ch1("Don't stop licking if you wanna cum.", "Keep eating me out if you wanna cum.", "Keep licking if you wanna cum, silly."))+"[/say]")

		saynn("Ферри лихорадочно кивает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_fast")
	if(state == "vag_fast"):
		playAnimation(StageScene.ChairOral, "lickfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Она снова ныряет внутрь, глубоко проникая языком, а затем тянется вверх, чтобы сосать твой клитор сквозь кольцо кляпа. Её нос прижимается к твоему лобку.")

		saynn("Ты нажимаешь на пульте на полную мощность. Пуля беспощадно жужжит прямо по её клитору.")

		saynn("[say=ferri]Хрррнммх![/say]")

		saynn("Её бёдра дико дёргаются. Её язык работает в неистовых, небрежных круговых движениях. Ты гладишь её рога всё быстрее и грубее, оттягивая её волосы.")

		saynn("[say=pc]"+str(ch1("That's it. Eat me out.", "Don't stop. Don't you dare stop.", "Lick. Lick like the desperate kitten you are."))+"[/say]")

		saynn("Все тело Ферри дрожит. Ее хвост бешено мечет из стороны в сторону. На подбородке смешиваются слезы и слюна.")

		saynn("Её стоны вибрируют прямо в твою киску. Она вот-вот кончит. И ты тоже.")

		saynn("Но.. чувствуя невероятную жестокость.. ты решаешь выключить игрушку!")

		saynn("[say=ferri]Х-Хафф![/say]")

		saynn("И прежде чем она успевает отстраниться, ты хватаешь её за рога и с силой вжимаешь её лицо в свою киску, втирая её нос и язык прямо в свой клитор.")

		saynn("[say=ferri]Хффф..![/say]")

		saynn("Она взвизгивает прямо тебе в щель, но сбежать не может. Твои бёдра дёргаются ей в лицо, размазывая твою влагу по её меху. Кольцо-кляп держит её рот открытым, а язык — зажатым для тебя..")

		saynn("[say=pc]"+str(ch1("You don't get to cum. But I do.", "Get denied, slut. Make me cum.", "No cumming for stupid brats. Lick. Now."))+"[/say]")

		saynn("Оргазм накрывает тебя мощной волной. Твои бёдра сжимаются вокруг её головы. Твоя киска пульсирует, извергая поток соков прямо ей на язык и в горло. У неё нет другого выбора, кроме как глотать, давясь и задыхаясь, пока ты втираешься ей в лицо.")

		saynn("[say=ferri]Глоть.. глоть.. ннгх..[/say]")

		saynn("Ты удерживаешь её так до последней судороги, пока твоё тело дрожит.")

		saynn("Затем ты отпускаешь её рога и отталкиваешь её назад.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_pullout")
	if(state == "vag_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Ферри валится на спину, жадно хватая ртом воздух. С её губ капает слюна вперемешку с твоими соками. Её тело всё ещё дрожит после стольких отказов; её киска промокла насквозь, игрушка медленно соскальзывает, а лента уже совсем размокла от влаги.")

		saynn("Ты берешь корзинный намордник и заменяешь им кольцо-кляп. Её клыки цокают о металл. Её тело постепенно остывает.")

		saynn("[say=ferri]Ты.. СТАЯ!.. Ах ты сучка.. хафф-ф.. Ненавижу тебя..[/say]")

		saynn("Её голос слабый и охрипший.")

		saynn("[say=pc]"+str(ch1("Obey and you might get what you want.", "Obey and you might get what you want, whore.", "Obey and you might get what you want, worthless."))+"[/say]")

		saynn("Ты подбираешь игрушку с пола и выходишь из камеры, чтобы посмотреть на реакцию Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pp_start"):
		putOff("ferri", "basketmuzzle")
		putOn("ferri", "ringgag")
		if(straponUsed):
			recWearStrapon()

	if(_action == "pp_cum"):
		if(straponUsed):
			getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Strapon)
		else:
			getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Penis)
		GM.pc.orgasmFrom("ferri")

	if(_action == "pp_pullout"):
		putOff("ferri", "ringgag")
		putOn("ferri", "basketmuzzle")
		recRemoveStrapons()

	if(_action == "vag_fast"):
		getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Vagina)
		GM.pc.orgasmFrom("ferri")

	if(_action == "vag_pullout"):
		putOff("ferri", "ringgag")
		putOn("ferri", "basketmuzzle")

	setState(_action)

func saveData():
	var data = .saveData()

	data["straponUsed"] = straponUsed
	data["vagVariant"] = vagVariant

	return data

func loadData(data):
	.loadData(data)

	straponUsed = SAVE.loadVar(data, "straponUsed", false)
	vagVariant = SAVE.loadVar(data, "vagVariant", false)
