extends RecruitSceneBase

var gentle = false
var mean = false
var inPublic = false
var bondage = false
var anal = false
var condomType = ""
var condomUsed = false
var condomBroke = false
var straponUsed = false
var cameInsideRahi = false

func _init():
	sceneID = "RahiRecSceneSex"

func _run():
	if(state == ""):
		addCharacter("rahi")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		inPublic = (c3 == 0)
		bondage = (c3 == 1)
		anal = (c3 == 2)
		condomType = extra("condom", "no")
		condomUsed = (condomType != "no")
		straponUsed = (extra("strapon", "") != "")
		playAnimation(StageScene.SexStealth, "rub", {pc="pc", npc="rahi"})
		aimCameraAndSetLocName("fight_corner_ne")
		saynn("Ты входишь в камеру Рахи и хватаешь её за поводок. Затем ты выводишь её наружу, мимо ревущей толпы арены. Задние лапы Рахи шаркают по холодному полу, а хвост низко поджат.")

		saynn("Здесь особо негде уединиться... Так что хорошо, что ты и не ищешь укромного места. Вот этот клочок земли в нескольких метрах от толпы — в самый раз.")

		saynn("Ты останавливаешься, разворачиваешься и плавно тянешь за цепь, заставляя кошечку встать перед тобой. Как только она подчиняется, ты обнимаешь её сзади; твоя рука скользит под её шорты, и твои ловкие пальцы вырывают у неё милый стон, начиная дразнить её клитор.")

		saynn("[say=rahi]З-здесь?.. Мяу... ах... люди же увидят...[/say]")

		saynn("[say=pc]"+str(ch1("Тсс. Просто расслабься. Я с тобой.", "Тише, кошечка. Это происходит. Просто стони.", "Твое мнение здесь никого не волнует, киса. Я заставлю тебя кричать."))+"[/say]")

		saynn("Её дыхание сбивается, она пытается свести ноги вокруг твоей руки... но ты заставляешь её раздвинуть бёдра. Большие голубые глаза Рахи следят за тобой, пока ты доставляешь ей удовольствие, и из неё всё чаще вырываются милые звуки. Но их всё ещё недостаточно, чтобы заглушить гул толпы.")

		if (!straponUsed):
			saynn("К этому моменту ты уже изрядно возбудился... Пора повеселиться.")

		else:
			saynn("Страпон наготове... Пора повеселиться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_prepare")
	if(state == "sex_prepare"):
		playAnimation(StageScene.SexFreeStanding, "tease", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты вынимаешь руку из её шорт, твои пальцы скользят от её влаги. Рахи краснеет, её бёдра покачиваются, а внутренние стороны бёдер непроизвольно трутся друг о друга. Мило.")

		saynn("[say=pc]"+str(ch1("Я просто предлагаю тебе немного веселья. Дай знать, если мне стоит остановиться.", "Я знаю, что тебе нравится. Стой смирно. Глаза вперед, задница плотнее к моему паху.", "Я знаю, что ты всего лишь маленькая шлюшка. Ты даже не сопротивляешься."))+"[/say]")

		saynn("Она тихонько мяукает, прижимаясь спиной к твоей груди; её хвост обвивает твою ногу, а задница трётся о..."+str(" your {pc.penis}" if !straponUsed else "you")+"..")

		saynn("Сначала — рубашка: твои руки быстро расстегивают пуговицы, и она падает на пол. Ты чувствуешь её дрожь... теперь её упругая грудь открыта взору ничего не подозревающей толпы.")

		saynn("[say=rahi]Н-наверное, хватит..[/say]")

		saynn("В этот момент ты полностью стягиваешь с неё шорты, и ткань падает на пол. Рахи инстинктивно пытается пригнуться, чтобы прикрыться, но ты быстро перехватываешь её лапки и отводишь их ей за спину.")

		saynn("[say=rahi]Мяу-у![/say]")

		saynn("Её ноги широко разведены, грудь прогнута вперед, а розовые интимные места выставлены напоказ любому, кто решит обернуться. И некоторые действительно оборачиваются..")

		if (!straponUsed):
			saynn("Твой член уже пристроился, касаясь складок, а кончик упирается в самое отверстие.."+str(" Потрачу лишнюю минутку на презерватив... Лучше перестраховаться." if condomUsed else "")+"")

		else:
			saynn("Ты быстро закрепляешь страпон на талии; его блестящий наконечник уже трется о её складки, прощупывая вход.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_part")
	if(state == "sex_part"):
		playAnimation(StageScene.SexFreeStanding, "sex", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Затем ты входишь внутрь.")

		saynn("[say=rahi]Аах..! М-мяу.. Т-так полно..[/say]")

		saynn("Она изо всех сил вцепляется в твои запястья, вонзая когти в твою кожу.")

		saynn("Ты не спешишь. Ты медленно отстраняешься.. позволяя скользкому любовному туннелю немного сомкнуться.. прежде чем снова войти глубоко! Твои медленные толчки бедрами сопровождаются тем, как твои руки тянут её на твой "+str("{pc.penis}" if !straponUsed else "резиновый член")+"!")

		saynn("[say=rahi]Ннн.. ах.. ахх..[/say]")

		saynn("Кто-то свистит в твою сторону. И еще несколько голов оборачиваются. Они смотрят, как Рахи трахают прямо у них на глазах. Щеки кошечки пылают красным.")

		saynn("[sayMale]Разъеби эту шлюху![/sayMale]")

		saynn("Каждый следующий толчок вырывает из неё мягкий стон, а пушистый хвост всё еще крепко обвивает тебя. Её пальцы на ногах то и дело поджимаются, пока ты раз за разом входишь в неё на всю длину.")

		saynn("Теперь наблюдает уже больше заключенных. Кто-то начинает ласкать себя.. кто-то — теребить свои щелочки. Похоже, гладиаторские бои здесь больше не главное развлечение.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_fast")
	if(state == "sex_fast"):
		playAnimation(StageScene.SexFreeStanding, "fast", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты прибавляешь темп, вколачивая в эту киску всё быстрее. Стоны Рахи становятся громче, её тело извивается в твоих руках, а внутренние стенки плотно сжимаются вокруг тебя.")

		saynn("[say=rahi]Пожалуйста.. ах.. они все.. ах.. смотрят на неё..[/say]")

		saynn("[say=pc]"+str(ch1("Они просто наслаждаются шоу. Ты отлично справляешься, киса...", "Хорошо. Я хочу, чтобы они смотрели на тебя, пока я тебя трахаю.", "Заткнись и кончай на мой член, кошечка."))+"[/say]")

		saynn("Спустя несколько секунд её киска начинает спазмировать вокруг тебя, пока ты"+str(" cock" if !straponUsed else " strapon")+"долбишь в одну точку.. в то самое место, от которого всё её тело то каменеет.. то расслабляется.")

		saynn("[say=rahi]Ааахх-х..[/say]")

		saynn("Громкий крик страсти эхом разносится по арене; глаза Рахи закатываются, губы широко разомкнуты, язык высунут и покрыт слюной.")

		saynn("Толпа ликует... некоторые из них стонут, тоже кончив.")

		saynn("Но ты еще не закончил...")

		addButton("Кончить внутрь", "Оплодотвори кошечку!", "sex_cum")
	if(state == "sex_cum"):
		playAnimation(StageScene.SexFreeStanding, "inside", {pc="pc", npc="rahi", pcCum=cameInsideRahi, bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты продолжаешь трахать Рахи сквозь её оргазм, сквозь её судорожные движения... пока она не начинает скулить и сама не прижимается к тебе."+str(" Давление нарастает в твоей {pc.penis}.." if !straponUsed else "")+"")

		if (straponUsed):
			saynn("Как только пик её удовольствия начинает спадать, ты вбиваешь страпон до самого основания! Её стенки снова плотно сжимаются вокруг члена, пока ты втираешься глубоко в неё... ремни прижимаются вплотную к её заднице, игрушка зарыта в неё до самого основания. Рахи мяукает, её тело дрожит от каждого глубокого толчка, а хвост дико дергается.")

			saynn("[say=pc]"+str(ch1("Да.. Это так приятно.", "Принимай всё.. Как хорошая киска..", "Маленькая сучка.. трахается на людях с резиновым членом."))+"[/say]")

		elif (condomUsed && !condomBroke):
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого основания! Её стенки сжимаются, когда ты изливаешься внутрь... густые струи твоего {pc.cum} начинают заполнять презерватив внутри неё, раздувая его до краев. Похоже, он выдержал! Рахи мяукает, её тело дрожит от каждой пульсации, а хвост дико дергается.")

			saynn("[say=pc]"+str(ch1("Да.. Это так приятно.", "Принимай всё.. Как хорошая киска..", "Сучка для размножения.. ей трахают киску на глазах у всех."))+"[/say]")

		else:
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого основания!"+str(" О нет, похоже, [b]презерватив порвался![/b]" if condomBroke else "")+"Её стенки плотно сжимаются, когда ты изливаешься внутрь... густые струи твоего {pc.cum} начинают заливать её, наполняя её утробу. Рахи мяукает, её тело дрожит от каждой пульсации, а хвост дико дергается.")

			saynn("[say=pc]"+str(ch1("Да.. Это так приятно.", "Принимай всё.. Как хорошая киска..", "Сучка для размножения... её щель набивают прямо на людях."))+"[/say]")

		saynn("После нескольких быстрых толчков ты остаешься внутри неё"+str(", позволяя её сжимающейся щели выжать тебя досуха," if cameInsideRahi else "")+". За тобой наблюдает множество похотливых глаз. Некоторые заключенные даже хлопают.")

		saynn("Рахи тяжело дышит... и ты тоже.")

		if (gentle):
			saynn("Когда всё заканчивается... ты медленно и осторожно выходишь из неё. Её ноги дрожат, поэтому ты подхватываешь её под руки."+str(", твоё семя вытекает из её использованной киски," if cameInsideRahi else ", её киска течет от соков,")+".")

			saynn("[say=pc]Вот так. Разве это не было весело?[/say]")

			saynn("[say=rahi]М-мяу..[/say]")

		elif (mean):
			saynn("Когда всё заканчивается... ты резко вырываешь свой член, оставляя киску Рахи широко раззявленной."+str(" и извергается твоим семенем," if cameInsideRahi else " и течет от её соков,")+". Её дрожащие ноги едва держат её. Ты кусаешь её за шею, заставляя её снова застонать.")

			saynn("[say=pc]Вот так, шлюшка. Теперь ты моя.[/say]")

		else:
			saynn("Когда всё заканчивается... ты вынимаешь свой член, оставляя киску Рахи"+str(" чтобы твоё семя капало ей на бёдра," if cameInsideRahi else " чтобы её соки капали ей на бёдра")+". Её ноги дрожат... поэтому ты подхватываешь её за талию и слегка прикусываешь её за шею.")

			saynn("[say=pc]Хорошая девочка... Очень хорошая девочка.[/say]")

		saynn("Пора возвращаться... пока вас не окружила толпа.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_cell")
	if(state == "back_to_cell"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Вы приводите Рахи обратно в камеру. Цепь снова прикована к трубе.")

		saynn("[say=pc]Теперь ты будешь работать на меня, верно?[/say]")

		if (perfect):
			saynn("[say=rahi]Конечно... она будет делать всё, что ты захочешь...[/say]")

		elif (success):
			saynn("[say=rahi]Да... она будет делать всё, что ты попросишь...[/say]")

		else:
			saynn("[say=rahi]Эм... ну... в общем...[/say]")

			saynn("Хм... Похоже, она не собирается этого делать.")

		saynn("Ты выходишь из камеры, чтобы посмотреть, что об этом думает Кейт...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "sex_prepare"):
		processTime(10*60)
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

	if(_action == "back_to_cell"):
		processTime(10*60)
		recRemoveStrapons()

	setState(_action)

func saveData():
	var data = .saveData()

	data["gentle"] = gentle
	data["mean"] = mean
	data["inPublic"] = inPublic
	data["bondage"] = bondage
	data["anal"] = anal
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
	inPublic = SAVE.loadVar(data, "inPublic", false)
	bondage = SAVE.loadVar(data, "bondage", false)
	anal = SAVE.loadVar(data, "anal", false)
	condomType = SAVE.loadVar(data, "condomType", "")
	condomUsed = SAVE.loadVar(data, "condomUsed", false)
	condomBroke = SAVE.loadVar(data, "condomBroke", false)
	straponUsed = SAVE.loadVar(data, "straponUsed", false)
	cameInsideRahi = SAVE.loadVar(data, "cameInsideRahi", false)
