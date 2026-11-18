extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var dildoID = ""
var dildoHasArticaCum = false
var dildoHasCum = false
var dildoHasSomething = false

func _init():
	sceneID = "articaEventDildo3Scene"

func _run():
	if(state == ""):
		setFlag("ArticaModule.nextReaction", "d3hap")
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("cellblock_nearcells")
		saynn("Артика направляется к сиреневому блоку камер; очевидно, она собирается опробовать свой новый дилдо.")

		saynn("Она никуда особо не спешит,"+str(", spending a lot of time covering herself up" if nakedAndShy else "")+".. так что ты вполне можешь успеть к её камере первым и.. наполнить внутренний резервуар её игрушки чем-нибудь.. чем-нибудь вроде спермы.. если, конечно, хочешь..")

		addButton("Просто наблюдай", "Ты предпочитаешь не связываться с дилдо Артики", "watch_artica")
		addButton("Дилдо!", "Броситься к камере Артики и наполнить её дилдо чем-нибудь до её прихода..", "go_fill_dildo")
	if(state == "go_fill_dildo"):
		playAnimation(StageScene.CanineDildoSex, "tease", {pc="pc"})
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		saynn("Ты спешишь к камере Артики и начинаешь искать игрушку.")

		saynn("Дилдо такого размера трудно спрятать.. так что ты быстро находишь его под её кроватью.")

		saynn("Посмотрим, чем же ты сможешь его наполнить..")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_fuel")
	if(state == "after_fuel"):
		if (dildoHasSomething):
			saynn("Ты решаешь не использовать сперму и выбираешь что-то другое.. Тем не менее, это будет отличный сюрприз для неё.")

		elif (dildoHasArticaCum):
			saynn("Ты густо смазываешь этот дилдо спермой... но теперь это не просто какая-то там сперма... это сперма Артики. Это будет для неё потрясающий сюрприз.")

		elif (dildoHasCum):
			saynn("Ты густо смазываешь этот дилдо спермой... Это будет для неё потрясающий сюрприз.")

		else:
			saynn("Ты решаешь ничего не мазать на игрушку. Эх.")

		saynn("Сделав своё дело, ты быстро возвращаешь дилдо на место и выскакиваешь из камеры Артики.")

		saynn("Вот и она, как раз вовремя...")

		addButton("Смотреть", "Посмотреть, что будет дальше", "watch_artica")
	if(state == "watch_artica"):
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		GM.pc.setLocation("cellblock_lilac_nearcell")
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.CanineDildoSex, "tease", {pc="artica", bodyState={naked=true,hard=true}})
		saynn("Артика прокрадывается в свою камеру и тут же тянется к игрушке, которую спрятала под кроватью. Не самое лучшее место... но где ещё ей хранить такой огромный, мать его, дилдо?")

		saynn(""+str("Undressing quickly, she" if !isNaked else "She")+" ...размещает идеальную увеличенную копию своего собачьего члена прямо посреди камеры, на холодном полу. Вид его внушительных размеров заставляет Артику уже дрожать от возбуждения...")

		saynn("Путь к нему был долгим... так что, очевидно, Артика распорядится им с толком.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_lubes_toy")
	if(state == "artica_lubes_toy"):
		playAnimation(StageScene.CanineDildoSex, "hover", {pc="artica", bodyState={naked=true,hard=true}})
		saynn("Несмотря на то, насколько... похотливой... она выглядит... она всё же соблюдает осторожность. Артика хватает тюбик лубриканта и покрывает игрушку хорошим толстым слоем этой скользкой жижи... Что же касается неё самой... она уже мокрая как сука, её киска буквально сочится от желания..."+str(" her real cock putting pressure on the chastity cage.." if isCaged else " her real cock fully hard, veins pulsing from the strong heartbeat..")+"")

		saynn("Пушинка устраивается над игрушкой, прижимая свои чувствительные складки к знакомому кончику силиконового фаллоса... Без особых усилий она насаживается на него, чувствуя, как её киска растягивается..")

		saynn("[say=artica]Нхх.. мм..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_starts_riding")
	if(state == "artica_starts_riding"):
		playAnimation(StageScene.CanineDildoSex, "sex", {pc="artica", bodyState={naked=true,hard=true}})
		saynn("Тихий вздох срывается с её губ, когда она опускается на дилдо, ощущая, как он широко раздвигает её. От первого же ощущения её ноги начинают дрожать, а пальцы ног широко расставляются, пока внутренние стенки плотно обхватывают каждую выемку и бугорок этой игрушки..")

		saynn("[say=artica]Какой большой..[/say]")

		saynn("Сначала она начинает медленно, плавно вращая бедрами вслед за стержнем. Однако её нетерпение заставляет её садиться всё глубже и глубже, и её сочащаяся смазка быстро встречается с узлом.. её узлом..")

		saynn("[say=artica]Ммм..[/say]")

		saynn("Она уже точно знает, что хочет с ним сделать..")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_rides_faster")
	if(state == "artica_rides_faster"):
		playAnimation(StageScene.CanineDildoSex, "fast", {pc="artica", bodyState={naked=true,hard=true}})
		saynn("Темп ускоряется, дыхание становится чаще, а с губ срываются стоны — она начинает трахать дилдо всё яростнее, с силой насаживаясь на узел, и её киска туго сжимает его..")

		saynn("[say=artica]Ах.. пожалуйста.. я х-хочу его внутри..[/say]")

		if (dildoHasArticaCum || dildoHasCum):
			saynn("Если она продолжит в том же духе, в неё наверняка что-нибудь впрыснут..")

		if (isCaged):
			saynn("Её запертый член ходит вверх-вниз, отчаянно пытаясь встать и вылезти из препуция... но именно это давление пушистой девчонке и придётся терпеть. По сути, её член уже внутри неё, так зачем ей нужен настоящий?")

		else:
			saynn("Её собачий член ходит вверх-вниз, уже пульсируя от того, как хорошо игрушка массирует все её эрогенные зоны; внутри него нарастает давление.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_knots_herself")
	if(state == "artica_knots_herself"):
		playAnimation(StageScene.CanineDildoSex, "knotinside", {pc="artica", pcCum=true, cum=dildoHasSomething, bodyState={naked=true,hard=true}})
		saynn("После нескольких резких толчков... она почувствовала, как внутри неё раздувается узел, растягивая её киску до предела.")

		saynn("[say=artica]АХ![/say]")

		saynn("Артика закричала так громко, что все в блоке камер повернули головы. Её тело сотрясают конвульсии во время мощного оргазма; киска судорожно сжимается вокруг толстого основания и жирного узла, заглатывая игрушку на всю длину... Её настоящий член извергается, выстреливая струями спермы, которые разлетаются по полу, а яички напрягаются.")

		if (dildoHasSomething):
			saynn("Но и это ещё не всё. Киска Артики так сильно сжимает узел, что это заставляет игрушку начать закачивать содержимое прямо в утробу пушистой!")

			saynn("[say=artica]Ах.. п-подожди.. что..[/say]")

			saynn("Она быстро чувствует, как её чем-то наполняют... её живот становится всё более бугристым... но всё равно уже слишком поздно что-то предпринимать...")

			saynn("[say=artica]Ааах..[/say]")

		elif (dildoHasArticaCum):
			saynn("Но и это ещё не всё. Киска Артики так сильно сжимает узел, что это заставляет игрушку начать закачивать в утробу пушистой что-то очень густое и липкое... Она даже не осознаёт, что её набивают до отказа её собственной спермой...")

			saynn("[say=artica]Ах.. п-подожди.. ч-что это..[/say]")

			saynn("Она быстро чувствует, как её наполняют спермой.. её животик становится всё более раздутым.. но всё равно было уже слишком поздно что-то предпринимать..")

			saynn("[say=artica]Ааах..[/say]")

		elif (dildoHasCum):
			saynn("Но это ещё не всё. Киска Артики так сильно сжимает узел, что это заставляет игрушку накачивать матку пушистой наполнять чем-то очень густым и липким.. Она даже не осознаёт, что её забивают спермой до отказа..")

			saynn("[say=artica]Ах.. п-подожди.. ч-что это..[/say]")

			saynn("Она быстро чувствует, как её наполняют спермой.. её животик становится всё более раздутым.. но всё равно было уже слишком поздно что-то предпринимать..")

			saynn("[say=artica]Ааах..[/say]")

		saynn("Девушка тяжело дышит, задрав голову вверх и опираясь на лапы; всё её тело дрожит, а стимуляция заставляет каждую мышцу непроизвольно напрягаться от мелких электрических импульсов..")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_knotfucks_toy")
	if(state == "artica_knotfucks_toy"):
		playAnimation(StageScene.CanineDildoSex, "knot", {pc="artica", bodyState={naked=true,hard=true}})
		saynn("..но она не останавливается. Словно ведомая своей ненасытной нуждой, она продолжает скакать, пока узел то входит, то выходит из её разверзшейся киски, а она изо всех сил пытается вырваться.. только для того, чтобы мгновение спустя снова с силой опуститься на этот жирный шар.."+str(" Cum is leaking out of her stuffed stretched cunt when it is not plugged.. providing extra lube.." if dildoHasCum else "")+"")

		saynn("[say=artica]Д-да.. е-ещё.. п-пожалуйста.. ах..[/say]")

		saynn("Каждый раз, когда узел входит обратно, из киски Артики брызжет смазка — от чрезмерной стимуляции она просто.. теряет контроль..")

		saynn("[say=artica]Я такая.. к-knot-сучка.. ах..[/say]")

		saynn("Её тело всё ещё дрожало, а разум затуманился от такого невероятного наслаждения...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_rides_even_faster_knot")
	if(state == "artica_rides_even_faster_knot"):
		playAnimation(StageScene.CanineDildoSex, "knotfast", {pc="artica", pcCum=true, bodyState={naked=true,hard=true}})
		saynn("Артика тяжело дышит; силы, необходимые для того, чтобы преодолеть собственную тесноту, изматывают её... но в то же время её киска постепенно привыкает к тому, что её набивают до отказа... снова и снова... расслабляясь и позволяя члену продолжать движение.")

		saynn("Её движения становятся всё более неистовыми, а стоны переходят в отчаянные крики наслаждения. Вскоре её накрывает очередной оргазм, заставляя тело содрогаться в конвульсиях, а её секс — судорожно сжиматься вокруг узла, пока член извергает остатки накопленной спермы...")

		saynn("[say=artica]Я... я просто шлюха для собственного члена...[/say]")

		saynn("У тебя были подозрения на этот счёт... но приятно, когда она проясняет всё сама.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_after_knotknot")
	if(state == "artica_after_knotknot"):
		playAnimation(StageScene.CanineDildoSex, "knotinside", {pc="artica", pcCum=true, cum=dildoHasSomething, bodyState={naked=true,hard=true}})
		saynn("В конце концов, Артика слишком изматывается, чтобы продолжать... Одним последним, мощным толчком она заталкивает узел внутрь себя... и оставляет его там.")

		saynn("[say=artica]Да-а-а... ах...[/say]")

		saynn("Она закрывает глаза... и просто наслаждается ощущением того, насколько сильно она растянута... Её член продолжает пульсировать, капая спермой на пол, а яички к этому моменту уже полностью опустошены...")

		saynn("Ну и ладно. Ты позволил девушке насладиться собой. Она наверняка сможет освободиться сама.")

		saynn("Но тебе пришло время уходить...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "start_fuel"):
		var newDildo = GlobalRegistry.createItem("CanineDildo")
		dildoID = newDildo.uniqueID
		GM.pc.getInventory().addItem(newDildo)
		runScene("FluidTransferScene", [dildoID], "fueling_articas_dildo")
		setState("after_fuel")
		return

	if(_action == "artica_lubes_toy"):
		processTime(2*60)

	if(_action == "artica_starts_riding"):
		processTime(3*60)

	if(_action == "artica_rides_faster"):
		processTime(3*60)

	if(_action == "artica_knots_herself"):
		processTime(3*60)
		
		if(dildoID != ""):
			var theDildo = GM.pc.getInventory().getItemByUniqueID(dildoID)
			if(theDildo != null):
				var theFluids = theDildo.getFluids()
				theFluids.transferTo(getCharacter("artica").getBodypart(BodypartSlot.Vagina), 1.0)
		
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "artica_knotfucks_toy"):
		processTime(3*60)

	if(_action == "artica_rides_even_faster_knot"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "artica_after_knotknot"):
		processTime(3*60)
		if(dildoID != ""):
			var theDildo = GM.pc.getInventory().getItemByUniqueID(dildoID)
			if(theDildo != null):
				GM.pc.getInventory().removeItem(theDildo)

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "fueling_articas_dildo"):
		processTime(1 * 60)
		
		var theDildo = GM.pc.getInventory().getItemByUniqueID(dildoID)
		if(theDildo != null):
			var theFluids = theDildo.getFluids()
			if(theFluids.hasFluidTypeWithCharID("Cum", "artica")):
				dildoHasArticaCum = true
				dildoHasCum = true
			elif(theFluids.hasFluidType("Cum")):
				dildoHasCum = true
			elif(!theFluids.isEmpty()):
				dildoHasSomething = true
		setState("after_fuel")

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy
	data["dildoID"] = dildoID
	data["dildoHasArticaCum"] = dildoHasArticaCum
	data["dildoHasCum"] = dildoHasCum
	data["dildoHasSomething"] = dildoHasSomething

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
	dildoID = SAVE.loadVar(data, "dildoID", "")
	dildoHasArticaCum = SAVE.loadVar(data, "dildoHasArticaCum", false)
	dildoHasCum = SAVE.loadVar(data, "dildoHasCum", false)
	dildoHasSomething = SAVE.loadVar(data, "dildoHasSomething", false)
