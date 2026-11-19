extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""

func _init():
	sceneID = "EngineerCaughtOfflimitsScene"

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
		saynn("Пока ты бродишь по темным, тускло освещенным коридорам инженерного блока, из-за угла доносится звук тяжелых шагов. Внезапно перед тобой появляется один из инженеров. {npc.He} замечает тебя!")
		
		# (new engineer)
		if(!sawBefore):

			# (default lines)
			var possibleLines = [
				"[say=npc]Эй! Тебе здесь не положено находиться.[/say]",
				"[say=npc]Думаешь, можешь просто так ввалиться сюда и остаться незамеченной? Как бы не так.[/say]",
				"[say=npc]Пытаться пробраться сюда тайком — большая ошибка.[/say]",
				"[say=npc]Я покажу тебе, что бывает с теми, кто нарушает правила.[/say]",
				"[say=npc]Эй! Я не позволю тебе саботировать наше оборудование.[/say]",
				"[say=npc]Думаешь, можно просто так зайти сюда и копаться в моих механизмах? Повторю: как бы не так.[/say]",
				"[say=npc]И что это у нас тут? Новая заключенная пытается проскользнуть в инженерный блок? Ты еще пожалеешь об этом решении.[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Ты еще кто такая, черт возьми, и что ты здесь забыла?[/say]",
					"[say=npc]Лучше приготовь внятное объяснение, почему ты здесь, иначе тебя ждет сущий ад.[/say]",
					"[say=npc]Ты выбрала не того инженера, с которым стоит связываться, сучка.[/say]",
					"[say=npc]Эй, сучка! У меня нулевая терпимость к нарушителям, особенно в моем священном инженерном блоке![/say]",
					"[say=npc]Даю тебе ровно одну секунду, чтобы оправдаться, шлюха. Время вышло![/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]О, привет! Прости, но тебе не положено находиться в этой зоне. Придется доложить об этом охране.[/say]",
					"[say=npc]О, привет. Прости, но тебе придется понести наказание за свои действия. Но я позабочусь о том, чтобы с тобой обошлись справедливо.[/say]",
					"[say=npc]О, а ты кто? Я не хочу причинять тебе боль, я здесь, чтобы следить за работой этого объекта. Но я не могу позволить тебе нарушать правила.[/say]",
					"[say=npc]Эй! Придется попросить тебя пойти со мной. Обещаю, я не трону тебя, пока ты слушаешься.[/say]",
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]О. Ты кто? Ты звала меня?..[/say]",
					"[say=npc]О, какая любопытная? Что ты ищешь? Не меня, верно?..[/say]",
					"[say=npc]Это не место для заключенных. И что же ты собираешься со мной сделать?..[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
		# (saw before)
		else:
			# (default lines)
			var possibleLines = [
				"[say=npc]Тебе следовало бежать, пока была возможность.[/say]",
				"[say=npc]Опять ты. За свою дерзость ты еще поплатишься.[/say]",
				"[say=npc]Я сделаю из тебя назидание для всех остальных, кто вздумает сюда сунуться.[/say]",
				"[say=npc]Я тебя предупреждал, а теперь тебе придется иметь дело со мной.[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Я тебя помню, ублюдок! Пора вышвырнуть твою задницу отсюда.[/say]",
					"[say=npc]На этот раз тебе от меня не сбежать, скользкая ты сука.[/say]",
					"[say=npc]Разве я не говорил тебе свалить нахер из моего инженерного блока, сучка?[/say]",
					"[say=npc]Какого хера ты всё еще здесь торчишь, сучка?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]Снова здравствуй. Видел, как ты бродила здесь недавно. Вообще-то это закрытая зона, знаешь ли.[/say]",
					"[say=npc]Опять ты... Придется доложить об этом охране. Но если будешь слушаться, я замолвлю за тебя словечко.[/say]",
					"[say=npc]О, я тебя помню. Думаю, тебе пора завязывать с попытками вломиться в инженерный блок, здесь нет ничего интересного...[/say]",
					"[say=npc]О, привет. Тебе здесь нельзя быть, я же уже говорил.[/say]"
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Вернулся за добавкой?..[/say]",
					"[say=npc]Не знаю, что ты ищешь, но вокруг никого нет, кроме меня...[/say]",
					"[say=npc]О, ты снова меня нашел. И что ты теперь сделаешь?..[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
			# (end)

		if(npcVariation in ["kind", "subby"]):
			saynn("Похоже, {npc.he} не настроен на драку.")
			
			addButton("Запугивание", "Вежливо попросить пропустить тебя", "intimidate")
			addButton("Атаковать", "Ну, они сами напросились", "attack")
			addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")
		else:
			saynn("Похоже, {npc.he} просто так тебя не отпустит.")

			addButton("Атаковать", "Ну, они сами напросились", "attack")
			addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")
		
	if(state == "intimidate_success"):
		saynn(RNG.pick([
			"[say=pc]Думаю, тебе будет лучше, если ты меня отпустишь. Понимаешь, о чем я?[/say]",
			"[say=pc]Если не собираешься меня отпускать, я не стану сдерживаться.[/say]",
			"[say=pc]Попытка остановить меня плохо кончится для тебя. А?[/say]",
		]))
		
		saynn("Инженер слышит твои слова и опускает {npc.his} голову.")
		
		saynn(RNG.pick([
			"[say=npc]Ладно, ладно, я тебя услышал(а). Только не бей..[/say]",
			"[say=npc]Тогда я не буду тебя задерживать, иди..[/say]",
			"[say=npc]Ладно, только ничего не сломай..[/say]",
			]))
		
		saynn("Похоже, уговорить {pc.him} немного развлечься не составит труда.")
		
		addWonButton()
	
	if(state == "intimidate_fail"):
		saynn(RNG.pick([
			"[say=pc]Думаю, тебе будет лучше, если ты меня отпустишь. Понимаешь, о чем я?[/say]",
			"[say=pc]Если не собираешься меня отпускать, я не стану сдерживаться.[/say]",
			"[say=pc]Попытка остановить меня плохо кончится для тебя. А?[/say]",
		]))
		
		saynn("Инженер слышит твои слова и принимает боевую стойку.")
	
		saynn(RNG.pick([
			"[say=npc]Я не могу тебя отпустить, прости.[/say]",
			"[say=npc]Если придется драться — я буду драться.[/say]",
			"[say=npc]Я не боюсь! Я должен защитить оборудование![/say]",
		]))
		
		saynn("Похоже, назревает драка.")
		
		addButton("Драться", "Начать бой", "startfight")
		
	if(state == "attack"):
		# (if subby, can just auto-win)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		saynn("Ты наносишь удар по {npc.name}!")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("Но {npc.he} готов(а): он(а) отталкивает тебя и издает яростный рык.")

			saynn(RNG.pick([
				"[say=npc]О, ты, блять, об этом еще пожалеешь.[/say]",
				"[say=npc]Значит, придется применить силу.[/say]",
				"[say=npc]Плохой выбор. Готовься к последствиям, сучка.[/say]",
			]))

		# (options is fight)
			addButton("Драться", "Начать бой", "startfight")
		# (if subby/coward happened)
		elif(npcVariation == "subby"):
			saynn("{npc.He} совершенно к этому не был(а) готов(а). Охранник ахает и падает перед тобой замертво.")

			saynn(RNG.pick([
				"[say=npc]Ой!.. Не делай мне больно! Можешь идти.[/say]",
				"[say=npc]Ладно, ладно, ты победил... Делай что хочешь...[/say]",
				"[say=npc]Эй!.. Ой.. ты победил. И что ты теперь будешь делать?..[/say]",
			]))

			addWonButton()
			# (default)
		else:
			saynn("{npc.He} пошатывается, но быстро восстанавливает равновесие. Охранник явно не в восторге от тебя.")

			saynn(RNG.pick([
				"[say=npc]Ну, я могу преподать тебе пару уроков.[/say]",
				"[say=npc]Посмотрим, хватит ли этого урока для тебя.[/say]",
				"[say=npc]Сопротивление только ухудшит твое положение.[/say]",
			]))

			addButton("Драться", "Начать бой", "startfight")



	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		# (default)
		if(npcVariation != "mean"):
			saynn(RNG.pick([
				"[say=npc]Хм. Думаю, сначала нам стоит немного развлечься.[/say]",
				"[say=npc]Мы сейчас повеселимся, прежде чем я вышвырну тебя из инженерного блока.[/say]",
				"[say=npc]Я вышвырну тебя из инженерного блока. Но сначала...[/say]",
			]))

		# (if mean)
		else:
			saynn(RNG.pick([
				"[say=npc]Ты реально думала, что сможешь победить? Ну и шлюха.[/say]",
				"[say=npc]Тупая сучка. То, что тебя сейчас оттрахают — это меньшая из твоих проблем.[/say]",
			]))

		saynn("Раз уж ты больше не можешь сопротивляться, твой единственный выход — сдаться.")

		# (sex)
		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")


	if(state == "if_won"):
		saynn("Ты прижимаешь поверженного инженера к полу. {npc.He}, кажется, особо и не сопротивляется.")

		saynn(RNG.pick([
			"[say=npc]Ну и что теперь?[/say]",
			"[say=npc]Ладно, ты победила. Будь по-твоему.[/say]",
			"[say=npc]Уже собираешься меня оттрахать?[/say]",
		]))

		# (Options are sex or leave them be, Inventory, Struggle)

		# (Need everything to be free to fuck)

		addWonButton()

	if(state == "offer_body"):
		saynn("Ты очень хочешь избежать драки, но и быть вышвырнутым(ой) из инженерного блока тоже не гоже. Поэтому вместо того, чтобы сдаться, ты одариваешь инженера ласковой улыбкой и принимаешь сексуальную позу, демонстрируя свои {pc.masc} изгибы.")

		saynn("[say=pc]Как насчет того, чтобы я предложила тебе кое-что получше? Например, саму себя.[/say]")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("{npc.He} оценивающе осматривает тебя и тянется, чтобы схватить за руку.")

			saynn("[say=npc]Да неужели? Попробуй только сопротивляться — пожалеешь.[/say]")
			
			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (if subby)
		elif(npcVariation == "subby"):
			saynn("{npc.He} краснеет, украдкой поглядывая на тебя. Застенчивый инженер опускает {npc.his} голову.")

			saynn("[say=npc]В смысле... можешь взять меня, если хочешь..[/say]")

			saynn("Хм, похоже, этот инженер — та еще подчиняшка.")
			addWonButton()
		else:
			# (if default)

			saynn("{npc.He} разглядывает тебя и делает шаг навстречу.")

			saynn("[say=npc]Хм. Может быть. Я бы не отказалась от хорошего траха.[/say]")

			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (Options are sex or sex (dom) if hands untied)


	if(state == "after_sex"):
		saynn("Ты используешь это время, чтобы ускользнуть, пока инженер не вывела тебя из инженерного блока.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")

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

	if(_action == "startfight"):
		runScene("FightScene", [npcID], "guardfight")
	
	if(_action == "startsexsubby"):
		getCharacter(npcID).prepareForSexAsDom()
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc"], "subbysex")
	
	if(_action == "startsexasdom"):
		runScene("GenericSexScene", ["pc", npcID], "domsex")
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	
	if(_action == "intimidate"):
		if(npcVariation == "kind" && RNG.chance(50)):
			setState("intimidate_fail")
			return
		setState("intimidate_success")
		return

	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		setState("after_sex")
	
	if(_tag == "guardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(30)
			if(GM.ES.triggerReact(Trigger.WonCaughtOffLimitsFight, [npcID, CharacterType.Engineer])):
				endScene()
				return
		else:
			if(GM.ES.triggerReact(Trigger.LostCaughtOffLimitsFight, [npcID, CharacterType.Engineer])):
				endScene()
				return
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
