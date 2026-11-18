extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaSexMutualPawjobScene"

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
		saynn("Артика так напряжена, что её лапы всё время @@B*@@"+str(" sliding under her uniform and boldly rubbing herself in various places, her shorts bulging as she does it" if !isNaked else " sliding along her curves and rubbing herself in various places, her cock twitching slightly as she does it")+". Ей точно не помешает разрядка... да и тебе тоже, на самом деле.")

		saynn("[say=pc]Давай расслабимся, Артика.[/say]")

		saynn("[say=artica]Размотать?.. Ты хочешь.. ис-использовать меня?.. Ммм-м.."+str(" Make me your c-cock s-sleeve?.." if GM.pc.hasReachablePenis() else " Maybe do s-something with my c-cock or p-pussy..")+"[/say]")

		saynn("Такая непринужденная..")

		saynn("[say=pc]Думаю, нам стоит помочь друг другу. Вот увидишь.[/say]")

		saynn("Ты хватаешь её за руку и тянешь к одному из укромных мест..")

		addButton("Продолжить", "Смотреть, что будет дальше", "near_waterfall")
	if(state == "near_waterfall"):
		playAnimation(StageScene.PawJobMutual, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName("yard_waterfall")
		GM.pc.setLocation("yard_waterfall")
		addCharacter("artica", ["naked"])
		saynn("Твоя камера может быть слегка тесновата для того, что ты задумал... так что ты просто выводишь Артику во внутренний двор. Здесь полно зелени и кустов, за которыми можно спрятаться...")

		saynn("[say=artica]Свежий воздух.. И повсюду трава..[/say]")

		saynn("[say=pc]Почему бы тебе не лечь? Давай насладимся этим."+str(" Just don't get your uniform dirty, better take it off." if !isNaked else "")+"[/say]")

		saynn("[say=artica]Ох.."+str(" Yeah, you're right.. haha." if !isNaked else "")+"[/say]")

		saynn(""+str("You help Artica strip her clothes off and then place them on the bench nearby.. After that, you and Artica" if !isNaked else "You and Artica find a good spot and")+" лежали на сочной траве, лицом друг к другу.")

		saynn("[say=artica]Почему.. так далеко..[/say]")

		saynn("Её понимает твоё намерение, когда ты осторожно опускаешь одну из своих {pc.feet} на её"+str(" round pregnant" if getCharacter("artica").isVisiblyPregnant() else " slim fluffy")+" живот.. в нижнюю часть.. опасно близко к её щели, из которой уже выглядывает голубой член..")

		saynn("[say=pc]Понимаешь почему?[/say]")

		saynn("[say=artica]Д-да...[/say]")

		if (GM.pc.isWearingChastityCage()):
			saynn("Легкий бриз от водопада создает приятную прохладу.. Артика повторяет твой жест, кладя одну из своих задних лап тебе на живот; её пальцы уже нежно дразнят твою клетку целомудрия, играя с зажатым внутри членом..")

		elif (GM.pc.hasReachablePenis()):
			saynn("Легкий бриз от водопада создает приятную прохладу.. Артика повторяет твой жест, кладя одну из своих задних лап тебе на живот; её пальцы уже нежно дразнят твой член, заставляя тебя затвердеть..")

		elif (GM.pc.hasReachableVagina()):
			saynn("Легкий бриз от водопада создает приятную прохладу.. Артика повторяет твой жест, кладя одну из своих задних лап тебе на живот; её пальцы уже нежно дразнят твою милую щелочку, заставляя тебя течь..")

		else:
			saynn("Легкий бриз от водопада создает приятную прохладу.. Артика повторяет твой жест, кладя одну из своих задних лап тебе на живот; её пальцы уже нежно дразнят твою промежность, заставляя тебя изнывать от желания..")

		saynn("[say=pc]Такая лапочница... ты всё сразу поняла..[/say]")

		saynn("Щёчки пушистой краснеют, когда ты с силой прижимаешь её твердый член к её животу своими {pc.foot}.. заставляя её закусить губу.")

		addButton("Взаимный лапотрах", "Повеселитесь вместе", "do_mutual_pawjob")
	if(state == "do_mutual_pawjob"):
		if (GM.pc.hasReachablePenis()):
			playAnimation(StageScene.PawJobMutual, "sex", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		else:
			playAnimation(StageScene.PawJobMutual, "rub", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Как порочно... кто угодно может зайти в любой момент.. И всё же, желание толкает вас двоих всё дальше.")

		saynn("Осторожно, ты зажимаешь её голубой ствол между своих {pc.feet}.. а затем начинаешь нежно поглаживать его, проводя {pc.toes} по вздутой чувствительной поверхности. Это мгновенно вызывает реакцию: Артика издает милый стон, её член начинает подергиваться, сердце всё сильнее качает через него кровь, а с кончика сочится предэякулят.")

		saynn("[say=artica]Ах.. э-это так п-приятно..[/say]")

		if (GM.pc.isWearingChastityCage()):
			saynn("В ответ она ускоряет темп своих движений, её голубые подушечки лап умело скользят по твоей девственной клетке, пальцы поджимаются, дразня член внутри.. Это поистине уникальный опыт: у тебя перехватывает дыхание, а с губ срываются один стон за другим..")

		elif (GM.pc.hasReachablePenis()):
			saynn("В ответ она ускоряет темп своих движений, её голубые подушечки лап с умелой точностью скользят вдоль всего твоего {pc.penis}, пальцы поджимаются, дразня головку.. Это поистине уникальный опыт: у тебя перехватывает дыхание, а с губ срываются один стон за другим..")

		elif (GM.pc.hasReachableVagina()):
			saynn("В ответ она ускоряет темп своих движений; её голубые подушечки лап умело и точно скользят по складкам твоей влажной киски, а пальцы сжимаются, дразня клитор... Это поистине уникальное ощущение: дыхание перехватывает, а с губ то и дело срываются стоны...")

		else:
			saynn("В ответ она ускоряет темп своих движений; её голубые подушечки лап умело и точно скользят по твоей промежности, а пальцы сжимаются, лаская чувствительную зону... Это поистине уникальное ощущение: дыхание перехватывает, а с губ то и дело срываются стоны...")

		saynn("[say=pc]Нх.. ах.. да, продолжай ласкать меня лапками..[/say]")

		saynn("Когда ваши движения синхронизируются, вас обоих накрывает волной теплого наслаждения, ваши тела и ноги двигаются в идеальной гармонии... Узел на члене Артики начинает раздуваться, пока ты продолжаешь сжимать его своей {pc.feet}."+str(" At the same time, the fluff feels your cock growing harder under her paw." if GM.pc.hasReachablePenis() else "")+"")

		addButton("Быстрее", "Драть её член быстрее", "stroke_cum")
	if(state == "stroke_cum"):
		if (GM.pc.hasReachablePenis()):
			playAnimation(StageScene.PawJobMutual, "fast", {pc="pc", npc="artica", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		else:
			playAnimation(StageScene.PawJobMutual, "rubfast", {pc="pc", npc="artica", npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (GM.pc.isWearingChastityCage()):
			saynn("Ведомые этой странной общей страстью, вы с Артикой ускоряете темп, всё быстрее лаская члены друг друга и громко демонстрируя свою любовь к этому занятию...")

			saynn("[say=artica]Ах.. ахх.. я такая.. шлюшка для {pc.feet}.. Т-так интенсивно.. ах-х..[/say]")

			saynn("Её узел раздулся до максимума, ствол пульсирует в твоей {pc.feet}... Артика прикрывает рот рукой, заглушая свои похотливые стоны, её взгляд дрожит, а возбуждение только растет. В то же время твой собственный член подергивается в своей тесной клетке. Её лапа, покрытая твоим предэякулятом, так сладко натирает твой зажатый член...")

			saynn("С двумя страстными криками вы одновременно достигаете пика; ваши члены пульсируют в ритме сердец, извергая густые струи семени на ваши ступни и животы... Артика особенно сильно извивается, пока её скрытая киска извергает фонтан соков прямо на траву под вами...")

		elif (GM.pc.hasReachablePenis()):
			saynn("Ведомые этой странной общей страстью, вы с Артикой ускоряете темп, всё быстрее лаская члены друг друга и громко демонстрируя свою любовь к этому занятию...")

			saynn("[say=artica]Ах.. ахх.. я такая.. шлюшка для {pc.feet}.. Т-так интенсивно.. ах-х..[/say]")

			saynn("Её узел раздулся до полного размера, ствол пульсирует между ваших {pc.feet}... Артика прикрывает рот рукой, заглушая свои шлюшкие стоны, её взгляд дрожит, а возбуждение продолжает нарастать. В то же время твой член подёргивается от её ласк: её лапа, покрытая твоей предэякуляцией, так искусно скользит вдоль всей твоей длины...")

			saynn("С двумя страстными криками вы одновременно достигаете пика; ваши члены пульсируют в ритме сердец, извергая густые струи семени на ваши ступни и животы... Артика особенно сильно извивается, пока её скрытая киска извергает фонтан соков прямо на траву под вами...")

		elif (GM.pc.hasReachableVagina()):
			saynn("Ведомые этой странной общей страстью, вы с Артикой ускоряете темп, всё быстрее лаская друг друга и громко демонстрируя свое наслаждение этим занятием...")

			saynn("[say=artica]Ах.. ахх.. я такая.. шлюшка для {pc.feet}.. Т-так интенсивно.. ах-х..[/say]")

			saynn("Её узел раздулся до полного размера, ствол пульсирует между ваших {pc.feet}... Артика прикрывает рот рукой, заглушая свои шлюшкие стоны, её взгляд дрожит, а возбуждение продолжает нарастать. В то же время твоя киска подёргивается под её ласками. Её лапа, покрытая твоими соками, так сладко натирает твой клитор...")

			saynn("С двумя страстными криками вы вместе достигаете пика: её член пульсирует в такт сердцебиению, извергая густые струи семени ей на живот, в то время как твоя киска фонтанирует соками, заливая бёдра... Артика извивается особенно сильно, так как обе пары её интимных мест дёргаются одновременно...")

		else:
			saynn("Ведомые этой странной общей страстью, вы с Артикой ускоряете темп, всё быстрее лаская друг друга в самых чувствительных зонах и громко демонстрируя свою любовь к этому занятию...")

			saynn("[say=artica]Ах.. ахх.. я такая.. шлюшка для {pc.feet}.. Т-так интенсивно.. ах-х..[/say]")

			saynn("Её узел раздулся до максимума, ствол пульсирует между твоих {pc.feet}... Артика прикрывает рот рукой, заглушая свои шлюшковатые стоны, её взгляд дрожит, а возбуждение продолжает расти. В то же время её лапа заставляет тебя неистово извиваться, так искусно потирая твой промежность...")

			saynn("С двумя страстными криками вы вместе достигаете пика: её член пульсирует в такт сердцебиению, извергая густые струи семени ей на живот, пока ты выгибаешься спиной и крепко вцепляешься в землю... Артика извивается особенно сильно, так как обе пары её интимных мест дёргаются одновременно...")

		saynn("[say=artica]Нья-а-ах...[/say]")

		saynn("[say=pc]Ха-ах... Д-да... кон-чай, девочка...[/say]")

		saynn("Даже когда удовольствие затопляет твой разум, ты продолжаешь усердно ласкать её член, выжимая её яйца досуха...")

		addButton("Отдохнуть", "Насладитесь послевкусием", "after_cum")
	if(state == "after_cum"):
		playAnimation(StageScene.PawJobMutual, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("После всего вы с Артикой тяжело дышите, просто отдыхая на холодной траве и устремив взгляды высоко вверх, на фальшивое небо... сперма всё ещё стекает с твоих {pc.feet}...")

		saynn("[say=artica]Ах..[/say]")

		saynn("[say=pc]Приятно, да?..[/say]")

		saynn("Вы просто лежите вот так, наслаждаясь послевкусием близости...")

		saynn("[say=artica]Д-да...[/say]")

		saynn("Её взгляд улавливает чьи-то шаги... но ей почти всё равно, она продолжает отдыхать нагой... Честно говоря, ты тоже не особо напрягаешься. К счастью, тому, кто идет, кажется, тоже нет до вас дела...")

		saynn("Хорошенько отдохнув, ты помогаешь Артике подняться. Она смахивает пыль с вас обоих.")

		saynn("[say=artica]Я б-буду... на своём месте...[/say]")

		saynn("Ты киваешь и провожаешь её взглядом; она уходит, соблазнительно покачивая бёдрами.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "near_waterfall"):
		processTime(5*60)

	if(_action == "do_mutual_pawjob"):
		processTime(15*60)

	if(_action == "stroke_cum"):
		processTime(5*60)
		getModule("ArticaModule").triggerCorruption(0.03)
		if(GM.pc.hasPenis() || GM.pc.hasReachableVagina()):
			GM.pc.cummedOnBy("pc")
		getCharacter("artica").cummedOnBy("artica")

	if(_action == "after_cum"):
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
