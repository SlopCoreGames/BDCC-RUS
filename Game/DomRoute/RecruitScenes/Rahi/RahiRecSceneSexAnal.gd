extends RecruitSceneBase

var gentle = false
var mean = false
var condomType = ""
var condomUsed = false
var condomBroke = false
var straponUsed = false
var cameInsideRahi = false

func _init():
	sceneID = "RahiRecSceneSexAnal"

func _run():
	if(state == ""):
		addCharacter("rahi")
		aimCameraAndSetLocName("hideout_breakroom")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		condomType = extra("condom", "no")
		condomUsed = (condomType != "no")
		straponUsed = (extra("strapon", "") != "")
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Ты рассказываешь Кейт о своем плане... и она дает тебе кое-что с собой.")

		saynn("Затем ты входишь в камеру и берешь Рахи за поводок. Ее задние лапы шаркают по холодному полу, пока ты ведешь ее к центру комнаты; ее хвост низко поджат.")

		saynn("[say=rahi]Ч-что она... мяу...[/say]")

		saynn("Она наблюдает за тем, как ты расстегиваешь ее рубашку и стягиваешь шорты.")

		saynn("[say=pc]"+str(ch1("Don't worry, I'll be gentle. Let me know if I should stop. Just kneel, please?", "On your knees. Now.", "Shut up and get down, cat. You know what's coming."))+"[/say]")

		saynn("Ее дыхание сбивается. Она сглатывает... и повинуется... опускаясь на колени.")

		saynn("Затем ты достаешь полученный предмет... маленький флакон лубриканта. От щелчка крышки она вздрагивает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_prepare")
	if(state == "sex_prepare"):
		playAnimation(StageScene.SexFisting, "tease", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты выдавливаешь щедрую порцию смазки на пальцы... затем опускаешься на колени позади нее и убираешь ее хвост в сторону. Рахи ахает, когда ты прижимаешь скользкий палец к ее тугому анусу. А затем она вскрикивает еще громче, когда ты медленно начинаешь вводить его внутрь.")

		saynn("[say=rahi]Это... слишком... тесно...[/say]")

		saynn("[say=pc]"+str(ch1("Shh. I'll go slow. Just breathe.", "That's the point, kitty. I'm going to stretch that tight hole.", "I don't care. You'll take it anyway, little future buttslut."))+"[/say]")

		saynn("Ты мягко двигаешь пальцем, распределяя смазку вокруг входа. Сначала она сжимается... но затем постепенно расслабляется, обвивая своим хвостом твое запястье. Тебе удается довольно легко добавить второй палец. Тело Рахи напрягается... но она не отстраняется... она лишь ниже склоняет голову.")

		saynn("Ее киска, оставленная без внимания, начинает блестеть. Несколько одиноких капель ее соков стекают по внутренней стороне бедер.")

		saynn("[say=rahi]Э-это.. немного.. неловко..[/say]")

		saynn("[say=pc]"+str(ch1("That's natural. Nothing to be ashamed of.", "Good. I want to see how wet you get from just your ass.", "Such a whore. Getting this wet from anal fingering."))+"[/say]")

		if (!straponUsed):
			saynn("Ты вынимаешь пальцы и пристраиваешься, кончик твоего члена уже упирается в её вход."+str("You take some extra time to put a condom on.. Might as well use one." if condomUsed else "")+"")

		else:
			saynn("Ты вынимаешь пальцы и быстро закрепляешь страпон на талии, его блестящий наконечник уже касается её входа.. подергивая его.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_part")
	if(state == "sex_part"):
		playAnimation(StageScene.SexLowDoggy, "sex", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Затем ты входишь внутрь.")

		saynn("[say=rahi]Ааах.. С-слишком.. он слишком толстый.. мяу..[/say]")

		saynn("Её когти скребут по бетону, когда она дергается вперед. Ты сжимаешь её бедра, удерживая на месте. Анальное кольцо сжимается вокруг твоего члена, сопротивляясь, но благодаря смазке ты погружаешься всё глубже, дюйм за дюймом.")

		saynn("[say=rahi]Р-растягивает.. она чувствует себя такой наполненной..[/say]")

		saynn("Ты замираешь на полпути, давая ей привыкнуть. Её внутренние стенки продолжают спазмировать, пытаясь вытолкнуть тебя. Тем временем её киска продолжает сочиться, капая на пол.")

		saynn("Ты медленно отстраняешься.. а затем входишь глубже. Рахи стонет.. её тело извивается, пока ты заглатываешь всё больше своего "+str("toy" if straponUsed else "shaft")+" inside.")

		saynn("[say=pc]"+str(ch1("See? You can take it. Such a good kitty.", "Your cute butt can take more than that.", "Look at that. The bitch is starting to enjoy it already."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_fast")
	if(state == "sex_fast"):
		playAnimation(StageScene.SexLowDoggy, "fast", {pc="pc", npc="rahi", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься, всё быстрее вколачиваясь в эту узкую задницу. Стоны Рахи становятся громче, прерывистее, а её анус отчаянно сжимается вокруг тебя.")

		saynn("[say=rahi]Ах.. ах.. пожалуйста.. медленнее.. мяу..[/say]")

		saynn("[say=pc]"+str(ch1("Breathe with me. In and out. You're doing fine.", "You're loving it, I can feel it.", "Shut your mouth and take it, buttslut. I'll decide the pace."))+"[/say]")

		saynn("Её ноги дрожат. Она уткнулась лицом в предплечья, уши прижаты, щеки пылают. Звук ударов твоих бедер о её задницу эхом разносится по каменным стенам.")

		saynn("Длинная, густая струйка её соков тянется от клитора к полу, растягиваясь и наконец обрываясь.")

		saynn("[say=rahi]Она.. о-она не может.. п-по кончить..[/say]")

		saynn("[say=pc]"+str(ch1("That's okay. You don't have to. Just feel it.", "If you submit, we can work on that more.", "That's the point, you needy little bitch. Feels great for me."))+"[/say]")

		saynn("Её внутренние стенки спазмируются вокруг твоего "+str("{pc.penis}" if !straponUsed else "strapon")+". Её киска продолжает оставлять влажную лужицу под ней..")

		if (!straponUsed):
			saynn("Ты уже совсем близко.")

		addButton("Кончить внутрь", "Наполни её задницу!", "sex_cum")
	if(state == "sex_cum"):
		playAnimation(StageScene.SexLowDoggy, "inside", {pc="pc", npc="rahi", pcCum=cameInsideRahi, bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true}})
		saynn("Ты продолжаешь трахать Рахи в задницу, несмотря на её дрожь и всхлипы..")

		if (straponUsed):
			saynn("После нескольких мощных толчков ты вбиваешь страпон до самого основания! Её анальные стенки плотно обхватывают ствол, пока ты вжимаешься глубоко внутрь.. ремень прижимается вплотную к её ягодицам, игрушка заходит до самого основания. Рахи скулит, её тело содрогается от каждого глубокого толчка, а хвост дико дёргается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all in your ass.. Like a good kitty..", "Little bitch.. I knew you could fit this whole rubber cock."))+"[/say]")

		elif (condomUsed && !condomBroke):
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого упора! Её анальные стенки сжимаются, когда ты изливаешься внутрь.. густые струи твоей {pc.cum} начинают заполнять презерватив в её прямой кишке, раздувая его до краев. Похоже, он выдержал! Рахи скулит, её тело содрогается от каждой пульсации, а хвост дико дёргается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all.. Like a good kitty..", "Little bitch.. I knew you could take it."))+"[/say]")

		else:
			saynn("Как только ты достигаешь пика, ты входишь в неё до самого основания!"+str(" Oh no, looks like the [b]condom broke![/b]" if condomBroke else "")+"Стенки её ануса плотно сжимаются, когда ты изливаешься внутрь неё... густые струи твоего {pc.cum} начинают заливать её прямую кишку, наполняя её до краев. Рахи мяукает, её тело дрожит от каждого толчка, а хвост дико дёргается.")

			saynn("[say=pc]"+str(ch1("Yes.. This feels so good.", "Take it all.. Like a good kitty..", "Little bitch.. I knew you could take it."))+"[/say]")

		saynn("После нескольких быстрых толчков ты остаешься внутри неё"+str(" , letting her clenching anus milk you dry" if cameInsideRahi else "")+". Рахи падает на локти, тяжело дыша, а её заброшенная киска всё ещё капает на пол.")

		saynn("[say=rahi]Она... она не может... ах... ф-фххх...[/say]")

		if (gentle):
			saynn("Когда ты заканчиваешь... ты выходишь... медленно и осторожно. Её анус слегка приоткрывается, прежде чем снова сжаться.")

			saynn("[say=pc]Вот и всё. Было не так уж плохо, правда?[/say]")

			saynn("[say=rahi]Мя-я-яу...[/say]")

		elif (mean):
			saynn("Когда ты заканчиваешь... ты резко вырываешь свой член, оставляя задницу Рахи широко раскрытой."+str(" and leak your seed onto her thighs" if cameInsideRahi else ", dripping with lube")+".")

			saynn("[say=pc]Ну вот и всё, шлюха. Твоя задница теперь принадлежит мне.[/say]")

			saynn("[say=rahi]Мя-я-яу...[/say]")

		else:
			saynn("Когда ты заканчиваешь... ты вынимаешь свой член, оставляя анус Рахи мелко дрожать."+str(" , some of your seed already leaking out" if cameInsideRahi else ", still slick with lube")+".")

			saynn("[say=pc]Хорошая девочка... Очень хорошая девочка.[/say]")

			saynn("[say=rahi]С-спасибо.. мяу..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_care")
	if(state == "after_care"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="rahi", bodyState={naked=true}, npcBodyState={naked=true, hard=true}})
		saynn("После всего случившегося ты притягиваешь кошечку в теплые объятия.")

		saynn("[say=pc]Теперь ты будешь работать на меня, верно?[/say]")

		if (perfect):
			saynn("[say=rahi]Конечно.. она сделает всё, что пожелаешь.. даже это, снова..[/say]")

		elif (success):
			saynn("[say=rahi]Да.. она сделает всё, что попросишь.. только.. полегче с её задницей..[/say]")

		else:
			saynn("[say=rahi]Эм... ну... в общем...[/say]")

			saynn("Хм... Похоже, она не собирается этого делать.")

		saynn("Закончив всё, ты выходишь из камеры, чтобы посмотреть, что думает Кейт..")

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
			if(GM.pc.shouldCondomBreakWhenFucking("rahi", GM.pc.useWorstCondom(), "anal")):
				condomBroke = true
		if(condomType == "best"):
			if(GM.pc.shouldCondomBreakWhenFucking("rahi", GM.pc.useBestCondom(), "anal")):
				condomBroke = true
		
		if(straponUsed):
			getCharacter("rahi").cummedInAnusBy("pc", FluidSource.Strapon)
		if(!straponUsed && (!condomUsed || condomBroke)):
			cameInsideRahi = true
			getCharacter("rahi").cummedInAnusBy("pc")
		if(condomUsed && !condomBroke):
			addFilledCondomToLootIfPerk(GM.pc.createFilledCondom())
		GM.pc.orgasmFrom("rahi")

	if(_action == "after_care"):
		processTime(5*60)
		recRemoveStrapons()

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
