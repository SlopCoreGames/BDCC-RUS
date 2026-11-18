extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var harnessID = ""

func _init():
	sceneID = "articaSexRopesScene"

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
		saynn("Какую веревочную сбрую ты хочешь использовать, чтобы связать Артику?")

		addPumpButtons("do_pick_harness")
		addButton("Отмена", "Вы передумали", "endthescene")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_pick_harness")
	if(state == "do_pick_harness"):
		saynn("Проведя столько времени с этим пушистиком, ты замечаешь, какой извращенкой она стала... Это заставляет задуматься, признается ли она когда-нибудь в своих самых диких фантазиях.")

		saynn("[say=pc]Эй, Артика. Мне тут кое-что любопытно стало.[/say]")

		saynn("[say=artica]Что именно?..[/say]")

		saynn("[say=pc]Тебе нравится, когда ты не контролируешь ситуацию?[/say]")

		saynn("[say=artica]Эм.. ну.. я.. я п-понятия не имею.. я.. я н-не..[/say]")

		saynn("Снова возвращается привычное заикание; девушка еще ниже опускает подбородок, а её лапки начинают нежно поглаживать её "+str("fluffy sides" if isNaked else "clothed sides")+", при этом она пожимает плечами.")

		saynn("[say=pc]Да или нет?[/say]")

		saynn("[say=artica]Она... эм...[/say]")

		saynn("То, как она переминается на задних лапах, пока покачивает задницей... то, как краснеют её щеки и как хвост обвивается вокруг ноги... в её нынешнем состоянии она никогда в этом не признается.")

		saynn("[say=pc]Тут другой вопрос. Тебе нравится.. зависать.. в моей камере?[/say]")

		saynn("Ты сделал особый акцент на слове «зависать».")

		saynn("[say=artica]О.. да.. ха-ха. А почему ты спрашиваешь?..[/say]")

		saynn("Молча ты начинаешь кружить вокруг"+str(" naked" if isNaked else " clothed")+" девушки.. твой взгляд.. как у хищника.")

		saynn("[say=artica]Т-ты выглядишь.. ж-жутковато..[/say]")

		saynn("Ты просто улыбаешься.. ожидая, что она либо остановит тебя.. либо убежит.. но пушистая никогда не убегает.")

		addButton("Схватить её", "Затащить её в свою камеру", "kidnap")
	if(state == "kidnap"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.RopesSolo, "struggle", {pc="artica", bodyState={naked=true, hard=true}})
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		saynn("Ты останавливаешься позади неё.. прежде чем подойти вплотную и прижать ладонь к её пасти, заставляя её замолчать.")

		saynn("[say=artica]..и-и.. п..[/say]")

		saynn("[say=pc]Потому что я хочу, чтобы ты вешалась у меня в камере, Артика.[/say]")

		saynn("Прежде чем она успевает вырваться, ты тащишь пушистую бестию в свою личную камеру... где ты"+str(" undress her and then" if !isNaked else "")+" начинаешь туго обматывать её запястья, лодыжки и грудь веревками... веревками, которые ты подготовил заранее, привязав их другие концы к потолку.")

		saynn("[say=artica]Ч-что это... А-ах![/say]")

		saynn("Когда ты затягиваешь веревки, они впиваются в мех Артики... но также заставляют её задние лапы оторваться от пола, не давая ей упасть, а вместо этого подвешивая её высоко в воздухе.")

		saynn("[say=pc]Вот и всё.[/say]")

		saynn("Особое чувство быстро овладевает сознанием Артики. Сколько бы она ни пыталась извиваться... ей не вырваться из пут, её обнаженное тело беспомощно подвешено над полом... все её интимные места на виду... и она полностью в твоей власти...")

		saynn("[say=artica]Ах... Т-ты что... п-похитил меня?..[/say]")

		saynn("[say=pc]Смотря как. Будешь вести себя хорошо или включишь настоящую сучку?[/say]")

		saynn("Она оглядывается... и дёргает хвостом... её пальцы на лапах поджимаются... Это всё, что она может сделать.")

		saynn("[say=artica]Я... эм... я з-знаю, ч-что нужно вести себя п-прилично...[/say]")

		saynn("[say=pc]Да неужели? Это был бы для тебя очень плохой конец, а? Застрянешь здесь, в моей камере... навечно в роли моей секс-игрушки.[/say]")

		saynn("[say=artica]Э-это б-было бы.. д-действительно.. очень плохо..[/say]")

		saynn("Её"+str(" dark swollen" if getCharacter("artica").isLactating() else " cyan")+" "+str("cyan member leaking pre in its cage" if isCaged else "cyan member peeking from its sheath, leaking pre")+"..")

		saynn("Так и хочется дразнить её ещё сильнее...")

		saynn("[say=pc]Я бы держала тебя под кайфом от размножающих препаратов..[say=pc]"+str(" Maybe with your belly full of someone's pups.." if !GM.pc.hasReachablePenis() else " With your belly full of pups..")+"Твой разум сломлен, а твои дырочки постоянно растянуты и забиты..[/say]")

		saynn("Чем больше ты говоришь, тем сильнее Артика ерзает и скулит, а её киска истекает соками прямо на пол.")

		saynn("[say=artica]Т-такой.. ж-жестокий..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "in_cell")
	if(state == "in_cell"):
		playAnimation(StageScene.RopesOralSex, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Как именно ты хочешь развлечься с этой пушистиком?")

		addButton("Игрушки", "Прикрепить несколько вибрирующих игрушек к её щелкам..", "do_toys")
		addButtonWithChecks("Вагинальный", "Оплодотворить пушинку", "do_vag", [], [[ButtonChecks.HasReachablePenis]])
		addButtonWithChecks("Анальный", "Немного поразвратничать и трахнуть другое отверстие Артики", "do_anal", [], [[ButtonChecks.HasReachablePenis]])
		addButtonWithChecks("Оральный секс", "Немного растянуть горло Артики", "do_deepthroat", [], [[ButtonChecks.HasReachablePenis]])
		addButtonWithChecks("Тереться лицом", "Тереться киской о её лицо", "do_grind", [], [[ButtonChecks.HasReachableVagina]])
	if(state == "do_grind"):
		playAnimation(StageScene.RopesOralSex, "lick", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Почти не говоря ни слова, ты вжимаешь свою обнаженную {pc.pussyStretch} киску в морду Артики, усаживаясь верхом на её собачью мордочку и начиная неистово тереться о неё.")

		saynn("[say=artica]Ой...[/say]")

		saynn("[say=pc]О да~. Я могу делать с тобой всё, что захочу..[/say]")

		saynn("Это чертовски приятно; приглушенные всхлипы Артики лишь разжигают твою страсть, заставляя тебя тереться о её лицо всё сильнее и сильнее, втирая свой запах в её мех и помечая его своими соками..")

		saynn("В конце концов, горячий аромат, которым вынуждена дышать пушистка, заставляет её подчиняться твоим грубым движениям: она приоткрывает губы и высовывает язык, ловя твои чувствительные складки, когда те скользят по её рту.")

		saynn("[say=pc]Какая жадная лизалка..[/say]")

		addButton("Быстрее", "Тереть лицом быстрее", "do_grind_cum")
	if(state == "do_grind_cum"):
		playAnimation(StageScene.RopesOralSex, "lickfast", {pc="artica", npc="pc", npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Ты чувствуешь, что двигаешься всё быстрее; обе руки ложатся ей на голову, фиксируя её, пока ты втираешься ей в лицо своей сочащейся щелью.. от этих ощущений ты страстно стонешь..")

		saynn("Всё это время связанная Артика изо всех сил старается угодить тебе, проводя своим бирюзовым языком по твоим складкам и слизывая каждую каплю смазки.")

		saynn("[say=pc]Ах.. лад-дно.. Ох, бля-а~..[/say]")

		saynn("С судорожным вздохом тебя выбрасывает за край; от оргазма ноги слабеют, а твоя киска начинает пульсировать и заливать лицо Артики фонтанами смазки, делая её мех мокрым и пахучим..")

		saynn("[say=pc]Нх-х.. да-а.. вот так.. помечаю тебя, как настоящую шлюху..[/say]")

		saynn("Артика густо краснеет.. когда ты перестаёшь тереться о неё, она почему-то продолжает поскуливать.")

		saynn("[say=pc]Что? Я была слишком грубой?[/say]")

		saynn("[say=artica]Н-нет.. эм.. я.. я всё ещё..[/say]")

		saynn("Ты смотришь ей за спину... вау... её собственная киска уже разливает лужицу соков на полу, источая невероятно манящий аромат...")

		saynn("Ты можешь оставить её возбужденной и неудовлетворенной... или подарить ей разрядку, о которой она так мечтает...")

		addButton("Без разрядки", "Оставить Артику в возбуждении", "no_release")
		addButton("Вылизать её", "Довести Артику до оргазма, лаская её киску языком", "eat_artica_out")
	if(state == "do_deepthroat"):
		playAnimation(StageScene.RopesOralSex, "sex", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}})
		saynn("Грубоватая... такая говорливая дрянь. Стоит использовать это в свою пользу.")

		saynn("Нежным, но уверенным движением ты направляешь её голову к своему обнаженному {pc.penis}, приглашая её взять тебя в рот.")

		saynn("[say=artica]Эм... ик!..[/say]")

		saynn("Артика на мгновение колеблется, когда твой член касается её сомкнутых губ. Но чем сильнее она вдыхает твой запах, тем больше сдается, медленно приоткрывая рот, и её губы размыкаются всё шире и шире...")

		saynn("[say=pc]Будь хорошей девочкой...[/say]")

		saynn("Медленными, размеренными движениями ты вводишь член в её пасть; головка быстро достигает задней части рта, и предэякулят капает ей прямо в глотку. Там так тепло и влажно, а её голубой язык дразнит твой член, обильно смазывая его слюной.")

		saynn("[say=pc]Весь целиком..[/say]")

		saynn("Медленно ты начинаешь наращивать давление... пока головка твоего члена не проскальзывает в её глотку, растягивая её до предела.")

		saynn("[say=artica]Ах-х..[/say]")

		saynn("И вот ты начинаешь входить в неё толчками, заталкивая всё глубже и растягивая тугие стенки её горла... металлический ошейник на её шее делает процесс трахания невероятно приятным...")

		addButton("Быстрее", "По-настоящему испытать её", "throatfuck_cum")
	if(state == "throatfuck_cum"):
		playAnimation(StageScene.RopesOralSex, "fast", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}})
		saynn("По мере того как твоя уверенность в умении Артики сосать растёт, ты начинаешь трахать её глотку всё быстрее и жестче; её губы плотно обхватывают член при каждом глубоком толчке, заставляя её шею бугриться. Ты чувствуешь, как вскоре срабатывает её рвотный рефлекс... бедняжка задыхается от твоего члена, а её горло издаёт сплошные влажные хлюпающие звуки...")

		saynn("[say=artica]Кхх-х.. ххх.. кхх..[/say]")

		saynn("Это ощущается... слишком.. хорошо.. Поэтому ты на время игнорируешь её потребность в свежем воздухе и просто продолжаешь терзать её глотку, пока у неё самой течёт слюна от того, что она вынуждена принимать тебя так глубоко.")

		saynn("[say=pc]Нгх.. Сейчас будет, сучка.. Только посмей упустить хоть каплю..[/say]")

		saynn("Последним мощным толчком ты вгоняешь свой член так глубоко, насколько позволяет её глотка... а затем просто взрываешься внутри, и твой {pc.penis} наполняет живот Артики твоей {pc.cum}, пока её тело содрогается от удовольствия, а голубые похотливые глаза закатываются вверх.")

		saynn("Это настолько приятно, что ноги начинают дрожать... но ты также чувствуешь, что Артика слабеет... пора выходить, пока она окончательно не отключилась...")

		addButton("Продолжить", "Смотреть, что будет дальше", "deepthroat_pull")
	if(state == "deepthroat_pull"):
		playAnimation(StageScene.RopesOralSex, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}})
		saynn("Когда ты вырываешь свой член из её глотки, Артика начинает жадно хватать ртом воздух и кашлять.")

		saynn("[say=artica]Кхх... кх... кх...[/say]")

		saynn("Твой член выглядит... чистым. Влажным... но чистым.")

		saynn("[say=pc]Ого, отличная работа.[/say]")

		saynn("Ты вытираешься о её пухлые щечки и делаешь шаг назад.")

		saynn("Почему-то девчонка скулит, тяжело и часто дыша.")

		saynn("[say=pc]Что такое? Я был слишком груб?[/say]")

		saynn("[say=artica]Н-нет.. эм.. я.. я всё ещё..[/say]")

		saynn("Ты смотришь ей за спину... вау... её киска образует лужицу соков на полу, источая невероятно манящий аромат...")

		saynn("Ты можешь оставить её возбужденной и неудовлетворенной... или подарить ей разрядку, о которой она так мечтает...")

		addButton("Без разрядки", "Оставить Артику в возбуждении", "no_release")
		addButton("Вылизать её", "Довести Артику до оргазма, лаская её киску языком", "eat_artica_out")
	if(state == "no_release"):
		saynn("[say=pc]Прости, пушистик. Я лучше оставлю твою шлюшковатую попку в возбужденном состоянии~.[/say]")

		saynn("Сзади слышны всхлипы и стоны — Артика извивается в своих веревках.")

		saynn("Пора развязать их и вернуть её на место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getharness")
	if(state == "eat_artica_out"):
		if (isCaged):
			playAnimation(StageScene.RopesSex, "lick", {pc="artica", npc="pc", pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}})
			saynn("Ты вздыхаешь и опускаешься на колени позади неё... прежде чем уткнуться лицом в эту жаждущую киску.")

			saynn("[say=artica]Ах..[/say]")

			saynn("Её член в клетке, так что ты просто сжимаешь её яйца, пока твой язык начинает слизывать её соки, проходя по чувствительным голубым складкам и уделяя массу внимания её скрытому клитору.")

			saynn("[say=artica]Ах.. д-да!.. ах.. боги.. ах..[/say]")

			saynn("Вскоре ты обнаруживаешь, что занимаешься языковым сексом с её киской, исследуя и слизывая всё внутри, пока она извивается, а её внутренние стенки плотно обхватывают твой язык. Запах потрясающий, тебе всё мало.")

			saynn("[say=artica]Я.. я.. няаа-ааа-ах!..[/say]")

			saynn("Внезапно её пульсирующая щель извергает фонтан соков, который заливает всё твоё лицо, а её запертый член выпускает слабые струйки семени на пол, пока её яички напрягаются.")

		else:
			playAnimation(StageScene.RopesSex, "lickstroke", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
			saynn("Ты вздыхаешь и опускаешься на колени позади неё... прежде чем уткнуться лицом в эту жаждущую киску.")

			saynn("[say=artica]Ах..[/say]")

			saynn("Твоя рука ложится на её член, и ты начинаешь ласкать его, пока твой язык слизывает её соки, проходя по чувствительным бирюзовым складкам и уделяя массу внимания её скрытому клитору.")

			saynn("[say=artica]Ах.. д-да!.. ах.. боги.. ах..[/say]")

			saynn("Вскоре ты обнаруживаешь, что занимаешься языковым сексом с её киской, исследуя и слизывая всё внутри, пока она извивается, а её внутренние стенки плотно обхватывают твой язык. Запах потрясающий, тебе всё мало.")

			saynn("[say=artica]Я.. я.. няаа-ааа-ах!..[/say]")

			saynn("Внезапно её пульсирующая щель извергает фонтан соков, которые заливают всё твоё лицо; её узловатый собачий член выстреливает густыми струями семени на пол, а яички при этом напрягаются.")

		saynn("[say=pc]Вот так, грязная шлюшка... Быстро ты.[/say]")

		saynn("[say=artica]С-спас-с-сибо... ахх...[/say]")

		saynn("Ну, по крайней мере, ты унял её зуд. Ты даёшь Артике немного отдохнуть, прежде чем ослабить верёвки и помочь ей подняться и вернуться на место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getharness")
	if(state == "do_anal"):
		playAnimation(StageScene.RopesSex, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		var isPreg = getCharacter("artica").isVisiblyPregnant()
		if (isPreg):
			saynn("Артика беременна... так что в этот раз ты будешь трахать её только в задницу!")

		else:
			saynn("Злюка, значит... Посмотрим, как она запоёт после этого.")

		saynn("Твои руки ложатся на её задницу, и ты жадно сжимаешь её, раздвигая и сводя ягодицы, массируя и разминая их. При этом ты видишь, как её тугое анусное отверстие подмигивает тебе.")

		saynn("[say=pc]Такая беспомощная маленькая добыча. Я могу делать с тобой всё, что захочу...[/say]")

		saynn("[say=artica]Д-да...[/say]")

		saynn("[say=pc]Даже это.[/say]")

		saynn("Артика напрягается, чувствуя, как твой член трется о её крошечную дырочку; от этих дразнящих ласк её анус судорожно сжимается.")

		saynn("[say=artica]И-иик!.. Я н-не..[/say]")

		saynn("[say=pc]Не обучена? Что ж, тогда мы обучим твою попку.[/say]")

		saynn("Мягким толчком ты прижимаешь головку члена к её узкому входу, заставляя её мышцы снова напрячься. Медленно ты начинаешь входить.. снова и снова, дюйм за дюймом растягивая её тугое отверстие своим членом..")

		saynn("Пока ты это делаешь, пушистики копошатся в её путах, а её заброшенная киска становится совсем мокрой и жаждущей.")

		saynn("[say=artica]П-почему н-не.. ах.. п-почему не моя..[/say]")

		if (isPreg):
			saynn("[say=pc]Почему не твоя киска? Можешь умолять меня снова, когда родишь это потомство.[/say]")

			saynn("[say=artica]Нх-х..[/say]")

		else:
			saynn("[say=pc]Почему бы просто не всадить его туда? Отличная идея.[/say]")

			saynn("[say=artica]По-подожди!..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "anal_inside")
	if(state == "anal_inside"):
		playAnimation(StageScene.RopesSex, "inside", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Дело идет не очень гладко.. возможно, потому что ты не используешь смазку. Тогда ты плюешь на свой член.. и снова начинаешь входить, пока головка наконец не проскальзывает сквозь тугой анальный сфинктер и не уходит глубже в неё.")

		saynn("Артика ахает, ощущая это; от странных ощущений она начинает ерзать всё сильнее... Твой член быстро находит её мягкую простату и начинает давить на неё.")

		saynn("[say=artica]Ах!..[/say]")

		if (isCaged):
			saynn("От стимуляции этой точки клетка Артики сжимается, а её собственный член пытается вырваться из ножен, отчаянно желая затвердеть... Но металл слишком прочен...")

		else:
			saynn("От стимуляции этой точки член Артики выходит из ножен, становясь твердым и сочащимся смазкой.")

		saynn("Медленными, размеренными движениями ты вгоняешь член всё глубже в задницу Артики, растягивая её тугое голубое отверстие до предела...")

		addButton("Продолжить", "Смотреть, что будет дальше", "anal_sex")
	if(state == "anal_sex"):
		playAnimation(StageScene.RopesSex, "sex", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("В то же время ты ускоряешься, теперь уже медленно вбиваясь в её задницу; тело Артики раскачивается взад-вперед, подвешенное в воздухе на верёвках.")

		saynn("[say=artica]Ах.. ах..[/say]")

		saynn("Внутри всё ещё невероятно тесно, её стенки так плотно обхватывают твой {pc.penis}, что ты можешь кончить в любую секунду... Но пока ты сдерживаешься и просто трахаешь её в задницу, положив руки ей на бока и притягивая к себе во время каждого толчка.")

		saynn("[say=pc]Хах... какая тугая добыча.[/say]")

		if (isCaged):
			saynn("Её мокрая киска совсем не получает стимуляции... зато её бесполезный член в клетке — да; прозрачная жидкость капает с кончика, пока он всё сильнее дергается, а её простата становится твердой и набухшей...")

		else:
			saynn("Её мокрая киска совсем не получает стимуляции... зато её собачий член — да; прозрачная жидкость капает с кончика, пока он всё сильнее дергается, а его узел слегка раздувается, и её простата становится твердой и набухшей...")

		saynn("[say=artica]Нх-х.. гхх-х.. ах.. т-ты так м-меня р-растягиваешь.. ах..[/say]")

		saynn("Артика высовывает язык и стонет в пустоту... пока ты не доведешь её до точки невозврата..."+str(" Weak spurts of seed fly out of her caged throbbing dick" if isCaged else " Powerful spurts of seed erupt from her hard throbbing dick")+", её заброшенная киска пульсирует на воздухе, а влажные стенки ануса начинают доить тебя.")

		saynn("[say=artica]Я... ахх-х.. п-прям как.. жопоslut.. ах.. ахх..хх..[/say]")

		saynn("Пока это происходит, ты чувствуешь, что твой собственный оргазм уже близко...")

		addButton("Кончить внутрь", "Забей ей задницу до краев!", "anal_sex_cum")
	if(state == "anal_sex_cum"):
		playAnimation(StageScene.RopesSex, "inside", {pc="artica", npc="pc", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		if (pcHasKnot):
			saynn("Сдерживаться больше нет смысла... и уже слишком поздно выходить... ты вгоняешь свой член глубоко внутрь, заставляя жирный узел растянуть её вход настежь!")

			saynn("[say=artica]Ах! У-узел!..[/say]")

			saynn("Твоя жирная мясистая шишка давит на её маленькую простату, вминая её и выжимая всё до капли,"+str(" Artica's cock is hard as rock again as it shoots out more lines of thick cum!" if !isCaged else " Artica's cock is throbbing in its tight cage again as it shoots out more lines of thick cum!")+"")

		else:
			saynn("Сдерживаться больше нет смысла... и уже слишком поздно выходить... ты вгоняешь свой член глубоко внутрь, пока он не погружается в неё целиком.")

			saynn("[say=artica]Ах!..[/say]")

			saynn("Твой ствол давит на её маленькую простату, вминая её и выжимая всё до капли,"+str(" Artica's cock is hard as rock again as it shoots out more lines of thick cum!" if !isCaged else " Artica's cock is throbbing in its tight cage again as it shoots out more lines of thick cum!")+"")

		saynn("В то же время твой член пульсирует внутри неё, волны твоего {pc.cum} затопляют её задницу, окрашивая сжимающиеся стенки и наполняя её до самых краёв!")

		saynn("[say=pc]Нгхх.. Какая тесная шлюшка..[/say]")

		saynn("Вы оба тяжело дышите, твои ноги едва тебя держат...")

		addButton("Отдохнуть", "Пусть пушистость еще немного повисит", "vag_cum_rest")
	if(state == "do_vag"):
		playAnimation(StageScene.RopesSex, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Злюка, значит... Посмотрим, как она запоёт после этого.")

		saynn("Твоя рука ложится на мех на её спине и скользит по нему, лаская её девичьи изгибы. Когда твои пальцы достигают основания её пушистого хвоста, он инстинктивно обвивается вокруг твоего запястья... но она сама не сопротивляется веревкам, лишь ожидая своей участи...")

		saynn("[say=pc]Такая беспомощная маленькая добыча.[/say]")

		saynn("[say=artica]Д-да...[/say]")

		saynn("С этими словами ты освобождаешь свой член и устраиваешься позади неё, поглаживая её бёдра, пока верёвки удерживают их разведенными для тебя.")

		saynn("Какой отличный вид... оба её голодных отверстия на виду... Но сегодня ты нацелишься на то, что поскорее смазано...")

		saynn("[say=artica]Я.. д-должна быть х-хищницей.. а н-не пойманной д-добычей..[/say]")

		saynn("Твои слова, кажется, взывают к племенным истокам Артики... Можно и дальше нажимать на её болевые точки.")

		addButton("Продолжить", "Смотри, что будет дальше", "vag_sex")
	if(state == "vag_sex"):
		playAnimation(StageScene.RopesSex, "sex", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Артика пытается оглянуться назад... но веревки мешают ей видеть, что ты творишь... Пора заставить её прочувствовать это...")

		saynn("Стремительно пристроившись к этой сочной киске, ты вонзаешься в неё глубоко, твой {pc.penis} погружается в её влажную плоть, раздвигая лазурные складки и заставляя её тело податься вперед.")

		saynn("[say=artica]Ахх-х..[/say]")

		saynn("С низким рыком ты ловишь её, когда она откидывается назад, снова вбиваясь внутрь; твои бедра хлопают по её пушистым бедрам, пока пушинка судорожно вздыхает, а её киска сжимается вокруг твоего вошедшего члена, обволакивая его своим жаром...")

		saynn("[say=artica]Ах.. ахх.. так.. так много..[/say]")

		saynn("[say=pc]Гррх.. А я-то думала.. Хищник.. А сама стонешь как шлюха на моем члене.[/say]")

		saynn("Каждый толчок посылает дрожь удовольствия по её телу, заставляя её извиваться в веревках, а её бедра каждый раз качаются навстречу твоему члену."+str(" Her own cock swayed freely between her legs, leaking precum as you stimulate one of her sensitive spots.." if !isCaged else " Her own cock twitched in its tight chastity cage, leaking precum as you stimulate one of her sensitive spots..")+"")

		saynn("[say=artica]Ах.. ш-шлюшка.. ш-шлюх.. п-поймавшаяся.. д-добыча.. н-наслаждающаяся.. ч-членами.. е-ебёт меня.. нх.. х-х..[/say]")

		addButton("Быстрее", "Трахни её быстрее", "vag_faster")
	if(state == "vag_faster"):
		playAnimation(StageScene.RopesSex, "fast", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		var isPreg = getCharacter("artica").isVisiblyPregnant()
		saynn("По мере того как ты всё более неистово терзаешь жаждущую щель Артики, воздух наполняется её стонами; её застенчивый ротик с трудом выговаривает слова, издавая лишь милые звуки.")

		if (!isPreg):
			saynn("[say=pc]И дело не только в трахе: эта шлюхоподобная хищница не уйдет отсюда, не получив моих щенков внутри себя.[/say]")

			saynn("[say=artica]Д-да.. ах.. о-о.. осемени.. м-меня.. о-осемени э-эту.. ш-шлюхоподобную.. х-хищницу.. ах-х..[/say]")

		else:
			saynn("[say=pc]И дело не только в трахе: эту шлюхоподобную беременную хищницу будут осеменять до тех пор, пока она не выучит своё место.[/say]")

			saynn("[say=artica]Д-да.. ах.. о-о.. осеменяй.. в-всегда.. хх-ха.. ах.. п-помет.. в меня..[/say]")

		saynn("Её пальцы на ногах поджимаются,"+str(" her pregnant belly swaying back and forth.. just like her swollen milky tits.." if isPreg else " her {artica.breasts} swaying back and forth")+".. пока её тело внезапно не сотрясает конвульсия удовольствия!")

		saynn("[say=artica]Аах-х!..[/say]")

		saynn("Артика выгибает спину настолько, насколько позволяют веревки; соки её киски обильно текут вокруг твоего члена, полностью покрывая его, её внутренние стенки сжимают твой ствол, а её анус заметно подергивается в такт ритму..."+str("while her caged cock is throbbing in its prison, shooting weak spurts of seed onto the floor" if isCaged else "while her knotted canine cock is throbbing and shooting strong spurts of seed onto the floor")+"..")

		saynn("Она кажется такой узкой... так и хочется... войти в неё поглубже...")

		addButton("Кончить внутрь", "Ра-а-азмножай!", "vag_cum")
	if(state == "vag_cum"):
		playAnimation(StageScene.RopesSex, "inside", {pc="artica", npc="pc", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		var isPreg = getCharacter("artica").isVisiblyPregnant()
		if (pcHasKnot):
			saynn("Пока Артику всё еще накрывают волны оргазма, твой собственный финиш наконец настигает тебя. С громким рыком ты вбиваешь свой член глубоко внутрь, твой узел с хлопком впечатывается в пульсирующую киску Артики... прежде чем проскользнуть целиком! Толстая головка растягивает её щель, заставляя пушистую бестинку снова выгнуться спиной, а её киска снова заливается сквиртом от перестимуляции. Спустя мгновение твой член начинает пульсировать, наполняя её «машинку для детей» твоим семенем!")

		else:
			saynn("Пока Артику всё еще накрывают волны оргазма, твой собственный финиш наконец настигает тебя. С громким рыком ты вбиваешь свой член глубоко внутрь! Твоя мощная толщина растягивает её щель, заставляя её снова выгнуть спину, а её киска снова заливается сквиртом от перестимуляции. Спустя мгновение твой член начинает пульсировать, наполняя её «машинку для детей» твоим семенем!")

		if (isPreg):
			saynn("[say=pc]Гррх-х.. Беременей, шлюха..[/say]")

		else:
			saynn("[say=pc]Гррх-х.. Залетай, шлюха..[/say]")

		saynn("[say=artica]Нья-а-а-ах..[/say]")

		saynn("Её язык высунут и течет слюна, бедная пушистая сучка жадно ерзает на твоем члене,"+str(" her own caged cock keeps dribbling seed onto the floor.." if isCaged else " her own member keeps dribbling seed onto the floor..")+"")

		saynn("В камере быстро начинает пахнуть сексом... Столько запахов... Вы с Артикой тяжело дышите, твой член полностью внутри её секс-органа, а внутренние стенки массируют и доят его...")

		saynn("[say=artica]Т-т-так м-много.. боги..[/say]")

		addButton("Дать ей отдохнуть", "Пусть пушистость еще немного повисит", "vag_cum_rest")
	if(state == "vag_cum_rest"):
		playAnimation(StageScene.RopesOralSex, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		if (pcHasKnot):
			saynn("Ты ждешь немного, пока твой узел немного спадет... а затем резко вырываешь его, заставляя поток твоего семени хлынуть из её раздолбанного, использованного отверстия...")

		else:
			saynn("Ты позволяешь Артике немного погреть твой член... а затем выходишь, заставляя поток твоего семени хлынуть из её раздолбанного, использованного отверстия...")

		saynn("[say=artica]Ах... я т-такая.. п-породистая сучка для осеменения..[/say]")

		saynn("Затем ты встаешь перед её тяжело дышащей мордочкой, давая ей отличный вид на твой испачканный член...")

		saynn("[say=pc]Прибери за собой, сучка для осеменения.[/say]")

		saynn("Ты кладешь член ей на лицо и просто любуешься тем, как она высовывает язык и начинает вылизывать тебя, слизывая сперму и жадно втягивая её горячий запах...")

		saynn("[say=artica]Хх-х.. нн-нн..нх.. слёрп..[/say]")

		saynn("[say=pc]Хорошая кок-сучка.[/say]")

		saynn("Поскольку твой орган всё еще... влажный... ты просто вытираешь его о её белоснежные пушистые щеки... заставляя её покраснеть.")

		saynn("[say=artica]Д-да.. ж-жаждущая члена.. добыча.. шлюха..[/say]")

		saynn("Пора её отпускать. Ты ослабляешь верёвки, помогаешь пушистой подняться на ноги и собираешь её вещи..."+str(" which there are none obviously.." if isNaked else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getharness")
	if(state == "do_toys"):
		playAnimation(StageScene.RopesSolo, "idle", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("[say=pc]Злая~? Я могу показать тебе, какая я злая![/say]")

		saynn("Пока Артика занята борьбой с путами, ты подходишь к ней, держа что-то в руках.")

		saynn("[say=pc]Открой рот, пушистая.[/say]")

		saynn("Она часто моргает... а затем качает головой. Ты вздыхаешь и тянешься, чтобы ущипнуть её за соски... о боже, в них вставлены шикарные фиолетовые пирсинги.")

		saynn("[say=artica]Ик!..[/say]")

		saynn("Как только Артика приоткрывает губы, ты заталкиваешь внутрь резиновый шарик и быстро затягиваешь кожаные ремни на её голове.")

		saynn("[say=pc]Спасибо... А теперь... вот это...[/say]")

		saynn("В твоих руках оказывается кусок чёрной ткани, которым ты начинаешь завязывать ей глаза, лишая её зрения...")

		saynn("[say=artica]Я... я б-буду п-послушной... с-сделаю в-всё что у-годно... и-ик!..[/say]")

		saynn("[say=pc]Всё, что я слышу, это... «пожалуйста, будь со мной пожестче~». Не волнуйся, так и будет.[/say]")

		saynn("Пока Артика лишена голоса, с повязкой на глазах и полностью обездвижена, ты не теряешь ни секунды и выуживаешь целый арсенал игрушек, от малых до великих. Схватив несколько маленьких розовых вибраторов, ты..."+str("attach one to the tip of her canine cock with a little strap" if !isCaged else "slide one under her chastity cage")+"...а второй приклеиваешь ей прямо на клитор...")

		saynn("[say=pc]Думаешь, это всё? Убери хвост с дороги, моя рабыня~.[/say]")

		saynn("В ответ слышно лишь тихое поскуливание... поэтому ты отвешиваешь ей звонкий шлепок по заднице, от которого девчонка буквально подлетает — из-за веревок Артика начинает кружиться и раскачиваться от удара.")

		saynn("[say=artica]Ммм-х..[/say]")

		saynn("[say=pc]Не заставляй меня приказывать дважды..[/say]")

		saynn("Артика убирает хвост в сторону, обнажая свою влажную, жаждущую щель и милое, тугое анальное отверстие...")

		saynn("Ты берешь небольшую пробку, обильно смазываешь её лубрикантом и начинаешь вводить в её анус, заставляя девчонку извиваться.")

		saynn("[say=pc]Да ладно тебе, я же не собираюсь делать из тебя задротку прямо сейчас, расслабься~.[/say]")

		saynn("Далее... фаллос среднего размера... ты совмещаешь его с щелью Артики и осторожно вгоняешь внутрь, затыкая её второе отверстие.")

		saynn("[say=pc]Ты такая мокрая.. так жаждешь члена.[/say]")

		saynn("Хотя игрушки всё ещё выключены, она уже вовсю виляет задом, а её дырочки заметно сжимаются вокруг них..")

		saynn("[say=pc]Давай повеселимся.[/say]")

		addButton("Включить всё", "Посмотреть, сколько сможет вытерпеть Артика..", "do_toys_cum")
	if(state == "do_toys_cum"):
		playAnimation(StageScene.RopesSolo, "struggle", {pc="artica", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Ты включаешь все игрушки, позволяя им неистово жужжать.. пока ты просто сидишь на кровати и наблюдаешь.")

		saynn("Когда приятная вибрация достигает всех чувствительных точек Артики, она издает приглушенный стон. Её тело извивается, пока вибрация одновременно стимулирует её мужские и женские органы, а фаллос вибрирует внутри её влажной щели.")

		saynn("[say=artica]Нхх-х-хх!..ххх..х.х..[/say]")

		saynn("Не прошло и минуты, как она уже выгибает спину, а её бедра неконтролируемо дергаются от беспощадной стимуляции.")

		saynn("[say=pc]Да неужели? Уже кончаешь?[/say]")

		saynn("Её член пульсирует"+str(" in its cage" if isCaged else "")+", изнывая от желания разрядки, пока предэякулят капает с кончика, разбрызгиваясь по полу под ней. Тем временем её киска сжимается и спазмирует вокруг вибрирующего дилдо, запрятанного глубоко внутри, от этих ощущений у неё текут слюни..")

		saynn("[say=pc]Просто дай мне знать, когда пора. Не хочу пропустить момент.[/say]")

		saynn("Её тугой анус сжимается вокруг анальной пробки, от её ерзанья пробка смещается внутри, массируя простату девушки.. Пока вибрации продолжают расходиться волнами по её телу, оргазм Артики становится всё ближе и ближе..")

		saynn("[say=artica]Нххх-ххх.. НХХххх!.. МХХх-хх!..[/say]")

		saynn("С резким приглушенным криком тело Артики содрогается в экстазе, её мышцы напрягаются под тугими веревками, пока её "+str("locked cock starts throbbing and shooting jets of cum from the little hole of the cage" if isCaged else "hard canine cock starts throbbing and shooting jets of cum")+" на пол, её киска и анус спазмируют вокруг игрушек, выжимая из них всё до последней капли..")

		saynn("Сквирт за сквиртом, соки Артики хлещут из её киски, пропитывая пол под ней, пока вибратор для клитора неустанно работает, растягивая оргазм этой пушистой дурочки всё дольше и дольше, заставляя её выгибаться в веревках изо всех сил.. Можно даже позавидовать..")

		saynn("Может, этого достаточно..")

		addButton("Выключить игрушки", "Дать Артике успокоиться", "toys_turnoff")
	if(state == "toys_turnoff"):
		playAnimation(StageScene.RopesSolo, "idle", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Игрушки продолжают чрезмерно стимулировать чувствительные места Артики; её яички всё сильнее напрягаются, а с кончика её"+str(" caged" if isCaged else "")+"члена всё капает сперма. Наконец ты выключаешь их... но пушистая комочек всё ещё дёргается.")

		saynn("Ты заглядываешь под её повязку... и видишь совершенно отсутствующие, затуманенные голубые глаза... её тело дрожит, а дырочки сжимаются вокруг игрушек, которые находятся внутри неё...")

		saynn("[say=pc]Ого. Кажется, я тебя немного сломал. Хорошо.[/say]")

		saynn("Она всё ещё пускает слюни, щеки горят румянцем, а взгляд расфокусирован...")

		saynn("Если выпустить такую девчонку в дикую природу... это наверняка приведёт к очень плохому концу для неё...")

		addButton("Обнимашки", "Помочь девушке прийти в себя", "toys_cuddle")
	if(state == "toys_cuddle"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", npcBodyState={naked=true}})
		saynn("Когда ты вытаскиваешь все игрушки из её растянутых дырочек и убираешь все вибраторы... ты осторожно ослабляешь верёвки, укладывая пушистую зверушку на холодный пол... где она начинает слизывать собственные выделения... К счастью, её белый мех скрывает любые следы.")

		saynn("[say=pc]Иди сюда, глупышка.[/say]")

		saynn("Ты притягиваешь Артику к себе на тёплые колени и обнимаешь её на кровати. Твои руки нежно гладят её по волосам, успокаивая её чувства.")

		saynn("Покоясь в твоих объятиях, она постепенно восстанавливает дыхание.")

		saynn("[say=artica]Н-ня... т-такая... т-такая шлюшка...[/say]")

		saynn("Ты удивленно приподнимаешь бровь?")

		saynn("[say=pc]Кто?[/say]")

		saynn("[say=artica]..я.. х-ха-ха..[/say]")

		saynn("Ты усмехаешься и нежно трешься носом о её подбородок.")

		saynn("Проведя некоторое время в объятиях, ты помогаешь ей вернуться на место; её разум теперь чуть больше развращен удовольствием, чем прежде...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addPumpButtons(go_id):
	var pumps = GM.pc.getInventory().getItemsWithTag(ItemTag.RopeHarness)
	for pump in pumps:
		addButton(pump.getVisibleName(), pump.getVisibleDescription(), go_id, [pump])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_pick_harness"):
		var pump = _args[0]
		harnessID = pump.getUniqueID()
		#GM.pc.getInventory().removeItem(pump)
		#getCharacter("artica").getInventory().forceEquipRemoveOther(pump)

	if(_action == "kidnap"):
		processTime(5*60)
		if(harnessID != ""):
			var theHarness = GM.pc.getInventory().getItemByUniqueID(harnessID)
			if(theHarness != null):
				GM.pc.getInventory().removeItem(theHarness)
				getCharacter("artica").getInventory().forceEquipRemoveOther(theHarness)

	if(_action == "do_toys"):
		processTime(3*60)
		getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("blindfold"))
		getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ballgag"))

	if(_action == "do_grind_cum"):
		processTime(5*60)
		getCharacter("artica").cummedOnBy("pc", FluidSource.Vagina)
		getModule("ArticaModule").addCorruption(0.01)
		GM.pc.orgasmFrom("artica")

	if(_action == "throatfuck_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInMouthBy("pc")
		getModule("ArticaModule").addCorruption(0.01)
		GM.pc.orgasmFrom("artica")

	if(_action == "deepthroat_pull"):
		processTime(5*60)

	if(_action == "no_release"):
		processTime(2*60)

	if(_action == "eat_artica_out"):
		processTime(5*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		GM.pc.cummedOnBy("artica", FluidSource.Vagina)

	if(_action == "anal_inside"):
		processTime(5*60)

	if(_action == "anal_sex"):
		processTime(5*60)

	if(_action == "anal_sex_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInAnusBy("pc")
		getModule("ArticaModule").triggerCorruption(0.03)
		GM.pc.orgasmFrom("artica")

	if(_action == "vag_sex"):
		processTime(5*60)

	if(_action == "vag_faster"):
		processTime(3*60)

	if(_action == "vag_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInVaginaBy("pc")
		getModule("ArticaModule").triggerCorruption(0.02)
		GM.pc.orgasmFrom("artica")

	if(_action == "vag_cum_rest"):
		processTime(10*60)

	if(_action == "endthescene_getharness"):
		if(harnessID != ""):
			var theHarness = getCharacter("artica").getInventory().getItemByUniqueID(harnessID)
			if(theHarness != null):
				getCharacter("artica").getInventory().removeEquippedItem(theHarness)
				GM.pc.getInventory().addItem(theHarness)
		playAnimation(StageScene.Solo, "stand")
		endScene()
		return

	if(_action == "do_toys_cum"):
		processTime(20*60)
		getModule("ArticaModule").triggerCorruption(0.03)

	if(_action == "toys_turnoff"):
		processTime(5*60)
		getCharacter("artica").getInventory().removeEquippedItemsWithBuff(Buff.BlindfoldBuff)

	if(_action == "toys_cuddle"):
		processTime(3*60)
		if(harnessID != ""):
			var theHarness = getCharacter("artica").getInventory().getItemByUniqueID(harnessID)
			if(theHarness != null):
				getCharacter("artica").getInventory().removeEquippedItem(theHarness)
				GM.pc.getInventory().addItem(theHarness)
		getCharacter("artica").getInventory().removeEquippedItemsWithBuff(Buff.GagBuff)

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
	data["harnessID"] = harnessID

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
	harnessID = SAVE.loadVar(data, "harnessID", "")
