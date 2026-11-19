extends RecruitSceneBase

var condomType = ""
var condomUsed = false
var condomBroke = false
var straponUsed = false

func _init():
	sceneID = "ElizaRecSceneSexOrgasmDenial"

func _reactInit():
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.Body)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearTop)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearBottom)
	putOn("eliza", "LatexStraitjacket")
	putOn("eliza", "oldcollar")

func _run():
	if(state == ""):
		condomType = extra("condom", "no")
		condomUsed = (condomType != "no")
		straponUsed = (extra("strapon", "") != "")
		addCharacter("eliza", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Ты входишь в холодную камеру. Элиза всё ещё прикована цепями к трубе над головой. На ней всё та же смирительная рубашка из её психиатрической лечебницы. Грудь обнажена, её собственные связанные руки приподнимают её. На талии застегнут металлический пояс целомудрия... пояс, ключ от которого всё ещё у тебя.")

		saynn("Она сверлит тебя взглядом.")

		saynn("[say=pc]"+str(ch1("...", "Hey there, slut.", "Getting used to it, I see."))+"[/say]")

		saynn("Элиза ничего не отвечает, лишь сверлит тебя глазами. Ты подходишь к ней, сжимая в руке маленький ключик.")

		saynn("Ты вставляешь его в замок пояса целомудрия и поворачиваешь. Раздается щелчок, вся конструкция отпирается и с тяжелым лязгом падает на пол, обнажая тугую, аппетитную киску Элизы.")

		saynn("Её дыхание сбивается, веки слегка подергиваются. Кажется, она знает, что будет дальше. Она дергается на цепях... но те не дают ей ни малейшей свободы, оставляя её совершенно беспомощной перед тобой.")

		saynn("[say=eliza]Что бы это ни было... просто покончи с этим...[/say]")

		saynn("[say=pc]"+str(ch1("...", "With pleasure.", "You don't get a say in this, slave."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "straight_to_sex")
	if(state == "straight_to_sex"):
		playAnimation(StageScene.SexMatingPress, "sex", {npc="eliza", bodyState={exposedCrotch=true,hard=true}})
		if (!straponUsed):
			saynn("В следующее мгновение Элиза уже на полу, прижатая тобой, её спина вжата в холодный пол. Её ноги высоко задраны, она почти сложилась пополам, открывая тебе полный доступ. И ты не теряешь ни секунды, с силой вгоняя свой член в её киску без смазки.")

		else:
			saynn("В следующее мгновение Элиза уже на полу, прижатая тобой, её спина вжата в холодный пол. Её ноги высоко задраны, она почти сложилась пополам, открывая тебе полный доступ. Твой стрэп-он уже плотно затянут на талии. И ты не теряешь ни секунды, вонзая свой новый, блестящий, заранее смазанный резиновый член в её киску.")

		saynn("[say=eliza]Ннх... чертов зверь...[/say]")

		if (!straponUsed):
			saynn("Она довольно узкая, её внутренние стенки тут же пытаются сопротивляться, сжимаясь вокруг тебя. Они сдавливают и обхватывают твой член, словно пытаясь вытолкнуть его наружу. Но у них не получается.")

		else:
			saynn("Она довольно узкая... ты не чувствуешь этого напрямую, но трение очень сильное: её внутренние стенки тут же пытаются сопротивляться, сжимаясь вокруг резиновой игрушки. Они сдавливают и обхватывают твой член, словно пытаясь вытолкнуть его наружу. Но у них не получается.")

		saynn("Ты начинаешь трахать её. Медленными, глубокими толчками... не разрывая зрительного контакта. Твои руки упираются в пол по обе стороны от неё, обеспечивая устойчивость, пока ты вколачиваешься в её лоно, и каждое грубое движение всё сильнее прижимает её к полу.")

		saynn("[say=pc]"+str(ch1("...", "Take it, you fucking bitch.", "You like that, don't you? Fucking slut."))+"[/say]")

		saynn("[say=eliza]Нх.. гх.. чертов..![/say]")

		saynn("При самых мощных толчках кончик твоего "+str("cock" if !straponUsed else "strapon")+" смачно бьёт в самый зев её матки, создавая небольшую выпуклость под её животом. Её изумрудные глаза широко распахнуты, они мечутся по камере, она не может долго выдерживать твой взгляд.")

		saynn("Несмотря на попытки сопротивляться, тело предает её, заставляя её там, внизу, течь от твоего напора.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_faster")
	if(state == "sex_faster"):
		playAnimation(StageScene.SexMatingPress, "fast", {npc="eliza", bodyState={exposedCrotch=true,hard=true}})
		saynn("Ты ускоряешься, всё сильнее вколачиваясь в её щель, и влажные шлепки эхом отдаются в тесной камере. Этот натиск заставляет Элизу издавать сдавленные стоны, а её внутренние стенки дрожат вокруг тебя.")

		saynn("[say=eliza]Ах.. ахх.. хх..[/say]")

		saynn("Каждый толчок немного сдвигает её тело по полу вперед... но твои ноги, крепко упертые в пол, не дают ей слишком сильно соскользнуть.")

		saynn("Ты отводишь взгляд и просто сосредотачиваешься на трахе, поддаваясь животному желанию. Кошка тоже явно не настроена на болтовню: она запрокидывает голову и стонет в потолок.")

		saynn("[say=pc]"+str(ch1("...", "Such a good sextoy.", "Nothing but a sextoy."))+"[/say]")

		saynn("Ты кряхтишь"+str(", feeling yourself getting close" if !straponUsed else ", the friction wearing you down")+". Всё тело Элизы напрягается. Она вот-вот кончит.")

		saynn("Было бы обидно всё испортить.")

		addButton("Отказать ей", "Лишить Элизу оргазма", "deny_eliza")
	if(state == "deny_eliza"):
		playAnimation(StageScene.SexMatingPress, "inside", {npc="eliza", bodyState={exposedCrotch=true,hard=true}, pcCum=!straponUsed, cum=!straponUsed})
		saynn("Внезапно ты замираешь. Почти полностью выходя из неё, оставляя лишь"+str(" rubber" if straponUsed else "")+" самый кончик внутри.")

		saynn("Тело Элизы всё ещё дрожит, из неё по инерции всё ещё вырываются тихие стоны. Она смотрит на тебя снизу вверх, её грудь тяжело вздымается, а в глазах застыл дикий взгляд.")

		saynn("[say=eliza]Ты.. остановился.. ах..[/say]")

		saynn("Ты принимаешь очень суровый, строгий вид.")

		saynn("[say=pc]"+str(ch1("Submit.", "Only if you submit.", "Say that you're submitting, worthless."))+"[/say]")

		saynn("[say=eliza]И.. и что же?.. хх.. Неужели будешь лишать меня разрядки?..[/say]")

		saynn("Надеемся, твое лицо сможет ответить на этот вопрос.")

		saynn("Но затем.. по её лицу начинает расплываться медленная, порочная улыбка.")

		saynn("[say=eliza]Жаль, что от оргазмического голодания меня штырит неимоверно.. ммм..[/say]")

		saynn("Её киска пульсирует.. сжимаясь вокруг твоего всё ещё "+str("cock" if !straponUsed else "toy")+". И вдруг.. она резко вскрикивает, выгибаясь в спине.")

		saynn("[say=eliza]Ааахх~..[/say]")

		saynn("Одной этой мысли хватило, чтобы столкнуть её в бездну. Эта сучка стонет и извивается под тобой, а её внутренние стенки доят "+str("you" if !straponUsed else "your strapon")+" волнообразными толчками.")

		saynn("[say=pc]"+str(ch1("...", "Fucking bitch.", "Stupid fucking slave."))+"[/say]")

		if (!straponUsed):
			saynn("Ну что ж... больше нет смысла сдерживаться. И ты с силой входишь в неё на всю длину, уходя в неё до самого основания. Из твоей груди вырывается сдавленный рык, когда твой {pc.penis} начинает вбивать семя глубоко в её матку. Её кончающая киска всё ещё доит твои яйца, высасывая последнюю каплю. Ты чувствуешь, как твой {pc.cum} затапливает её, наполняя её до краёв...")

		else:
			saynn("Ну что ж... больше нет смысла сдерживаться. И ты с силой входишь в неё всей резиновой длиной, заталкивая этот страпон до самого основания. Это продлевает её оргазм, погружая её ещё глубже в состояние экстаза. Её кончающая киска всё ещё пытается доить тебя.")

		saynn("[say=eliza]Ммм.. б-бля~..[/say]")

		saynn("Когда ты, наконец, выходишь, её киска остаётся широко раззявленной"+str(", a stream of thick seed gushing out from her used slit onto the cold floor" if !straponUsed else " for a bit, her folds and fur are soaked in her juices")+".")

		saynn("Ты не произносишь ни слова. Ты берёшь пояс верности, снова надеваешь его на неё и защелкиваешь замок. Затем ты разворачиваешься и уходишь.")

		saynn("Всё прошло не совсем так, как ты ожидал.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "straight_to_sex"):
		if(straponUsed):
			recWearStrapon()
		putOff("eliza", "LatexStraitjacket")
		putOn("eliza", "LatexStraitjacketNoBelt")

	if(_action == "deny_eliza"):
		if(straponUsed):
			getCharacter("eliza").cummedInVaginaBy("pc", FluidSource.Strapon)
		else:
			getCharacter("eliza").cummedInVaginaBy("pc", FluidSource.Penis)
		GM.pc.orgasmFrom("eliza")

	if(_action == "endthescene"):
		recRemoveStrapons()
		putOff("eliza", "LatexStraitjacketNoBelt")
		putOn("eliza", "LatexStraitjacket")
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["condomType"] = condomType
	data["condomUsed"] = condomUsed
	data["condomBroke"] = condomBroke
	data["straponUsed"] = straponUsed

	return data

func loadData(data):
	.loadData(data)

	condomType = SAVE.loadVar(data, "condomType", "")
	condomUsed = SAVE.loadVar(data, "condomUsed", false)
	condomBroke = SAVE.loadVar(data, "condomBroke", false)
	straponUsed = SAVE.loadVar(data, "straponUsed", false)
