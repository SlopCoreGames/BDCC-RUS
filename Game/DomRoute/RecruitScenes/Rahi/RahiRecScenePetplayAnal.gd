extends RecruitSceneBase

var gentle = false
var mean = false

func _init():
	sceneID = "RahiRecScenePetplayAnal"

func _run():
	if(state == ""):
		addCharacter("rahi")
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="allfours", npcBodyState={naked=true, leashedBy="pc"}})
		gentle = (c1 == 0)
		mean = (c1 == 2)
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Для этого тебе понадобится особый предмет. Ты спрашиваешь свою команду, нет ли у них чего-нибудь подобного. И, похоже, у Анса есть как раз то, что нужно! Он также дал тебе тюбик лубриканта. Очень качественного лубриканта.")

		saynn("Забрав всё необходимое, ты заходишь в камеру Рахи и берешь её поводок. Она не особо сопротивляется, когда ты подводишь её к центру камеры.")

		saynn("[say=pc]"+str(ch1("I really wanna trust you. You're gonna be a good puppy for me for a bit, okay?", "I will check how obedient you are. From now on, you're gonna act like a puppy. Until I say otherwise. Got it?", "You will act like a bitch in heat from now on. Do you understand that, slut?"))+"[/say]")

		saynn("Рахи растерянно моргает, её ушки прижимаются к голове.")

		saynn("[say=rahi]Мяу?.. Но она же кошка..[/say]")

		saynn("Твоя хватка на поводке крепнет.")

		saynn("[say=pc]"+str(ch1("Yes, I know. But I wanna see how well you can do this. It's gonna be fun. Let's get those clothes off first, pets don't wear them, do they?", "I only see a puppy in front of me. A very strange puppy. Puppies usually don't wear clothes, do they?", "I don't care. You'll play the part or I'll make you. Now, mutts don't need clothes. Take them off."))+"[/say]")

		saynn("Она колеблется... но в конце концов её лапки начинают расстегивать пуговицы на рубашке. Ты просто наблюдаешь, как она обнажает свою упругую грудь, и её соски теперь ловят легкий прохладный ветерок. Следом идут шорты: она цепляется когтями за пояс и медленно тянет его в стороны, позволяя ткани сползти по бедрам и обнажая её милый розовый цветочек.")

		saynn("[say=pc]"+str(ch1("Good. Precious. Now could you get on all fours for me?", "Mhm. Pups don't walk on two legs too.", "Get on all fours."))+"[/say]")

		saynn("Рахи трет мордочку... а затем медленно опускается перед тобой, поджав хвост между ног. Когда она это делает, ты преподносишь ей тот самый таинственный предмет... огромную силиконовую пробку, больше любой обычной... гладкую... сужающуюся к концу... с расширяющимся основанием. Глаза Рахи округляются.")

		saynn("[say=rahi]..м-мяу??..[/say]")

		saynn("[say=pc]"+str(ch1("Shh. This will help you feel like a proper puppy. Just relax for me, okay?", "Puppies don't get to question. They obey. Now hold still.", "Don't act so surprised, I will make it fit."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "lube_part")
	if(state == "lube_part"):
		playAnimation(StageScene.SexFisting, "tease", {pc="pc", npc="rahi", npcBodyState={naked=true, hard=true}})
		saynn("Ты встаешь позади Рахи и выдавливаешь щедрую порцию смазки на пальцы. Рахи вздрагивает, когда твой прохладный, скользкий палец прижимается к её анусу. Её спина слегка выгибается.")

		saynn("[say=rahi]Нн.. это.. ах..[/say]")

		saynn("[say=pc]"+str(ch1("Why don't you bark for me instead?", "Quiet. Pups don't talk. They only bark.", "Bark, your slutty pet."))+"[/say]")

		saynn("[say=rahi]..р-р-р... гав...[/say]")

		saynn("Рахи очень узкая. Очень. Ты прижимаешь палец к её анусу и начинаешь медленно водить им.. мягкими кругами и толчками.. растягивая кольцо. Один палец проскальзывает внутрь. Рахи выпускает когти, скребя ими по полу.")

		saynn("Вскоре присоединяется второй палец, растягивая отверстие еще шире. Дыхание Рахи сбивается, из горла вырываются тихие поскуливания. Её киска становится влажной.. но ты не планируешь её стимулировать. Сейчас фокус не на этом.")

		saynn("[say=rahi]..в-вуфф.. ах..[/say]")

		saynn("Ты добавляешь третий палец. Она стонет, её хвост дрожит. Затем четвертый. Теперь ты по-настоящему чувствуешь, как её анус сжимается вокруг пальцев. Но ты продолжаешь растягивать её, просовывая пальцы внутрь и шевеля ими, пока Рахи, уронив подбородок, стонет прямо в пол.")

		saynn("[say=pc]"+str(ch1("You're doing so well. Almost ready.", "There we go. Loose enough now.", "Pathetic. This little hole can take more."))+"[/say]")

		saynn("Ты вынимаешь пальцы и берешь пробку. Её кончик прижимается к её растянутому входу. Рахи ахает, когда ты начинаешь давить на основание, заставляя игрушку медленно растягивать задний проход кошки еще сильнее. Однако она сильно сжимается.. препятствуя полному входу.")

		saynn("[say=rahi]Ааахх..[/say]")

		saynn("[say=pc]"+str(ch1("Just relax, little puppy. You need to relax.", "Quit clenching so much, puppy. I will work it in no matter what.", "Stop clenching, slut. This is not a cock."))+"[/say]")

		saynn("Она тяжело дышит и пыхтит, её тело дрожит, пока ты продолжаешь давить на её анус.. пока, наконец, толстая часть пробки не прорывается сквозь сфинктер. Всё её тело содрогается, и из киски вырывается немного смазки.")

		saynn("[say=rahi]Ня-а-ахх..[/say]")

		saynn("[say=pc]"+str(ch1("There. Good puppy. Let's go for a walk now.", "Good. Much better. Now we're going for a walk.", "Enjoy it. We're going for a walk."))+"[/say]")

		saynn("Ты хватаешь поводок и тянешь за него, подзывая Рахи следовать за собой. Она неуклюже подается вперед, все еще на четвереньках, переставляя лапы одну за другой; при каждом движении пробка внутри нее смещается. Тонкая струйка возбуждения стекает по ее бедру.")

		addButton("Продолжить", "Смотреть, что будет дальше", "walkies")
	if(state == "walkies"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="allfours", further=true, npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_west_corridor")
		saynn("Ты выводишь Рахи из камеры и просто начинаешь прогулку по коридору. Лапы Рахи шаркают по холодному полу, время от времени вырываются тихие стоны, а ее хвост поджат.")

		saynn("[say=rahi]Мммх.. х-хх.. р-рррфф..[/say]")

		saynn("Она движется довольно медленно, так что ты решаешь не выставлять ее на показ толпе у арены. Обычной прогулки по убежищу должно хватить.")

		saynn("Время от времени она прислоняется к стене и начинает дрожать с закрытыми глазами.")

		saynn("[say=pc]"+str(ch1("You're doing so well. Just keep crawling, puppy.", "No stopping, just crawl.", "What part of being a bitch don't you understand? Crawl."))+"[/say]")

		saynn("Она кивает и продолжает ползти за тобой, оставляя за собой тонкую дорожку смазки.")

		saynn("Пока вы гуляете, ты в конце концов натыкаешься на знакомое лицо.")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_encounter")
	if(state == "kait_encounter"):
		playAnimation(StageScene.Massage, "butt", {pc="kait", npc="rahi", npcBodyState={naked=true, hard=true}})
		addCharacter("kait")
		saynn("Это Кейт, снежная леопардиха.")

		saynn("[say=kait]Оуу, посмотрите на этого щеночка.[/say]")

		saynn("Она замечает, как медленно ползет Рахи, и решает обойти ее кругом, быстро обнаруживая гигантское расширенное основание пробки, торчащее из ее ануса.")

		saynn("[say=kait]Ого. Теперь понятно, почему ей так тяжело.[/say]")

		saynn("Прежде чем Рахи успевает среагировать, Кейт наклоняется и слегка тянет за пробки. Достаточно, чтобы та сдвинулась, обнажая свою толщину... прежде чем тугая «звезда» снова заглатывает её.")

		saynn("[say=rahi]Ннх..[/say]")

		saynn("Спина Рахи выгибается, с губ срывается тихий скулёж. Её киска заметно пульсирует, выделяя ещё больше прозрачной смазки.")

		saynn("[say=kait]О, ей это нравится. Дай-ка я помогу.[/say]")

		saynn("Лапа Кейт находит влажную щель Рахи и начинает медленно описывать круги вокруг клитора, заигрывая с ним. Ноги Рахи дрожат, рот приоткрыт, она тяжело дышит, словно щенок.")

		saynn("[say=rahi]Ах.. гав.. ахх..[/say]")

		saynn("[say=kait]Хорошая девочка.[/say]")

		saynn("Кейт делает последний рывок за пробку, вызывая громкий писк... а затем убегает.")

		saynn("[say=pc]"+str(ch1("See? You're being such a good puppy. Let's keep moving.", "You liked it? Good. Don't stop. Crawl. Now.", "You're leaking everywhere, slut. Move."))+"[/say]")

		saynn("Вы дёргаете за поводок, и Рахи снова принимается ползти, непроизвольно покачивая бёдрами.")

		saynn("Вскоре вы встречаете еще одного человека...")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_encounter")
	if(state == "avy_encounter"):
		playAnimation(StageScene.Spanking, "fastonce", {pc="avy", npc="rahi", npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName("hideout_middle")
		removeCharacter("kait")
		addCharacter("avy")
		saynn("Это Эви. Она подходит к вам с Рахи.")

		saynn("[say=avy]Знакомое личико. Рада, что ты нашла свое место, кошечка.[/say]")

		saynn("Она наклоняется позади кошечки и замечает ту гигантскую пробку.")

		saynn("[say=avy]Так вот почему ты так ерзаешь? Дай-ка я помогу.[/say]")

		saynn("По коридору разносится звонкий шлепок — Эви отвешивает подзатыльник по обнаженной заднице Рахи!")

		saynn("[say=rahi]ЙИП!..[/say]")

		saynn("Ее анус судорожно пульсирует, на мгновение обнажая пробку еще сильнее. Все тело Рахи содрогается, из груди вырывается сдавленный стон...")

		saynn("[say=avy]Хех. Ну и шлюшка. Держи спину ровнее.[/say]")

		saynn("Эви хватает Рахи за хвост и тянет вверх, заставляя ту выпятить задницу... задницу, по которой она тут же снова хлопает.")

		saynn("Задница Рахи снова сжимается вокруг пробки, ноги широко раздвигаются, а киска буквально заливает соками...")

		saynn("[say=avy]Жалкая маленькая дворняжка. Хочешь ещё?[/say]")

		saynn("[say=rahi]П-пожалуйста... ннхх... с-слишком много...[/say]")

		saynn("Ави ухмыляется и наносит три быстрых шлепка один за другим, всё ещё придерживая хвост другой лапой. Задница Рахи раскраснелась, а пробка внутри неё подпрыгивает от каждого удара. Бедная кошка уже пускает слюни, высунув язык.")

		saynn("[say=avy]Вот так. Теперь она точно знает своё место.[/say]")

		saynn("[say=rahi]...р-р-р-аффф...[/say]")

		saynn("Лисица гладит кошку по голове и быстро исчезает. Всё это время Рахи просто валится на пол, тяжело дыша; её покрасневшая задница подергивается, а пробка всё ещё глубоко внутри.")

		saynn("[say=pc]"+str(ch1("You took that well. Good puppy. Almost home.", "Look at it as an endurance test. We need strong people.", "Look at it as an endurance test. We don't need weak bitches."))+"[/say]")

		saynn("[say=rahi]Хафф...[/say]")

		saynn("Вы тянете за поводок. Рахи скулит, но подчиняется, подползая обратно на дрожащих лапах.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_cell")
	if(state == "back_to_cell"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="allfours", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Вы заводите Рахи обратно в камеру. Она снова падает на пол, вся дрожа; её киска всё ещё течёт, а анус широко растянут вокруг пробки.")

		saynn("[say=pc]"+str(ch1("All done. Let's get that out of you. Easy now.", "I'm gonna pull it out now. Sit tight.", "Time to pull the plug. Sit tight."))+"[/say]")

		saynn("Ты опускаешься на колени позади неё и медленно тянешь за основание пробки. Рахи ахает и впивается ногтями в пол, пока расширитель снова растягивает её анус... пока пробка наконец не выскальзывает с влажным чпоком.")

		saynn("Её анальное отверстие на мгновение остается широко раскрытым, обнажая влажную темноту. Кольцо медленно сжимается и расслабляется. Тонкая струйка смазки стекает из него.")

		saynn("[say=rahi]Нхх.. т-так.. т-так растянуто..[/say]")

		saynn("В конце концов оно начинает закрываться, стягиваясь обратно в тугую розовую складку. Она всё еще тяжело дышит, а её задница буквально горит.")

		if (success):
			saynn("Похоже, ей понравилось. Возможно.")

		else:
			saynn("Глядя на это сейчас... возможно, ты зашел слишком далеко.")

		saynn("Ты пару раз проводишь рукой по спине Рахи, прежде чем снова пристегнуть её на цепь к трубе.")

		saynn("Затем ты выходишь из камеры, чтобы посмотреть, что об этом думает Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "lube_part"):
		processTime(5*60)

	if(_action == "walkies"):
		processTime(3*60)

	if(_action == "kait_encounter"):
		processTime(10*60)

	if(_action == "avy_encounter"):
		processTime(5*60)

	if(_action == "back_to_cell"):
		processTime(10*60)

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
