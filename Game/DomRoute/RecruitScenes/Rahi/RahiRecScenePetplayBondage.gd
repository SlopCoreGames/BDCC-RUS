extends RecruitSceneBase

var gentle = false
var mean = false

func _init():
	sceneID = "RahiRecScenePetplayBondage"

func _run():
	if(state == ""):
		addCharacter("rahi")
		aimCameraAndSetLocName("hideout_breakroom")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Для этого дела тебе понадобится куча всего... Но Кейт и Энс снабдили тебя кое-какими забавными игрушками. Хорошо, когда есть команда.")

		saynn("Ты входишь в камеру Рахи и хватаешь её поводок. Она не особо сопротивляется, когда ты тянешь её к выходу.")

		saynn("[say=pc]"+str(ch1("I really wanna trust you. I'm going to put some things on you, okay? Just relax.", "Time to see how obedient you are. I will wear some things on you. And you will do as I say.", "You're gonna be our bitch. So I might as well dress you as one."))+"[/say]")

		saynn("Рахи моргает, её ушки прижимаются к голове. Лапки вцепляются в тугой поводок.")

		saynn("[say=rahi]Она... она не совсем понимает...[/say]")

		saynn("[say=pc]"+str(ch1("You don't need to. Just stand still for me. Let's get those clothes off first.", "Leave the thinking to me. Clothes off. Now.", "Shut up and strip. You're wasting time."))+"[/say]")

		saynn("Она колеблется... но в конце концов её лапки начинают расстегивать пуговицы на рубашке. Ты наблюдаешь, как она обнажает свою упругую грудь, и её соски тут же реагируют на легкий прохладный ветерок. На очереди шорты... она цепляет пояс когтями и тянет вниз, позволяя ткани соскользнуть по бедрам и обнажить её милый розовый цветок.")

		saynn("[say=pc]"+str(ch1("Good girl. Now kneel. We have a lot to put on you.", "Perfect. On your knees. And don't move. We have a lot to put on you.", "Mhm. Not get on your knees, you slutty pet. It's time to make you look like a proper pet."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "rahi_corset")
	if(state == "rahi_corset"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="allfours", npcBodyState={naked=true, leashedBy="pc"}})
		saynn("Рахи опускается на пол, слегка дрожа. Ты начинаешь с корсета, обхватывая её талию и туго затягивая шнуровку. Она ахает, когда её дыхание становится прерывистым.")

		saynn("[say=rahi]М-мяу... с-слишком туго...[/say]")

		saynn("[say=pc]"+str(ch1("Shh, you'll get used to it. Breathe slowly.", "It's supposed to be tight. That's the point.", "Complain again and I will get it even tighter. Just obey, slut."))+"[/say]")

		saynn("Дальше... фиксаторы для конечностей. Ты берешь её запястья и прижимаешь их к плечам, прежде чем надеть и застегнуть кожаные ремни, которые удерживают её руки в таком положении. Она всё еще может шевелить руками... но предплечья теперь зафиксированы.")

		saynn("Затем пора заняться ногами. К ним немного сложнее подступиться... но тебе почти удается закрепить её лодыжки рядом с задницей с помощью похожего ремня.")

		addButton("Продолжить", "Смотреть, что будет дальше", "rahi_bitchsuit")
	if(state == "rahi_bitchsuit"):
		playAnimation(StageScene.PuppySexOral, "tease", {pc="pc", npc="rahi", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		saynn("Когда всё закончено, Рахи остается стоять на локтях и коленях. Её кисти и задние лапы свободны... но она может лишь слегка шевелить пальцами ног или едва заметно двигать ими.")

		saynn("Рахи явно мучается в костюме сучки, тихонько поскуливая и едва не заваливаясь на бок.")

		saynn("[say=pc]"+str(ch1("Try to crawl. Move your limbs slowly. I'll help you balance.", "You don't walk. You crawl. Get used to it.", "Slutty pets like you will only crawl."))+"[/say]")

		saynn("Кошечка делает несколько коротких шажков. Выглядит довольно мило, когда так виляет задом.")

		saynn("Но ты еще не закончил. На очереди — кляп. Ты прижимаешь красный резиновый шарик к её губам и ждешь, пока она приоткроет рот достаточно широко, чтобы ты мог его вставить. Затем ты затягиваешь ремешок на затылке... туго.")

		saynn("[say=rahi]Мммпхх..[/say]")

		saynn("Одна из вещей, которую ты раздобыл у команды... это короткая цепочка с зажимами на обоих концах. Да, ты прекрасно знаешь, куда её пристроить. Ты подносишь её к её груди... и прищелкиваешь каждый сосок зажимом, позволяя цепочке свисать между ними.")

		saynn("[say=rahi]Хххк-! Мммппхх..[/say]")

		saynn("Её тело содрогается, Рахи запрокидывает голову и дёргает грудью, отчего зажимы ещё сильнее тянут её чувствительные соски.")

		saynn("[say=pc]"+str(ch1("Deep breaths. The sting will fade into warmth soon.", "Learn to accept the pain, kitty cat.", "Cry all you want. It won't make me stop. I am making you my bitch."))+"[/say]")

		saynn("Рахи тяжело дышит сквозь кляп, пока ты достаешь маленький вибратор... розовое яйцо. Ты подходишь к ней со спины и приклеиваешь его прямо на клитор, плотно прижимая. Затем ты закрепляешь пульт на её бедре и поворачиваешь колесико на несколько делений. Маленькая игрушка в форме пули начинает неистово жужжать.")

		saynn("[say=rahi]Ммм.. ммпх..[/say]")

		saynn("[say=pc]"+str(ch1("This will help you feel good..", "Behave and you might even cum.", "If you don't obey, I will turn it off."))+"[/say]")

		saynn("Наконец... повязка на глаза. Рахи видит тугую черную ткань и замирает. Затем она начинает неуклюже пятиться от тебя, её большие голубые глаза полны страха, а хвост судорожно дергается в воздухе.")

		saynn("Видеть, как она старается... слышать, как оковы на её конечностях лязгают о пол... Это, честно говоря, просто очаровательно.")

		addButton("Поводок", "Тянуть за поводок", "add_blindfold")
	if(state == "add_blindfold"):
		saynn("Ты решительно дергаешь за поводок... отчего кошечка с приглушенным скулением заваливается на бок. Тогда ты приседаешь рядом и начинаешь завязывать ей повязку на глазах, лишая её возможности видеть.")

		saynn("[say=pc]"+str(ch1("Shh, I've got you. You can't see, so just trust your other senses. Trust the leash.", "Now you truly have no choice but to obey. Trust my leash, pup.", "No sight. No voice. No movement. Perfect little bitch pup."))+"[/say]")

		saynn("Кажется... всё готово. Рахи теперь готова к прогулке. Место, где находится арена... может быть слишком людным... да и слишком далеким. Но ты можешь просто погулять с ней здесь, вокруг нового убежища.")

		saynn("Ты помогаешь Рахи снова встать на четыре лапы.")

		saynn("[say=pc]"+str(ch1("Time for a short walk.", "We're going for a walk. Pups need their walkies.", "Let's get you out for some walkies, slut."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "corridor_bondage")
	if(state == "corridor_bondage"):
		playAnimation(StageScene.PuppyDuo, "walk", {pc="pc", npc="rahi", npcBodyState={naked=true, hard=true, leashedBy="pc"}, flipNPC=true, npcAction="walk"})
		aimCameraAndSetLocName("hideout_west_corridor")
		saynn("Ты выходишь из камеры. Рахи ползет на локтях и коленях, слепо следуя за поводком. Каждое движение заставляет зажимы тянуть её соски... а вибратор всё так же жужжит в её киске. Она не самая быстрая... но она явно старается. Ты только сейчас заметил, насколько сильно она покраснела — её щеки буквально пылают.")

		saynn("И вот ты выгуливаешь свою собачку по узкому техническому коридору. Повсюду всё еще валяется какой-то мусор... но ты просто тянешь за поводок каждый раз, когда Рахи вот-вот обо что-то ударится.")

		saynn("[say=pc]"+str(ch1("Good. You're such a good puppy.", "Keep moving your pawsies, little puppy.", "Keep up, bitch. You can move those paws faster than that."))+"[/say]")

		saynn("[say=rahi]Р-р-р... х-хы... г-гав...[/say]")

		saynn("Ты идешь по коридору... пока не натыкаешься на кого-то.")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_meet")
	if(state == "kait_meet"):
		addCharacter("kait")
		playAnimation(StageScene.PuppySexStart, "pat", {pc="kait", npc="rahi", npcBodyState={naked=true, hard=true}})
		saynn("[say=kait]Ох... Ты реально выложился по полной. Посмотри на эту собачку![/say]")

		saynn("Кейт приседает рядом с Рахи и начинает вовсю гладить её по голове и чесать за ушком.")

		saynn("[say=kait]Так и хочется потискать твои щечки, красавица~. Погладить животик?[/say]")

		saynn("Рахи тихонько гавкает... и заваливается на бок, когда Кейт мягко подталкивает её. Твоя собачка дрыгает лапками, пока снежная леопардица вовсю чешет ей пузико.")

		saynn("[say=kait]Там у тебя тоже всё совсем мокрое~. О-о-о. Тебе явно нравится.[/say]")

		saynn("Кейт тянется к пульту от игрушки, прибавляя мощность на несколько делений. Вскоре у Рахи начинают вырываться приглушенные стоны, а её тело корчится, когда жужжание у клитора становится всё более высокочастотным.")

		saynn("[say=kait]Вот так. Это твоя награда за то, что ты такая послушная собачка. И это ещё не всё... если будешь делать всё, что мы скажем. Ты ведь будешь делать всё для нас... Правда, собачка?[/say]")

		saynn("[say=rahi]Г-гав...[/say]")

		saynn("[say=pc]"+str(ch1("Don't push her too much. I'm being very gentle with her.", "I think she will, yes.", "That slutty pup doesn't really have a choice."))+"[/say]")

		saynn("Кейт помогает Рахи подняться, а затем оставляет тебя в покое.")

		saynn("Ты ещё немного побродишь по убежищу... пока не натыкаешься на Эви.")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_encounter")
	if(state == "avy_encounter"):
		playAnimation(StageScene.PuppySexStart, "sad", {pc="avy", npc="rahi", npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName("hideout_middle")
		removeCharacter("kait")
		addCharacter("avy")
		saynn("Темная лисичка подходит к вам двоим с легкой ухмылкой на лице.")

		saynn("[say=avy]Узнаю эту кошечку. Хм. Что тут скажешь... одобряю.[/say]")

		saynn("Она приседает рядом, тяжело дыша и заливаясь румянцем, Рахи... а затем дергает носом.")

		saynn("[say=rahi]Ммм...[/say]")

		saynn("[say=avy]Что? Укусить меня решила?[/say]")

		saynn("Ави тянется... но не погладить, а затянуть кляп, повязку на глазах и корсет еще туже.")

		saynn("[say=avy]Удачи тебе с этим, дворняжка.[/say]")

		saynn("Рахи просто пускает слюни... пока Ави не дергает за цепочку на ее соске, заставляя бедную киску громко ахнуть.")

		saynn("[say=avy]Какая чувствительная~. Дай-ка я кое-что проверю.[/say]")

		saynn("Лисичка тянет за хвост Рахи... и заглядывает в ее жаждущую щелочку, которая изрядно промокла. Ави выставляет на пульте максимальную мощность...")

		saynn("[say=rahi]Мммхх-х-х~..[/say]")

		saynn("[say=avy]Такая шлюшка.. Лай мне.[/say]")

		saynn("Рахи раскачивается из стороны в сторону, неистово виляя задом. Жужжание становится невыносимо громким, бедная кошечка изо всех сил пытается сдержать нахлынувшее удовольствие. Её передние лапки сдаются первыми, и она роняет мордочку на пол, высоко задрав задницу. Из неё начинают вырываться всё более приглушенные стоны..")

		saynn("[say=rahi]Мммхх.. ххх-х.. гав.. МММхх.. Ммммхх-.. г-гав.. р-рр-гав..[/say]")

		saynn("[say=avy]Да неужели? Хочешь кончить прямо сейчас? Жалкое зрелище. Как насчет того, чтобы я..[/say]")

		saynn("Ави внезапно выключает игрушку. И это окончательно сносит Рахи крышу. Она валится на бок и начинает извиваться, потирая ножки друг о друга и скуля в темноте.")

		saynn("[say=avy]Да-а. Вот так. Если хочешь кончить, будешь ловить каждое наше слово.[/say]")

		saynn("[say=pc]"+str(ch1("You're being way too mean, Avy. Chill.", "Yeah, I will make sure she listens. Will use a clicker if I have to.", "That bitch in heat is gonna do exactly what I tell her to do."))+"[/say]")

		saynn("Рахи еще долго тяжело дышит.. пока её тело остывает, а ощущение оргазма постепенно угасает, оставляя её плоть сверхчувствительной.")

		saynn("Пора возвращать её в чувство.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_cell_bondage")
	if(state == "back_to_cell_bondage"):
		playAnimation(StageScene.PuppySexStart, "start", {pc="pc", npc="rahi", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		removeCharacter("avy")
		saynn("Вы заводите Рахи обратно в камеру. После последнего этапа она просто падает на пол — с повязкой на глазах и в путах, по её телу пробегает легкая дрожь.")

		saynn("Сначала ты снимаешь повязку. Её глаза пытаются сфокусироваться, зрачки расширены до предела.")

		saynn("Затем — шарик-кляп. Она кашляет и сглатывает.")

		saynn("[say=rahi]Г-гав...[/say]")

		saynn("Тихий стон вырывается у неё, когда ты отклеиваешь пластырь, удерживающий вибратор. И второй стон — когда ты снимаешь зажимы.")

		if (success):
			saynn("[say=pc]Ну как тебе?[/say]")

			saynn("[say=rahi]Гав... о-очень интенсивно...[/say]")

			saynn("[say=pc]Будешь делать всё, что тебе скажут?[/say]")

			saynn("[say=rahi]Г-гав...[/say]")

			saynn("Похоже, что да.")

		else:
			saynn("[say=pc]Ну как всё прошло, киска? Прости, если я переборщил(а).[/say]")

			saynn("[say=rahi]Мяу... о-она могла бы и больше...[/say]")

			saynn("Хм.")

		saynn("Ты не спешишь, освобождая каждую её конечность. Затем ты снова привязываешь её поводком к трубе, хватаешь все игрушки и выходишь наружу.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_actual")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "rahi_corset"):
		processTime(5*60)
		putOn("rahi", "PuppyCorset")

	if(_action == "rahi_bitchsuit"):
		processTime(3*60)
		putOn("rahi", "ballgag")

	if(_action == "add_blindfold"):
		processTime(3*60)
		putOn("rahi", "blindfold")

	if(_action == "corridor_bondage"):
		processTime(5*60)

	if(_action == "kait_meet"):
		processTime(5*60)

	if(_action == "avy_encounter"):
		processTime(5*60)

	if(_action == "back_to_cell_bondage"):
		processTime(15*60)
		putOff("rahi", "ballgag")
		putOff("rahi", "blindfold")

	if(_action == "endthescene_actual"):
		putOff("rahi", "PuppyCorset")
		endScene()
		return

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
