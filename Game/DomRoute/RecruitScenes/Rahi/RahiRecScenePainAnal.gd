extends RecruitSceneBase

var gentle = false
var mean = false

func _init():
	sceneID = "RahiRecScenePainAnal"

func _run():
	if(state == ""):
		addCharacter("rahi")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Для того, что ты задумал, тебе понадобятся кое어 какие вещи. Ты спрашиваешь Кейт и Энс... и, к счастью, у них всё есть! Плюсы работы в команде.")

		saynn("После этого ты заходишь в камеру Рахи, хватаешь её поводок и притягиваешь её к центру помещения.")

		saynn("[say=pc]"+str(ch1("Our team only needs brave people. I'm going to test your pain tolerance. Trust me, okay?", "Our team only needs brave people. So I'm gonna test how well you handle pain. Understand?", "Our team has no place for cowards. I'm gonna test how well you handle pain. Understand?"))+"[/say]")

		saynn("Рахи моргает, а затем издает отчетливый глотательный звук.")

		saynn("[say=rahi]Она... она не уверена...[/say]")

		saynn("[say=pc]"+str(ch1("I won't do anything that you can't handle. I will be gentle. Now, let's get those clothes off..", "You will have to trust me, kitty cat. Now, clothes off.", "Too bad. You don't get a choice. Strip. Everything. Or I'll tear them off myself."))+"[/say]")

		saynn("Ты наблюдаешь, как её лапки начинают расстегивать пуговицы на рубашке. Она обнажает перед тобой свою упругую грудь, её соски слегка сморщились от прохладного ветерка. Следом идут шорты: она цепляет когтями пояс и стягивает их вниз, открывая твоему взору её милую розовую щелочку.")

		saynn("Рахи замирает, пока ты медленно обходишь её кругом, ведя пальцами по её талии, позвоночнику, плечам... прежде чем опуститься ниже и обхватить её задницу, едва касаясь пальцами её ануса. Рахи ахает, выгибая спину.")

		saynn("[say=rahi]Ах... м-мяу...[/say]")

		saynn("Затем ты достаешь главный предмет, который приготовил... изогнутый металлический анальный крюк! Его отполированная поверхность холодит при прикосновении... на одном конце у него небольшой шарик, а на другом — веревка.")

		saynn("[say=pc]"+str(ch1("Looks fun, doesn't it? I really wanna see it inside you.", "This is gonna be fun, kitty. Trust me.", "This is gonna go up your butt. I hope you're excited, slut."))+"[/say]")

		saynn("Рахи нервно косится на крюк, плотно обхватив хвостом бедро.")

		addButton("Продолжить", "Смотреть, что будет дальше", "prepare_anal")
	if(state == "prepare_anal"):
		saynn("Ты начинаешь смазывать конец крюка лубрикантом, втирая скользкий гель пальцами. Рахи наблюдает за этим, и её дыхание учащается.")

		saynn("Затем ты встаешь позади нее. Одной рукой ты раздвигаешь ее ягодицы, обнажая тугое розовое отверстие. Другой рукой ты прижимаешь закругленный кончик крючка к ее входу.")

		saynn("[say=rahi]Ннх..![/say]")

		saynn("Сначала медленно и осторожно ты начинаешь толкать. Крючок входит в нее дюйм за дюймом. Ее тело сопротивляется, внутренние стенки сжимаются вокруг инородного предмета... но тебе удается пропихнуть его глубже. Она тихо поскуливает, пока крючок скользит всё глубже... пока не достигает изгиба ее задницы.")

		saynn("[say=rahi]Хх.. хх.. п-полно..[/say]")

		saynn("Ты слегка тянешь крючок вверх, заставляя его сместиться внутри нее; это заставляет кошку встать на кончики пальцев, и из нее вырывается громкий стон.")

		saynn("[say=pc]"+str(ch1("Don't be so sad, it will feel good, I'm sure.. Now for the rest.", "See? That wasn't so hard. Now for the rest.", "Don't be so sad, it will get much more painful soon."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "hogtied")
	if(state == "hogtied"):
		playAnimation(StageScene.Hogtied, "idle", {pc="rahi", npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Тебе нужно, чтобы Рахи лежала на животе... поэтому ты помогаешь ей лечь.")

		saynn("Крючок всё еще остается внутри нее. Но теперь ты берешь привязанную к нему веревку и завязываешь ее узлом вокруг хвоста Рахи!")

		saynn("Когда ты тянешь за крючок, Рахи запрокидывает голову, и ее спина выгибается дугой. Ты затягиваешь веревку, фиксируя ее на этой длине.")

		saynn("[say=rahi]Ах!..[/say]")

		saynn("Теперь Рахи не может выпрямить спину: стоит ей попытаться, как крючок тянет ее за волосы, заставляя шипеть и морщиться от боли. В то же время крючок смещается внутри ее задницы.")

		saynn("[say=rahi]Это.. ах.. больно..[/say]")

		saynn("[say=pc]"+str(ch1("Let me know if this is too much.", "Such a helpless kitty. Try to endure it.", "Such a helpless toy. I'm not done yet."))+"[/say]")

		saynn("Вы заводите лапы Рахи за спину и используете другую веревку, чтобы связать её запястья и лодыжки вокруг хвоста. Теперь Рахи по-настоящему беспомощна: она связана «узлом», а в её анус вставлен крюк.")

		saynn("[say=rahi]Э-это.. м-может быть слишком.. ой.. ах.. Ой![/say]")

		saynn("Вы поднимаете руку и с силой опускаете её на её правую щеку. Звонкий шлепок эхом разносится по стенам камеры.")

		saynn("Удар пронзает всё её тело. Мышцы сжимаются... в том числе и те, что обхватывают крюк. Металл смещается внутри неё, надавливая на стенки. В то же время веревка на её хвосте заставляет её голову еще сильнее запрокинуться назад.")

		saynn("[say=rahi]Ааах-х.. нхх-..[/say]")

		saynn("Вы снова шлепаете её. На этот раз по левой щеке. Очередной спазм. Очередное смещение крюка. Рахи шипит и скулит, высунув язык и уже пуская слюни.")

		saynn("Вы продолжаете, пока её задница не наливается пунцовым цветом. От каждого шлепка она корчится... и каждое её движение делает только хуже. Несмотря на боль, между её ног начинает нарастать возбуждение. Её заброшенная киска делает бетон влажным.")

		saynn("[say=rahi]Ннххг.. хх.. б-больно..[/say]")

		saynn("Вы делаете паузу, чтобы осмотреть её. Легкое натяжение веревки заставляет всё её тело одеревенеть. Еще один рывок — и она жалобно скулит.")

		saynn("[say=pc]"+str(ch1("You're doing so well. Just a little more.", "Feel that? That's the hook reminding you who owns this hole.", "I can lift you by the hook. Want me to try?"))+"[/say]")

		saynn("Рахи неистово качает головой. По её щекам начинают течь одинокие слезы. Очевидно, она на пределе.")

		saynn("Так... пора завязывать.")

		addButton("Развязать", "На сегодня хватит", "untie_rahi_anal")
	if(state == "untie_rahi_anal"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="rahi", npcBodyState={naked=true}})
		saynn("Сначала ты развязываешь веревку на хвосте. Рахи мгновенно роняет голову с облегченным вздохом. Затем ты освобождаешь её запястья и лодыжки. Она плюхается на пол, а крюк всё еще остается внутри её задницы.")

		saynn("Ты осторожно берешься за него и медленно тянешь. Изогнутый металл начинает выходить из неё дюйм за дюймом. Она всё сильнее скулит, а её анус сжимается вокруг него... пока круглая сфера наконец не показывается наружу.")

		saynn("Крюк с мягким звоном падает на пол, а отверстие хвоста Рахи заметно пульсирует.")

		saynn("[say=rahi]Э-это... хх... б-было... оу... б-больно...[/say]")

		saynn("Ты подхватываешь Рахи и притягиваешь её к себе.")

		saynn("[say=pc]"+str(ch1("Sorry, kitty. I had to test your endurance.", "You did pretty good, kitty. Very good.", "You'll learn to love it. You just need more practice."))+"[/say]")

		saynn("Ты гладишь её по спине, пока она пытается расслабиться в твоих объятиях. Легкий массаж, кажется, помогает снять почти всё напряжение.")

		saynn("[say=rahi]Это.. было слишком.. всё целиком..[/say]")

		saynn("Похоже, она от этого.. вообще не в восторге.")

		saynn("Ты ещё какое-то время нежно обнимаешь Рахи, а затем оставляешь её одну и выходишь из камеры, чтобы узнать мнение Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "prepare_anal"):
		processTime(5*60)

	if(_action == "hogtied"):
		processTime(5*60)

	if(_action == "untie_rahi_anal"):
		processTime(3*60)

	setState(_action)

func saveData():
	var data = .saveData()

	data["gentle"] = gentle
	data["mean"] = mean

	return data

func loadData(data):
	.loadData(data)

	gentle = SAVE.loadVar(data, "gentle", false)
	mean = SAVE.loadVar(data, "mean", false)
