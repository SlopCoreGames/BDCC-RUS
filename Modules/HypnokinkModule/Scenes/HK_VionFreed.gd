extends SceneBase

func _init():
	sceneID = "VionFreed"

func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "stand", {npc="vion"})
		saynn("Ты выхватываешь у лисички датапад и быстро пролистываешь предустановленные им диагностические инструменты.")
		saynn("[say=vion]Ты что задумал?[/say]")
		saynn("[say=pc]А вот это сюрприз~[/say]")
		saynn("Алекс говорил, что справится и без этих инструментов всего за час. Уверена, с ними ты и вовсе уложишься в это время?")

		addButton("Взлом", "Да насколько это может быть сложно?", "hack_cage")
		
	if(state == "hack_fail"):
		saynn("Раздраженно фыркнув, ты решаешь пока оставить попытки.")
		saynn("[say=vion]Всё в порядке?[/say]")
		saynn("[say=pc]Да нет, всё норм. Просто оказалось чуть сложнее, чем я думал.[/say]")
		saynn("[say=vion]Ну, что бы ты там ни задумал, уверена — ты со всем разберешься.[/say]")
		
		addButton("Уйти", "В следующий раз получится лучше.", "hack_fail_after")

	if(state == "hack_succeed"):
		saynn("Ну, было не так уж плохо. Ты с пафосом кликаешь по кнопке подтверждения.")
		saynn("*клик*")
		saynn("И твои глаза, и глаза Виона словно примагнитились к его паху. Всего через мгновение там начинает проступать щупальце.")
		saynn("[say=vion]Ты это сейчас что, реально...[/say]")
		saynn("[say=pc]Ага. Поблагодаришь меня позже.[/say]")
		saynn("[say=vion]...Я могу поблагодарить тебя [i]прямо сейчас[/i].[/say]")
		saynn("Почти животная ярость в его голосе слегка застает тебя врасплох.")
		saynn("[say=vion]Если только ты не против, в таком случае советую тебе покинуть камеру на ближайшие пару часов.[/say]")

		addButton("Вылезти", "Похоже, это твой сигнал к выходу.", "bail")
		addButton("Продержаться до конца", "Как это — упустить такую выгоду?", "ride_it_out")

	if(state == "bail"):
		saynn("[say=pc]Ну, оставляю вас. Веселитесь![/say]")
		saynn("[say=vion]О, еще как![/say]")

		saynn("Сначала ты не забываешь прихватить клетку, а затем выбираешься наружу, а Вион буквально дышит тебе в спину. Он наклоняется и машет пролетающему мимо рыси.")
		saynn("[say=vion]Эй! Не хочешь трахнуться?[/say]")
		saynn("Рысь едва успевает подтвердить свое согласие, как Вион хватает его за шиворот и затаскивает внутрь. Ты решаешь дать им немного уединения и поспешно ретируешься, хотя и не успеваешь уйти достаточно тихо, чтобы не услышать за спиной весьма возбужденные звуки.")

		addButton("Уйти", "", "endthescene")

	if(state == "ride_it_out"):
		saynn("[say=pc]Нет, я только «за». Так мы должны...[/say]")
		saynn("Тебя прерывает Вион: он грубо хватает тебя за воротник и притягивает к себе. Почти соприкасаясь носами, он пристально смотрит тебе прямо в глаза.")
		saynn("[say=vion][b]Сон.[/b][/say]")
		saynn("Власть приказа неоспорима. Твои мысли разлетаются на миллион осколков, колени слабеют, и ты [i]падаешь[/i].")
		saynn("[say=vion]И [b]преклоняешь колени.[/b][/say]")
		
		addButton("Встать на колени", "", "sex_1")

	if(state == "sex_1"):
		playAnimation(StageScene.SexOral, "fast", {npc="pc", pc="vion", bodyState={exposedCrotch=true, hard=true}})
		saynn("Ты опускаешься перед ним на колени, безмолвная и послушная, а в глазах всё плывет.")
		saynn("Ты подавлена, затерянная в туманной дымке, лишь отдаленно осознавая происходящее.")
		
		addButton("Подчиниться", "", "sex_2")

	if(state == "sex_2"):
		playAnimation(StageScene.SexStanding, "fast", {npc="pc", pc="vion", bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true}})	
		saynn("В какой-то момент с тебя срывают одежду.")
		saynn("Вион изо всех сил старается наверстать упущенное время, используя твое тело как инструмент для своего облегчения. Твой разум лишь пассивно наблюдает за процессом.")

		addButton("Повиноваться", "", "sex_3")
		
	if(state == "sex_3"):
		playAnimation(StageScene.SexMissionary, "sex", {npc="pc", pc="vion", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true}})
		saynn("Твое тело испытывает чистое, концентрированное наслаждение и блаженство.")
		saynn("Твой разум дрейфует в туманном, бездумном, покорном трансе; мысли затихли, а воля подавлена.")
		
		addButton("Служить", "", "sex_4")

	if(state == "sex_4"):
		playAnimation(StageScene.SexAllFours, "fastflop", {npc="pc", pc="vion", npcCum=true, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true}})
		saynn("Детали стерлись из памяти — ты слишком поглощен удовольствием, чтобы помнить о чем-то еще.")
		saynn("Единственная мысль, которую тебе удается удержать в голове... [i]оно[/i] того стоило.")	
		
		addButton("...", "", "sex_after")

	if(state == "sex_after"):
		playAnimation(StageScene.Sleeping, "sleep", {npc="vion", pc="pc", bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("Несколько часов спустя...")
		
		saynn("[say=vion]Эй. Эй, {pc.name}.[/say]")
		saynn("[say=pc]Ммм?[/say]")
		saynn("[say=vion]Надеюсь, не слишком сильно тебя накрыло? Ты еще здесь?[/say]")
		saynn("Тебе удается что-то невнятно пробормотать в ответ.")
		saynn("[say=pc]Ннх. Я... я в нор-р-ме.[/say]")
		saynn("[say=vion]Ну, это хорошо. Надеюсь, ты не против, если я немного посплю?[/say]")
		saynn("[say=pc]Ннн-а, всё... путём.[/say]")
		
		addButton("Встать", "", "get_up")
		
	if(state == "get_up"):
		playAnimation(StageScene.Solo, "stand", {pc="pc", bodyState={naked=true}})
		saynn("Ты медленно высвобождаешься из объятий Виона. По мере того как сознание постепенно возвращается, ты вспоминаешь, что нужно забрать его клетку. Он её точно не заметит. И лишь когда ты, спотыкаясь, выходишь из его камеры, до тебя доходит, что тебе, пожалуй, стоит одеться.")
		addButton("Уйти", "", "endthescene")

func _react_scene_end(_tag, _result):
	if(_tag == "computerhack"):
		if(_result[0] == true):
			setState("hack_succeed")
			setFlag("HypnokinkModule.Vion_FreedFromCage", true)
			setFlag("HypnokinkModule.VionTopicKnown_Backstory", true) # in case didnt see this yet somehow
		else:
			setState("hack_fail")
		
func _react(_action: String, _args):
	if(_action == "hack_cage"):
		runScene("ComputerSimScene", ["DatapadHackComputer"], "computerhack")
	
	if(_action == "ride_it_out"):
		GM.pc.addLust(80)
		
	if(_action == "sex_1"):
		GM.pc.addLust(20)
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		
	if(_action == "sex_2"):
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		
	if(_action == "sex_2"):
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		processTime(30 * 60)
		GM.pc.cummedInMouthBy("vion")
		
	if(_action == "sex_3"):
		GM.pc.orgasmFrom("vion")
		GM.pc.addLust(100)
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		processTime(30 * 60)
		if(GM.pc.hasReachableAnus()):
			GM.pc.cummedInAnusBy("vion")
		elif(GM.pc.hasReachableVagina()):
			GM.pc.cummedInVaginaBy("vion")
		else:
			GM.pc.cummedOnBy("vion")
			
	if(_action == "sex_4"):
		GM.pc.orgasmFrom("vion")
		GM.pc.addLust(100)
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		processTime(30 * 60)
		if(GM.pc.hasReachableVagina()):
			GM.pc.cummedInVaginaBy("vion")
		elif(GM.pc.hasReachableAnus()):
			GM.pc.cummedInAnusBy("vion")
		else:
			GM.pc.cummedOnBy("vion")
		
	if(_action == "sex_after"):
		GM.pc.addLust(-80)
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 75)
		processTime(30 * 60)
		GM.pc.cummedOnBy("vion")
		
	if(_action == "get_up"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, -125)
		HypnokinkUtil.raiseSuggestibilityTo(GM.pc, 30)
		
	if(_action == "hack_fail_after"):
		runScene("VionRepeatConversation")
		endScene()
		return
		
	if(_action == "endthescene"):
		setFlag("HypnokinkModule.Vion_HaveDatapad", false)
		setFlag("HypnokinkModule.Vion_HaveCage", true)
		endScene()
		return

	setState(_action)
