extends SceneBase

func _init():
	sceneID = "NuraTalkScene"

func _run():
	if(state == ""):
		addCharacter("nura")
		playAnimation(StageScene.Duo, "stand", {npc="nura"})
		saynn("Вы подходите к Нур-А. Кажется, она находится в режиме ожидания — просто стоит неподвижно.")

		saynn("[say=nura]Здравствуйте, я — Нур-А. Чем я могу вам помочь?[/say]")

		addButton("Память?", "Спросить, помнит ли она что-нибудь", "talk_memory")
		addButton("Исцели меня", "Попросить Нур-А залечить ваши раны", "healcheck")
		addButton("Эмоциональная поддержка", "Спросить, как Нур-А может помочь вам эмоционально", "emo_help")
		if (!getFlag("CellblockModule.NuraGaveTool")):
			if (!getFlag("CellblockModule.NuraFoundTool")):
				addDisabledButton("Отдать инструмент", "У вас нет инструмента, чтобы отдать его Нур-А")
			else:
				addButton("Отдать инструмент", "Отдать Нур-А гигантский шприц, который вы нашли", "give_syringe")
		addButton("Уйти", "Пора идти", "endthescene")
	if(state == "give_syringe"):
		saynn("Вы протягиваете Нур-А найденный гигантский шприц.")

		saynn("[say=pc]Вот, мне кажется, он тебе подходит.[/say]")

		saynn("Нур-А хватает шприц, её рука трансформируется, чтобы ввести иглу в пустое отверстие. Шприц почти мгновенно наполняется каким-то препаратом, после чего рука Нур-А принимает прежний вид.")

		saynn("[say=nura]Нур-А признательна. Теперь я способна выполнять свое предназначение.[/say]")

		saynn("[say=pc]Может, существуют и другие инструменты, созданные специально для тебя?[/say]")

		saynn("[say=nura]Мне не хватает этой информации.[/say]")

		saynn("Справедливо, её здесь бросили не просто так.")

		addButton("Продолжить", "Спросить о чем-то другом", "")
	if(state == "talk_memory"):
		saynn("[say=pc]Ты что-нибудь помнишь? Почему ты здесь?[/say]")

		saynn("Нур-А явно слышит вас, но замирает в молчании на несколько секунд.")

		saynn("[say=nura]Я — Нур-А. Я андроид-медсестра. Моя цель — оказывать медицинскую помощь и эмоциональную поддержку тем, кто в ней нуждается.[/say]")

		saynn("Ты вздыхаешь.")

		saynn("[say=pc]Что-нибудь еще?[/say]")

		saynn("[say=nura]Мое программирование не предусматривает иных целей. Моя главная и единственная задача — помогать вам и исполнять свои обязанности медсестры.[/say]")

		saynn("Ясно.")

		addButton("Продолжить", "Спросить о чем-то другом", "")
	if(state == "heal_success"):
		saynn("[say=pc]Ладно. Мне нужна медицинская помощь.[/say]")

		saynn("Безжизненные глаза андроида сканируют вас.")

		saynn("[say=nura]Пожалуйста, не двигайтесь, пока я ввожу обезболивающее.[/say]")

		saynn("Затем она кладет руку вам на плечо. Ее запястье трансформируется, превращаясь в промышленный шприц, наполненный каким-то препаратом. Острая игла с легкостью вонзается в ваше плечо и впрыскивает обезболивающее. Вы уже чувствуете себя гораздо лучше.")

		saynn("[say=nura]Обезболивающее введено.[/say]")

		saynn("[say=pc]Спасибо.[/say]")

		saynn("Она возвращает руке прежний вид и пристально смотрит на вас.")

		saynn("[say=nura]Могу ли я еще чем-нибудь вам помочь?[/say]")

		addButton("Продолжить", "Спросить о чем-то другом", "")
	if(state == "heal_fail"):
		saynn("[say=pc]Ладно. Мне нужна медицинская помощь.[/say]")

		saynn("Безжизненные глаза андроида сканируют вас.")

		saynn("[say=nura]Пожалуйста, не двигайтесь, пока я ввожу обезболивающее.[/say]")

		saynn("Затем она кладет руку вам на плечо. Ее запястье полностью трансформируется, обнажая... пустоту. Похоже, там должно быть гнездо для какого-то инструмента. Но самого инструмента явно не хватает.")

		saynn("[say=nura]Ошибка. Не удалось выполнить задачу из-за отсутствия оборудования. Нур-А очень сожалеет.[/say]")

		saynn("Она возвращает руке прежний вид и пристально смотрит на вас.")

		saynn("[say=nura]Могу ли я еще чем-нибудь вам помочь?[/say]")

		saynn("[say=pc]Скорее всего, нет.[/say]")

		addButton("Продолжить", "Спросить о чем-то другом", "")
	if(state == "emo_help"):
		saynn("[say=pc]Что ты имеешь в виду под эмоциональной помощью, Нур-А?[/say]")

		saynn("Андроид пристально смотрит на вас.")

		saynn("[say=nura]Нур-А способна осуществлять объятия.[/say]")

		saynn("[say=pc]Только объятия?[/say]")

		saynn("[say=nura]Мне не хватает способностей, чтобы снять эмоциональное напряжение каким-либо иным способом.[/say]")

		saynn("Справедливо. Ты быстро осматриваешь её тело и понимаешь, что у неё напрочь отсутствуют какие-либо... интимные места. Грудь кажется маленькой, довольно упругой, но на ней нет даже сосков. Даже её рот — это просто динамик внутри неподвижной челюсти. На производстве этого андроида явно решили жестко сэкономить.")

		addButton("Обними меня", "Попросить Нур-А обнять тебя", "get_hugged")
		addButton("Секс?", "Возможно, способ есть", "ask_sex")
		addButton("Проехали", "Спросить о чем-то другом", "")
	if(state == "get_hugged"):
		playAnimation(StageScene.Hug, "hug", {npc="nura"})
		saynn("[say=pc]Обними меня, Нур-А.[/say]")

		saynn("Андроид разводит руки и обхватывает тебя, притягивая ближе. Ты чувствуешь, насколько холодный её корпус. Её грудь совсем не мягкая, как ты и думал. Впрочем, сам жест довольно приятный.")

		saynn("Ровно через 5 секунд Нур-А отстраняется от объятий.")

		saynn("[say=nura]Объятия завершены. Надеюсь, тебе стало лучше.[/say]")

		saynn("[say=pc]Стало, немного.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "ask_sex"):
		saynn("[say=pc]Может, ты поможешь мне удовлетворить... другие потребности?[/say]")

		saynn("Нур-А сканирует тебя своими андроидскими глазами.")

		saynn("[say=nura]Прости, но у меня нет подходящих инструментов для этого.[/say]")

		saynn("[say=pc]Я понимаю. Но, может, мы всё равно попробуем?[/say]")

		saynn("[say=nura]Нур-А рада помочь.[/say]")

		addButton("Проехали", "Спросить о чем-то другом", "")
		addButtonWithChecks("Сквиз (ножницы)", "Тереться кисками друг о друга", "do_fake_scissoring", [], [ButtonChecks.HasReachableVagina])
		addButtonWithChecks("Вагинальный секс?", "Попробовать трахнуть её", "do_fake_vaginal", [], [ButtonChecks.HasReachablePenis])
	if(state == "do_fake_scissoring"):
		playAnimation(StageScene.SexTribadism, "tease", {npc="nura", pc="pc"})
		saynn("Ты находишь пустой рабочий стол и быстро сгребаешь с него весь мусор. Затем ты берешь андроида за руку и подводишь к столу, помогая ей забраться на него. Ты тоже запрыгиваешь на стол и укладываешь Нур-А на спину.")

		saynn("[say=pc]Слегка разведи ноги.[/say]")

		saynn("Нур-А раздвигает ноги перед тобой. Её промежность идеально плоская, ни намека на киску.")

		saynn("[say=nura]Задание выполнено.[/say]")

		saynn("Но что поделаешь — ты ложишься напротив неё и переплетаешь свои ноги с её ногами так, чтобы ваши промежности плотно прижались друг к другу.")

		addButton("Тереть", "Сделать это", "start_fake_pussyrubbing")
	if(state == "start_fake_pussyrubbing"):
		playAnimation(StageScene.SexTribadism, "sex", {npc="nura", pc="pc", pcCum=true})
		saynn("Вы начинаете тереться друг о друга кисками. Ну, точнее, её воображаемой киской. Нур-А придерживает её руками, глядя на тебя, а затем начинает помогать, двигая бедрами в противоход.")

		saynn("Ощущения... странные. Плоская металлическая панель там, где у неё должно быть лоно, довольно холодная и жесткая. Но всё же, это вызывает приятное трение. Твоя {pc.pussyStretch} постепенно намокает, и ты размазываешь соки по её промежности, заставляя её блестеть.")

		saynn("[say=nura]Приятно, пациент?[/say]")

		saynn("[say=pc]Да, продолжай.[/say]")

		saynn("Нур-А прислушивается к тебе и ускоряется, притирая свою металлическую промежность к твоей щели. Вскоре ты начинаешь тихо стонать. Достаточно тихо, чтобы тебя не заметили.")

		saynn("Похоже, у этого андроида внизу совсем нет датчиков, и она ориентируется только на визуальный и аудиоряд. Но этого вполне достаточно, чтобы довести тебя до пика. Ты сильнее раздвигаешь губы и издаешь громкий стон, пока всё твоё тело начинает корчиться и дрожать. Нур-А замечает это и тоже замирает, позволяя тебе в спокойствии пережить волны оргазма.")

		saynn("[say=nura]Нур-А рада быть полезной.[/say]")

		saynn("[say=pc]Спасибо...[/say]")

		saynn("Ты отдыхаешь несколько минут, прежде чем слезть со стола и помочь Нур-А сделать то же самое.")

		addButton("Продолжить", "Это было приятно", "")
	if(state == "do_fake_vaginal"):
		playAnimation(StageScene.SexStanding, "tease", {npc="nura", pc="pc", bodyState={exposedCrotch=true,hard=true}})
		saynn("Ты подходишь к Нур-А и обнажаешь свой {pc.penis}, прежде чем поднести его к ней.")

		saynn("[say=pc]Я знаю, что у тебя нет киски или чего-то подобного. Просто постой смирно для меня, ладно?[/say]")

		saynn("Андроид кивает тебе.")

		saynn("[say=nura]Нур-А сделает это.[/say]")

		saynn("Ты кладешь одну руку ей на плечо. Плечо всё еще холодное. Нур-А кажется отличной опорой. Ты обходишь её, и твоя вторая рука ловко приводит член в состояние эрекции, после чего ты направляешь его между её металлических бедер. К счастью, там нет ничего, что могло бы защемить кожу, так что ты можешь свободно прижиматься к её гладкому паху.")

		saynn("[say=pc]Можешь... свести ноги чуть плотнее? Но не слишком сильно.[/say]")

		saynn("Нур-А слушает и делает всё, что ты просишь, зажимая твой член между своих холодных бёдер. В этом есть какая-то извращенная прелесть...")

		addButton("Трахнуть её бёдра", "Начать двигать бёдрами", "do_fake_humps")
	if(state == "do_fake_humps"):
		playAnimation(StageScene.SexStanding, "sex", {npc="nura", pc="pc", pcCum=true, bodyState={exposedCrotch=true,hard=true}})
		saynn("Ты начинаешь двигать бёдрами вперёд-назад, позволяя своему {pc.cock} тереться о бёдра андроида, постепенно наращивая темп. И хотя в её промежности ничего нет, трения достаточно, чтобы из твоего ствола начала сочиться предэякуляционная смазка.")

		saynn("Твоя рука соскальзывает с её плеча на грудь. Она очень упругая и совсем не колышется. Но за неё вполне удобно держаться, пока ты вколачиваешь свой член между её ног.")

		saynn("Вскоре ты ловишь себя на том, что тяжело дышишь ей в затылок горячим дыханием. Кажется, андроид рада отвечать на твои движения своими: она слегка сжимает твой член, а затем тоже начинает двигать бёдрами.")

		saynn("Ты трахаешь её бёдра около минуты, прежде чем чувствуешь, что оргазм уже совсем близко.")

		saynn("[say=pc]Сейчас..[/say]")

		saynn("[say=nura]Не сдерживайся, выпускай всё накопившееся напряжение, пациент.[/say]")

		saynn("Ты издаёшь страстный стон перед тем, как кончить; твой {pc.cock} начинает пульсировать и содрогаться, выбрасывая волну за волной горячей липкой {pc.cum} между бёдер андроида, создавая на полу изрядную лужу. Это чертовски приятно. Похоже, Нур-А это почувствовала и замерла, чтобы не перестимулировать тебя слишком сильно.")

		saynn("[say=pc]Ого. Спасибо тебе, Нур-А.[/say]")

		saynn("[say=nura]Нур-А рада быть полезной.[/say]")

		saynn("Ты кладешь подбородок ей на холодное плечо и замираешь так на какое-то время, медленно восстанавливая дыхание.")

		addButton("Продолжить", "Это было приятно", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "healcheck"):
		if(getFlag("CellblockModule.NuraGaveTool")):
			GM.pc.addPain(-GM.pc.getPain())
			setState("heal_success")
			return
		else:
			setState("heal_fail")
			return

	if(_action == "give_syringe"):
		setFlag("CellblockModule.NuraGaveTool", true)

	if(_action == "get_hugged"):
		GM.pc.addStamina(10)

	if(_action == "start_fake_pussyrubbing"):
		processTime(5*60)
		GM.pc.orgasmFrom("nura")

	if(_action == "do_fake_humps"):
		processTime(5*60)
		GM.pc.orgasmFrom("nura")

	setState(_action)

func getDevCommentary():
	return "Rahi, why did you write an android that has no pussy or squishy boobs?? There is a reason x3\n\nIdeally, the way I see Nur-A's completed content is as follows:\nYou meet her and do some chatting/lewds. (this part is complete)\nYou return to Alex and tell him about Nura. He starts explaining to you how she is an incomplete prototype that was scrapped because of reasons (who needs a nurse without holes or personality or something).\nYou want Nura to be finished. Alex says that you will need parts and/or credits for that.\nYou go around looking for these parts. Each one adds something (boobs, vagina, better ass, hair, different heads/tails/ears, various dicks, maybe a synthetic womb). Where would you find these parts? I have no idea x3\nYou also find personality chips. They make Nura act subby or extremely rough or as a kind domme mommy, you know.\nMaybe there is also a hidden sub-story that reveals itself more as you upgrade Nura. Something about her past. Maybe she is a stolen prototype from Syndicate? Maybe she is actually a girl that was killed and turned into a cyborg. Maybe she was one of the inmates x3. I dunno, you can take her any direction.\nAfter you upgrade her enough, she would join Eliza in the medical wing or something. She is a nurse after all..\n\nIf you're a writer and like Nura, feel free to grab this character and write for her, I'd be happy ^^"

func hasDevCommentary():
	return true
