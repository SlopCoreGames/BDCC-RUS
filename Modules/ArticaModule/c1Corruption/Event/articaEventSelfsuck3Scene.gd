extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var straponHasArticaCum = false
var straponHasCum = false

func _init():
	sceneID = "articaEventSelfsuck3Scene"

func _run():
	if(state == ""):
		setFlag("ArticaModule.nextReaction", "s3hap")
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		GM.pc.setLocation("cellblock_lilac_nearcell")
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		saynn("Артика, похоже, направляется к своей камере. Похоже, кого-то развезло от возбуждения...")

		saynn("Пожалуй, стоит посмотреть, что она будет делать.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_selfsucking")
	if(state == "artica_selfsucking"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.SelfSuck, "sex", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Вы заглядываете к ней в камеру... и видите, что Артика уже на кровати: она высоко подтянула ноги, а её спина изогнулась идеальной дугой.")

		if (!isCaged):
			saynn("Она сосет собственный член! Её губы обхватили голубоватый ствол, она двигает головой, а её язык активно скользит по плоти, посылая электрические разряды удовольствия по всему телу, отчего её пальцы на ногах непроизвольно поджимаются.")

			saynn("[say=artica]Ммм-м..[/say]")

			saynn("Она стонет, обхватив свой член, настолько погруженная в процесс, что даже не замечает вашего пристального взгляда.")

		else:
			saynn("Она сосет собственный член! Ну, настолько, насколько ей позволяет целомудрие... Её губы обхватили клетку, она двигает головой, а язык активно ласкает орган внутри, посылая электрические разряды удовольствия по всему телу, отчего её пальцы на ногах непроизвольно поджимаются.")

			saynn("[say=artica]Ммм-м..[/say]")

			saynn("Она стонет, обхватив свой запертый член, настолько погруженная в процесс, что даже не замечает вашего пристального взгляда.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_selfsucks_faster")
	if(state == "artica_selfsucks_faster"):
		playAnimation(StageScene.SelfSuck, "fast", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Издавая жадный приглушенный скулёж, Артика ускорилась, теперь уже активно подавая бедрами, доводя себя до оргазма всё быстрее и быстрее.")

		saynn("Каким-то образом ей удалось поймать идеальный баланс: её задние лапы мастерски работали, компенсируя каждое движение бедер."+str(", позволяя члену достигать самого горла благодаря её натренированной гибкости..." if !isCaged else ", позволяя ей запихивать в рот всё больше клетки благодаря её натренированной гибкости...")+"")

		saynn("В такой позе её мокрая киска выставлена напоказ... можно поспорить, что этим грех не воспользоваться...")

		addButtonWithChecks("Трахнуть её", "Присоединиться к веселью", "fuck_artica", [], [[ButtonChecks.HasReachablePenis]])
		addButtonWithChecks("Надеть на неё страпон", "Присоединиться к веселью", "strapon_artica_pick", [], [[ButtonChecks.HasStraponAndCanWear]])
		addButton("Просто наблюдай", "Смотреть, что будет дальше", "nofuck_artica_cum")
	if(state == "nofuck_artica_cum"):
		playAnimation(StageScene.SelfSuck, "inside", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Думаешь, лучше не спугнуть эту возбужденную пушистицу...")

		if (!isCaged):
			saynn("Она и так отлично справляется: так жадно сосет собственный пульсирующий член, что её узел быстро раздувается и упирается ей прямо в губы. Пытаться заглотить собственный узел в таком положении — затея так себе... поэтому пушистица просто трется носом о него, стараясь сосредоточиться на ласках самого ствола...")

		else:
			saynn("Она и так справляется на ура: так неистово сосет свой пульсирующий заблокированный член, что зажатый внутри ствол оказывает реальное давление на металл, отчаянно пытаясь встать колом. Девочка продолжает просовывать язык в любые отверстия клетки, доставляя себе удовольствие всеми доступными способами...")

		saynn("[say=artica]Мммхх.. Ммм.. ММмхх!..[/say]")

		saynn("Её тело дрожит всё сильнее... И вскоре её собственный член извергается ей в рот, выбрасывая густые струи белой спермы прямо ей в глотку. Артика жадно глотает... пока её согнутое тело содрогается в оргазме, а киска обливается соком; эта странная поза делает ощущения куда более интенсивными, чем это вообще должно быть...")

		saynn("Даже когда её оргазм начинает утихать, пушинка всё ещё тихонько стонет вокруг твоего члена, вылизывая голубой ствол языком...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_walksout")
	if(state == "artica_walksout"):
		addCharacter("artica")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Ты просто стоишь у её камеры, прислонившись к одной из стен...")

		saynn("Спустя несколько минут выходит Артика... и видит тебя... её щеки мгновенно заливаются румянцем.")

		saynn("[say=artica]Ох... п-привет... э-э... м-м... х-ха... п-привет...[/say]")

		saynn("[say=pc]Привет, Артика.[/say]")

		saynn("Ты скрещиваешь руки на груди и улыбаешься, отчего девушка смущается ещё сильнее. Она понимает, что ты всё видел...")

		saynn("[say=pc]Не переживай, я не осуждаю. Хотя ты та ещё извращенка~.[/say]")

		saynn("[say=artica]Эм... с-спасибо... д-да... х-ха-ха...[/say]")

		saynn("Она быстро бросается на своё место... Её глаза так и сияют.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "fuck_artica"):
		playAnimation(StageScene.SelfSuck, "fuckfast", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Прежде чем Артика успевает среагировать, ты уже нависаешь над ней, прижимая её в этой позе, с обнаженным и твердым членом. Её глаза расширились от неожиданности... но твой хват и пылающая похоть в глазах заставили её забыть о протестах.")

		saynn("[say=artica]МММмммх![/say]")

		saynn("Резким толчком ты вгоняешь свой {pc.penis} глубоко в неё, заставляя Артику издать приглушённый стон прямо в свой собственный"+str(" locked" if isCaged else "")+" член. Ощущение внезапного растяжения в сочетании с собственным членом во рту было ошеломляющим. Ты не даёшь ей передохнуть, а вместо этого сразу начинаешь трахать её киску с первобытной страстью.")

		saynn("Разум Артики затопило интенсивное наслаждение; её дрожащие от похоти глаза закатились, пока она отчаянно сосала свой собственный член... а твои толчки не давали ей возможности сосредоточиться хоть на чём-то. Её киска плотно сжимается вокруг твоего ствола, тело жадно откликается на твою грубую ласку. С каждым толчком ты вбиваешь свой член всё глубже, попадая в её точку G под идеальным углом, отчего она дико содрогается, обхватывая твою спину ногами и подтягивая тебя к себе задними лапами...")

		saynn("[say=pc]Какая шлюха.. Сосёт сама себе, пока её киску разрывают в клочья.[/say]")

		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		saynn("Её член пульсирует у неё во рту"+str(", от прилива крови её узел раздувается в жирный мясной шар" if !isCaged else " пока она бесцеремонно тычет языком во все отверстия её клетки целомудрия")+". Она чувствует приближение оргазма, её тело дрожит... и ты тоже чувствуешь, что близок"+str(", узел на твоём члене тоже стремительно раздувается" if pcHasKnot else "")+"..")

		addButton("Кончить внутрь", "Оплодотворить эту жаждущую пушистицу", "fuck_artica_cum")
	if(state == "fuck_artica_cum"):
		playAnimation(StageScene.SelfSuck, "fuckinside", {pc="artica", npc="pc", npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		saynn("Последним глубоким толчком ты вбиваешь свой член до самого упора,"+str(" заполняя этот жаждущий влагалище узлом," if pcHasKnot else " прорываясь в её матку,")+" прежде чем... кончить внутрь. Твой ствол пульсирует, наполняя её"+str(" busy" if getCharacter("artica").isVisiblyPregnant() else "")+" «машину для деторождения» своим горячим семенем.")

		saynn("[say=artica]МММХХХ-Хх!..[/say]")

		saynn("Она сжимается вокруг твоего члена, высасывая из твоих яичек всё до последней капли... прежде чем кончить самой; её собственный член извергается ей прямо в рот, выбрасывая густые струи белой спермы ей в глотку. Артика жадно глотает... пока её согнутое тело содрогается в оргазме, а эта странная поза делает ощущения куда более интенсивными, чем это вообще должно быть...")

		saynn("Наконец ты замедляешься, твои толчки становятся мелкими, когда ты вливаешь последние капли своего семени в матку Артики. Затем ты просто замираешь, оставив член глубоко внутри неё... пока она вылизывает себя языком.")

		saynn("[say=artica]Ммм-мх..[/say]")

		saynn("Её глаза такие... милые... Они так и сияют...")

		saynn("[say=pc]Хах... Похоже, я тебе больше не нужна, чтобы кормить тебя.[/say]")

		saynn("[say=artica]..ммм.. ммх..[/say]")

		saynn("[say=pc]Мощно было, правда?[/say]")

		saynn("[say=artica]мхм..[/say]")

		saynn("Вы просто лежите так несколько минут, прижавшись друг к другу телами. Комната наполнена запахом секса... Тело Артики всё ещё дрожит от послевкусия оргазма, а её киска слабо сжимает твой член...")

		addButton("Обнимашки", "Вы провели некоторое время вместе", "after_sex_cuddle")
	if(state == "after_sex_cuddle"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", npcBodyState={naked=true,hard=true}})
		saynn("После такого неприкрытого проявления страсти... Вы решаете притянуть Артику к себе, чтобы обняться.")

		saynn("Вы помогаете ей... расслабиться, а затем обнимаете её, пока она всё ещё лежит на кровати.")

		saynn("[say=artica]Ах..[/say]")

		saynn("[say=pc]Как твоя спина?[/say]")

		saynn("[say=artica]Ох.. всё в порядке.. оно того стоило..[/say]")

		saynn("Вы посмеиваетесь и ласкаете её щеку носом.")

		saynn("[say=pc]Ну ты и извращенка.[/say]")

		saynn("[say=artica]Д-да.. ха-ха.. похоже, я та еще шлюшка..[/say]")

		saynn("Так вы и лежали в объятиях какое-то время, пока ей не пора было возвращаться на своё место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "strapon_artica_pick"):
		saynn("Выберите страпон, которым хотите трахнуть Артику.")

		addStraponButtons()
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_put_on_strapon")
	if(state == "strapon_artica_fuck"):
		playAnimation(StageScene.SelfSuck, "fuckfast", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Прежде чем Артика успела среагировать, вы уже нависли над ней, прижимая её к постели и быстро затягивая ремни страпон-ханесса на талии."+str(", ту самую, что наполнена особым сюрпризом." if (straponHasArticaCum || straponHasCum) else "")+". Её глаза расширились от удивления... но твоя хватка и пылающая похоть в глазах заставили её забыть о протестах.")

		saynn("[say=artica]МММмммх![/say]")

		saynn("Резким толчком ты вонзаешь резиновую игрушку глубоко в неё, заставляя Артику издать приглушённый стон прямо в свой собственный"+str(" locked" if isCaged else "")+" член. Ощущение внезапного растяжения в сочетании с собственным членом во рту было ошеломляющим. Ты не даёшь ей передохнуть, а вместо этого сразу начинаешь трахать её киску с первобытной страстью.")

		saynn("Разум Артики затопило неистовое наслаждение; её дрожащие от вожделения глаза закатились, пока она отчаянно сосала свой собственный член... а твои толчки не давали ей возможности сосредоточиться хоть на чём-то. Её киска судорожно сжимается вокруг резинового стержня, тело жадно откликается на твою грубую ласку. С каждым толчком ты вбиваешь страпон всё глубже, попадая точно в точку G под идеальным углом, отчего она дико содрогается, обхватывая твою спину ногами и подтягивая тебя к себе задними лапами...")

		saynn("[say=pc]Какая шлюха.. Сосёт сама себе, пока её киску разрывают в клочья.[/say]")

		saynn("Её член пульсирует у неё во рту"+str(", от прилива крови её узел раздувается в жирный мясной шар" if !isCaged else " пока она бесцеремонно тычет языком во все отверстия её клетки целомудрия")+". Она чувствовала приближение оргазма, её тело дрожало...")

		if (straponHasArticaCum):
			saynn("[say=pc]Нхх... Надеюсь, ты не против того, чем я наполнила этот страпон~. Он особенный.[/say]")

			saynn("[say=artica]Ммммхх-?..[/say]")

		elif (straponHasCum):
			saynn("[say=pc]Нхх... Надеюсь, ты не против того, чем я наполнила этот страпон~.[/say]")

			saynn("[say=artica]Ммммхх-?..[/say]")

		addButton("Кончить внутрь", "Оплодотворить эту жаждущую пушистицу", "fuck_artica_strapon_cum")
	if(state == "fuck_artica_strapon_cum"):
		playAnimation(StageScene.SelfSuck, "fuckinside", {pc="artica", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (straponHasArticaCum || straponHasCum):
			saynn("Финальным глубоким толчком ты вбиваешь страпон до самого конца, пробиваясь к её матке. Её киска сжимает его так сильно... что это наконец заставляет страпон начать качать в девчонку её "+str(" busy" if getCharacter("artica").isVisiblyPregnant() else "")+" горячее семя прямо в её матку-производитель..."+str(" Её собственное семя..." if straponHasArticaCum else " Чьё-то чужое семя...")+"")

		else:
			saynn("Последним мощным толчком ты вбиваешь страпон глубоко внутрь, буквально прорываясь к её матке. Ты не кончил в неё... но её сжимающаяся киска всё равно отчаянно пытается выдоить его до последней капли...")

		saynn("[say=artica]МММХХХ-Хх!..[/say]")

		saynn("Она плотно обхватывает твою игрушку... а затем кончает сама: её член извергается ей прямо в рот, выбрасывая густые струи белой спермы ей в глотку. Артика жадно глотает... пока её согнутое тело содрогается в оргазме, а эта странная поза делает ощущения куда более интенсивными, чем это вообще возможно...")

		saynn("Наконец ты замедляешься, делая пологие толчки, чтобы не слишком утомлять девушку. Затем ты просто замираешь, оставив страпон глубоко внутри неё... пока она вылизывает свой член языком.")

		saynn("[say=artica]Ммм-мх..[/say]")

		saynn("Её глаза такие... милые... Они так и сияют...")

		saynn("[say=pc]Хах... Похоже, я тебе больше не нужна, чтобы кормить тебя.[/say]")

		saynn("[say=artica]..ммм.. ммх..[/say]")

		saynn("[say=pc]Мощно было, правда?[/say]")

		saynn("[say=artica]мхм..[/say]")

		saynn("Вы так и остаётесь в таком положении несколько минут, прижавшись друг к другу телами. Комната наполнена запахом секса... Тело Артики всё ещё дрожит от послевкусия оргазма, а её киска слабо сжимает твой резиновый ствол... Пора его снимать...")

		addButton("Обнимашки", "Вы провели некоторое время вместе", "after_sex_cuddle")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "do_put_on_strapon", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "artica_selfsucking"):
		processTime(5*60)

	if(_action == "artica_selfsucks_faster"):
		processTime(3*60)

	if(_action == "fuck_artica"):
		processTime(3*60)

	if(_action == "strapon_artica_pick"):
		processTime(3*60)

	if(_action == "nofuck_artica_cum"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.1)
		getCharacter("artica").cummedInMouthBy("artica")

	if(_action == "artica_walksout"):
		processTime(3*60)

	if(_action == "fuck_artica_cum"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.1)
		getCharacter("artica").cummedInMouthBy("artica")
		getCharacter("artica").cummedInVaginaBy("pc")
		GM.pc.orgasmFrom("artica")

	if(_action == "after_sex_cuddle"):
		GM.pc.unequipStrapon()
		processTime(13*60)

	if(_action == "do_put_on_strapon"):
		processTime(2*60)
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		var theFluids = strapon.getFluids()
		if(theFluids != null):
			if(theFluids.hasFluidTypeWithCharID("Cum", "artica")):
				straponHasArticaCum = true
			if(theFluids.hasFluidType("Cum")):
				straponHasCum = true
		setState("strapon_artica_fuck")
		return

	if(_action == "fuck_artica_strapon_cum"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.1)
		getCharacter("artica").cummedInMouthBy("artica")
		getCharacter("artica").cummedInVaginaBy("pc", FluidSource.Strapon)
		GM.pc.orgasmFrom("artica")

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
	data["straponHasArticaCum"] = straponHasArticaCum
	data["straponHasCum"] = straponHasCum

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
	straponHasArticaCum = SAVE.loadVar(data, "straponHasArticaCum", false)
	straponHasCum = SAVE.loadVar(data, "straponHasCum", false)
