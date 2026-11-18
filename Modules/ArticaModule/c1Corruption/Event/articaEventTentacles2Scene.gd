extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaEventTentacles2Scene"

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
		saynn("Сжимая в лапках тот странный цветок, Артика, судя по всему, снова направляется к медицинскому блоку."+str(" She has to awkwardly cover her private bits up at the same time to avoid drawing too much attention.." if nakedAndShy else "")+"")

		saynn("Интересно...")

		saynn("Тебе снова приходится ехать в первом лифте в одиночку... пока ты просто стоишь снаружи и ждешь второй..")

		addButton("Медпункт", "Посмотрим, что там будет", "in_medical")
	if(state == "in_medical"):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="eliza"})
		aimCameraAndSetLocName("med_lobbymain")
		saynn("Ты спускаешься на лифте на нижний этаж... и украдкой пробираешься в вестибюль медпункта, стараясь не слишком привлекать к себе внимание.")

		saynn("Похоже, Артика показывает это растение кошке-врачу...")

		saynn("[say=artica].. ..[/say]")

		saynn("[say=eliza]Охх. Отлично, это именно то, что нужно. Дай-дай~. А теперь подожди здесь немного![/say]")

		saynn("Кошка-врач куда-то спешит, оставляя"+str(" naked" if isNaked else "")+" Артику стоять у стойки. Вскоре доктор возвращается, держа в руках какой-то флакон...")

		saynn("[say=eliza]И они боялись, что я взорву и эту станцию тоже, глупые людишки. Всё прошло просто замечательно~.[/say]")

		saynn("Почему-то ты чувствуешь слабый запах жженого пластика...")

		saynn("[say=artica].. ..?[/say]")

		saynn("[say=eliza]Ага. Хочу, чтобы ты протестировала это и сообщила мне результаты. Лей это на те же цветы, на маленькие, а то не хочется портить всю настоящую еду.[/say]")

		saynn("Артика хватает флакон с какой-то светящейся зеленой жидкостью... и убирает его.")

		saynn("[say=artica].. ..? ..[/say]")

		saynn("[say=eliza]О, да, Нова? Могу назначить ей внезапный медосмотр... Скажем... прямо сейчас~. Идет?[/say]")

		saynn("Артика согласно кивает.")

		saynn("[say=eliza]Ну, тогда развлекайся~.[/say]")

		saynn("Пушистая краснеет... и направляется обратно к лифту.")

		addButton("Следовать", "Посмотреть, куда идет пушистая...", "artica_in_greenhouses")
	if(state == "artica_in_greenhouses"):
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("main_greenhouses")
		GM.pc.setLocation("main_greenhouses")
		saynn("Артика снова подходит к тем скрытым ступеням... и начинает красться. Она идет тем же путем, что и раньше, обходя случайные патрули, большинство из которых, кажется, дремлют на посту.")

		saynn("Ты делаешь то же самое, следуя за шагами Артики... почти как охотник.")

		saynn("В конце концов пушистая добирается до теплиц. И так как угрозы со стороны Новы нет, она заходит внутрь.")

		addButton("Теплицы", "Посмотри, на что способна Артика", "artica_pours_drug_on_plant")
	if(state == "artica_pours_drug_on_plant"):
		saynn("Ты прокрадываешься внутрь... но решаешь держаться поближе к выходу на случай, если всё снова пойдет наперекосяк.")

		saynn("Артика подходит к одному из больших длинных лотков, где растут множество маленьких цветочков... Она достает ту странную склянку... и просто держит её в руке.")

		saynn("Кажется, пушинка пытается набраться решимости; её глаза закрыты, и она что-то шепчет себе под нос.")

		saynn("Наконец она открывает склянку... и выливает её светящееся зеленое содержимое на цветы.")

		saynn("Сначала ничего не происходит... растения лишь слегка вздрагивают, и на этом всё. Но как только светящаяся жидкость начала заметно просачиваться по стеблям, всё стремительно изменилось...")

		addButton("Продолжить", "Смотреть, что будет дальше", "plant_grabs_artica")
	if(state == "plant_grabs_artica"):
		playAnimation(StageScene.TentaclesTease, "tease", {pc="artica", plant=true, bodyState={hard=true}})
		saynn("Цветы начали расти с поразительной скоростью: стебли становились толще и длиннее, изгибаясь и извиваясь к свету. Лепестки на кончиках быстро опадают, обнажая зеленые острые... щупальца.")

		saynn("Артика отступает назад, её глаза широко распахнуты от изумления.")

		saynn("[say=artica]Это действительно работает... вау...[/say]")

		saynn("Её восторг быстро сменяется тревогой... когда одно из щупалец внезапно обвивает её лодыжку.")

		saynn("[say=artica]М-м... эй.. п-пусти..[/say]")

		saynn("Артика пытается вытащить ногу, но растения продолжают расти, и их хватка становится только крепче... Бедняжка дрожит от страха."+str(" Her exposed canine cock is hard as a rock.." if (isNaked && !isCaged) else "")+"")

		saynn("Подгоняемая адреналином, Артика умудряется ухватиться за одну из стальных балок, поддерживающих крышу этой теплицы, и начинает вытягивать себя.")

		addButton("Запереть двери", "(Вариант Noncon) Не дать Артике сбежать от монстра, которого она сама и создала...", "lock_doors")
		addButton("Просто наблюдай", "(Вариант Consensual) Просто наблюдать за тем, что будет дальше", "con_variant")
	if(state == "lock_doors"):
		setFlag("ArticaModule.nextReaction", "t2noncon")
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.TentaclesTease, "tease", {pc="artica", plant=true, bodyState={hard=true, naked=true}})
		saynn("Артика вот-вот вырвется из объятий зеленых щупалец... но тебе слишком любопытно посмотреть, что они с ней сделают... поэтому ты быстро выскальзываешь из теплицы и запираешь двери, запирая пушистику внутри...")

		saynn("Еще несколько быстрорастущих усиков скользят по её телу, пытаясь притянуть её поближе...")

		saynn("[say=artica]П-прекрати.. э-это..[/say]")

		saynn("Чудом пушистике удается освободить ногу! Она стремительно бросается к выходу... но врезается в закрытые двери.")

		saynn("[say=artica]Ч-что.. к-как.. п-почему эти.. п-погоди!.. п-помогите!..[/say]")

		saynn("Паника захлестывает её; она отчаянно давит на двери, пытаясь их открыть... пока одинокий щупалец не вытягивается достаточно длинным, чтобы обвить лодыжку Артики и резко дернуть её назад, заставляя бедную перепуганную девушку потерять равновесие и рухнуть на пол.")

		saynn("[say=artica]АЙ![/say]")

		saynn("Она пытается вцепиться когтями в пол... но другие щупальца быстро обвивают её бедра и запястья, утягивая обратно туда, где она стояла мгновение назад...")

		if (!isNaked):
			saynn("Одно из щупалец проскальзывает под её рубашку... и стягивает её... в то время как еще несколько... находят её"+str(" caged drippy cock" if isCaged else " hard canine cock")+" и чувствительную киску, спрятанную в шортах... которые они быстро обнажают...")

			saynn("[say=artica]М-моя у-униформа.. н-нет.. п-подождите.. п-п-пожалуйста..[/say]")

		else:
			saynn("Одно щупальце находит грудь Артики и обхватывает её... в то время как другие... достигают её"+str(" caged drippy cock" if isCaged else " hard canine cock")+" и чувствительной киски...")

			saynn("[say=artica]Н-нет.. п-подождите.. п-п-пожалуйста..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_noncon_cum")
	if(state == "artica_noncon_cum"):
		playAnimation(StageScene.TentaclesTease, "inside", {pc="artica", pcCum=true, plant=true, bodyState={hard=true, naked=true}})
		saynn("Сердце Артики бешено колотится, пока она отчаянно пытается вырваться... и всё же... хватка растения была непоколебимой. Казалось, у него есть собственный разум...")

		saynn("Толстый, скользкий отросток прижимается к её киске, дразня влажное входное отверстие... а затем одним грубым толчком врывается внутрь, широко раздвигая голубоватые складки!")

		saynn("[say=artica]Ах!.. П-погоди!..[/say]")

		if (isCaged):
			saynn("В то же время другой, маленький и милый отросток умудряется проскользнуть под девственную корзинку Артики и ныряет внутрь её влагалища, дразня и поглаживая запертый пульсирующий член; бедняжка-пушинка невольно стонет, пока удовольствие и страх захлестывают её разум одновременно...")

		else:
			saynn("Одновременно с этим другой отросток обвивает её собачий член и начинает ритмично и неумолимо тереть его, заставляя бедняжку-пушинку стонать, пока удовольствие и страх смешиваются в её голове...")

		saynn("[say=artica]Нхх.. ах.. м-моя к-киска.. ах.. п-пре.. п.. ах-х..[/say]")

		saynn("Щупальца трахали её безжалостно: одно глубоко ввинчивалось в киску, попадая по самым чувствительным точкам, отчего она задыхалась и стонала, а её внутренние стенки судорожно сжимались вокруг него... в то время как другое ласкало её член."+str(", making it throb inside its little cage.." if isCaged else ", making the knot at its base start getting bigger and fatter..")+"Непрекращающаяся стимуляция перегружает все её чувства...")

		saynn("[say=artica]Нх-х.. с-слишком м-много.. ах.. ахх-.. ах..[/say]")

		saynn("Удовольствие было слишком сильным, слишком интенсивным...")

		saynn("С громким криком Артика кончает, её {artica.penis} извергается густыми, горячими струями спермы, которые разлетаются по её животу и всем окружающим щупальцам, а её киска отчаянно пытается выдоить толстый отросток, застрявший внутри неё.")

		saynn("Органические волны проносятся сквозь её тело.. одна за другой.. пока все её лапки крепко зажаты, оставляя пушистую бедняжку беспомощной перед этим потоком экстатических ощущений..")

		saynn("[say=artica]Ах.. ах.. ах.. ах..[/say]")

		saynn("Когда её оргазм начинает угасать, щупальца медленно разжимаются, позволяя Артике рухнуть на пол.. в то время как они сами отползают на свои исходные позиции, постепенно уменьшаясь в размерах..")

		saynn("Артика уставилась в потолок, её тело всё ещё дрожит от пережитого интенсивного опыта.")

		saynn("[say=artica]Ч-что.. хх.. ах.. ч-что же я н-наделала..[/say]")

		saynn("Артика пытается подняться на ноги, её лапы всё ещё подрагивают.."+str(" She grabs her clothes and looks at the plants with a mix of awe and fear.." if !isNaked else "She looks at the plants with a mix of awe and fear..")+"Эхо удовольствия всё ещё вибрирует в её изнурённом, полностью использованном теле..")

		saynn("Переведя дух, она проходит мимо тебя; её разум настолько затуманен, что она даже не замечает, что двери снова открылись..")

		saynn("Тебе тоже пора уходить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "con_variant"):
		setFlag("ArticaModule.nextReaction", "t2con")
		playAnimation(StageScene.Solo, "stand", {pc="artica"})
		saynn("Ты решаешь спрятаться и просто наблюдать, вмешиваясь лишь в том случае, если Артика окажется в серьезной опасности. А пока что.. с ней вроде бы всё в порядке.. по большей части.")

		saynn("Артике удается вытащить ногу, и она бросается к выходу. Ей удается прилично отдалиться от растений... но затем она замирает, тяжело дыша и оглядываясь назад.")

		saynn("Зеленые скользкие щупальца все еще немного растут... но теперь они просто слепо колышутся в воздухе, пытаясь нащупать источник тепла... выписывая в воздухе завораживающие узоры.")

		saynn("Белый"+str(" naked" if isNaked else "")+" пушок заставляет ее перевести дух... она просто завороженно разглядывает огромное растение. С ее позиции все эти щупальца теперь кажутся... вроде как безобидными... Ее киска становится всё мокрее... Она явно чувствует какое-то... странное притяжение... непреодолимое желание позволить им коснуться себя.")

		saynn("Неужели она это сделает?..")

		addButton("Продолжить", "Смотреть, что будет дальше", "con_artica_returns_to_tentacles")
	if(state == "con_artica_returns_to_tentacles"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.TentaclesTease, "tease", {pc="artica", plant=true, bodyState={hard=true, naked=true}})
		saynn("Медленно Артика начинает отступать, сокращая дистанцию между собой и зелеными щупальцами, которые, кажется, уже почуяли ее присутствие и тянутся к ее телу...")

		saynn("[say=artica]Зачем я это д-делаю...[/say]")

		saynn("Ее голос дрожит, тело пробирает дрожь, когда первое щупальце касается ее бедра — это прикосновение одновременно чужеродное... и чертовски возбуждающее... Артика подходит всё ближе и ближе, позволяя себе стать уязвимой перед их ласками...")

		if (!isNaked):
			saynn("С нерешительным, прерывистым вздохом Артика отдается моменту, позволяя новым щупальцам исследовать ее тело; они легко забираются под ее футболку и шорты, стягивая их и обнажая ее {artica.breasts}, "+str("caged drippy cock" if isCaged else "hard drippy cock")+" и ее мокрую, жаждущую киску...")

		else:
			saynn("С нерешительным, дрожащим вздохом Артика отдается моменту, позволяя новым отросткам исследовать ее тело; их скользкие кончики скользят по меху, лаская изгибы ее {artica.breasts} и бедер, вызывая дрожь во всем теле, "+str("her locked member dripping pre" if isCaged else "her hard cock dripping pre")+"..")

		addButton("Продолжить", "Смотреть, что будет дальше", "con_artica_cums")
	if(state == "con_artica_cums"):
		playAnimation(StageScene.TentaclesTease, "inside", {pc="artica", pcCum=true, plant=true, bodyState={hard=true, naked=true}})
		saynn("Один из тентаклей обвивает ее талию, притягивая ближе... в то время как другой скользит между ее ног, находя и дразня ее киску и"+str(" caged cock" if isCaged else " cock")+"своими нежными ласками.")

		saynn("[say=artica]Лег-легко.. ах..[/say]")

		saynn("Тихий стон сорвался с ее губ, когда тентакли стали смелее, растирая ее клитор и надавливая на складки.. пока не нашли влажное горячее отверстие и не растянули его широко, набивая ее мокрую, жаждущую киску до отказа.."+str(" At the same time, another tendril wraps around her cyan shaft and begins stroking it, spreading her own precum around the veiny texture.." if !isCaged else " At the same time, another tendril, a very thin one, finds its way under Artica's chastity cage.. and slides inside her sheath, rubbing the pointy tip of a cyan shaft that is trapped in there..")+"")

		saynn("[say=artica]Ах..[/say]")

		saynn("Теперь ей не сбежать, даже если бы она захотела.. но она и не хочет.. Ее ноги дрожат, когда тентакли.. щупальца.. начинают входить внутрь, наполняя ее киску в голодном ритме, почти созвучном ее бешеному сердцебиению.")

		saynn("[say=artica]Ах.. ахх-х.. ах.. ах.. п-пожалуйста..[/say]")

		saynn("Артика стонет громче, ее милые звуки эхом разносятся по оранжерее, смешиваясь со влажными звуками ее киски, которую нещадно долбят; сразу два тентакля растягивают ее стенки, попадая по всем самым чувствительным точкам..")

		saynn("И затем, с криком экстаза, Артика кончает так сильно, что ее тело выгибается дугой, а киска судорожно сжимает тентакли внутри; ее член дергается, выбрасывая густые струи спермы на ее живот и на все окружающие отростки. Тентакли продолжают двигаться, выцеживая каждую последнюю каплю семени из ее яичек, пока она переживает оргазм.")

		saynn("[say=artica]Ах-х!.. Ахх.. ах..[/say]")

		saynn("Изнуренная и опустошенная, Артика прислоняется к растению, её тело всё ещё дрожит от послевкусия оргазма. Зелёные скользкие щупальца медленно втягиваются, оставляя её с чувством удовлетворения... но в то же время — какой-то пустоты.")

		saynn("[say=artica]Ч-что.. хх.. ах.. ч-что же я н-наделала..[/say]")

		saynn("Артика пытается подняться на ноги, её лапы всё ещё подрагивают.."+str(" She grabs her clothes and looks at the plants with a mix of awe and fear.." if !isNaked else "She looks at the plants with a mix of awe and fear..")+"Отголоски наслаждения всё ещё вибрируют в её теле...")

		saynn("Переведя дух, она проходит мимо тебя; её разум настолько затуманен, что она совершенно не замечает твоего присутствия.")

		saynn("Тебе тоже пора уходить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_medical"):
		processTime(3*60)

	if(_action == "artica_in_greenhouses"):
		processTime(10*60)

	if(_action == "artica_pours_drug_on_plant"):
		processTime(5*60)

	if(_action == "plant_grabs_artica"):
		processTime(3*60)

	if(_action == "lock_doors"):
		processTime(5*60)

	if(_action == "con_variant"):
		processTime(5*60)

	if(_action == "artica_noncon_cum"):
		processTime(5*60)
		getCharacter("artica").cummedOnBy("artica")
		getModule("ArticaModule").triggerCorruption(0.07)

	if(_action == "con_artica_returns_to_tentacles"):
		processTime(5*60)

	if(_action == "con_artica_cums"):
		processTime(5*60)
		getCharacter("artica").cummedOnBy("artica")
		getModule("ArticaModule").triggerCorruption(0.07)

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
