extends SceneBase

func _init():
	sceneID = "ElizaDrugTestHuCowScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("[say=pc]Почему бы не попробовать вот этот вариант? Тебе ведь нравится доить, правда?[/say]")

		saynn("Элиза приподнимает бровь.")

		saynn("[say=eliza]Обычно это делаю я.[/say]")

		saynn("[say=pc]И что? Тебе не нравится?[/say]")

		saynn("[say=eliza]Ну, нет, очевидно... лактация — это горячо...[/say]")

		saynn("Она опускает взгляд на свою грудь.")

		saynn("[say=eliza]Думаю, с моими сиськами и так всё в порядке.[/say]")

		saynn("[say=pc]Но они могли бы быть куда больше.[/say]")

		saynn("[say=eliza]Это же лишний вес. Мне нужно оставаться ловкой, я же кошка![/say]")

		saynn("Ты делаешь самый умоляющий вид, какой только можешь, а твои губы дрожат, будто ты вот-вот расплачешься прямо перед ней.")

		saynn("Элиза замечает это... и вздыхает.")

		saynn("[say=eliza]Попробовать не помешает. Я уже и забыла, разве у него нет других побочных эффектов?[/say]")

		saynn("[say=pc]Вроде бы нет... или всё-таки да?[/say]")

		saynn("Ты невинно отводишь взгляд.")

		saynn("Элиза кладет свежую таблетку на язык... и дает ей раствориться.")

		saynn("Вскоре начинает действовать.")

		saynn("Теплая волна проносится по телу Элизы. Ее спина выгибается, а синий топ внезапно становится ей слишком тесен, треща по швам.")

		saynn("[say=eliza]Ой...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "eliza_tfs")
	if(state == "eliza_tfs"):
		addCharacter("eliza", ["naked"])
		playAnimation(StageScene.TFLook, "breasts", {pc="eliza", bodyState={exposedChest=true, hard=true}})
		saynn("Ее грудь раздувается под тканью, становясь всё больше и больше, пока топ не разрывается в клочья!")

		saynn("[say=eliza]Не думала, что всё произойдет так быстро![/say]")

		saynn("Бюстгальтер всё еще держится... но ненадолго. С громким «ДЗЫНЬ» одна из застежек не выдерживает и отлетает, освобождая ее сочные груди.")

		saynn("[say=eliza]Ах! Мой топ![/say]")

		saynn("Пока её сиськи раздуваются вовне, остальное тело меняется, подстраиваясь под новый вес: она становится шире и фигуристее, задница выпячивается сильнее, а бёдра — массивнее.")

		saynn("У Элизы перехватывает дыхание, пока она пытается стоять смирно; её новая грудь колышется и подпрыгивает, соски твердеют и наливаются молоком. Тонкие струйки молока уже начинают стекать по её новым изгибам — грудь буквально переполняется этой жижей.")

		saynn("[say=eliza]Мммхх..[/say]")

		saynn("Она обхватывает свою грудь ладонями, ощущая её тяжесть.")

		saynn("[say=eliza]Такая тяжёлая.. хах..[/say]")

		saynn("Её ладошки слегка сжимают буфера, заставляя их брызгать молоком.")

		saynn("[say=eliza]Ах.. А это даже приятно.[/say]")

		saynn("Она прикусывает губу.")

		saynn("[say=pc]Тебе нужна синяя таблетка?[/say]")

		saynn("Её ушки навостряются в твою сторону.")

		saynn("[say=eliza]Ох.. ну.. э-э.. а что делает синяя?.. ммм.. неважно.. может, мы сможем..[/say]")

		saynn("Она слегка покачивает бедрами, выставляя напоказ свою огромную грудь.")

		saynn("[say=eliza]Нет.. О чем я думала.. до этого.. Кажется, о своей синей кофточке.. Почему-то мысли путаются.[/say]")

		saynn("[say=pc]Почему это?[/say]")

		saynn("Ее лапки продолжают сжимать и разминать грудь.")

		saynn("[say=eliza]Из-за этих.. огромных.. молочных.. сисек.. Они такие тяжелые.. соски прямо чешутся..[/say]")

		saynn("Она смотрит на тебя жадными глазами, а ее щеки заливает румянец.")

		saynn("[say=eliza]Может.. может, ты поможешь мне сцедить молоко?.. Пожалуйста.. мммм..[/say]")

		saynn("Бедная кошечка, совсем изголодалась по дойке.")

		saynn("[say=pc]Похоже, это займет несколько часов.[/say]")

		saynn("[say=eliza]Ну пожалуйста![/say]")

		saynn("Так. Ты задумываешься об этом на секунду.")

		saynn("[say=pc]Думаю, можно воспользоваться насосами. Пошли![/say]")

		saynn("Вы используете её амулет как импровизированный поводок, вытягивая её из лаборатории в сторону доильного зала. Медсестры во все глаза пялятся на сиськи Элизы.")

		saynn("[say=eliza]Здравствуйте... н-не обращайте на нас внимания...[/say]")

		addButton("Запереть её", "Подготовить Элизу к дойке", "lock_eliza_in")
	if(state == "lock_eliza_in"):
		playAnimation(StageScene.MilkingStallSolo, "milking", {pc="eliza", bodyState={naked=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"]]}})
		aimCameraAndSetLocName("med_milkingroom")
		saynn("Вы ведете Элизу к стойлам и заходите в то, что оборудовано установкой промышленных молочных насосов.")

		saynn("Мягко, но уверенно вы помогаете Элизе наклониться вперед, после чего пристегиваете её запястья к длинной трубе.")

		saynn("В таком положении её массивные груди свисают ниже грудной клетки, напоминая вымя.")

		saynn("[say=eliza]Дои меня... пожалуйста...[/say]")

		saynn("[say=pc]Одну минуту.[/say]")

		saynn("Убедившись, что она надежно закреплена, вы берете две присоски, соединенные гибкими трубками с большим молочным баком. Вы плотно прижимаете их к ареолам Элизы с характерным шипением, и лишний воздух тут же начинает откачиваться.")

		saynn("Вы щелкаете переключателем... и насосы оживают с низким гулом, чередуя мощные всасывания с медленным отпусканием.")

		saynn("[say=eliza]Ах~..[/say]")

		saynn("Молоко струится по прозрачным трубкам, когда грудь Элизы начинает вырабатывать... вырабатывать очень много. Каждое всасывание посылает разряды электрического удовольствия по её нервам. Её крупные, чувствительные соски пульсируют внутри чаш, выделяя множество мелких капель молока.")

		addButton("Продолжить", "Смотреть, что будет дальше", "milk_fast")
	if(state == "milk_fast"):
		playAnimation(StageScene.MilkingStallSolo, "fast", {pc="eliza", bodyState={naked=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"]]}})
		saynn("Дыхание Элизы становится рваным, спина непроизвольно выгибается, а ноги дрожат. Насосы продолжают чередовать яростное всасывание и мягкое отпускание, поддерживая ровный поток; молоко разбрызгивается о стенки чаш, прежде чем устремиться вниз по трубкам.")

		saynn("[say=eliza]Ах... ах... так хорошо... еще... е-е-еще...[/say]")

		saynn("Её стоны становятся громче и жарче. Каждый вдох — это шепот нужды. Вы рады, что вам не приходится делать это самому: насосы работают на полную катушку, и от каждого всасывания её титьки подпрыгивают и колышутся.")

		saynn("Стоять позади неё... это чертовски приятный вид. Её хвост оттянут в сторону, открывая доступ к её дырочкам, которые так же жаждут ласки, как и всё остальное тело, а сочная смазка стекает по внутренней стороне бёдер.")

		saynn("[say=eliza]Я сейчас с-с кончу... ах... бля... я сейчас...[/say]")

		saynn("Ноги Элизы трясутся, кулаки сжимаются... И вдруг, без предупреждения, насосы усиливают натиск, с дополнительным давлением втягивая соски девушки. Накал становится невыносимым...")

		addButton("Продолжить", "Смотри, как она кончает", "eliza_cums")
	if(state == "eliza_cums"):
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc="eliza", bodyState={naked=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"]]}})
		saynn("[say=eliza]Му-у-у~...[/say]")

		saynn("Из пасти кошечки вырывается милый животный звук, когда по её телу начинает разливаться прилив наслаждения. Она сильно извивается, а её соски выстреливают мощными струями молока прямо в стаканы, едва не перегружая систему.")

		saynn("Маленькие гейзеры белой кремовой жидкости брызжут из её набухших сосков, пока моторы насосов гудят, жадно высасывая каждую каплю.")

		saynn("[say=eliza]Муу.. муу-у~..[/say]")

		saynn("Стоны Элизы эхом разносятся по кабинке; её ноги подкашиваются, бедра дрожат, а по телу проходят волны послевкусия. Насосы продолжают работать, механическим давлением жадно вытягивая остатки молока из её вымени.")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_milking")
	if(state == "after_milking"):
		playAnimation(StageScene.MilkingStallSolo, "milking", {pc="eliza", bodyState={naked=true, hard=true, chains=[["hoseshort", "breastpump", "scene", "milktank"]]}})
		saynn("Когда Элиза приходит в себя после пика, она тяжело дышит; её вымя стало чуть менее объемным, но всё еще выглядит тяжелым.")

		saynn("Вы выключаете насосы, давая ей отдохнуть.")

		saynn("[say=eliza]..ммм.. хх-ххаа.. ах..[/say]")

		saynn("[say=pc]Приятно было, да?[/say]")

		saynn("[say=eliza]Даа..[/say]")

		saynn("[say=pc]Хорошая коровка.[/say]")

		saynn("[say=eliza]Муу~..[/say]")

		saynn("Вы даете ей перевести дух, прежде чем приступить к снятию помп и разблокировке фиксаторов.")

		addButton("Лаборатория", "Вернуться в лабораторию вместе с ней", "back_to_the_lab")
	if(state == "back_to_the_lab"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcBodyState={exposedChest=true}})
		saynn("Вы возвращаете Элизу в лабораторию.")

		saynn("[say=pc]Хочешь так и остаться?[/say]")

		saynn("Она довольно мычит, не отрывая взгляда от своих огромных сисек.")

		saynn("[say=eliza]Они классные... но... за ними нужен постоянный уход. Ну, ты понимаешь...[/say]")

		saynn("[say=pc]Дойка.[/say]")

		saynn("[say=eliza]Ага. Если бы я не была врачом, я бы, наверное, осталась молочной коровкой... почему бы и нет...[/say]")

		saynn("Она находит синюю таблетку и проглатывает её.")

		saynn("Её пышные формы начинают терять свою внушительность, постепенно уменьшаясь в объёме. Вымя больше не свисает так сильно, постепенно возвращаясь к обычным размерам Элизы.")

		saynn("[say=eliza]Ах.. так гораздо лучше.[/say]")

		saynn("С упругих сосков всё ещё капает молоко.")

		saynn("[say=eliza]Похоже, теперь у меня еще и лактация будет какое-то время... Бесплатное молоко для кофе, ха![/say]")

		saynn("Вы киваете и провожаете взглядом Элизу, возвращающуюся на своё место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "eliza_tfs"):
		processTime(3*60)
		setFlag("ElizaModule.elizatf_body", "hucow")
		getCharacter("eliza").updateBodyparts()
		getCharacter("eliza").induceLactation()
		getCharacter("eliza").fillBreasts()
		getCharacter("eliza").fillBreasts()

	if(_action == "lock_eliza_in"):
		processTime(5*60)
		var thePump = GlobalRegistry.createItem("BreastPump")
		var theFluids = thePump.getFluids()
		theFluids.addFluid("Milk", 400.0)
		getCharacter("eliza").getInventory().forceEquipStoreOtherUnlessRestraint(thePump)

	if(_action == "milk_fast"):
		processTime(5*60)
		var thePump = getCharacter("eliza").getInventory().getEquippedItem(InventorySlot.UnderwearTop)
		if(thePump):
			var theFluids = thePump.getFluids()
			if(theFluids):
				theFluids.addFluid("Milk", 1200.0)

	if(_action == "eliza_cums"):
		processTime(3*60)
		var thePump = getCharacter("eliza").getInventory().getEquippedItem(InventorySlot.UnderwearTop)
		if(thePump):
			var theFluids = thePump.getFluids()
			if(theFluids):
				theFluids.addFluid("Milk", 8200.0)
		GM.main.SCI.processMilkCharacterCustom(getCharacter("eliza"), BodypartSlot.Breasts)

	if(_action == "after_milking"):
		processTime(3*60)

	if(_action == "back_to_the_lab"):
		processTime(3*60)
		getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearTop)
		setFlag("ElizaModule.elizatf_body", "")
		getCharacter("eliza").updateBodyparts()
		if(!getFlag("ElizaModule.tfcan_hucow", false)):
			setFlag("ElizaModule.tfcan_hucow", true)
			addMessage("Элиза может отрастить огромные вымя, если ты ей прикажешь.")

	setState(_action)
