extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter
var npc2ID = ""
var npc2:DynamicCharacter
var whoStr = "inmate"
var npcVariation = "mean"

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

#func _reactInit():
#	processTime(10*60)
#	npc.afterTakingAShower()
#
#	var npcSlavery:NpcSlave = npc.getNpcSlavery()
#	if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
#		npcSlavery.getActivity().satisfyWant("pee")

func _reactInit():
	if(RNG.chance(50)):
		npc2ID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Guards, [], GuardGenerator.new(), {})
		whoStr = "guard"
	else:
		npc2ID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {})
		whoStr = "inmate"
	if(npc2ID == null || npc2ID == ""):
		addMessage("Не удалось найти подходящего NPC :(")
		endScene()
		return
	npc2 = getCharacter(npc2ID)
	addCharacter(npc2ID)
	
	var personality:Personality = npc2.getPersonality()
	
	var biggestStat = PersonalityStat.Mean
	var biggestStatNum = personality.getStat(PersonalityStat.Mean)
	var lowestStat = PersonalityStat.Mean
	var lowestStatNum = personality.getStat(PersonalityStat.Mean)
	var statsToCheck = [PersonalityStat.Subby, PersonalityStat.Coward]
	for theStat in statsToCheck:
		var theValue = personality.getStat(theStat)
		if(theValue > biggestStatNum):
			biggestStatNum = theValue
			biggestStat = theStat
		if(theValue < lowestStatNum):
			lowestStatNum = theValue
			lowestStat = theStat
	
	if(biggestStatNum > (-lowestStatNum)):
		#Big stat
		if(biggestStat == PersonalityStat.Mean):
			npcVariation = "mean"
		if(biggestStat == PersonalityStat.Subby):
			npcVariation = RNG.pick(["kind", "subby"])
		if(biggestStat == PersonalityStat.Coward):
			npcVariation = RNG.pick(["kind", "subby"])
	else:
		#Low stat
		if(lowestStat == PersonalityStat.Mean):
			npcVariation = "kind"
		if(lowestStat == PersonalityStat.Subby):
			npcVariation = RNG.pick(["kind", "mean"])
		if(lowestStat == PersonalityStat.Coward):
			npcVariation = "mean"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID
	if(_charID == "npc2"):
		return npc2ID

func _init():
	sceneID = "SlaveryPetWalkiesAskPat"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=npcID, npcBodyState={naked=true}})

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		saynn("Пока вы гуляете со своим щеночком по станции, вы натыкаетесь на одного из "+str(whoStr)+"s.")
		
		if(npcVariation == "kind"):
			saynn("[say=npc2]"+RNG.pick([
				"Ой, какой у тебя милый щеночек.",
				"Какой прелестный щенок!",
				"Ну что за милашка!",
				"Вижу милашку на поводке.",
				"О, вижу щенка на прогулке, ха!",
				"Ого, какой милый песик.",
			])+"[/say]")
			
			saynn("На "+whoStr+"'s глаза загораются от восторга.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Не возражаешь, если я поглажу {npc.him}?",
				"Можно мне погладить {npc.him}?",
				"Так и хочется погладить!",
			])+"[/say]")
			
			addButton("Конечно", "Позволить им погладить щенка", "let_pat")
			addButton("No", "Никаких поглаживаний", "no_pat")
		if(npcVariation == "mean"):
			saynn("[say=npc2]"+RNG.pick([
				"Тебе реально обязательно выгуливать свою тупую псину здесь?",
				"Эй, я вообще-то тут иду!",
				"Свали с дороги.",
				"Лучше контролируй своего питомца.",
			])+"[/say]")
			
			saynn("На "+whoStr+"'s хмурит {npc.his} брови.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Не нюхай меня.",
				"Не смотри на меня, тупая собака.",
				"Какого хера тебе надо? Отъебись.",
				"Проваливай, пока я не наступила на твою дворнягу.",
			])+"[/say]")
			
			addButton("Кусь!", "Приказать питомцу укусить их", "make_bite")
			addButton("Уйти", "Вы не хотите навлекать на себя неприятности", "do_mean_leave")
		if(npcVariation == "subby"):
			saynn("[say=npc2]"+RNG.pick([
				"Ой... Какой милый щеночек.",
				"Ооо...",
				"Ого. Не обращай на меня внимания...",
				"Щеночек!",
			])+"[/say]")
			
			saynn("На "+whoStr+"'s слегка краснеет.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Эх, вот если бы и меня так на поводке держали... {npc.he} кусается?",
				"Обожаю гулять на поводке. {npc.he} кусается?",
				"Я вовсе не пускаю слюни!.. {npc.he} кусается?",
			])+"[/say]")
			
			addButton("Дать лапу", "Приказать питомцу дать им лапу", "make_subby_paw")
			addButton("Игриво прикусить", "Приказать питомцу укусить их", "make_subby_bite")
			addButton("Уйти", "Просто пройти мимо", "endthescene")
			if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
				addButton("Лизать", "Приказать питомцу лизать им промежность", "make_subby_lick")
			else:
				addDisabledButton("Лизать", "Требуется навык питомца A или выше")

	if(state == "make_subby_lick"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npcAction="sit", npc=npcID, npcBodyState={naked=true}})
		
		saynn("[say=pc]Не, {npc.he} может кое-что получше.[/say]")
		
		saynn("Вы указываете на "+whoStr+" и прикажи своему щеночку.")
		
		saynn("[say=pc]Лизать.[/say]")
		
		saynn("Твой щеночек послушно ползет к {npc2.him}, а затем садится и начинает тыкаться носом в промежность {npc2.his}.")
		
		if(npc2.hasReachablePenis() || npc2.isWearingChastityCage()):
			saynn("Но это еще не всё: твой щеночек еще и высовывает {npc.his} язык, проводя им по {npc2.his} {npc2.penis}"+(" сквозь одежду." if !npc2.isFullyNaked() else "."))
		elif(npc2.hasReachableVagina()):
			saynn("Но это еще не всё: твой щеночек еще и высовывает {npc.his} язык, проводя им по {npc2.his} {npc2.pussyStretch} киске"+(" сквозь одежду." if !npc2.isFullyNaked() else "."))
		else:
			saynn("Но это еще не всё: твой щеночек еще и высовывает {npc.his} язык, проводя им по ней"+(" сквозь одежду." if !npc2.isFullyNaked() else "."))
		
		saynn("[say=npc2]"+RNG.pick([
			"Ты хорошо натренировал(а) {npc.him}...",
			"Хороший щеночек...",
		])+"[/say]")
		
		saynn("За это твой щеночек получает много поглаживаний по голове.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "make_subby_paw"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npcAction="paw", npc=npcID, npcBodyState={naked=true}})

		saynn("[say=pc]Нет, {npc.he} не делает этого.[/say]")

		saynn("Ты отдаешь приказ своему щеночку.")
		
		saynn("[say=pc]Дай лапу, {npc2.him}, малыш.[/say]")
		
		saynn("Твой питомец слушается, садится и протягивает {npc.his} лапу тебе"+whoStr+". {npc2.He} трясет ею.")
		
		saynn("[say=npc2]"+RNG.pick([
			"Ты отлично обучил(а) {npc.him}...",
			"Хороший щеночек...",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "make_subby_bite"):
		playAnimation(StageScene.PuppySexOral, "tease", {pc=npc2ID, npc=npcID, npcBodyState={naked=true}})
	
		saynn("[say=pc]{npc.He} может. Но тебе не стоит бояться.[/say]")
		
		saynn("Вы отдаете приказ своему щеночку ласковым голосом.")
		
		saynn("[say=pc]Покажи, {npc2.him} как ты умеешь кусаться, щенок.[/say]")
		
		saynn("Твой питомец послушно подползает к "+whoStr+", который приседает. {npc.Name} открывает {npc.his} рот... и начинает покусывать руку "+whoStr+", выглядит довольно мило.")
		
		saynn("[say=npc2]"+RNG.pick([
			"Охх, щекотно..",
			"Хороший щеночек...",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "do_mean_leave"):
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Ты решаешь, что оно того не стоит... и просто уходишь.")
		
		saynn("[say=npc2]"+RNG.pick([
			"Вот так, брысь отсюда.",
			"Да, вали уже.",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "make_bite_won"):
		playAnimation(StageScene.PuppyDuo, "defeat", {pc=npc2ID, npc=npcID, npcBodyState={naked=true}})
		
		saynn("Вы указываете на "+whoStr+"и отдай приказ своему питомцу!")
		
		saynn("[say=pc]Кусай![/say]")
		
		saynn("Твой щенок замечает врага и начинает ползти к {npc2.him}, со стороны {npc.him} слышится жуткое рычание!"+whoStr+"видит это и посмеивается... пока {npc2.his} лодыжку не кусают! А следом и вторую!")
		
		saynn("На "+whoStr+"кряхтит и падает на {npc2.his} колени перед твоим щенком... И прежде чем {npc2.he} успевает встать, {npc2.he} получает крепкий удар лбом!")
		
		saynn("[say=npc2]"+RNG.pick([
			"Аргх.. Блять! Тупая псина!",
			"Я сдаюсь. Держи свою дурацкую собаку подальше!",
			"Ладно, плевать, проваливай.",
		])+"[/say]")
		
		if(OPTIONS.isContentEnabled(ContentType.Watersports)):
			saynn("Ты посмеиваешься, глядя, как твой щенок метит поверженного врага — это становится последним актом полного унижения.")
		else:
			saynn("Вы посмеиваетесь, пока ваш щенок слегка бодает поверженного врага — в качестве финального акта полного унижения.")
		
		saynn("[say=npc2]"+RNG.pick([
			"ЭЙ! Нет! Плохая!",
			"Прекрати, мелкий засранец!",
			"Какого хуя?!",
		])+"[/say]")
		
		saynn("Вы гладите своего щеночка и продолжаете свой путь.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "make_bite_fail"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=npcID, npcAction="sad", npcBodyState={naked=true}})
		
		saynn("Вы указываете на "+whoStr+"и отдай приказ своему питомцу!")
		
		saynn("[say=pc]Кусай![/say]")
		
		saynn("Твой щеночек видит врага... и, к сожалению, слишком пугается, чтобы укусить {npc2.him}. Вместо этого, {npc.he} плюхается на пол и скулит, прикрывая {npc.himself} своими {npc.his} лапами. Похоже, {npc.he} всё ещё не помешало бы немного потренироваться...")
		
		saynn("[say=npc2]"+RNG.pick([
			"Пфф. Жалкое зрелище.",
			"Хах. Даже свою шлюшковатую сучку толком дрессировать не смогла.",
			"Укуси меня? Твой щенок знает, как надо.",
		])+"[/say]")
		
		saynn("Похоже, назревает драка...")
		
		addButton("Драться", "Вместо этого тебе придётся их кусать", "mean_start_fight")
		
	if(state == "let_pat"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		playAnimation(StageScene.PuppySexOral, "tease", {pc=npc2ID, npc=npcID, npcBodyState={naked=true, hard=true}})
		
		saynn("Вы киваете, позволяя {npc2.him} сделать это.")
		
		saynn("Ваш щенок с энтузиазмом виляет {npc.his} хвостом, когда "+whoStr+" гладит {npc.him}.")
		
		saynn("[say=npc2]"+RNG.pick([
			"Кто у нас хороший песик?",
			"Кто у нас хорошая {npc.boy}?",
			"Прелестный, драгоценный щеночек.",
			"Посмотри на себя, какая милашка.",
		])+"[/say]")
		
		saynn("Ваш питомец игриво лает в ответ.")
		
		if(RNG.chance(40) && npc2.hasReachablePenis() && !npc.isOralBlocked()):
			saynn("[say=npc2]"+RNG.pick([
				"Эх, жаль, что я не могу проверить твою маленькую пасть на деле.",
				"Интересно, как ловко ты умеешь грызть косточку.",
			])+"[/say]")
			
			addButton("Просто уйти", "Смотреть, что будет дальше", "endthescene")
			if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
				addButton("Позволить им", "Дать им немного повеселиться с вашим питомцем", "let_pat_suck")
			else:
				addDisabledButton("Позволить им", "Требуется навык «Ласка» уровня B- или выше")
		elif(RNG.chance(40) && npc2.hasReachableVagina() && !npc.isOralBlocked()):
			saynn("[say=npc2]"+RNG.pick([
				"Интересно, как хорошо ты умеешь лизать.",
			])+"[/say]")
			
			addButton("Просто уйти", "Смотреть, что будет дальше", "endthescene")
			if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
				addButton("Позволить им", "Дать им немного повеселиться с вашим питомцем", "let_pat_lick")
			else:
				addDisabledButton("Позволить им", "Требуется навык «Ласка» уровня B- или выше")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "let_pat_suck_inside"):
		playAnimation(StageScene.PuppySexOral, "sex", {pc=npc2ID, npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		saynn("Ты киваешь, позволяя {npc2.him} немного развлечься с твоим питомцем.")
		
		saynn("Ваш щеночек послушно разевает {npc.his} пасть и позволяет"+whoStr+"блядь, ебашь сырым.. прежде чем проглотить всю порцию целиком.")
	
		saynn("[say=npc2]"+RNG.pick([
			"О да, хорошая шлюшковатая зверушка.",
			"Глотай всё до капли, милашка.",
			"Вот так. Какой славный ротик.",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "let_pat_suck_outside"):
		playAnimation(StageScene.PuppySexOral, "sex", {pc=npc2ID, npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		saynn("Ты киваешь, позволяя {npc2.him} немного развлечься с твоим питомцем.")
		
		saynn("Твой щеночек послушно разевает {npc.his} пасть и позволяет..."+whoStr+"да в рот его ебать, прямо так.. прежде чем принять липкий груз на лицо {npc.his}.")
	
		saynn("[say=npc2]"+RNG.pick([
			"Наслаждайся грязью, щенок.",
			"Тебе ведь нравится сперма, правда?",
			"Ой, пометил тебя своей кончой.",
			"Можешь слизать её, если хочешь.",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "let_pat_lick"):
		playAnimation(StageScene.PuppySexOral, "grind", {pc=npc2ID, npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		saynn("Ты киваешь, позволяя {npc2.him} немного развлечься с твоим питомцем.")
		
		saynn("Твой щеночек послушно размыкает {npc.his} губы и высовывает {npc.his} язык, позволяя"+whoStr+"прижми {npc2.his} {npc2.pussyStretch} к нему. {npc2.He} втирается в морду твоего щенка... заливая {npc.his} лицо фонтаном смазки.")
	
		saynn("[say=npc2]"+RNG.pick([
			"Наслаждайся грязью, щенок.",
			"Было приятно, спасибо, щенок.",
			"Ой, я тебя пометил.",
			"А у тебя классный язычок, щеночек.",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "no_pat"):
		playAnimation(StageScene.Duo, "stand", {npc=npc2ID})
		
		saynn("[say=pc]{npc.He} {npc.isAre} сегодня не в настроении для незнакомцев.[/say]")
		
		saynn("На "+whoStr+" слегка хмурится.")
		
		saynn("[say=npc2]Понятно. Ну, что ж.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "won_mean_fight"):
		playAnimation(StageScene.Duo, "stand", {npc=npc2ID, npcAction="defeat"})
		
		saynn("Черт возьми, "+whoStr+" валится на пол, не в силах продолжать бой.")
		
		saynn("[say=npc2]"+RNG.pick([
			"Аргх. Твою мать.",
			"Да пошел ты.",
		])+"[/say]")
		
		saynn("Похоже, твой щенок стал доверять тебе чуть больше после этого.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "lost_mean_fight"):
		playAnimation(StageScene.Duo, "defeat", {npc=npc2ID})
		
		saynn("Блядь. Ты валишься на пол, не в силах продолжать бой.")
		
		saynn("[say=npc2]"+RNG.pick([
			"А теперь хватай свою псину и вали нахер отсюда.",
			"Свали, пока я твою тупую собаку тоже не отлупила.",
		])+"[/say]")
		
		saynn("Похоже, твой щенок стал доверять тебе чуть меньше после этого.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "let_pat"):
		processTime(5*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.getActivity().onPat()
		#return
	
	if(_action == "let_pat_suck"):
		processTime(5*60)
		if(RNG.chance(50)):
			npc.cummedInMouthBy(npc2ID)
			npc.gotThroatFuckedBy(npc2ID)
			setState("let_pat_suck_inside")
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
				npcSlavery.getActivity().satisfyWant("food")
		else:
			npc.cummedOnBy(npc2ID)
			npc.gotThroatFuckedBy(npc2ID)
			setState("let_pat_suck_outside")
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
				npcSlavery.getActivity().satisfyWant("shower")
		return
	
	if(_action == "let_pat_lick"):
		processTime(5*60)
		npc.cummedOnBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.5))
		npc.cummedInMouthBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.7))
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")
			npcSlavery.getActivity().satisfyWant("shower")
			
	if(_action == "make_bite"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		var winChance = npcSlavery.getSlaveSkill(SlaveType.Pet) * 10
		if(!RNG.chance(winChance)):
			setState("make_bite_fail")
		else:
			setState("make_bite_won")
			npcSlavery.getActivity().onPat()
			npcSlavery.getActivity().satisfyWant("play")
			npcSlavery.getActivity().satisfyWant("train")
			npcSlavery.getActivity().satisfyWant("pee")
		return
		
	if(_action == "mean_start_fight"):
		runScene("FightScene", [npc2ID], "fight_mean")
		return
		
	if(_action == "make_subby_paw"):
		processTime(3*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.getActivity().satisfyWant("train")
		
	if(_action == "make_subby_bite"):
		processTime(3*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.getActivity().satisfyWant("play")
	
	if(_action == "make_subby_lick"):
		processTime(3*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.getActivity().onPat()
		
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "fight_mean"):
		processTime(10 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_mean_fight")
			addExperienceToPlayer(10)
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			npcSlavery.addTrust(0.03)
		else:
			setState("lost_mean_fight")
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			npcSlavery.addTrust(-0.05)

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npc2ID"] = npc2ID
	data["whoStr"] = whoStr
	data["npcVariation"] = npcVariation

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	
	npc2ID = SAVE.loadVar(data, "npc2ID", "")
	npc2 = GlobalRegistry.getCharacter(npc2ID)
	whoStr = SAVE.loadVar(data, "whoStr", "")
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
