extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaEventTentacles4Scene"

func _run():
	if(state == ""):
		setFlag("ArticaModule.gaveBirthToEggs", true)
		setFlag("ArticaModule.nextReaction", "t4hap")
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Когда ты приближаешься к Артике, ты видишь, что она в глубоком смятении... Она тяжело дышит, обхватив руками свой невероятно раздувшийся живот. Её глаза широко распахнуты от страха, и она смотрит на тебя с умоляющим выражением лица.")

		saynn("[say=artica]Я.. я.. к-кажется.. о-они х-хотят..[/say]")

		saynn("[say=pc]Думаешь, ты вот-вот родишь?[/say]")

		saynn("[say=artica]Ох.. эммм.. ах.. ч-что-то вроде того..[/say]")

		saynn("Что бы это ни было, лучше показать её врачу.")

		addButton("В медпункт!", "Отвести Артику в медпункт", "in_medical")
	if(state == "in_medical"):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="eliza"})
		aimCameraAndSetLocName("med_lobbymain")
		GM.pc.setLocation("med_lobbymain")
		saynn("Ты берешь Артику за лапу и осторожно ведешь к главному лифту. Он начинает спускать вас на нижний этаж...")

		saynn("[say=artica]Э-это н-не.. ц-щенята.. я.. я п-получила.. эм..[/say]")

		saynn("Ты делаешь вид, что не понимаешь, о чем она говорит.")

		saynn("[say=pc]Не волнуйся, я тебя держу.[/say]")

		saynn("[say=artica]Ах..[/say]")

		saynn("Металлические двери наконец открываются, позволяя тебе вывести Артикуку в медицинское лобби... Увидев и услышав тяжело дышащую, похожую на беременную пушистиху, знакомый доктор спешит к вам.")

		saynn("[say=eliza]Ого. Доктор Куинн на связи.[/say]")

		saynn("[say=pc]Ей нужна помощь.[/say]")

		saynn("[say=artica]Она... эм...[/say]")

		saynn("Кошка сканирует девушку каким-то прибором, а затем быстро начинает стучать по своему датападу.")

		saynn("[say=eliza]О, я знаю, яйца~. Я уже всё подготавливаю.[/say]")

		saynn("[say=pc]Яйца?[/say]")

		saynn("Кошка кивает.")

		saynn("[say=eliza]Эта заключенная приняла участие в небольшом эксперименте~. И теперь она полна... яиц. Не волнуйтесь, они безвредны... если она отложит их вовремя. А время пришло~.[/say]")

		saynn("Ты притворяешься, что удивлена.")

		saynn("[say=eliza]Хочешь... попробовать? Если нет — ничего страшного, я просто дам тебе парочку, когда закончим~. У них вкус их носителя... но обычно они очень сладкие~.[/say]")

		saynn("Ты действительно хочешь увидеть, как Артика откладывает эти растительные яйца?..")

		addButton("Смотреть", "Посмотреть на это", "do_watch")
		addButton("Пропустить", "Просто принять яйца", "do_skip")
	if(state == "do_skip"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Ты решаешь просто подождать в вестибюле.")

		saynn("И вскоре... Артика и доктор Куинн возвращаются к тебе, при этом живот Артики снова стал плоским!"+str(" Ну... более плоский... Он всё ещё явно круглый, просто чуть меньше." if getCharacter("artica").isVisiblyPregnant() else "")+"")

		saynn("[say=eliza]Вот, держи! Я оставила немного для... лаборатории.[/say]")

		saynn("Кошка протягивает тебе несколько... белых, похожих на яйца... плодов? Все они покрыты соком...")

		saynn("[say=eliza]Ой, прости, я их не помыла. Но это только добавляет вкуса, поверь мне~.[/say]")

		saynn("[say=pc]Спасибо.. наверное..[/say]")

		saynn("Кошка кивает и отступает назад.")

		addButton("Артика", "Посмотри на неё", "skip_lookatartica")
	if(state == "skip_lookatartica"):
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Артика выглядит.. выжатой.. измотанной.")

		saynn("[say=pc]Как ты себя чувствуешь?[/say]")

		saynn("[say=artica]Это.. ах.. это было интенсивно..[/say]")

		saynn("От её румянца на лице невольно улыбаешься.")

		saynn("[say=artica]Я.. в-вернусь.. на своё место..[/say]")

		saynn("[say=pc]Конечно, иди.[/say]")

		saynn("И Артика, и доктор Куинн оставляют тебя наедине с.. яйцами.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_watch"):
		aimCameraAndSetLocName("med_milkingroom")
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.GivingBirth, "birth", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("[say=pc]Ладно, погнали.[/say]")

		saynn("Кошка кивает и помогает тебе отвести тяжело дышащую пушистиху в одну из уединенных комнат. В этой, кажется, полно всякого.. специализированного оборудования.. включая высокотехнологичный стол.")

		saynn("Но прежде чем доктор успевает привести стол в действие, Артика опускается на пол и начинает стонать, хватаясь за свой огромный живот; в её звуках смешались боль и наслаждение..")

		saynn("[say=artica]Ах!.. ах.. Агх.. хх-хх..[/say]")

		saynn("[say=eliza]Подожди-и-и, я еще всё не настроила![/say]")

		saynn("Похоже, пока придется обойтись без этого стола."+str(" Ты быстро раздеваешь Артику и заставляешь её широко раздвинуть ноги, открывая вид на её влажные дырочки" if !isNaked else " Ты заставляешь Артику широко раздвинуть ноги, открывая вид на её влажные дырочки")+".")

		saynn("[say=artica]Ааах-х.. ахх.. это.. п-происходит..[/say]")

		saynn("И киска, и анус Артики подергиваются и сжимаются — её тело инстинктивно готовится к тому, что вот-вот случится.. Ты кладешь руки на извивающиеся ножки пушистой девчонки, пытаясь удержать её на месте.. и наблюдаешь.. завороженный видом первого яйца, которое уже показалось из её киски, дюйм за дюймом растягивая чувствительные складки..")

		saynn("[say=pc]Пусть всё идет своим чередом, девочка.[/say]")

		saynn("[say=artica]Нх-хх.. хх-х.. ААх-х![/say]")

		saynn("Артика продолжала тужиться.. пока первое яйцо наконец не выскользнуло из её киски с влажным хлюпаньем! Ощущения явно оказались слишком сильными для бедняжки: её глаза закатились, когда её "+str("запертый член пульсирует в клетке, жадно выделяя предэякулят" if isCaged else "твердый, как камень, член пульсировал, и с кончика уже свисала длинная капля смазки")+"..")

		saynn("[say=pc]Куинн?[/say]")

		saynn("[say=eliza]Я почти за-а-акончила! Прости-и-и! Чёртовы компы...[/say]")

		saynn("Ты хватаешь яйцо... о-о, оно скользкое, вся его поверхность покрыта соками Артики... и откладываешь его в сторону.")

		saynn("Следующее яйцо следует незамедлительно, это давит в тугой задний проход Артики. Она выгибает спину, издавая очередной стон боли и наслаждения, пока её задница растягивается всё шире... Похоже, это так сильно стимулирует её простату, что она не может сдержаться; глаза Артики снова закатываются, когда она..."+str("запертый член мечет густые струи спермы на пол, её яички напрягаются, когда яйцо наконец покидает её задницу..." if isCaged else "пульсирующий член начинает метать густые струи спермы на пол, её яички напрягаются, когда яйцо наконец покидает её задницу...")+"")

		saynn("[say=artica]Ааахх... Како-о-ое же оно б-б-большое...[/say]")

		saynn("[say=eliza]Есть![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_in_machine")
	if(state == "artica_in_machine"):
		playAnimation(StageScene.BDSMMachineFuck, "wand", {pc="artica", pcCum=true, noDildos=true, bodyState={naked=true, hard=true}})
		saynn("Доктору наконец удается запустить умный стол. Механизм осторожно подхватывает Артику длинными манипуляторами и подносит её к столу, после чего два трубчатых сборщика яиц плотно прижимаются к её влажным отверстиям...")

		saynn("[say=eliza]Получай![/say]")

		saynn("Одно за другим из её тела появляются круглые белые яйца, каждое из которых ввергает Артику в новый приступ страсти: её отверстия растягиваются всё шире и шире, пока она неустанно работает, выталкивая яйца наружу.")

		saynn("[say=artica]Ннхх... ах...[/say]")

		saynn("Её яички продолжают опустошаться, пока яйца, проталкиваясь наружу, нажимают на все её чувствительные точки; её член продолжает выдавать мощные струи семени, пока девушка всё глубже и глубже погружается в бездну наслаждения...")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_make_eggs")
	if(state == "do_make_eggs"):
		playAnimation(StageScene.BDSMMachineFuck, "tease", {pc="artica", noDildos=true, bodyState={naked=true, hard=true}})
		saynn("Когда последнее яйцо выскальзывает наружу, тело Артики содрогается в последней мощной судороге. Её киска и анальное отверстие... широко раззявлены... оба отверстия сочатся остатками сладкого нектара, в котором купались яйца... Её член, теперь уже опустошенный, слабо подергивается, пока вытекают последние капли спермы.")

		saynn("[say=artica]..ах..[/say]")

		saynn("Она кажется совершенно изможденной... её живот теперь"+str(" уже не такой круглый, как раньше... но всё ещё более-менее круглый..." if getCharacter("artica").isVisiblyPregnant() else " снова совершенно плоский...")+"")

		saynn("[say=eliza]Какой отличный урожай![/say]")

		saynn("Кошка протягивает тебе твою долю яиц... все они покрыты соком и пахнут... Артикой...")

		saynn("[say=artica]О-о.. о-о..[/say]")

		saynn("[say=pc]Расслабься, Артика. Тебе нужно отдохнуть.[/say]")

		saynn("Она кивает и просто откидывает голову назад, отдыхая, пока её отверстия начинают медленно закрываться...")

		saynn("Ты смотришь на яйца...")

		saynn("[say=pc]Да что мне с ними вообще делать?[/say]")

		saynn("Кошка показывает тебе, внезапно вонзаясь зубами в один из них... отчего твои легкие мгновенно наполняет сладкий аромат.")

		saynn("[say=eliza]Ах~. Это еда. Просто отличная закуска~.[/say]")

		saynn("[say=pc]Понятно..[/say]")

		saynn("Вы проводите какое-то время вместе с кошкой и Артикой... пока она снова не сможет ходить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_lobby")
	if(state == "back_to_lobby"):
		addCharacter("artica")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		aimCameraAndSetLocName("med_lobbymain")
		saynn("Кошка приводит тебя и Артику обратно в лобби...")

		saynn("[say=eliza]Ну, на этом всё! Если вдруг почувствуешь, что набился сочными фруктами — ты знаешь, где меня искать![/say]")

		saynn("Артика краснеет.")

		saynn("[say=artica]Ладно..[/say]")

		saynn("Она поворачивается к тебе.")

		saynn("[say=artica]С-спасибо... Странно чувствовать себя не... сытой... всё время... ха-ха...[/say]")

		saynn("И она направляется к своему привычному месту.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_medical"):
		processTime(5*60)

	if(_action == "do_watch"):
		processTime(3*60)

	if(_action == "do_skip"):
		processTime(35*60)
		var howMuch:int = 0
		if(getCharacter("artica").hasEffect(StatusEffect.ArticaFullWithPlantEggs)):
			howMuch = getCharacter("artica").getEffect(StatusEffect.ArticaFullWithPlantEggs).eggAmount
			getCharacter("artica").removeEffect(StatusEffect.ArticaFullWithPlantEggs)
		var willReceive:int = int(float(howMuch) / 2)
		addMessage("Вы получили "+str(willReceive)+" вкусные растительные яйца!")
		if(willReceive > 0):
			var anEgg = GlobalRegistry.createItem("PlantEgg")
			anEgg.whoGaveBirth = "artica"
			anEgg.setAmount(willReceive)
			GM.pc.getInventory().addItem(anEgg)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "skip_lookatartica"):
		processTime(3*60)

	if(_action == "artica_in_machine"):
		processTime(3*60)

	if(_action == "do_make_eggs"):
		processTime(30*60)
		var howMuch:int = 0
		if(getCharacter("artica").hasEffect(StatusEffect.ArticaFullWithPlantEggs)):
			howMuch = getCharacter("artica").getEffect(StatusEffect.ArticaFullWithPlantEggs).eggAmount
			getCharacter("artica").removeEffect(StatusEffect.ArticaFullWithPlantEggs)
		var willReceive:int = int(float(howMuch) / 2)
		addMessage("Вы получили "+str(willReceive)+" вкусные растительные яйца!")
		if(willReceive > 0):
			var anEgg = GlobalRegistry.createItem("PlantEgg")
			anEgg.whoGaveBirth = "artica"
			anEgg.setAmount(willReceive)
			GM.pc.getInventory().addItem(anEgg)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "back_to_lobby"):
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
