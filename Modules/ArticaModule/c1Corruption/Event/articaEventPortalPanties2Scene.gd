extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var hasPortalPantiesAlready = false

func _init():
	sceneID = "articaEventPortalPanties2Scene"

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
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Похоже, Артика направляется к лифту.")

		saynn("Твоя догадка: она снова идет в мастерскую...")

		addButton("Следовать", "Проследить за ней", "in_workshop")
	if(state == "in_workshop"):
		GM.pc.setLocation("eng_workshop")
		aimCameraAndSetLocName("eng_workshop")
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="alexrynard"})
		saynn("И ты не ошибся: Артика стоит рядом с тем лисим инженером.")

		saynn("[say=alexrynard]Слушай, я занят. Не хочу звучать грубо, но... я не так жажду секса, как большинство здесь обитающих.[/say]")

		saynn("Лисенок изо всех сил пытается подобрать правильные слова, говоря строго, но медленно. Пушинка опускает взгляд.")

		saynn("[say=artica].. ..[/say]")

		saynn("[say=alexrynard]Я рада, что тебе нравится быть подопытным. Уверена, кто-нибудь в медблоке это оценит. М-м?[/say]")

		saynn("Инженер вздыхает и пытается вернуться к работе, сжимая в руке отвертку. Он пытается что-то открутить... но его руки начинают дрожать, когда Артика собирается уходить...")

		saynn("[say=alexrynard]Погоди![/say]")

		saynn("Пушинка мгновенно возвращается к лисенку, ее глаза полны надежды. А инженер снова тяжело вздыхает.")

		saynn("[say=alexrynard]У меня есть еще кое-что для тестов. Но это в последний раз.[/say]")

		saynn("Фокси запускает руку под верстак... и вытаскивает еще один кейс. Он открывает его... и обнаруживается... трусики? Фиолетовые трусики. Артика с любопытством склоняет голову набок, разглядывая обычный на вид предмет одежды.")

		saynn("[say=artica]..?[/say]")

		saynn("[say=alexrynard]Ну надо же, смотри-ка.[/say]")

		saynn("Он выворачивает трусики наизнанку... обнаруживая прикрепленные к ткани какие-то устройства. Вместе с ними он показывает Артике еще какую-то... трубку.")

		saynn("[say=alexrynard]Ты сама во всем разберешься, я уверен. А теперь оставь меня в покое, мне нужно сосредоточиться.[/say]")

		saynn("Артика хватает оба прототипа... и уже начинает натягивать трусики на себя...")

		saynn("[say=alexrynard]Нет, не здесь. Иди... куда-нибудь в другое место.[/say]")

		saynn("Она кивает... и просто уходит, покачивая бедрами от особого возбуждения.")

		saynn("[say=artica]..[/say]")

		saynn("[say=alexrynard]Не за что.[/say]")

		addButton("Следовать", "Посмотрим, куда теперь направилась Артика...", "in_cell")
	if(state == "in_cell"):
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		GM.pc.setLocation("cellblock_lilac_nearcell")
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.SexPortalOral, "tease", {pc="artica", onlyRight=true, bodyState={naked=true, hard=true}})
		removeCharacter("alexrynard")
		saynn("Артика влетает в свою камеру"+str(", быстро швыряет свою одежду на кровать" if !isNaked else "")+"и натягивает неприметные фиолетовые трусики.")

		saynn("[say=artica]..просто трусики?.. По крайней мере, сидят плотно..[/say]")

		saynn("От того, что она их надела, ничего особенного не произошло... и на них, кажется, нет ни кнопок, ни каких-либо органов управления... поэтому она переключает внимание на другое устройство.")

		saynn("[say=artica]..хм..[/say]")

		saynn("А вот это куда интереснее: на нем целый ряд кнопок и маленький экранчик. Она делает глубокий вдох и нажимает на одну из них.")

		saynn("Раздается электронный писк, а затем устройство загорается... почти как фонарик.")

		saynn("[say=artica]Ой!..[/say]")

		saynn("Но на самом деле это было нечто иное. Глаза Артики расширяются от изумления, когда устройство открывает своего рода портал... и внутри этого портала... она видит безошибочно узнаваемые бирюзовые складки своей собственной киски...")

		saynn("[say=artica]Ох.. погоди.. что.. к-как..[/say]")

		saynn("Сердце бешено колотится, когда она подносит устройство... которое теперь больше напоминает мастурбатор... всё ближе... От тепла её собственного дыхания киска, изображенная на этом мастурбаторе, начинает сжиматься и намокать. Артика тут же пытается заглянуть в свои трусики... но всё, что ей удаётся — это освободить свой член; трусики плотно обхватили её щель... так что отрицать очевидное больше невозможно...")

		saynn("[say=artica]Неужели... именно так выглядит моя киска?.. Вау...[/say]")

		saynn("Она проводит языком по складкам... и стонет, чувствуя, как её лижут... Её глаза сияют от возбуждения...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_sits")
	if(state == "artica_sits"):
		playAnimation(StageScene.FleshlightSit, "tease", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Не в силах больше сопротивляться, она садится на край кровати, приставляя мастурбатор к кончику своего пульсирующего, узловатого собачьего члена. Она осторожно обводит им свои лепестки, смешивая предэякулят с соками своей киски... прежде чем внезапно замереть и отстранить мастурбатор.")

		saynn("[say=artica]..неужели я... д-действительно это сделаю?..[/say]")

		saynn("Она колеблется, её взгляд становится отчаянным.")

		saynn("[say=artica]..неужели я и вправду с-сама себя оттрахаю...[/say]")

		saynn("Артика вздыхает, её тело ерзает, пальцы ног поджимаются. Она подносит мастурбатор чуть ближе к лицу... и раздвигает складки другой лапой... заглядывая глубоко внутрь... видя весь этот скользкий любовный туннель с тугой шейкой матки на конце... Артика в мельчайших деталях видит, как сжимается её киска... её собственный возбужденный запах бьёт в ноздри... дурманящий аромат...")

		saynn("[say=artica]..может, совсем чуть-чуть... ммм... я просто вытащу его перед самым концом... д-да...[/say]")

		saynn("Она прижимает флешлайт к кончику своего члена... и позволяет ему проникать в складки плоти, раздвигая их... её собственный член скользит в приветливую влажную щель...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_fucks_herself")
	if(state == "artica_fucks_herself"):
		playAnimation(StageScene.FleshlightSit, "sex", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Наслаждение накрывает мгновенно и с невероятной силой; её тело откликается и на само проникновение, и на внутренние ощущения, а с губ срывается тихий стон...")

		saynn("[say=artica]Ах..[/say]")

		saynn("Артика начинает с медленных, размеренных толчков, и каждое движение флешлайта заставляет её содрогаться от дрожи.")

		saynn("[say=artica]Я чувствую... к-каждый дюйм... своего собственного члена... внутри себя... ах... ах...[/say]")

		saynn("Её дыхание учащается, смешиваясь с милыми стонами, которые она издает, трахая саму себя, утопая в море наслаждения...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_fucks_herself_faster")
	if(state == "artica_fucks_herself_faster"):
		playAnimation(StageScene.FleshlightSit, "fast", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("С каждым толчком она, сама того не замечая, ускоряется, и флешлайт становится скользким от её соков. Двойная стимуляция — когда она одновременно и трахает, и трахается — сводит её с ума, а стоны становятся всё громче.")

		saynn("[say=artica]Д-да... ах... хах...[/say]")

		saynn("Она чувствует, как узел у основания её члена раздувается от крови... и хлопает по чувствительным складкам, больше не в силах войти внутрь.")

		saynn("[say=artica]Мне стоит остановиться... п-прямо сейчас... ах... еще всего несколько раз... ммм-м... и всё...[/say]")

		saynn("Она уже близко, её тело извивается на кровати, а по всему телу пробегает дрожь...")

		saynn("[say=artica]Мне н-нужно остановиться..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_doesnt_stop")
	if(state == "artica_doesnt_stop"):
		playAnimation(StageScene.FleshlightSit, "cum", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Собственная киска сжимала её слишком сильно, и Артика издала страстный стон, когда с силой вогнала свой член целиком в эту плоть.. узел с приятным хлопком проскользнул внутрь..")

		saynn("[say=artica]Нхх.. я н-не могу остановиться..[/say]")

		saynn("Её тело дрожит, накрывая волной оргазма. С губ срываются новые стоны, пока густая кремовая сперма бьёт струями из её члена, наполняя её собственную киску.. Она, должно быть, чувствовала каждый толчок, ощущая, как внутри разливается тепло..")

		saynn("Её растопыренные пальцы ног вытянуты, подбородок высоко поднят.. а глаза сияют от похоти..")

		saynn("[say=artica]З-зачем я это сделала.. ах..[/say]")

		saynn("Ты и сама знаешь почему..")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_first_orgasm")
	if(state == "after_first_orgasm"):
		playAnimation(StageScene.FleshlightSit, "inside", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Когда оргазм начинает утихать, она остается тяжело дышащей, при этом её член всё еще остается внутри неё, создавая милую выпуклость на животе..")

		if (getCharacter("artica").isVisiblyPregnant()):
			saynn("[say=artica]Х-хотя, я и так уже беременна..[/say]")

		else:
			saynn("[say=artica]Я так с-себя забеременею..[/say]")

		saynn("Артика смотрит вниз на себя... узел не дает ни капле вытечь... если вытащить его сейчас, на кровать хлынет поток семени...")

		saynn("Даже после такого оргазма глаза Артики всё еще полны похоти...")

		saynn("[say=artica]Ну... раз уж я и так кончила в с-себя...[/say]")

		saynn("Неужели она реально продолжит... какая же ненасытная пушинка.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_more_horny")
	if(state == "artica_more_horny"):
		playAnimation(StageScene.FleshlightSit, "standsex", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Она осторожно стягивает фаллоимитатор со своего разбухшего узла, ахая от того, как он с хлопком выскальзывает, оставляя её киску слегка приоткрытой и сочащейся собственной спермой. Затем, не теряя ни секунды, Артика поудобнее устраивается на кровати, прицеливая фаллоимитатор к своему члену...")

		saynn("На этот раз она не ласкает ствол, а с силой вгоняет его в свою киску; её бедра уже двигаются в размеренном темпе, а узкая, влажная щель плотно обхватывает член, причём излишки семени делают её любовный туннель невероятно скользким...")

		saynn("[say=artica]Ах... п-почему в киске так п-приятно...[/say]")

		saynn("Может, тебе стоит ей помочь?")

		addButton("Просто наблюдай", "Просто наблюдай, как Артика засаживает сама себе", "just_watch")
		addButton("Присоединиться", "Хватай фаллоимитатор Артики и помоги ей трахать саму себя...", "join_in")
	if(state == "just_watch"):
		setFlag("ArticaModule.nextReaction", "p2alone")
		playAnimation(StageScene.FleshlightSit, "standfast", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Да ну, ты скорее просто позволишь ей повеселиться. Зачем пугать пушистую... когда она так отчаянно и похотливо стонет...")

		saynn("Она ускоряется, крепко сжимая лапами фаллоимитатор и всаживая его всё быстрее и сильнее; её полусдувшийся узел то и дело шлепает по набитой пизде, периодически выскальзывая туда-сюда...")

		saynn("[say=artica]Ах.. ах.. Ты такая шлюшка, Артика.. Т-трахать собственную пизду вот так.. ах.. так тесно..[/say]")

		saynn("От удовольствия у неё идет кругом голова, яички напрягаются всё сильнее, а член пульсирует внутри фаллоимитатора, пока она приближается к своему второму оргазму...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_cums_inside_herself_again")
	if(state == "artica_cums_inside_herself_again"):
		playAnimation(StageScene.FleshlightSit, "standinside", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Её узел снова раздувается от крови... что заставляет её жаждать... этого...")

		saynn("Одним резким толчком ей удается снова завязаться в своей пизде... её оргазмирующие внутренние стенки сжимаются вокруг собачьего члена... пока она не кончает на полную, выплескивая вторую порцию глубоко в матку и забивая собственную пизду снегом...")

		saynn("[say=artica]Ах.. ня-аааахх.. ах..[/say]")

		saynn("Она продолжала двигаться, её тело действовало само по себе, выжимая каждую последнюю каплю спермы из яичек... Она тяжело дышит... её трясет... а щель всё сильнее сжимается вокруг узла...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_after_double")
	if(state == "artica_after_double"):
		playAnimation(StageScene.FleshlightSit, "inside", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Наконец, измотанная и совершенно опустошенная, Артика валится на кровать, всё ещё оставаясь завязанной внутри собственной пизды.")

		saynn("Она лежит, тяжело дыша и наслаждаясь послевкусием, пока всё её тело всё ещё покалывает от удовольствия.")

		if (getCharacter("artica").isVisiblyPregnant()):
			saynn("[say=artica]Н-надо было этого не делать.. Как же я теперь буду дрочить по-другому.. ха-ха..[/say]")

		else:
			saynn("[say=artica]Я определенно умудрилась забеременеть.. ха-ха..[/say]")

		saynn("Ты позволяешь девушке прийти в себя.. и просто уходишь. Какая же она всё-таки кинки-пушинка..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_removepanties")
	if(state == "join_in"):
		setFlag("ArticaModule.nextReaction", "p2pc")
		playAnimation(StageScene.SexFleshlight, "tease", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Артика так увлеклась трахом самой себя.. что даже не услышала твоих шагов, приближающихся к её кровати..")

		saynn("Без лишних предупреждений ты выхватываешь фаллоимитатор из рук Артики, заставляя её ахнуть.")

		saynn("[say=artica]АХ! И-ИП![/say]")

		saynn("Другой рукой ты притягиваешь эту пушинку к себе в объятия.")

		saynn("[say=pc]Ого.. Посмотри-ка.. твоя киска такая мокрая..[/say]")

		saynn("[say=artica]Ч-что.. ты..[/say]")

		saynn("Ты не отвечаешь, вместо этого поднося фаллоимитатор вплотную к её подергивающемуся члену, потирая чувствительные голубые складки о кончик острого клыкастого члена.. Артика вздрагивает, её тело реагирует на это дразнящее прикосновение.")

		saynn("[say=pc]Какая нетерпеливая девочка..[/say]")

		saynn("Она скулит, инстинктивно подаваясь бедрами вперед в поисках тепла и тесноты.. но каждый раз, когда она это делает, ты лишь отстраняешь её киску подальше.")

		saynn("[say=artica]Пожалуйста..[/say]")

		saynn("Её голос переходит в отчаянный шепот..")

		saynn("[say=artica]Пожалуйста.. м-мне нужно..[/say]")

		saynn("Ты медленно надеваешь флешлайт на головку члена Артики, издевательски водя игрушкой вверх и вниз, так что её киска никогда не принимает всю длину.. Артика стонет, её бедра дергаются всё сильнее, когда она пытается затолкнуться глубже в игрушку.. но ты крепко удерживаешь её на месте..")

		saynn("[say=artica]Пожалуйста.. всё что угодно.. я сделаю всё, что скажешь.. м-мне нужно..[/say]")

		saynn("[say=pc]Тебе нужно что?[/say]")

		saynn("[say=artica]Мне нужно кончить.. в с-свою собственную п-письку.. я х-хочу осеменить саму себя.. п-пожалуйста..[/say]")

		saynn("То, как Артика умоляет, заставляет тебя улыбаться.. Как тут сможешь отказать?")

		addButton("Отдай это ей", "Скользи флешлайтом по её члену...", "pc_slides_felshlight")
	if(state == "pc_slides_felshlight"):
		playAnimation(StageScene.SexFleshlight, "sex", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Твой подбородок ложится ей на плечо, когда ты наконец насаживаешь флешлайт на член Артики, и полусдувшийся узел тоже проскальзывает внутрь...")

		saynn("[say=artica]Ах..[/say]")

		saynn("Артика громко стонет, когда знакомая теснота охватывает её член... знакомый член растягивает её дырочку...")

		saynn("Ты начинаешь ласкать её член флешлайтом в таком темпе, что она начинает ерзать и тереться о тебя...")

		saynn("[say=pc]Тебе нравится трахать саму себя?[/say]")

		saynn("[say=artica]Д-да... ах...[/say]")

		saynn("[say=pc]Ну так сделай это, трахни себя.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pc_slides_felshlight_fast")
	if(state == "pc_slides_felshlight_fast"):
		playAnimation(StageScene.SexFleshlight, "fast", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Артика подчиняется, слегка подавая бедра вперед, чтобы встретить флешлайт. Ощущение того, как она трахает сама себя, сводит её с ума, из её уст вырываются всё более страстные стоны... пока ты всё быстрее двигаешь флешлайтом по её члену.")

		saynn("[say=artica]Ах... ах... ах...[/say]")

		saynn("Ты чувствуешь, как её киска сопротивляется, её внутренние стенки сжимаются вокруг пульсирующего узловатого члена, усиливая трение. Но ты продолжаешь давить, заставляя её щель проглотить почти всю длину... раздувшийся от крови шар снова насаживается на складки её плоти...")

		saynn("[say=pc]Что мне делать с этим узлом?[/say]")

		saynn("[say=artica]В-внутрь.. пожалуйста.. ах.. в-вбей его.. заполни мой п-пиздю.. пожалуйста.. ах..[/say]")

		saynn("Какая ненасытная пушинка...")

		addButton("Узел", "Засунуть член Артики в её киску на всю длину", "pc_makes_artica_knot_herself_cum")
	if(state == "pc_makes_artica_knot_herself_cum"):
		playAnimation(StageScene.SexFleshlight, "inside", {pc="artica", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Когда Артика была уже близка к оргазму, ты внезапно толкнул плоть глубже, заставляя узел широко раздвинуть её киску и войти внутрь с милым чпокающим звуком.")

		saynn("[say=artica]АХ!.. Ахх-хх..[/say]")

		saynn("Артика вскрикивает от стона, её киска мертвой хваткой обхватывает ствол на всю длину. То, что её завязывает... её собственный член... быстро доводит пушинку до края.")

		saynn("[say=artica]Я.. Ах-х..[/say]")

		saynn("Её {artica.penis} пульсирует, выбрасывая густые струи кончи в фаллоимитатор... они заполняют её матку, смешиваясь с уже накопленным там семенем. Ты продолжаешь тянуть фаллоимитатор, стараясь выжать из её яичек последнюю каплю спермы.")

		saynn("[say=pc]Хорошая девочка. Да, размножай себя, вот так..[/say]")

		saynn("Она прижимается к тебе, её ноги дрожат, а пальцы на ногах то и дело поджимаются.")

		addButton("Обнимашки", "Притянуть её к себе, чтобы обняться", "do_cuddle_after_sex")
	if(state == "do_cuddle_after_sex"):
		playAnimation(StageScene.Cuddling, "squirm", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Ты укладываешь измотанную, опустошенную Артику на кровать и обнимаешь её... при этом её член всё еще плотно сидит в фаллоимитаторе, а узел надежно удерживает его внутри..")

		saynn("[say=artica]Хх-хх.. ммхх..[/say]")

		saynn("Ты посмеиваешься, глядя, как она всё еще извивается в твоих руках.")

		saynn("[say=pc]Наслаждаешься?[/say]")

		saynn("[say=artica]Да!.. ах.. как ты..[/say]")

		saynn("[say=pc]Ты не особо-то и пряталась, верно?[/say]")

		saynn("Она опускает взгляд.")

		saynn("[say=artica]М-может быть.. ха-ха..[/say]")

		saynn("Ты прижимаешься к её щеке, пока она тихонько мурлычет.")

		saynn("[say=pc]Какая послушная девочка.[/say]")

		saynn("Вы просто проводите время вот так.. пока Артика работает грелкой для члена.. для своего собственного члена..")

		saynn("Но в конце концов пришло время уходить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_removepanties")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_workshop"):
		processTime(3*60)

	if(_action == "in_cell"):
		processTime(3*60)
		if(!getCharacter("artica").getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom)):
			var thePanties = GlobalRegistry.createItem("PortalPanties")
			thePanties.coversPenis = false
			getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(thePanties)
		else:
			hasPortalPantiesAlready = true

	if(_action == "artica_sits"):
		processTime(3*60)

	if(_action == "artica_fucks_herself"):
		processTime(3*60)

	if(_action == "artica_fucks_herself_faster"):
		processTime(3*60)

	if(_action == "artica_doesnt_stop"):
		processTime(3*60)
		getCharacter("artica").cummedInVaginaBy("artica")
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "after_first_orgasm"):
		processTime(2*60)

	if(_action == "artica_more_horny"):
		processTime(2*60)

	if(_action == "just_watch"):
		processTime(3*60)

	if(_action == "join_in"):
		processTime(3*60)

	if(_action == "artica_cums_inside_herself_again"):
		processTime(3*60)
		getCharacter("artica").cummedInVaginaBy("artica")
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "artica_after_double"):
		processTime(3*60)

	if(_action == "endthescene_removepanties"):
		if(!hasPortalPantiesAlready):
			getCharacter("artica").getInventory().clearSlot(InventorySlot.UnderwearBottom)
		endScene()
		return

	if(_action == "pc_slides_felshlight"):
		processTime(3*60)

	if(_action == "pc_slides_felshlight_fast"):
		processTime(3*60)

	if(_action == "pc_makes_artica_knot_herself_cum"):
		processTime(3*60)
		getCharacter("artica").cummedInVaginaBy("artica")
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "do_cuddle_after_sex"):
		processTime(5*60)

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
	data["hasPortalPantiesAlready"] = hasPortalPantiesAlready

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
	hasPortalPantiesAlready = SAVE.loadVar(data, "hasPortalPantiesAlready", false)
