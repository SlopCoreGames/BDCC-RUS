extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""

func _init():
	sceneID = "HypnoEncounterStart"

func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	if(npc.getFlag(CharacterFlag.Introduced)):
		sawBefore = true
	else:
		npc.setFlag(CharacterFlag.Introduced, true)
	
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcVariation = "mean"
	if(personality.getStat(PersonalityStat.Mean) < -0.3):
		npcVariation = "kind"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcVariation = "subby"
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

	if(state == ""):
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn(RNG.pick([
				"Звук щелчка пальцев заставляет вас замереть на месте. Вы оборачиваетесь на звук и видите перед собой заключенную, застывшую в властной позе.",
			]))

			# (if never met)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"Вот так, всё внимание на меня.",
					"Теперь ты в моей власти.",
					"Готов(а) повиноваться?",
					"Пора поиграть~",
				])+"[/say]")

			# (if met before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"Вот так, всё внимание на меня.",
					"Теперь ты в моей власти.",
					"Готов(а) повиноваться?",
					"Пора поиграть~",
				])+"[/say]")
				
			saynn("Не то чтобы ты была обязана, но прошлый гипнотический опыт заставляет тебя поддаться. Тебе стоит...")
				
			HypnokinkUtil.addHypnoButtons(self, "submit", "decline", [], ["Decline"])
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn(RNG.pick([
				"Заключенная прижимает вас к стене и пристально заглядывает в глаза. Вы пытаетесь вырваться, но ваше внимание уже полностью захвачено.",
			]))

			# (if never saw or saw)
			saynn("[say=npc]"+RNG.pick([
				"Угадай что, сучка? Теперь ты моя.",
				"Вот она, та самая игрушка, о которой столько говорили.",
				"Тихо. Пора подчиняться.",
				"Не трать силы на брыкания.",
			])+"[/say]")

			saynn("Не то чтобы ты была обязана, но прошлый гипнотический опыт заставляет тебя поддаться. Тебе стоит...")
			
			HypnokinkUtil.addHypnoButtons(self, "submit", "attack", [], ["Fight"])

		# (kind version)
		if(npcVariation == "kind"):
			saynn(RNG.pick([
				"Одна из заключенных машет тебе рукой. Ты узнаешь этот взгляд — похоже, она наслышана о твоих опытах с гипнозом.",
			]))
			
			# (if never met)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"Эй, привет. Хочешь поиграть?",
					"Хочешь, я прокручу твой податливый разум?",
					"Не желаешь провести немного времени в трансе?",
				])+"[/say]")
			
		# (if met before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"Эй, привет. Хочешь поиграть?",
					"Хочешь, я прокручу твой податливый разум?",
					"Не желаешь провести немного времени в трансе?",
				])+"[/say]")
				
			saynn("Не то чтобы ты была обязана, но прошлый гипнотический опыт заставляет тебя поддаться. Тебе стоит...")
			
			HypnokinkUtil.addHypnoButtons(self, "submit", "decline", [], ["Decline"])
			
		# (subby version)
		if(npcVariation == "subby"):
			saynn(RNG.pick([
				"Кажется, одна из заключенных идет в ту же сторону. Более того, {npc.he} подстраивается под твой шаг, держась чуть впереди и нарочито виляя {npc.his} бедрами, чтобы привлечь твое внимание. Это срабатывает безотказно: ты завороженно наблюдаешь, как {npc.him} виляет {npc.his} задом...\n\nТуда-сюда...\n\nТвой шаг замедляется, и ты замираешь, когда {npc.he} {npc.verb('turn')} к тебе лицом.",
			]))

			# (if never saw)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"Хи-хи, это было слишком просто!",
					"Ты же знаешь, что хочешь меня...",
					"Работает каждый раз.",
				])+"[/say]")

			# (if saw before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"Хи-хи, это было слишком просто!",
					"Ты же знаешь, что хочешь меня...",
					"Работает каждый раз.",
				])+"[/say]")
				
			saynn("Не то чтобы ты была обязана, но прошлый гипнотический опыт заставляет тебя поддаться. Тебе стоит...")

			HypnokinkUtil.addHypnoButtons(self, "submit", "decline", [], ["Decline"])
			
			# (OPTIONS ARE)
			# (if normal = Play along, resist nonviolently)
			# (if mean = Play along, resist violently)
			# (if kind = Agree, Decline)
			# (if subby = Play along, Decline)


	if(state == "attack"):
		saynn("Ты отмахиваешься от наваждения и отталкиваешь {npc.him} от себя. Заключенная рычит и вскакивает, готовая к драке.")

		saynn("[say=npc]"+RNG.pick([
			"Большая ошибка, сучка.",
			"Для тебя это плохо кончится, сучка.",
			"Ты об этом пожалеешь.",
			"Ладно. Я сломаю тебя по старинке."
		])+"[/say]")

		addButton("Драться", "Начать бой", "startfight")


	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		# (default)
		if(npcVariation != "mean"):
			saynn("[say=npc]Ты что, думал, всё будет иначе?[/say]")

		# (if mean)
		else:
			saynn("[say=npc]Знай своё место, сучка.[/say]")

		saynn("Поскольку {npc.him} больше не может по-настоящему сопротивляться, у тебя остается только один выбор — подчиниться.")

		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")

	if(state == "if_won"):
		saynn("Ты прижимаешь побежденного заключенного к полу. {npc.He} особо не сопротивляется.")

		saynn("[say=npc]"+RNG.pick([
			"Иди нахуй.",
			"Слезь с меня, шлюха.",
			"Ннх! Черт возьми.",
		])+"[/say]")

		addWonButton()

	if(state == "decline"):
		saynn("Ты отмахиваешься от наваждения и прогоняешь заключенную.")

		saynn("[say=npc]"+RNG.pick([
			"Оу.",
			"Так и знал, что всё слишком хорошо, чтобы быть правдой.",
			"На секунду мне показалось, что это работает.",
			"Может, в следующий раз?",
			"Ну же, ну..."
		])+"[/say]")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "after_sex" || state == "after_sex_won"):
		saynn("Когда веселье заканчивается, зэк просто оставляет тебя в покое.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "after_sex"):
		GM.ES.triggerRun(Trigger.AfterSexWithDynamicNPCThatWon, [npcID])
		
	if(state == "after_sex_won"):
		GM.ES.triggerRun(Trigger.AfterSexWithDefeatedDynamicNPC, [npcID])

func addWonButton():
	addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
	addButtonWithChecks("Секс!", "Пора их оттрахать!", "startsexasdom", [], [ButtonChecks.CanStartSex])
	addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
	addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
	if(GM.pc.getInventory().hasRemovableRestraints()):
		addButton("Сопротивление", "Вырваться из оков", "strugglemenu")
	GM.ES.triggerRun(Trigger.DefeatedDynamicNPC, [npcID])

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return
		
		
	if(_action == "submit"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(15,30))
		endScene()
		
		var options= []
		options.append("HypnoEncounterDoll")
		options.append("HypnoEncounterFetch")
		if(npcVariation != "subby"):
			options.append("HypnoEncounterKneel")
			
		var pick = RNG.pick(options)
		runScene(pick,  [npcID])
		return

	if(_action == "decline"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		pass
		
	if(_action == "startfight"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(1,3))
		runScene("FightScene", [npcID], "guardfight")
		

	if(_action == "startsexsubby"):
		getCharacter(npcID).prepareForSexAsDom()
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "subbysex")
		return
	
	if(_action == "startsexasdom"):
		runScene("GenericSexScene", ["pc", npcID], "domsex")
		return
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex"]):
		setState("after_sex")
	if(_tag in ["domsex"]):
		setState("after_sex_won")
		
	if(_tag == "guardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(30)
		else:
			setState("if_lost")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
