extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaEventPortalPanties1Scene"

func _run():
	if(state == ""):
		setFlag("ArticaModule.nextReaction", "p1hap")
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Артика направляется к главному лифту, словно просто осматривает станцию..."+str(" She keeps covering her private bits though.. which doesn't help much because she has quite a lot that she needs to cover.." if nakedAndShy else "")+"")

		saynn("Она проходит мимо контрольно-пропускного пункта и заходит в лифт. Издалека трудно разглядеть, какую кнопку она нажимает... но вы замечаете, что она жмет самую нижнюю — ту, что ведет на этаж со всеми шахтными стволами...")

		addButton("Следовать", "Посмотреть, куда она направится дальше", "in_workshop")
	if(state == "in_workshop"):
		addCharacter("alexrynard")
		aimCameraAndSetLocName("mining_nearentrance")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="alexrynard", bodyState={hard=true}})
		saynn("Вы садитесь в следующий прибывший лифт и выбираете тот же этаж.")

		saynn("Когда вы выходите... вы обнаруживаете, что она забилась в щель под техническими мостками, там, где заключенным выдают инструменты вроде кирок...")

		if (isNaked):
			saynn("[say=alexrynard]Серьезно? Ты собралась так работать? Я ведь не слепая, знаешь ли.[/say]")

		else:
			saynn("[say=alexrynard]Серьезно? Ты собралась так работать? Я ведь не слепая, знаешь ли.[/say]")

		saynn("[say=artica].. ..[/say]")

		saynn("Из своего укрытия вы почти не слышите Артику — она говорит слишком тихо по сравнению с остальными...")

		saynn("[say=alexrynard]Ты реально об этом спрашиваешь? Разве не видно?[/say]")

		saynn("Артика оглядывает себя... и пожимает плечами.")

		saynn("[say=alexrynard]Я бы предпочла, чтобы ты не повредил свой член этой киркой. Ступай отсюда.[/say]")

		saynn("Пушистая опускает голову и направляется прочь. Инженер замечает это и закатывает глаза.")

		saynn("[say=alexrynard]Погоди. Вернись, заключенная.[/say]")

		saynn("[say=artica]..?[/say]")

		saynn("Артика послушно возвращается к лису.")

		saynn("[say=alexrynard]Что ты здесь забыла?[/say]")

		saynn("[say=artica].. .. ..[/say]")

		saynn("Инженер чешет подбородок, раздумывая...")

		saynn("[say=alexrynard]Хочешь стать подопытной?[/say]")

		saynn("Артика часто моргает, она ерзает всем телом, её хвост обвивается вокруг талии, а уши прижимаются к голове...")

		saynn("[say=alexrynard]Ну так что?[/say]")

		saynn("Артика моргает еще чаще. Настолько, что инженер решает кинуть в неё какой-то небольшой кейс. Девушка едва успевает поймать его, её всё тело прогибается под тяжестью того, что лежит внутри.")

		saynn("[say=alexrynard]Думаю, это значит «да». Иди за мной.[/say]")

		saynn("Инженер начинает подниматься по техническому мостику... в то время как Артика едва поспевает за ним, тихонько пыхтя и таща тяжелый кейс.")

		saynn("Интересно...")

		addButton("Следовать", "Смотреть, что будет дальше", "in_workshop_actually")
	if(state == "in_workshop_actually"):
		playAnimation(StageScene.Duo, "sit", {pc="artica", npc="alexrynard", bodyState={hard=true}})
		aimCameraAndSetLocName("eng_workshop")
		saynn("Они направляются к мастерской. Это место заставлено верстаками, что-то вроде творческой студии... но без творчества... и где «творчество» разрешено только под строжайшим присмотром...")

		saynn("Инженер указывает на стол, и Артика с тем же тяжелым дыханием ставит на него кейс.")

		saynn("[say=alexrynard]А теперь садись.[/say]")

		saynn("Она кивает и садится, пока инженер открывает кейс... обнаруживая... нечто...")

		saynn("Вы почти уверены, что это какая-то электроника. Видны компоненты... и провода... но очевидно, что здесь функциональность стоит выше... всего остального.")

		saynn("[say=alexrynard]Я собираю данные для своего проекта. Чем больше людей его протестирует, тем быстрее он станет полезен для остальных.[/say]")

		saynn("Артика склоняет голову набок, наблюдая, как лисичка быстро что-то собирает, используя защитные очки в качестве основы и прикрепляя к ним различные детали.")

		saynn("[say=alexrynard]Энтропия — важная штука, когда имеешь дело с такими сложными «черными ящиками», как мозг. Да, можно создать его цифровую модель... но тебе понадобится еще как минимум сотня мозгов, чтобы осознать всю эту сложность... то, как он работает...[/say]")

		saynn("Он смотрит на девушку... а она лишь заливается румянцем.")

		saynn("[say=alexrynard]Понимаешь, о чем я? Мы просто не в состоянии осознать, что делает каждый отдельный нейрон. Но каждый нейрон в нашем мозгу что-то делает. И если пытаться запомнить информацию о каждом из них, то для этого потребуется... как минимум мозг побольше. А вот машины... они вроде как справляются...[/say]")

		saynn("Кажется, инженер может рассуждать об этом бесконечно...")

		saynn("[say=alexrynard]Не знаю, что нас ждет в будущем. Чувствую, машины сыграют в нем огромную роль... что бы там ни думали некоторые люди.[/say]")

		saynn("Артика облизывается. Тем временем инженер, кажется, закончил работу над своим прототипом...")

		saynn("[say=alexrynard]И сама не знаю, зачем всё это объясняю... Просто надень это уже.[/say]")

		saynn("Он протягивает Артике... шикарный визор... из которого во все стороны торчат провода...")

		saynn("[say=alexrynard]Что? Передумала? Я не стану осуждать, если ты захочешь просто пойти поколоть камни киркой.[/say]")

		saynn("Артика качает головой и берет прототип...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_with_visor_on")
	if(state == "artica_with_visor_on"):
		addCharacter("artica", ["hypno", "naked"])
		playAnimation(StageScene.Duo, "sit", {pc="artica", npc="alexrynard", bodyState={hard=true, naked=true}})
		saynn("С помощью инженера она осторожно закрепляет его на голове...")

		saynn("[say=alexrynard]Это разработано, чтобы поднять тебе настроение, всё, что тебе нужно знать. Готова?[/say]")

		saynn("Артика кивает, её наивные голубые глаза светятся слепой уверенностью... Инженер соединяет провода... и визор загорается манящим жёлтым светом.")

		saynn("Мягкие огни начинают плясать перед глазами Артики, и её тело почти мгновенно расслабляется под воздействием устройства.")

		saynn("Инженер быстро замечает перемену в выражении лица Артики... И да, ты тоже это видишь, даже издалека... Её дыхание становится медленнее и глубже, взгляд — прямее... И самое главное, её глаза... с её глазами что-то происходит...")

		saynn("[say=alexrynard]Я никогда не видел такой реакции. Ты меня слышишь?[/say]")

		saynn("Она кивает, казалось бы, полностью контролируя своё тело...")

		saynn("[say=alexrynard]Как ощущения?[/say]")

		saynn("То, что происходит после этого вопроса... странно...")

		saynn("Лапки Артики начинают скользить по её меху"+str(", sliding under her shorts and shirt, slowly taking them off.." if !isNaked else ", not covering or hiding any of her private bits anymore..")+"")

		saynn("Фокси приподнимает бровь, пока пушистый мех... начинает ласкать её грудь, поглаживая мягкие полушария и играя с упругими сосками"+str(" swollen" if getCharacter("artica").isLactating() else "")+" nips..")

		saynn("[say=alexrynard]Ты вот что чувствуешь?[/say]")

		saynn("Она кивает. Что ж, она чувствует... саму себя... её лапы исследуют пушистый живот, скользя вниз, к мокрой киске, и "+str("hard trobbing cock" if !isCaged else "drippy locked cock")+"..")

		saynn("[say=alexrynard]Так, что-то здесь не так. Стой.[/say]")

		saynn("Артика повинуется... мгновенно... без лишних вопросов. Она замирает, как и прежде... но теперь она возбуждена, тихо посапывает, высунув язык, её соски напряжены, из её клыкастого члена сочится предэякулят, а киска оставляет мокрое пятно на сиденье...")

		saynn("Инженер вздыхает и ворчит себе под нос...")

		saynn("[say=alexrynard]...почему всё, что я создаю, либо отнимают, либо используют как оружие... либо оно превращается в секс-игрушку...[/say]")

		saynn("Каким-то образом Артика слышит его... но только последнюю часть...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_becomes_sextoy")
	if(state == "artica_becomes_sextoy"):
		playAnimation(StageScene.Zonked, "tease", {pc="artica", npc="alexrynard", bodyState={naked=true, hard=true}})
		saynn("Артика мгновенно соскальзывает со стула, принимая на полу крайне похотливую позу: ноги высоко закинуты к плечам, пальцы на ногах подрагивают, а лапы подбираются под её яички, послушно раздвигая киску для инженера и с гордостью демонстрируя скользкий бирюзовый любовный туннель...")

		saynn("Фокси смотрит на это зрелище... и вздыхает.")

		saynn("[say=alexrynard]Знаешь что... Я почти уверена, что в твоей голове есть предвзятость..[/say]")

		saynn("Артика наклоняет голову набок.")

		saynn("[say=alexrynard]Если мы сейчас остановимся, ты ведь захочешь чего-нибудь пошлого, а? Хочешь кончить?[/say]")

		saynn("Артика жадно кивает, высунув язык и пуская слюни; её загипнотизированные глаза с огромным интересом следят за причудливыми цветами... Другие инженеры начинают замечать девчонку на полу, застывшую в весьма двусмысленной позе.")

		saynn("[say=alexrynard]Ну что ж... валяй. Покажи мне, что ты чувствуешь. Только не на моем верстаке.[/say]")

		saynn("Похоже, это было всё, что нужно было услышать Артике...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_cums_from_order")
	if(state == "artica_cums_from_order"):
		if (isCaged):
			playAnimation(StageScene.Zonked, "rubcum", {pc="artica", npc="alexrynard", bodyState={naked=true, hard=true}})
			saynn("Она подчиняется мгновенно; её член заперт в клетке, поэтому её лапы тянутся между ног, а пальцы быстро и грубо вонзаются в её мокрую киску, словно она в отчаянии... С губ срываются стоны, тело выгибается, а разум мгновенно тонет в захлестывающем удовольствии...")

			saynn("Её член пульсирует в металлической ловушке, выделяя предэякулят, который она размазывает по своим когтистым пальцам; киска сжимается вокруг них, капая соками на холодный пол, а стимуляция подводит её к самому краю...")

		else:
			playAnimation(StageScene.Zonked, "strokecum", {pc="artica", npc="alexrynard", bodyState={naked=true, hard=true}})
			saynn("Она подчинилась мгновенно: её лапы легли на член, и она принялась быстро и жестко ласкать его, словно в отчаянии... С губ срываются стоны, тело выгибается, а разум мгновенно тонет в захлестывающем удовольствии...")

			saynn("Её член пульсирует, выделяя предэякулят, который она размазывает по когтистым пальцам; её заброшенная киска капает соками на холодный пол, а стимуляция подводит её к самому краю...")

		saynn("Инженер, наблюдая за этим, чешет затылок — скорее раздраженный, чем чем-либо еще. По крайней мере, он всё еще получает свои данные об энтропии или что он там искал...")

		saynn("С последним похотливым криком Артика кончает, её член выстреливает густыми струями спермы, забрызгивая её собственный"+str(" pregnant" if getCharacter("artica").isVisiblyPregnant() else "")+" живот и {artica.breasts}, а её киска хлещет, дико разбрызгивая всё вокруг по полу.")

		saynn("[say=alexrynard]Ой, да ладно тебе. Я же говорил: никакой грязи рядом с моим рабочим местом![/say]")

		saynn("Услышав это, Артика мгновенно переворачивается на живот... и начинает жадно слизывать собственную девичью сперму с пола, убирая за собой...")

		saynn("[say=alexrynard]О нет, прекрати, ты же столько грязи слизала![/say]")

		saynn("Артика кивает и тяжело дышит, её мышцы всё еще хаотично подергиваются от оргазма.")

		saynn("[say=alexrynard]Надеюсь, ты получила удовольствие или типа того.[/say]")

		saynn("Инженер тянется к прототипу, чтобы выключить его и снять.")

		addButton("Продолжить", "Смотреть, что будет дальше", "alex_removes_visor")
	if(state == "alex_removes_visor"):
		playAnimation(StageScene.Zonked, "tease", {pc="artica", npc="alexrynard", bodyState={naked=true, hard=true}})
		addCharacter("artica", ["naked"])
		saynn("Фокси осторожно разбирает прототип и снимает его с глаз Артики... глаз, в которых всё еще виден тот странный вихревой узор.")

		saynn("[say=alexrynard]Твою мать. Только не говори мне, что я сломал тебе мозг.[/say]")

		saynn("Но пока она моргает, узоры начинают бледнеть... Взгляд Артики устремлен куда-то в далекую точку пространства... она больше не загипнотизирована... но и здесь её тоже нет...")

		saynn("[say=alexrynard]Эй, ты.[/say]")

		saynn("Только когда инженер щелкает пальцами перед лицом Артики, она приходит в себя, тихо ахая и озираясь по сторонам; она всё еще лежит в крайне компрометирующей позе, и все её прелести выставлены на всеобщее обозрение...")

		saynn("[say=artica].. .. ..?..[/say]")

		saynn("[say=alexrynard]Не знаю, какого хрена ты валяешься на полу. Вставай, заключенная.[/say]")

		saynn("Артика смотрит вниз... и видит сперму на своей голой груди... отчего заливается густым румянцем.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_dressesup")
	if(state == "artica_dressesup"):
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="alexrynard"})
		saynn("Артика быстро вскакивает и пытается прикрыться, стараясь спрятать весь этот беспорядок...")

		saynn("[say=alexrynard]Я всё видел, так что не парься.[/say]")

		saynn("Инженер показывает визор.")

		saynn("[say=alexrynard]Сейчас я займусь обработкой данных. Свали отсюда.[/say]")

		saynn("Артика кивает и опускает подбородок, разворачиваясь, чтобы уйти..")

		saynn("[say=alexrynard]И.. спасибо.[/say]")

		saynn("[say=artica]..![/say]")

		saynn("Пушистик заурчал и убежал.. наверное, на своё место..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_workshop"):
		processTime(3*60)

	if(_action == "in_workshop_actually"):
		processTime(3*60)

	if(_action == "artica_with_visor_on"):
		processTime(3*60)
		getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("HypnovisorMk1"))

	if(_action == "artica_becomes_sextoy"):
		processTime(5*60)

	if(_action == "artica_cums_from_order"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.05)
		getCharacter("artica").cummedOnBy("artica")

	if(_action == "alex_removes_visor"):
		processTime(3*60)
		getCharacter("artica").resetEquipment()

	if(_action == "artica_dressesup"):
		processTime(3*60)

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
