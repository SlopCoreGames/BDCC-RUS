extends SceneBase

var amountCollected = 0.0

func _init():
	sceneID = "ElizaMilkingSeedFleshlightScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		aimCameraAndSetLocName("med_milkingroom")
		playAnimation(StageScene.Grope, "tease", {pc="pc", npc="eliza"})
		saynn("Вы подходите к Элизе и спрашиваете, может ли она подоить из вас семя.")

		saynn("[say=eliza]Охх, кажется, я знаю, что мы можем сделать~. Иди за мной![/say]")

		saynn("Она заводит вас в одну из пустых доильных кабинок.")

		saynn("[say=eliza]Постой здесь, мне нужно позвать кое-кого![/say]")

		saynn("Хм. Невольно задумываешься, как третий человек поможет во всем этом...")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_walks_in")
	if(state == "socket_walks_in"):
		removeCharacter("eliza")
		addCharacter("socket")
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="socket", npcAction=["hold_object", "res://Inventory/UnriggedModels/Fleshlight/FleshlightSocketStraw.tscn"]})
		saynn("Спустя несколько минут в комнату входит Сокет, потягивая что-то из своей... киски... через трубочку.")

		saynn("[say=socket]Хей![/say]")

		saynn("Вы удивленно приподнимаете бровь. Элиза тоже возвращается.")

		saynn("[say=eliza]Кажется, вы двое знакомы, верно?[/say]")

		saynn("Ты киваешь.")

		saynn("[say=socket]Да, {pc.he} мне очень помогла! Меньшее, что я могу сделать — это помочь ей в ответ.[/say]")

		saynn("Сокет протягивает лапу, предлагая тебе устройство, похожее на флешлайт... портал которого настроен на её собственное устройство для клитора.")

		saynn("Но Элиза хватает его первой... она раздвигает пальцами складки и заглядывает внутрь...")

		saynn("[say=eliza]Погоди, оно у тебя уже чем-то наполнено![/say]")

		saynn("[say=socket]Ага, это сидр. Пей через трубочку, очень вкусно![/say]")

		saynn("Элиза вздыхает.")

		saynn("[say=eliza]Так, погоди, я, пожалуй, пойду его помою.[/say]")

		saynn("Элиза оставляет вас двоих наедине ненадолго.")

		saynn("Воцаряется неловкая тишина... но вдруг Сокет начинает внезапно ерзать.")

		saynn("[say=socket]Охх... какое холодное.[/say]")

		saynn("Элиза вымывает весь сидр из киски Сокет...")

		saynn("[say=pc]Какой у нас вообще план?[/say]")

		saynn("[say=socket]Зачем дрочить в пластиковую бутылку, если у тебя есть я![/say]")

		saynn("Это... справедливо. Ты не против.")

		saynn("Вскоре Элиза возвращается и протягивает устройство Сокет.")

		saynn("[say=eliza]Вот, теперь он чистый. Нам нужно только семя.[/say]")

		saynn("[say=socket]Оки![/say]")

		saynn("Взгляд Сокет впивается в твои глаза.")

		saynn("[say=socket]Я всё сделаю, просто расслабься![/say]")

		saynn("Конечно...")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_tease")
	if(state == "socket_tease"):
		playAnimation(StageScene.SexFleshlight, "tease", {npc="socket", socketPussy=true, bodyState={exposedCrotch=true,hard=true}})
		saynn("Без малейших колебаний Сокет устраивается позади тебя и опускает флешлайт на твой пульсирующий член, совмещая его с отверстием.")

		saynn("Она действует медленно, позволяя твоему члену скользить по её складкам и слегка надавливая на само входное отверстие.")

		saynn("Ты чувствуешь тепло этой щели... как она подергивается, когда касаются её клитора... как она становится влажной и готовой к большему... в этом нет ничего искусственного...")

		saynn("Сокет замечает каплю предэякулята, сочащуюся с кончика твоего члена. Она подхватывает её мастурбатором и размазывает по своей чувствительной плоти.")

		saynn("[say=socket]Похоже, ты готов.[/say]")

		saynn("Элиза просто прислонилась к одной из стен, с огромным интересом наблюдая за процессом.")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_sex")
	if(state == "socket_sex"):
		playAnimation(StageScene.SexFleshlight, "sex", {npc="socket", socketPussy=true, bodyState={exposedCrotch=true,hard=true}})
		saynn("Сокет нажимает сильнее, позволяя твоему {pc.penis} раздвинуть лепестки её цветка и скользнуть внутрь! Её внутренние стенки приятно сжимаются вокруг твоего ствола, создавая приятное трение, пока она начинает двигать мастурбатор вперед-назад... заставляя тебя трахать её до красноты...")

		saynn("Она кладет подбородок тебе на плечо и смотрит вниз на происходящее.")

		saynn("[say=socket]У тебя классный член. Внутри он ощущается очень приятно.[/say]")

		saynn("[say=pc]Ага... спасибо.[/say]")

		saynn("Ты слегка подстраиваешься под её движения, твой член проникает глубоко внутрь, касаясь самой шейки матки.")

		saynn("Вскоре ты начинаешь тяжело дышать. С твоих губ срываются короткие стоны, пока Сокет продолжает насаживаться своей щелью на твой член...")

		saynn("[say=socket]Я могу делать это быстрее. Стенки моей киски усилены против большинства видов повреждений, включая физические.[/say]")

		saynn("[say=pc]То есть ты типа... идеальная секс-кукла?[/say]")

		saynn("Она тихо хихикает.")

		saynn("[say=socket]Можно и так сказать.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_faster")
	if(state == "socket_faster"):
		playAnimation(StageScene.SexFleshlight, "fast", {npc="socket", socketPussy=true, bodyState={exposedCrotch=true,hard=true}})
		saynn("Разъем ускоряет темп, дергая этот флешлайт туда-сюда еще быстрее, позволяя ее внутренним стенкам массировать твой член; от удовольствия она сжимается, покрывая твой агрегат слоем своих соков... в то время как твой член уже подтекает в нее предэякулятом.")

		saynn("[say=socket]Такого темпа должно хватить![/say]")

		saynn("Она немного тяжело дышит... но ты тоже. Разъем, по сути, заставляет тебя вколачивать свой член в ее киску, с силой вгоняя флешлайт глубоко и жестко... настолько сильно, что каждый раз на ее животе проступает едва заметный бугорок... когда твой член давит на ее матку.")

		saynn("С такой идеальной киской пик удовольствия стремительно приближается.")

		saynn("[say=pc]Я сейчас кончу... прямо в тебя.[/say]")

		saynn("[say=socket]Следи, чтобы не профукать ни капли! А то Элиза будет на нас злиться.[/say]")

		saynn("Элиза прикусывает губу.")

		saynn("[say=eliza]О да, еще как буду~.[/say]")

		saynn("Эта скользкая жара... то, как её портативная дырка принимает тебя... заставляет тебя кряхтеть.")

		addButton("Оргазм", "Забей эту мастурбаторку до краев", "process_cum")
	if(state == "process_cum"):
		playAnimation(StageScene.SexFleshlight, "inside", {npc="socket", socketPussy=true, bodyState={exposedCrotch=true,hard=true}})
		saynn("Как только её киска доводит тебя до края, Сокет с силой насаживается на мастурбатор, следя за тем, чтобы вся твоя пульсирующая длина оказалась внутри неё.")

		saynn("[say=pc]Гхх..[/say]")

		saynn("Ты кряхтишь и рычишь, твоё тело пробивает дрожь, а член начинает пульсировать внутри неё, выплескивая в манящую щель Сокет всё больше и больше густой, кремовой {pc.cum}. Её тугие внутренние стенки сжимают твой ствол, выжимая из твоих яичек всё до последней капли семени.")

		saynn("[say=pc]Блядь..[/say]")

		saynn("[say=socket]Ну и порция... хах.[/say]")

		saynn("Ты запрокидываешь голову, позволяя бесконечным волнам экстаза проходить сквозь тебя... а твоя {pc.penis} всё еще наполняет мастурбатор.")

		saynn("[say=pc]Гх..[/say]")

		saynn("Это было хорошо...")

		addButton("Продолжить", "Смотреть, что будет дальше", "socket_gives_fleshlight_back")
	if(state == "socket_gives_fleshlight_back"):
		playAnimation(StageScene.Duo, "stand", {pc="socket", npc="eliza"})
		GM.pc.setLocation("med_nearmilking")
		saynn("Только когда Сокет окончательно убеждается, что твой оргазм подошел к концу, она осторожно снимает флешлайт с твоего члена, стараясь держать его так, чтобы ничего не пролилось.")

		saynn("[say=socket]Ох, на тебе всё еще кое-что осталось![/say]")

		saynn("Она подставляет флешлайт под кончик твоего члена, обхватив его пальцами у основания и проводя ими вдоль ствола, собирая всю смазку, а затем позволяя ей стекать прямо в её набитую киску...")

		saynn("После этого она передает полный флешлайт Элизе.")

		saynn("[say=socket]Вот и всё! Погоди, а где же соломинка...[/say]")

		saynn("[say=eliza]Всё в порядке, она мне не нужна.[/say]")

		saynn("[say=socket]А мне нужна! Придется сходить за другой.[/say]")

		saynn("Элиза улыбается и накрывает флешлайт крышкой, пряча в ней разбухшую от спермы киску, пока ты пытаешься восстановить дыхание.")

		saynn("[say=eliza]Спасибо за ваш донорский вклад, я сейчас же пойду всё это сдам~.[/say]")

		saynn("Ты киваешь...")

		saynn("Пора идти.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "socket_walks_in"):
		processTime(5*60)

	if(_action == "socket_tease"):
		processTime(3*60)

	if(_action == "socket_sex"):
		processTime(5*60)

	if(_action == "socket_faster"):
		processTime(5*60)

	if(_action == "process_cum"):
		processTime(3*60)
		amountCollected = GM.main.SCI.processMilkPlayerPenis()
		GM.pc.orgasmFrom("socket")
		GM.pc.fillBalls()
		getCharacter("socket").cummedInVaginaBy("pc")

	if(_action == "socket_gives_fleshlight_back"):
		processTime(3*60)
		getCharacter("socket").clearOrificeFluids()

	setState(_action)

func saveData():
	var data = .saveData()

	data["amountCollected"] = amountCollected

	return data

func loadData(data):
	.loadData(data)

	amountCollected = SAVE.loadVar(data, "amountCollected", 0.0)
