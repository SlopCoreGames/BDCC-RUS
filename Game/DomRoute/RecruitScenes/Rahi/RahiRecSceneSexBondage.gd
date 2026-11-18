extends RecruitSceneBase

var gentle = false
var mean = false
var condomType = ""
var condomUsed = false
var condomBroke = false
var straponUsed = false
var cameInsideRahi = false

func _init():
	sceneID = "RahiRecSceneSexBondage"

func _run():
	if(state == ""):
		addCharacter("rahi")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		condomType = extra("condom", "no")
		condomUsed = (condomType != "no")
		straponUsed = (extra("strapon", "") != "")
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Для этого плана понадобится куча снаряжения для бондажа... но Кейт достаточно добра, чтобы поделиться недостающими деталями.")

		saynn("И вот ты входишь в камеру Рахи и берешь её поводок. Её ушки прижимаются к голове, когда ты ведешь её к центру комнаты, а затем поворачиваешься к ней лицом.")

		saynn("[say=pc]"+str(ch1("I'm gonna be very gentle.", "You're gonna stand still for me, like a good kitty.", "One wrong move.. and I will make it hurt.. a lot."))+"[/say]")

		saynn("[say=rahi]Мяу?..[/say]")

		saynn("Пора повеселиться.")

		addButton("Сковать её наручниками", "Время бондажа!", "do_bondage")
	if(state == "do_bondage"):
		playAnimation(StageScene.HangingDuo, "idle", {pc="rahi", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Эта рубашка будет только мешаться. Не говоря ни слова, ты начинаешь расстегивать пуговицы и снимать её.")

		saynn("[say=rahi]Ч-что ты... мяу![/say]")

		saynn("Затем ты хватаешь её лапки и сковываешь их вместе! Ты переделываешь поводок: отсоединяешь его от ошейника и пристегиваешь к наручникам, а другой конец закидываешь на прочный потолочный крюк, который каким-то образом здесь предусмотрительно установили.")

		saynn("[say=rahi]Ох... подожди! А-ах![/say]")

		saynn("Металл дребезжит, когда ты тянешь за поводок, заставляя кошку задрать руки над головой. Рахи встает на цыпочки, едва касаясь пола ступнями.")

		saynn("Её обнаженная грудь вздымается и опускается, розовые соски чутко реагируют на холодный ветер. Она краснеет под твоим взглядом.")

		saynn("Но ты еще не закончил. Ты хватаешь её за пояс шорт и стягиваешь их вниз; беспомощная кошечка не может ничего сделать, пока ты обнажаешь её пушистые бедра и милый маленький цветочек между ног.")

		saynn("[say=rahi]Мяу-у..[/say]")

		saynn("[say=pc]"+str(ch1("I'm gonna make you wear some more things. I hope this is okay. Let me know if I should stop.", "I'm just getting started, kitty cat.", "Fucktoys like you don't deserve freedom."))+"[/say]")

		saynn("Следующим делом ты надеваешь наручники на её щиколотки. Но вместо того чтобы соединить их вместе, ты используешь металлический разделитель, который заставляет её держать ноги широко разведенными для тебя.")

		saynn("[say=rahi]Она.. она больше не может прикрыться..[/say]")

		saynn("[say=pc]"+str(ch1("Again, let me know if I should stop.", "Good.", "Shut up, little slut."))+"[/say]")

		saynn("Действительно, её розовые складки теперь выставлены напоказ. Ты проводишь пальцами по чувствительным местам и слышишь её тихий стон; на твоих пальцах остается её возбуждение.")

		saynn("И всё же, ты еще не закончил.")

		addButton("Больше игрушек", "Надеть на Рахи что-нибудь еще", "more_toys")
	if(state == "more_toys"):
		playAnimation(StageScene.HangingSex, "tease", {pc="rahi", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, condom=condomUsed}})
		saynn("Полоска черной ткани ложится ей на глаза, погружая в полную темноту. Затем идет кляп. Ты прижимаешь резиновый шар к её губам, пока она не размыкает их, и теперь резиновая сфера держит её челюсть открытой, а с языка капает слюна.")

		saynn("[say=rahi]Мммф..[/say]")

		saynn("Её хвост поджат между ног — единственная часть тела, которую не удалось лишить воли.")

		saynn("Почти всё.. Последняя игрушка, что у тебя осталась — это маленький вибропуля. Ты закрепляешь пульт на её бедре, а само розовое яичко приклеиваешь скотчем прямо к клитору. Когда ты начинаешь крутить колесико, игрушка начинает громко жужжать, заставляя кошечку непроизвольно вилять задницей.")

		saynn("[say=rahi]Ммм-х.. ммффхх..[/say]")

		saynn("[say=pc]"+str(ch1("That looks great. Lovely.", "I know you like it. You will like what I will do with you next even more.", "Nothing but a needy whore. Not even trying to resist."))+"[/say]")

		saynn("Цепи держат её беспомощной: носки едва касаются пола, упругая грудь подпрыгивает, а киска сочится соком прямо на пол. Рахи запрокидывает голову, издавая приглушенные стоны сквозь кляп...")

		if (!straponUsed):
			saynn("В этот момент ты заходишь ей со спины, прицеливая свой член к её складкам; кончик уже упирается в самое вхождение."+str("You take some extra time to put a condom on.. Might as well use one." if condomUsed else "")+"")

		else:
			saynn("В этот момент ты быстро закрепляешь страпон на талии; его блестящий наконечник уже касается её складок, прощупывая вход.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_part")
	if(state == "sex_part"):
		playAnimation(StageScene.HangingSex, "sex", {pc="rahi", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, condom=condomUsed}})
		saynn("Затем ты входишь внутрь...")

		saynn("[say=rahi]Мммпх-![/say]")

		saynn("Всё её тело напрягается, цепи начинают греметь сильнее. Она инстинктивно пытается свести бёдра.. но распорка для лодыжек держит её раскрытой специально для тебя. Её когти бесполезно скребут по металлу.")

		saynn("Ты не спешишь. Ты медленно выходишь.. давая её влажному туннелю сомкнуться.. а затем снова глубоко входишь! С каждым толчком она плавно раскачивается вперед-назад, подстраиваясь под твои движения.")

		saynn("[say=rahi]Ннн.. ххх.. ах… мпхх..[/say]")

		saynn("Её хвост обвивается вокруг твоего пояса в отчаянной попытке за что-то ухватиться. Каждый толчок вырывает из неё тихий стон; её пальцы на лапах поджимаются, а связанные конечности напрягаются в кандалах.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_fast")
	if(state == "sex_fast"):
		playAnimation(StageScene.HangingSex, "fast", {pc="rahi", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, condom=condomUsed}})
		saynn("Ты ускоряешься, всё сильнее вколачивая член в её влажную киску. Приглушённые стоны Рахи становятся громче, её тело извивается в путах, а внутренние стенки плотно сжимаются вокруг тебя, пока игрушка продолжает ласкать её клитор.")

		saynn("[say=rahi]Мммпхх.. мммпхх-..[/say]")

		saynn("[say=pc]"+str(ch1("You're doing great, kitty.. just let it happen..", "Good. Squirm. The chains won't break.", "Shut up and cum on my cock, cat."))+"[/say]")

		saynn("Спустя несколько секунд её щель начинает спазмировать вокруг тебя, когда твой "+str("cock" if !straponUsed else "strapon")+" с силой бьёт в ту самую точку, от которой всё её тело сначала каменеет... а затем обмякает.")

		saynn("Её спина выгибается дугой. Пальцы на лапах поджимаются так сильно, что, кажется, сводит судорогой. Долгий, страстный крик захлёбывается в кляпе.")

		saynn("Её оргазм заставляет цепи дрожать, а хвост обвивается вокруг тебя туго, словно верёвка.")

		saynn("Но ты еще не закончил...")

		addButton("Кончить внутрь", "Оплодотвори кошечку!", "sex_cum")
	if(state == "sex_cum"):
		playAnimation(StageScene.HangingSex, "inside", {pc="rahi", npc="pc", npcCum=cameInsideRahi, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, condom=condomUsed}})
		saynn("Ты продолжаешь трахать Рахи сквозь её оргазм, сквозь её конвульсии... пока она не начинает скулить, пытаясь податься навстречу цепям."+str(" The pressure builds in your {pc.penis}.." if !straponUsed else "")+"")

		if (straponUsed):
			saynn("Как только пик её удовольствия начинает спадать, ты вбиваешь стрэп на всю глубину! Её стенки снова плотно обхватывают ствол, пока ты втираешься глубоко внутрь... ремень прижимается вплотную к её бёдрам, игрушка входит до самого основания. Рахи жалобно мяукает в кляп, её тело дрожит от каждого глубокого толчка, а хвост дико дёргается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all.. Like a good bound kitty..", "Little bitch.. getting fucked with a rubber cock."))+"[/say]")

		elif (condomUsed && !condomBroke):
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого основания! Её стенки сжимаются, когда ты изливаешься внутрь... густые струи твоего {pc.cum} начинают заполнять презерватив внутри неё, раздувая его до краев. Похоже, он выдержал! Рахи мяукает, её тело дрожит от каждой пульсации, а хвост дико дергается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all.. Like a good kitty..", "Breeding bitch.. getting her cunt fucked like that."))+"[/say]")

		else:
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого основания!"+str(" Oh no, looks like the [b]condom broke![/b]" if condomBroke else "")+"Её стенки плотно сжимаются, когда ты изливаешься внутрь... густые струи твоего {pc.cum} начинают заливать её, наполняя её утробу. Рахи мяукает, её тело дрожит от каждой пульсации, а хвост дико дергается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all.. Like a good kitty..", "Breeding bitch.. getting her cunt stuffed while completely helpless."))+"[/say]")

		saynn("После нескольких быстрых толчков ты остаешься внутри неё"+str(", letting her clenching slit milk you dry" if cameInsideRahi else "")+". Её прерывистое дыхание громко вырывается через нос, повязка на глазах насквозь промокла.")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_care")
	if(state == "after_care"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="rahi", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		if (gentle):
			saynn("Когда всё заканчивается... ты медленно и осторожно выходишь из неё. Её ноги дрожат, поэтому ты аккуратно опускаешь её запястья, один за другим расстегивая наручники. Рахи бессильно оседает в твои объятия."+str(", your seed dripping out of her used pussy" if cameInsideRahi else ", her pussy dripping with juices")+". Последним ты снимаешь кляп.")

			saynn("[say=rahi]С-спасибо.. мяу..[/say]")

			saynn("[say=pc]Вот так. Разве это не было весело?[/say]")

		elif (mean):
			saynn("Когда всё заканчивается... ты резко вырываешь свой член, оставляя киску Рахи широко раскрытой."+str(" and gushing with your seed" if cameInsideRahi else " and dripping with her juices")+". Она безвольно висит в цепях, почти не реагируя. Ты оставляешь небольшой след от укуса на её шее...")

			saynn("[say=pc]Вот так, шлюшка. Теперь ты моя.[/say]")

			saynn("Ты оставляешь её висеть ещё на мгновение, прежде чем опустить и подхватить.")

		else:
			saynn("Когда всё заканчивается... ты вынимаешь свой член, оставляя киску Рахи"+str(" to drip your seed onto her thighs" if cameInsideRahi else " to drip juices onto her thighs")+". Её ноги дрожат... поэтому ты подхватываешь её, расстегивая наручники, а затем слегка прикусываешь её за шею прямо через кляп.")

			saynn("[say=pc]Хорошая девочка... Очень хорошая девочка.[/say]")

			saynn("В последнюю очередь ты снимаешь повязку и кляп. Она моргает, глядя на тебя, а по её щекам текут слёзы.")

		saynn("[say=pc]Теперь ты будешь работать на меня, верно?[/say]")

		if (perfect):
			saynn("[say=rahi]Конечно же... она сделает всё, что ты захочешь... мяу...[/say]")

		elif (success):
			saynn("[say=rahi]Да... она будет делать всё, что ты попросишь...[/say]")

		else:
			saynn("[say=rahi]Эм... ну... в общем...[/say]")

			saynn("Хм... Похоже, она не собирается этого делать.")

		saynn("Закончив, ты выходишь из камеры, чтобы посмотреть, что об этом думает Кейт...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_bondage"):
		putOn("rahi", "policecuffs")
		putOn("rahi", "inmateanklecuffs")

	if(_action == "more_toys"):
		processTime(10*60)
		putOn("rahi", "blindfold")
		putOn("rahi", "ballgag")
		if(straponUsed):
			recWearStrapon()

	if(_action == "sex_part"):
		processTime(3*60)

	if(_action == "sex_fast"):
		processTime(3*60)

	if(_action == "sex_cum"):
		
		if(condomType == "worst"):
			if(GM.pc.shouldCondomBreakWhenFucking("rahi", GM.pc.useWorstCondom())):
				condomBroke = true
		if(condomType == "best"):
			if(GM.pc.shouldCondomBreakWhenFucking("rahi", GM.pc.useBestCondom())):
				condomBroke = true
		
		if(straponUsed):
			getCharacter("rahi").cummedInVaginaBy("pc", FluidSource.Strapon)
		if(!straponUsed && (!condomUsed || condomBroke)):
			cameInsideRahi = true
			getCharacter("rahi").cummedInVaginaBy("pc")
		if(condomUsed && !condomBroke):
			addFilledCondomToLootIfPerk(GM.pc.createFilledCondom())
		GM.pc.orgasmFrom("rahi")

	if(_action == "after_care"):
		processTime(3*60)
		recRemoveStrapons()
		putOff("rahi", "blindfold")
		putOff("rahi", "ballgag")
		putOff("rahi", "policecuffs")
		putOff("rahi", "inmateanklecuffs")

	setState(_action)

func saveData():
	var data = .saveData()

	data["gentle"] = gentle
	data["mean"] = mean
	data["condomType"] = condomType
	data["condomUsed"] = condomUsed
	data["condomBroke"] = condomBroke
	data["straponUsed"] = straponUsed
	data["cameInsideRahi"] = cameInsideRahi

	return data

func loadData(data):
	.loadData(data)

	gentle = SAVE.loadVar(data, "gentle", false)
	mean = SAVE.loadVar(data, "mean", false)
	condomType = SAVE.loadVar(data, "condomType", "")
	condomUsed = SAVE.loadVar(data, "condomUsed", false)
	condomBroke = SAVE.loadVar(data, "condomBroke", false)
	straponUsed = SAVE.loadVar(data, "straponUsed", false)
	cameInsideRahi = SAVE.loadVar(data, "cameInsideRahi", false)
