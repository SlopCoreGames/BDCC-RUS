extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var receivedPawjob = false
var usedCondom = false

func _init():
	sceneID = "articaSexPawjobScene"

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
		saynn("Похоже, Артика более открыта к... всяким пошлушкам. Так почему бы не помочь ей исследовать это?")

		saynn("[say=pc]Хватит этих подстольных лапок-пощекотушек. Пошли уже развлечемся по-настоящему![/say]")

		saynn("[say=artica]О?.. Л-лапки?..[/say]")

		saynn("Не особо вдаваясь в объяснения, ты хватаешь её за руку и тянешь к своей камере!")

		addButton("Камера", "Повеселиться", "in_cell")
	if(state == "in_cell"):
		playAnimation(StageScene.SexPawjob, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		addCharacter("artica", ["naked"])
		if (!isNaked):
			saynn("Ты заводишь Артику в свою камеру и предлагаешь ей раздеться. Без особого сопротивления её сиреневая форма падает на стул... Кажется, Артика совсем не стесняется наедине с тобой, с гордостью демонстрируя свои"+str(" round" if getCharacter("artica").isVisiblyPregnant() else "")+" forms.")

		else:
			saynn("Ты заводишь Артику в свою камеру и смотришь на неё. Кажется, Артика совсем не стесняется наедине с тобой, с гордостью демонстрируя свои"+str(" round" if getCharacter("artica").isVisiblyPregnant() else "")+" forms.")

		saynn("[say=pc]Покажи, что там у тебя есть.[/say]")

		if (isVerySlut):
			saynn("[say=artica]Ммм... Ты про мои лапки?.. Конечно.[/say]")

			saynn("Ты улыбаешься и поглаживаешь её пушистые бёдра.")

			saynn("[say=pc]Ну ты и лапочница, девчонка.[/say]")

			saynn("[say=artica]Да, есть такое.. ха-ха..[/say]")

		else:
			saynn("[say=artica]Ммм.. Показать?..[/say]")

			saynn("Ты улыбаешься и поглаживаешь её пушистые бёдра.")

			saynn("[say=pc]Твои подушечки. Покажи мне свои лапки, детка.[/say]")

			saynn("[say=artica]Ох.. ха-ха..[/say]")

		saynn("Артика сидит на твоей кровати, подложив под спину подушку, пока ты устраиваешься на противоположной стороне. Затем она медленно поднимает ноги..")

		saynn("Все её.. сокровища.. теперь действительно перед тобой.. даже больше, чем ты мог пожелать. Её {artica.breasts} с "+str("dark swollen milky nips" if getCharacter("artica").isLactating() else "perky cyan nips")+", её "+str("fluffy" if !getCharacter("artica").isVisiblyPregnant() else "round pregnant")+" животик, её {artica.penis}, обе её жаждущие дырочки.. и, конечно же.. великолепные лапки. Её щеки краснеют от твоего взгляда, а пальцы с коготками слегка поджимаются.")

		saynn("[say=artica]Вот так?..[/say]")

		if (GM.pc.hasReachablePenis()):
			saynn("От этого зрелища твой член наливается кровью за считанные секунды, а по вздувшимся венам начинает пульсировать жар..")

		saynn("Что ты хочешь сделать?")

		addButtonWithChecks("Принять лапосексуальный секс", "Позволить Артике творить магию своими лапками", "receive_pawjob", [], [[ButtonChecks.HasReachablePenis]])
		if (isCaged):
			addDisabledButton("Подставить ноги", "Артика в клетке.. Ты не сможешь ласкать её член ногами, пока она заперта..")
			addButton("Развлечения в целомудрии", "Артика в клетке.. но ты всё ещё можешь доставить ей удовольствие.. пусть и не напрямую", "chastity_give")
		else:
			addButton("Подставить ноги", "Позволить Артике использовать твои ноги для своего наслаждения", "offer_feet")
			addDisabledButton("Развлечения в целомудрии", "Это невозможно, пока Артика не в клетке")
		addButton("Отмена", "Прервать сцену", "endthescene")
	if(state == "receive_pawjob"):
		playAnimation(StageScene.SexPawjob, "sex", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Вид того, как Артика высоко задирает задние лапы... как её голубые подушечки сжимаются, когда она поджимает пальцы... заставляет тебя хотеть большего. И Артика это видит: она дразняще подносит лапы всё ближе и ближе к твоему твердому члену... отчего он начинает подергиваться...")

		saynn("[say=artica]М-можно?..[/say]")

		saynn("[say=pc]Давай, вперед.[/say]")

		saynn("Застенчиво Артика подчиняется: её задние лапы тянутся к тебе и осторожно обхватывают твой ствол, а её шершавые голубые подушечки обхватывают член... Одна лапа замирает, в то время как вторая начинает скользить по вздутым венам, достигая самой головки и собирая капли блестящей смазки на свои подушечки... прежде чем размазать её по всему твоему члену.")

		saynn("[say=pc]Нх... неплохо.[/say]")

		saynn("Ты сидишь неподвижно, позволяя Артике делать всю работу; обе её лапы теперь нежно ласкают тебя, скользя вверх и вниз по влажному стволу в медленном... но невероятно приятном... темпе. Её глаза полностью сосредоточены на твоём {pc.penis}, Артика закусывает губу, полностью отдаваясь процессу, чтобы доставить тебе лучший лапотрах в жизни...")

		addButton("Продолжить", "Смотреть, что будет дальше", "receive_pawjob_cum")
	if(state == "receive_pawjob_cum"):
		playAnimation(StageScene.SexPawjob, "fast", {pc="pc", npc="artica", pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("С каждым движением ты чувствуешь, как возбуждение нарастает, из твоих уст вырываются короткие стоны удовольствия, пока пальцы и подушечки Артики с нарастающей страстью трутся о твой член, а твои бедра инстинктивно дергаются..."+str(" Her own member is dripping plenty in its little cage, creating a wet spot on your bed sheets together with her needy pussy.." if isCaged else " Her own hard member is dripping plenty, creating a wet spot on your bed sheets together with her needy pussy..")+"")

		saynn("[say=pc]Хах...[/say]")

		saynn("То, как её мягкие подушечки сжимают твой член... как её пальцы дразнят чувствительную головку... манящее тепло её движений... это слишком хорошо... ты выгибаешь спину и запрокидываешь голову, из твоей груди вырывается низкое рычание, когда ты стремительно приближаешься к пику...")

		saynn("[say=artica]По-похоже, ты сейчас... ой!..[/say]")

		saynn("Твой член начинает пульсировать между лап Артики... а затем из пульсирующей головки вырываются струи горячей липкой {pc.cum}, которые попадают прямо на живот и препуций Артики, пачкая мех и "+str("the chastity cage" if isCaged else "the cyan shaft")+"..")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_pawjob")
	if(state == "after_pawjob"):
		playAnimation(StageScene.SexPawjob, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Артика убирает лапы от твоего конченного члена... и просто подставляет тебе себя... на её подушечках тоже осталось немного твоего семени.")

		saynn("[say=pc]Это было хорошо. Отличная работа.[/say]")

		saynn("[say=artica]С-спасибо..[/say]")

		if (!isCaged):
			saynn("Её собственный член всё ещё твёрдый, в этот раз пушистик так и не кончил... может, позволишь ей? Или можешь отправить её обратно на место...")

			addButton("Подставить ноги", "Позволить Артике использовать твои ноги для своего наслаждения", "offer_feet")
			addButton("Хватит", "Хватит веселиться", "endthescene")
		else:
			saynn("Её член в клетке... так что ей придётся довольствоваться лишь тем, что она смотрит на тебя. Пора отправить её обратно на место...")

			addButton("Хватит", "Хватит веселиться", "endthescene")
			addButton("Развлечения в целомудрии", "Артика в клетке.. но ты всё ещё можешь доставить ей удовольствие.. пусть и не напрямую", "chastity_give")
	if(state == "offer_feet"):
		playAnimation(StageScene.SexPawjob, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (receivedPawjob):
			saynn("Артика смотрит на тебя с отчаянным скулением, её похотливые глаза безмолвно умоляют о добавке.")

			saynn("[say=pc]Ладно. Давай сменимся.[/say]")

		else:
			saynn("Зрелище великолепное... но в этот раз ты предпочитаешь дать Артике повеселиться.")

			saynn("[say=pc]Давай сменимся, девочка.[/say]")

		saynn("Ты занимаешь её место и закидываешь ноги, в точности как она, подставляя свои {pc.feet} взору Артики.")

		saynn("[say=pc]С этими можно развлечься. Но я не шелохнусь. Докажи, насколько ты похотливая лапозадка![/say]")

		saynn("[say=artica]Д-да.. да.. х-хорошо..[/say]")

		saynn("Белый мех придвигается ближе, у неё текут слюнки, пока она разглядывает предложенные {pc.feet} и {pc.toes}..")

		addButton("Продолжить", "Смотреть, что будет дальше", "feet_thrust")
	if(state == "feet_thrust"):
		playAnimation(StageScene.SexPawjob, "thrust", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Раз ты не собираешься двигать ногами.. Артика осторожно кладет руки тебе на щиколотки.. а затем аккуратно просовывает свой твердый голубой член между твоих {pc.feet}, подаваясь бедрами вперед.")

		saynn("Для неё это.. явно унизительно.. щеки пушистой пылают ярко-красным, пока ты просто улыбаешься, наблюдая, как она использует твои {pc.feet} для своего удовольствия, всё сильнее втираясь между ними. Её голубой ствол такой теплый, а с кончика капает предэякулят, который ты подхватываешь своими {pc.toes} и размазываешь по всей длине.")

		saynn("[say=artica]Ах.. ах..[/say]")

		saynn("Из неё вырываются милые стоны, член Артики всё настойчивее скользит между твоих {pc.feet}, а узел у основания уже раздувается от прилива крови..")

		addButton("Продолжить", "Смотреть, что будет дальше", "feet_thrust_cum")
		addButtonWithChecks("Презерватив!", "Надень на неё презерватив, пока она не кончила и не измазала тебя во всём соку!", "feet_thrust_condom", [], [[ButtonChecks.HasCondoms]])
	if(state == "feet_thrust_cum"):
		playAnimation(StageScene.SexPawjob, "thrustfast", {pc="artica", npc="pc", pcCum=true, bodyState={naked=true, hard=true, condom=usedCondom}, npcBodyState={naked=true, hard=true}})
		if (usedCondom):
			saynn("Чувствуя, что член Артики уже пульсирует в предвкушении разрядки.. ты быстро разрываешь упаковку презерватива и надеваешь его на её голубой ствол.")

			saynn("[say=artica]Ох.. ах..[/say]")

			saynn("[say=pc]Продолжай, девочка~.[/say]")

			saynn("Ты чувствуешь жар, исходящий от её члена даже сквозь презерватив. Ты стараешься держать свои {pc.feet} как можно плотнее вокруг её ствола... но пушистая щетина всё равно умудряется зажать её узел между ними, заставляя тебя сжимать его.")

		else:
			saynn("Член Артики пульсирует от отчаянной нужды, ты чувствуешь исходящий от него жар. Ты стараешься держать свои {pc.feet} как можно плотнее вокруг её ствола... но пушистая щетина всё равно умудряется зажать её узел между ними, заставляя тебя сжимать его.")

		saynn("Трение посылает волны удовольствия сквозь бедняжку, стонущую от наслаждения... пока она полностью не сдается под натиском этих всепоглощающих ощущений...")

		saynn("[say=artica]Ах!.. Боги!.. Ах-х.. ах.. ах..[/say]")

		if (!usedCondom):
			saynn("Её бёдра неконтролируемо дергаются... прежде чем густые струи спермы начинают извергаться из её пульсирующего члена, забрызгивая твой живот и образуя горячие липкие пятна.")

			saynn("Её тело дрожит, дыхание становится прерывистым, руки трясутся... пока твои {pc.feet}, сжимая её член и узел, выкачивают всё больше и больше спермы из её яичек... создавая жуткий беспорядок...")

		else:
			saynn("Её бёдра неконтролируемо дергаются... прежде чем густые струи спермы начинают извергаться из её пульсирующего члена прямо в презерватив, который тебе удалось надеть на неё как раз вовремя.")

			saynn("Её тело дрожит, дыхание становится прерывистым, руки трясутся... пока твои {pc.feet}, сжимая её член и узел, выкачивают всё больше и больше спермы из её яичек... наполняя презерватив так, что тот начинает тяжело провисать...")

		saynn("[say=artica]Н..н-н..ня-а-ах..[/say]")

		saynn("К концу процесса.. Артика совсем выдохлась..")

		addButton("Продолжить", "Время обниматься", "feet_thrust_cuddle")
	if(state == "feet_thrust_cuddle"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("После такого интенсивного секса ты притягиваешь пушистую бестию к себе и начинаешь нежно обнимать её, попутно нашептывая ей на ушко всякие пошлости.")

		saynn("[say=pc]Какая же хорошая маленькая лапозалутка~.[/say]")

		saynn("[say=artica]Э-это б-было.. п-правда о-очень п-приятно.. ах.. с-спасибо-о..[/say]")

		if (usedCondom):
			saynn("Осторожно стянув с её члена наполненный презерватив, ты выбрасываешь его куда следует.")

		saynn("Немного полежав в обнимку, ты помогаешь пушистке вернуться на её место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "chastity_give"):
		playAnimation(StageScene.SexPawjob, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (receivedPawjob):
			saynn("Артика смотрит на тебя с отчаянным скулением, её похотливые глаза безмолвно умоляют о продолжении. Её член заперт в клетке.. но у тебя есть отличная идея..")

			saynn("[say=pc]Ладно. Давай попробуем кое-что эдакое.[/say]")

		else:
			saynn("Зрелище великолепное... но на этот раз ты решаешь дать Артике повеселиться. Её член заперт в клетке... но у тебя есть отличная идея...")

			saynn("[say=pc]Давай попробуем кое-что, девочка.[/say]")

		saynn("Артика смотрит на тебя своими огромными щенячьими глазками, пока ты хватаешь случайную порно-шлейку... и затягиваешь её на её талии, так что страпон оказывается прямо поверх её клетки целомудрия.")

		saynn("[say=artica]Эм..[/say]")

		saynn("Ты занимаешь её место и закидываешь ноги, в точности как она, подставляя свои {pc.feet} взору Артики.")

		saynn("[say=pc]С этими можно развлечься. Но я не шелохнусь. Докажи, насколько ты похотливая лапозадка![/say]")

		saynn("[say=artica]Н-но... к-как?..[/say]")

		saynn("Ты легонько тыкаешь её новый резиновый член своим {pc.toes}.")

		saynn("[say=artica]Д-да.. да.. х-хорошо..[/say]")

		saynn("Белый мех придвигается ближе, у неё текут слюнки, пока она разглядывает предложенные {pc.feet} и {pc.toes}..")

		addButton("Продолжить", "Смотреть, что будет дальше", "feet_thrust_chastity")
	if(state == "feet_thrust_chastity"):
		playAnimation(StageScene.SexPawjob, "thrust", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты не собираешься двигать ногами... поэтому Артика осторожно кладет руки тебе на щиколотки... а затем аккуратно просовывает свой страпон в пустоту между твоими {pc.feet}, подаваясь тазом вперед.")

		saynn("Прямой стимуляции нет. Так что для неё это явно... невероятно унизительно... щечки пушистой пылают ярко-красным, пока ты просто улыбаешься, наблюдая, как она использует твои {pc.feet}, всё сильнее втираясь страпоном туда-сюда между ними. Пушинка тихонько скулит...")

		saynn("[say=pc]Оу~... Но смотри, ты трахаешь мои {pc.feet}. Это же так горячо, правда?[/say]")

		saynn("Она фыркает и кивает... прежде чем закрыть глаза...")

		saynn("[say=pc]Нет, открой глаза, сучка. И смотри на мои {pc.feet}. Смотри, как хорошо твой член их трахает.[/say]")

		saynn("Пушинка послушно наблюдает за её действиями... у неё снова текут слюнки... её губы издают тихий стон...")

		saynn("[say=artica]Ах... д-да... э-это так п-приятно...[/say]")

		saynn("Пока она сосредоточена на процессе, из неё вырывается всё больше милых стонов; резиновый член Артики с нарастающей настойчивостью скользит между твоих {pc.feet}, а её запертый член предвкушающе сочит смазку за портуей, оставляя мокрое пятно на простынях...")

		addButton("Продолжить", "Смотреть, что будет дальше", "feet_thrust_cum_chastity")
	if(state == "feet_thrust_cum_chastity"):
		playAnimation(StageScene.SexPawjob, "thrustfast", {pc="artica", npc="pc", bodyState={naked=true, hard=true, condom=usedCondom}, npcBodyState={naked=true, hard=true}})
		saynn("С каждым толчком бёдра Артики подаются вперёд, стрэп-он ритмично скользит между твоих {pc.feet}. Несмотря на очевидную преграду между её членом и твоими ногами, она явно поглощена отчаянной жаждой разрядки, и её стоны становятся всё громче...")

		saynn("Небольшое количество трения и давления на девственную клетку Артики посылает волны удовольствия бедной стонущей пушинке... пока она полностью не сдаётся под напором этих всепоглощающих ощущений...")

		saynn("[say=artica]Ах!.. Боги!.. Ах-х.. ах.. ах..[/say]")

		saynn("Её бёдра начинают неконтролируемо дёргаться... а затем из-под ремней стрэп-она начинают вырываться густые струи спермы, стекающие вниз и разбрызгивающиеся по простыням, образуя горячие липкие узоры.")

		saynn("[say=pc]Ого, ничего себе.[/say]")

		saynn("Её тело дрожит, дыхание становится прерывистым, руки трясутся... пока всё больше и больше спермы стекает из её промежности... создавая такой беспорядок...")

		saynn("[say=artica]Н..н-н..ня-а-ах..[/say]")

		saynn("[say=pc]Впечатляет, тебе всё-таки удалось кончить~.[/say]")

		saynn("К концу процесса.. Артика совсем выдохлась..")

		addButton("Продолжить", "Время обниматься", "feet_thrust_cuddle")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_cell"):
		processTime(3*60)

	if(_action == "receive_pawjob"):
		receivedPawjob = true

	if(_action == "chastity_give"):
		getCharacter("artica").getInventory().equipItem(GlobalRegistry.createItem("StraponCanine"))

	if(_action == "receive_pawjob_cum"):
		processTime(3*60)
		getModule("ArticaModule").addCorruption(0.01)
		getCharacter("artica").cummedOnBy("pc")
		GM.pc.orgasmFrom("artica")

	if(_action == "after_pawjob"):
		processTime(3*60)

	if(_action == "feet_thrust"):
		processTime(5*60)

	if(_action == "feet_thrust_cum"):
		processTime(5*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		GM.pc.cummedOnBy("artica")

	if(_action == "feet_thrust_condom"):
		processTime(5*60)
		usedCondom = true
		GM.pc.useWorstCondom()
		getModule("ArticaModule").triggerCorruption(0.02)
		addFilledCondomToLootIfPerk(getCharacter("artica").createFilledCondom())
		setState("feet_thrust_cum")
		return

	if(_action == "feet_thrust_cuddle"):
		processTime(10*60)
		getCharacter("artica").removeStrapon()

	if(_action == "feet_thrust_chastity"):
		processTime(5*60)

	if(_action == "feet_thrust_cum_chastity"):
		processTime(5*60)
		getModule("ArticaModule").triggerCorruption(0.02)

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
	data["receivedPawjob"] = receivedPawjob
	data["usedCondom"] = usedCondom

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
	receivedPawjob = SAVE.loadVar(data, "receivedPawjob", false)
	usedCondom = SAVE.loadVar(data, "usedCondom", false)
